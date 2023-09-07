package com.landray.kmss.group.sync.service.spring;

import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.component.dbop.model.CompDbcp;
import com.landray.kmss.group.sync.model.Role;
import com.landray.kmss.group.sync.service.IWorkShiftSyncService;
import com.landray.kmss.hr.staff.model.HrStaffPersonExperienceWork;
import com.landray.kmss.hr.staff.model.HrStaffTrackRecord;
import com.landray.kmss.hr.staff.service.IHrStaffPersonExperienceWorkService;
import com.landray.kmss.hr.staff.service.IHrStaffTrackRecordService;
import com.landray.kmss.sys.organization.service.ISysOrgElementService;
import com.landray.kmss.sys.quartz.interfaces.SysQuartzJobContext;
import com.landray.kmss.sys.util.DBsourceUtils;

import java.sql.Connection;
import java.sql.Statement;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.landray.kmss.group.sync.constant.BeglGroupConstant.*;
import static com.landray.kmss.sys.util.DBsourceUtils.getConnection;
import static com.landray.kmss.sys.util.DBsourceUtils.getRole;

public class WorkShiftSyncService implements IWorkShiftSyncService {

    private IHrStaffTrackRecordService hrStaffTrackRecordService;
    private Map<String, Object> sqlmap = new HashMap<>();

    protected Role role = new Role();
    private ISysOrgElementService sysOrgElementService;

    @Override
    public void WorkShiftSync(SysQuartzJobContext jobContext) throws Exception {
        try {

            jobContext.logMessage("开始同步人员工作变动信息");
            HQLInfo hqlInfo = new HQLInfo();
//                String where = "fdIsAvailable = 1";
//                hqlInfo.setWhereBlock(where);
//        获取人员工作履历信息
            this.hrStaffTrackRecordService = (IHrStaffTrackRecordService) com.landray.kmss.util.SpringBeanUtil.getBean("hrStaffTrackRecordService");
            List<HrStaffTrackRecord> workServiceList = this.hrStaffTrackRecordService.findList(hqlInfo);
            this.sysOrgElementService = (ISysOrgElementService) com.landray.kmss.util.SpringBeanUtil.getBean("sysOrgElementService");
            //获取第三方数据库
            CompDbcp baseModel  = DBsourceUtils.getDBSource(THIRDDB);
            if (baseModel == null) {
                jobContext.logMessage("同步HR_PERSON人员信息失败，未找到数据源");
                return;
            }

            for (HrStaffTrackRecord work : workServiceList) {
                jobContext.logMessage("同步人员业务信息表HR_PERSON" + work.getFdPersonInfo());
                role = getRole(jobContext, work.getFdPersonInfo(),this.sysOrgElementService);
                this.sqlmap = setWorkSqlMap(work);
                String sql = DBsourceUtils.prepareSQL(sqlmap, "PERSON_RESUME");

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

//    public List<String> getRoles(){
//
//    }

    private Map<String,Object> setWorkSqlMap(HrStaffTrackRecord work) {
        sqlmap.put("BILLID", work.getFdId());
        sqlmap.put("FATHERID", work.getFdId());
        sqlmap.put("CODE", work.getFdId());
        sqlmap.put("CORPID", CORP_CODE);
        sqlmap.put("CORPCODE", CORP_CODE);
        sqlmap.put("CORPNAME", CORP_NAME);
        sqlmap.put("CORPSHORT", CORP_NAME);
        sqlmap.put("DEPTCODE", work.getFdPersonInfo().getFdOrgParent().getFdId());
        sqlmap.put("DEPTNAME", work.getFdPersonInfo().getFdOrgParent().getFdName());
        sqlmap.put("ROLE_ID", this.role.getId());
        sqlmap.put("ROLE_NAME", this.role.getName());
        sqlmap.put("CHANGETYPE_CODE", work.getFdPersonInfo().getFdId());
        sqlmap.put("CHANGETYPE_NAME", work.getFdTransType());
        sqlmap.put("CHANGETYPE_MODEL", work.getFdTransType());
        sqlmap.put("CHANGE_HINT", work.getFdPersonInfo().getFdName());
        sqlmap.put("ORDER_CHANGEDATEBZ", 1);
        sqlmap.put("CHANGE_DATE", work.getFdTransDate());
        return sqlmap;
    }

    public void setHrStaffTrackRecordService(IHrStaffTrackRecordService hrStaffTrackRecordService) {
        this.hrStaffTrackRecordService = hrStaffTrackRecordService;
    }

    public void setSysOrgElementService(ISysOrgElementService sysOrgElementService) {
        this.sysOrgElementService = sysOrgElementService;
    }
}
