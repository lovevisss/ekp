package com.landray.kmss.group.sync.service.spring;

import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.component.dbop.model.CompDbcp;
import com.landray.kmss.group.sync.model.Role;
import com.landray.kmss.group.sync.service.IWorkContractService;
import com.landray.kmss.hr.staff.model.HrStaffPersonExperienceContract;
import com.landray.kmss.hr.staff.service.IHrStaffPersonExperienceContractService;
import com.landray.kmss.sys.organization.service.ISysOrgElementService;
import com.landray.kmss.sys.quartz.interfaces.SysQuartzJobContext;
import com.landray.kmss.sys.util.DBsourceUtils;

import java.sql.Connection;
import java.sql.Statement;
import java.time.Instant;
import java.time.LocalDate;
import java.time.Period;
import java.time.ZoneId;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.landray.kmss.group.sync.constant.BeglGroupConstant.*;
import static com.landray.kmss.sys.util.DBsourceUtils.getConnection;
import static com.landray.kmss.sys.util.DBsourceUtils.getRole;

public class WorkContractService implements IWorkContractService {
    private IHrStaffPersonExperienceContractService hrStaffPersonExperienceContractService;
    private Map<String, Object> sqlmap = new HashMap<>();
    protected Role role = new Role();
    private ISysOrgElementService sysOrgElementService;

    @Override
    public void WorkContractSync(SysQuartzJobContext jobContext) throws Exception {
        try {

            jobContext.logMessage("开始同步人员劳动合同信息");
            HQLInfo hqlInfo = new HQLInfo();
//        获取人员工作履历信息
            this.hrStaffPersonExperienceContractService = (IHrStaffPersonExperienceContractService) com.landray.kmss.util.SpringBeanUtil.getBean("hrStaffPersonExperienceContractService");
            List<HrStaffPersonExperienceContract> workServiceList = this.hrStaffPersonExperienceContractService.findList(hqlInfo);

            this.sysOrgElementService = (ISysOrgElementService) com.landray.kmss.util.SpringBeanUtil.getBean("sysOrgElementService");

            //获取第三方数据库
            CompDbcp baseModel  = DBsourceUtils.getDBSource(THIRDDB);
            if (baseModel == null) {
                jobContext.logMessage("同步HR_PERSON人员信息失败，未找到数据源");
                return;
            }

            for (HrStaffPersonExperienceContract work : workServiceList) {
                jobContext.logMessage("同步人员业务信息表WORKCONTRACT" + work.getFdPersonInfo());
                role = getRole(jobContext, work.getFdPersonInfo(),this.sysOrgElementService);
                this.sqlmap = setWorkSqlMap(work);
                String sql = DBsourceUtils.prepareSQL(sqlmap, "PERSON_WORKCONTRACT");

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

    private Map<String, Object> setWorkSqlMap(HrStaffPersonExperienceContract work) {
        Map<String, Object> sqlmap = new HashMap<>();
        sqlmap.put("ID", work.getFdPersonInfo().getFdId());
        sqlmap.put("BILLID", work.getFdId());
        if(work.getFdPersonInfo() != null)
        {
            sqlmap.put("PERSONID", work.getFdPersonInfo().getFdId());
        }else {
            sqlmap.put("PERSONID"," ");
        }
        sqlmap.put("CORPID", "待定");
        sqlmap.put("CORPCODE", CORP_CODE);
        sqlmap.put("CORPNAME", CORP_NAME);
        sqlmap.put("CODE", work.getFdId());
        sqlmap.put("SIGN_NUM", work.getFdSignType());
        sqlmap.put("DEPT_CODE", work.getFdPersonInfo().getFdParent().getFdId());
        sqlmap.put("DEPT_NAME", work.getFdPersonInfo().getFdParent().getFdName());
        sqlmap.put("ROLE_CODE", work.getFdPersonInfo().getFdOrgParent().getFdId());
        sqlmap.put("ROLE_NAME", work.getFdPersonInfo().getFdOrgParent().getFdName());
        sqlmap.put("PERSONID", work.getFdPersonInfo().getFdId());
        sqlmap.put("PERSONNAME", work.getFdPersonInfo().getFdName());
        sqlmap.put("WORKCONTRACT_CODE", work.getFdName() + " " + work.getFdBeginDate());
        sqlmap.put("HTTERM_LXCODE", work.getFdContType());
        sqlmap.put("HTTERM_LXNAME", work.getFdContType());
//        Begin - End return int
        sqlmap.put("AGREEMENT_YEARNUM", Period.between(getLocalDateFromDate(work.getFdEndDate()), getLocalDateFromDate(work.getFdBeginDate())).getYears());
        sqlmap.put("AGREEMENT_BEGDATE", work.getFdBeginDate());
        sqlmap.put("AGREEMENT_ENDDATE", work.getFdEndDate());
        sqlmap.put("AGREEMENT_MEMO", AGREEMENTMEMO.get(work.getFdContStatus()));
        sqlmap.put("AGREEMENT_DESC", work.getFdMemo());
        sqlmap.put("CONTRACT_STATUS", AGREEMENTTYPE.get(work.getFdContStatus()));
        sqlmap.put("INPUT_DATE", work.getFdCreateTime());
        sqlmap.put("INPUT_USERID", work.getFdCreator().getFdId());
        sqlmap.put("INPUT_USERNAME", work.getFdCreator().getFdName());
        return sqlmap;
    }

    public static LocalDate getLocalDateFromDate(Date date) {
        // 将Date转为Instant对象
        Instant instant = date.toInstant();

        // 默认时区
        ZoneId zoneId = ZoneId.systemDefault();

        // 获取LocalDate对象
        LocalDate localDate = instant.atZone(zoneId).toLocalDate();

        return localDate;
    }

    public void setHrStaffPersonExperienceContractService(IHrStaffPersonExperienceContractService hrStaffPersonExperienceContractService) {
        this.hrStaffPersonExperienceContractService = hrStaffPersonExperienceContractService;
    }

    public void setSysOrgElementService(ISysOrgElementService sysOrgElementService) {
        this.sysOrgElementService = sysOrgElementService;
    }
}
