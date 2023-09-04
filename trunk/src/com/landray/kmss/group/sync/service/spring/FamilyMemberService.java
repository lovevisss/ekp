package com.landray.kmss.group.sync.service.spring;

import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.component.dbop.model.CompDbcp;
import com.landray.kmss.group.sync.service.IFamilyMemberService;
import com.landray.kmss.hr.staff.model.HrStaffPersonFamily;
import com.landray.kmss.hr.staff.service.IHrStaffPersonFamilyService;
import com.landray.kmss.sys.quartz.interfaces.SysQuartzJobContext;
import com.landray.kmss.sys.util.DBsourceUtils;

import java.sql.Connection;
import java.sql.Statement;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.landray.kmss.group.sync.constant.BeglGroupConstant.*;
import static com.landray.kmss.sys.util.DBsourceUtils.getConnection;
import static com.landray.kmss.sys.util.DBsourceUtils.prepareSQL;

public class FamilyMemberService implements IFamilyMemberService {

    private IHrStaffPersonFamilyService hrStaffPersonFamilyService;

    private Map<String, Object> sqlmap = new HashMap<>();

    private Integer index = 1;
    @Override
    public void FamilyMemberSync(SysQuartzJobContext jobContext) throws Exception {
        try{

            jobContext.logMessage("开始同步家庭成员信息");
            HQLInfo hqlInfo = new HQLInfo();


            //初始化hrstaffpersonfamilyservice
            this.hrStaffPersonFamilyService = (IHrStaffPersonFamilyService) com.landray.kmss.util.SpringBeanUtil.getBean("hrStaffPersonFamilyService");
            //获取人员家庭成员信息
            List<HrStaffPersonFamily> hrstafffamilyList = hrStaffPersonFamilyService.findList(hqlInfo);

            //获取第三方数据库
            CompDbcp baseModel  = DBsourceUtils.getDBSource(THIRDDB);

            for(HrStaffPersonFamily family : hrstafffamilyList){
                jobContext.logMessage("同步家庭成员信息表PERSON_RESUME" + family.getFdPersonInfo());
                this.sqlmap = setFamilySqlMap(family);
                String sql = prepareSQL(sqlmap, "PERSON_RESUME");

                jobContext.logMessage("执行sql语句:" + sql);
                Connection con = getConnection(baseModel);
                Statement stmt = con.createStatement();
                int rs = stmt.executeUpdate(sql);
                stmt.close();
                con.close();
            }
        }catch (Exception e){

            jobContext.logError("同步家庭成员信息失败" + e.getMessage());
        }
    }

    private Map<String, Object> setFamilySqlMap(HrStaffPersonFamily family) {
        Map<String, Object> sqlmap = new HashMap<>();
        sqlmap.put("ID", family.getFdId());
        sqlmap.put("CORPID", "待定");
        sqlmap.put("CORPCODE", CORP_CODE);
        sqlmap.put("CORPNAME", CORP_NAME);
        sqlmap.put("BILLID", family.getFdId());
        sqlmap.put("FATHERID", family.getFdId());
        sqlmap.put("TYPE", 4);
        if(family.getFdPersonInfo() != null)
        {
            sqlmap.put("PERSONID", family.getFdPersonInfo().getFdId());
        }
        else{
            sqlmap.put("PERSONID", "NULL");
        }

        sqlmap.put("SORTCODE", index++);
        sqlmap.put("FAMILYNAME", family.getFdName());
        sqlmap.put("FAMILY_RELATION", family.getFdRelated());
        sqlmap.put("FINISHSCHOOL", family.getFdCompany()+" "+family.getFdOccupation());
        sqlmap.put("MAINDEPTNAME", family.getFdConnect());
        return sqlmap;
    }



    public void setHrStaffPersonFamilyService(IHrStaffPersonFamilyService hrStaffPersonFamilyService) {
        this.hrStaffPersonFamilyService = hrStaffPersonFamilyService;
    }
}
