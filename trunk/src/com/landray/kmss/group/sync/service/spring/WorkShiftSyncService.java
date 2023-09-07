package com.landray.kmss.group.sync.service.spring;

import DBstep.iDBManager2000;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.component.dbop.model.CompDbcp;
import com.landray.kmss.group.sync.model.Creator;
import com.landray.kmss.group.sync.model.Role;
import com.landray.kmss.group.sync.service.IWorkShiftSyncService;
import com.landray.kmss.hr.ratify.model.HrRatifyTransfer;
import com.landray.kmss.hr.ratify.service.IHrRatifyTransferService;
import com.landray.kmss.hr.staff.model.HrStaffPersonInfo;
import com.landray.kmss.hr.staff.service.IHrStaffPersonInfoService;
import com.landray.kmss.sys.organization.service.ISysOrgElementService;
import com.landray.kmss.sys.quartz.interfaces.SysQuartzJobContext;
import com.landray.kmss.sys.util.DBsourceUtils;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.landray.kmss.group.sync.constant.BeglGroupConstant.*;
import static com.landray.kmss.sys.util.DBsourceUtils.getConnection;
import static com.landray.kmss.sys.util.DBsourceUtils.getRole;

public class WorkShiftSyncService implements IWorkShiftSyncService {

    private IHrRatifyTransferService hrRatifyTransferService;
    private Map<String, Object> sqlmap = new HashMap<>();

    protected Role role = new Role();

    protected Creator creator = new Creator();
    private ISysOrgElementService sysOrgElementService;


    protected IHrStaffPersonInfoService hrStaffPersonInfoService;

    private String change ;

    @Override
    public void WorkShiftSync(SysQuartzJobContext jobContext) throws Exception {
        try {

            jobContext.logMessage("开始同步人员工作变动信息");
            HQLInfo hqlInfo = new HQLInfo();
//                String where = "fdIsAvailable = 1";
//                hqlInfo.setWhereBlock(where);
//        获取人员工作履历信息
            this.hrRatifyTransferService = (IHrRatifyTransferService) com.landray.kmss.util.SpringBeanUtil.getBean("hrRatifyTransferService");
            List<HrRatifyTransfer> workServiceList = this.hrRatifyTransferService.findList(hqlInfo);
            this.sysOrgElementService = (ISysOrgElementService) com.landray.kmss.util.SpringBeanUtil.getBean("sysOrgElementService");
            this.hrStaffPersonInfoService = (IHrStaffPersonInfoService) com.landray.kmss.util.SpringBeanUtil.getBean("hrStaffPersonInfoService");
            //获取第三方数据库
            CompDbcp baseModel  = DBsourceUtils.getDBSource(THIRDDB);
            if (baseModel == null) {
                jobContext.logMessage("同步HR_PERSON人员信息失败，未找到数据源");
                return;
            }

            for (HrRatifyTransfer work : workServiceList) {
                jobContext.logMessage("同步人员变动信息表PERSONCHANGE" );
                HQLInfo hqlInfo1 = new HQLInfo();
                String where = "fdId = '" + work.getFdId() + "'";
                hqlInfo1.setWhereBlock(where);
                HrStaffPersonInfo hrStaffPersonInfo = (HrStaffPersonInfo) this.hrStaffPersonInfoService.findFirstOne(hqlInfo1);
                this.creator.setName(getRole(jobContext, hrStaffPersonInfo,this.sysOrgElementService).getName());
                getCreator(jobContext, work);
                this.sqlmap = setWorkSqlMap(work);
                String sql = DBsourceUtils.prepareSQL(sqlmap, "PERSONCHANGE");

                jobContext.logMessage("执行sql语句:" + sql);
                Connection con = getConnection(baseModel);
                Statement stmt = con.createStatement();
                int rs = stmt.executeUpdate(sql);
                stmt.close();
                con.close();
            }



        }catch (Exception e){

            jobContext.logError("同步奖惩信息失败" + e.getMessage());
        }
    }

    protected void getCreator(SysQuartzJobContext jobContext, HrRatifyTransfer staff) throws Exception {
        jobContext.logMessage("getContract");

        iDBManager2000 iDBManager2000 = new iDBManager2000();
        iDBManager2000.OpenConnection();
        String selSql = "select * "
                + "from hr_ratify_main "
                + "where fd_id = '"+ staff.getFdId() + "'";
        System.out.println(selSql);
        ResultSet result = iDBManager2000.ExecuteQuery(selSql);
        jobContext.logMessage("result" + result);
        while (result.next()){
            jobContext.logMessage("doc_creator_id" + result.getString("doc_creator_id"));
            jobContext.logMessage("doc_create_time" + result.getDate("doc_create_time"));
//            jobContext.logMessage("fd_end_date" + result.getDate("fd_end_date"));
            this.creator.setId(result.getString("doc_creator_id"));
            this.creator.setCreateTime(result.getDate("doc_create_time"));
//            jobContext.logMessage("fd_end_date c" + this.contract.getAgreementEndDate());
        }

        iDBManager2000.CloseConnection();


    }

    protected void getChange(SysQuartzJobContext jobContext, HrRatifyTransfer staff) throws Exception {
        jobContext.logMessage("getContract");

        iDBManager2000 iDBManager2000 = new iDBManager2000();
        iDBManager2000.OpenConnection();
        String selSql = "select * "
                + "from ekp_18a6f49488339596906d "
                + "where fd_id = '"+ staff.getFdId() + "'";
        System.out.println(selSql);
        ResultSet result = iDBManager2000.ExecuteQuery(selSql);
        jobContext.logMessage("result" + result);
        while (result.next()){
            jobContext.logMessage("名称" + result.getString("fd_bianDongFangShiMingChen"));
            jobContext.logMessage("doc_create_time" + result.getDate("doc_create_time"));
//            jobContext.logMessage("fd_end_date" + result.getDate("fd_end_date"));
            this.change = (result.getString("fd_bianDongFangShiMingChen"));
//            jobContext.logMessage("fd_end_date c" + this.contract.getAgreementEndDate());
        }

        iDBManager2000.CloseConnection();


    }

    private Map<String,Object> setWorkSqlMap(HrRatifyTransfer work) {
        sqlmap.put("BILLID", work.getFdId());
        sqlmap.put("FATHERID", work.getFdId());
        sqlmap.put("CODE", work.getFdId());
        sqlmap.put("CORPID", CORP_CODE);
        sqlmap.put("CORPCODE", CORP_CODE);
        sqlmap.put("CORPNAME", CORP_NAME);
        sqlmap.put("CORPSHORT", CORP_NAME);
        sqlmap.put("OLD_DEPTCODE", work.getFdTransferLeaveDept().getFdId());
        sqlmap.put("OLD_DEPTNAME", work.getFdTransferLeaveDept().getFdName());
        sqlmap.put("OLD_ROLE_ID", work.getFdTransferLeavePosts().get(0).getFdId());
        sqlmap.put("OLD_ROLE_NAME", work.getFdTransferLeavePosts().get(0).getFdName());
        sqlmap.put("APPLY_USERID", creator.getId());
        sqlmap.put("APPLY_USERNAME", creator.getName());
        sqlmap.put("APPLY_DATE", creator.getCreateTime());
        sqlmap.put("BUSINESS_YEAR", creator.getCreateTime().getYear());
        sqlmap.put("BUSINESS_MONTH", creator.getCreateTime().getMonth());
        sqlmap.put("INPUT_USERID", creator.getId());
        sqlmap.put("INPUT_USERNAME", creator.getName());
        sqlmap.put("INPUT_DATE", creator.getCreateTime());
        sqlmap.put("FLOW_FINISHSTATUS", 1);
        sqlmap.put("FLOW_FINISHDATE", work.getDocPublishTime());
        sqlmap.put("FLOW_FINISHUSERID", creator.getId());
        sqlmap.put("PERSONID", work.getFdTransferStaff().getFdId());
        sqlmap.put("PERSONNAME", work.getFdTransferStaff().getFdName());
        sqlmap.put("DEPTCODE", work.getFdTransferEnterDept().getFdId());
        sqlmap.put("DEPTNAME", work.getFdTransferEnterDept().getFdName());
        sqlmap.put("ROLE_ID", work.getFdTransferEnterPosts().get(0).getFdId());
        sqlmap.put("ROLE_NAME", work.getFdTransferEnterPosts().get(0).getFdName());
        sqlmap.put("CHANGETYPE_CODE",WORK_CHANGE_MAP.get(change).getWorkCode());
        sqlmap.put("CHANGETYPE_NAME", WORK_CHANGE_MAP.get(change).getName());
        sqlmap.put("CHANGETYPE_MODEL", WORK_CHANGE_MAP.get(change).getTypeCode());
        sqlmap.put("CHANGE_HINT", work.getFdTransferReason());
        sqlmap.put("ORDER_CHANGEDATEBZ", 0);
        sqlmap.put("CHANGE_DATE", work.getFdTransferDate());
        sqlmap.put("CHANGE_MEMO", work.getFdTransferRemark());
        return sqlmap;
    }

    public void setHrRatifyTransferService(IHrRatifyTransferService hrRatifyTransferService) {
        this.hrRatifyTransferService = hrRatifyTransferService;
    }

    public void setSysOrgElementService(ISysOrgElementService sysOrgElementService) {
        this.sysOrgElementService = sysOrgElementService;
    }

    public void setHrStaffPersonInfoService(IHrStaffPersonInfoService hrStaffPersonInfoService) {
        this.hrStaffPersonInfoService = hrStaffPersonInfoService;
    }
}
