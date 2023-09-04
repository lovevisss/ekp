package com.landray.kmss.group.sync.service.spring;

import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.component.dbop.model.CompDbcp;
import com.landray.kmss.group.sync.service.IWorkExpService;
import com.landray.kmss.hr.staff.model.HrStaffPersonExperienceWork;
import com.landray.kmss.hr.staff.service.IHrStaffPersonExperienceWorkService;
import com.landray.kmss.sys.quartz.interfaces.SysQuartzJobContext;
import com.landray.kmss.sys.util.DBsourceUtils;

import java.sql.Connection;
import java.sql.Statement;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.landray.kmss.group.sync.constant.BeglGroupConstant.*;
import static com.landray.kmss.sys.util.DBsourceUtils.getConnection;

public class WorkExpService implements IWorkExpService {

    private IHrStaffPersonExperienceWorkService hrStaffPersonExperienceWorkService;
    private Map<String, Object> sqlmap = new HashMap<>();
    private Integer index = 1;
    @Override
    public void WorkExpSync(SysQuartzJobContext jobContext) throws Exception {
        try {

                jobContext.logMessage("开始同步人员工作履历信息");
                HQLInfo hqlInfo = new HQLInfo();
//                String where = "fdIsAvailable = 1";
//                hqlInfo.setWhereBlock(where);
//        获取人员工作履历信息
                this.hrStaffPersonExperienceWorkService = (IHrStaffPersonExperienceWorkService) com.landray.kmss.util.SpringBeanUtil.getBean("hrStaffPersonExperienceWorkService");
                List<HrStaffPersonExperienceWork> workServiceList = this.hrStaffPersonExperienceWorkService.findList(hqlInfo);

            //获取第三方数据库
                CompDbcp baseModel  = DBsourceUtils.getDBSource(THIRDDB);
                if (baseModel == null) {
                    jobContext.logMessage("同步HR_PERSON人员信息失败，未找到数据源");
                    return;
                }

                for (HrStaffPersonExperienceWork work : workServiceList) {
                    jobContext.logMessage("同步人员业务信息表HR_PERSON" + work.getFdPersonInfo());
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

    public void setHrStaffPersonExperienceWorkService(IHrStaffPersonExperienceWorkService hrStaffPersonExperienceWorkService) {
        this.hrStaffPersonExperienceWorkService = hrStaffPersonExperienceWorkService;
    }


    private Map<String, Object> setWorkSqlMap(HrStaffPersonExperienceWork work) {
        Map<String, Object> sqlmap = new HashMap<>();
        sqlmap.put("ID", work.getFdId());
        sqlmap.put("CORPID", CORP_CODE);
        sqlmap.put("CORPCODE", CORP_CODE);
        sqlmap.put("CORPNAME", CORP_NAME);
        sqlmap.put("BILLID", work.getFdId());
        sqlmap.put("FATHERID", work.getFdId());
        sqlmap.put("TYPE", 3);
        if(work.getFdPersonInfo() != null){

            sqlmap.put("PERSONID", work.getFdPersonInfo().getFdId());
        }
        else {
            sqlmap.put("PERSONID", "");
        }
        sqlmap.put("SORT_CODE", index++);
        sqlmap.put("DESCRIPTION", work.getFdBeginDate()+"-"+work.getFdEndDate());
        sqlmap.put("RESUME_DESC1", work.getFdDescription());
        return sqlmap;
    }
}

