package com.landray.kmss.group.sync.service.spring;

import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.component.dbop.model.CompDbcp;
import com.landray.kmss.group.sync.service.IBonusPunishService;
import com.landray.kmss.hr.staff.model.HrStaffPersonExperienceBonusMalus;
import com.landray.kmss.hr.staff.service.IHrStaffPersonExperienceBonusMalusService;
import com.landray.kmss.sys.quartz.interfaces.SysQuartzJobContext;
import com.landray.kmss.sys.util.DBsourceUtils;
import com.landray.kmss.util.SpringBeanUtil;

import java.sql.Connection;
import java.sql.Statement;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import static com.landray.kmss.group.sync.constant.BeglGroupConstant.*;
import static com.landray.kmss.sys.util.DBsourceUtils.getConnection;

public class BounsPunishSyncService implements IBonusPunishService {

    private IHrStaffPersonExperienceBonusMalusService hrStaffPersonExperienceBonusMalusService;


    private Map<String, Object> sqlmap = new HashMap<>();
    private Integer index = 1;
    @Override
    public void BonusPunishSync(SysQuartzJobContext jobContext) throws Exception {
        try {

            jobContext.logMessage("开始同步奖惩人员信息");
            HQLInfo hqlInfo = new HQLInfo();
//        获取人员奖惩信息
            this.hrStaffPersonExperienceBonusMalusService = (IHrStaffPersonExperienceBonusMalusService) SpringBeanUtil.getBean("hrStaffPersonExperienceBonusMalusService");
            List<HrStaffPersonExperienceBonusMalus> bonusMalusServiceList = hrStaffPersonExperienceBonusMalusService.findList(hqlInfo);
//获取第三方数据库
            CompDbcp baseModel  = DBsourceUtils.getDBSource(THIRDDB);
            if (baseModel == null) {
                jobContext.logMessage("同步HR_PERSON人员信息失败，未找到数据源");
                return;
            }

            for (HrStaffPersonExperienceBonusMalus bonusMalus : bonusMalusServiceList)
            {
                this.sqlmap = setBonusPunishSqlMap(bonusMalus);
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

    private Map<String, Object> setBonusPunishSqlMap(HrStaffPersonExperienceBonusMalus bonusMalus) {
        Map<String, Object> sqlmap = new HashMap<>();
        sqlmap.put("ID", bonusMalus.getFdId());
        sqlmap.put("CORPID", CORP_CODE);
        sqlmap.put("CORPCODE", CORP_CODE);
        sqlmap.put("CORPNAME", CORP_NAME);
        sqlmap.put("BILLID", bonusMalus.getFdId());
        sqlmap.put("FATHERID", bonusMalus.getFdId());
        sqlmap.put("TYPE", 2);
        if(bonusMalus.getFdPersonInfo() != null){

            sqlmap.put("PERSONID", bonusMalus.getFdPersonInfo().getFdId());
        }
        else {
            sqlmap.put("PERSONID", "");
        }
        sqlmap.put("SORT_CODE", index++);
        sqlmap.put("EDUKIND", bonusMalus.getFdBonusMalusType());
        sqlmap.put("SPECIALITY", bonusMalus.getFdBonusMalusName());
        sqlmap.put("RESUME_DESC1", bonusMalus.getFdBonusMalusDate());
        return sqlmap;
    }

    public void setHrStaffPersonExperienceBonusMalusService(IHrStaffPersonExperienceBonusMalusService hrStaffPersonExperienceBonusMalusService) {
        this.hrStaffPersonExperienceBonusMalusService = hrStaffPersonExperienceBonusMalusService;
    }
}
