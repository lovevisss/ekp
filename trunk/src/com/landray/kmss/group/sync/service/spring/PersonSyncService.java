package com.landray.kmss.group.sync.service.spring;

import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.component.dbop.model.CompDbcp;
import com.landray.kmss.group.sync.service.IHrSyncService;
import com.landray.kmss.hr.staff.model.HrStaffPersonInfo;
import com.landray.kmss.hr.staff.service.IHrStaffPersonExperienceContractService;
import com.landray.kmss.hr.staff.service.IHrStaffPersonInfoService;
import com.landray.kmss.sys.organization.service.ISysOrgElementService;
import com.landray.kmss.sys.quartz.interfaces.SysQuartzJobContext;
import com.landray.kmss.sys.util.DBsourceUtils;
import com.landray.kmss.util.SpringBeanUtil;
import org.springframework.util.StringUtils;

import java.sql.Connection;
import java.sql.Statement;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.landray.kmss.group.sync.constant.BeglGroupConstant.*;
import static com.landray.kmss.sys.util.DBsourceUtils.*;

public class PersonSyncService extends HrSyncService implements IHrSyncService {


    @Override
    public void HrSync(SysQuartzJobContext jobContext) throws Exception {

        try{
            jobContext.logMessage("开始同步HR_PERSON人员信息");
            HQLInfo hqlInfo = new HQLInfo();
//            String where = "fdIsAvailable = 1";
//            hqlInfo.setWhereBlock(where);

//            获取hrpersoninfo
            this.hrStaffPersonInfoService = (IHrStaffPersonInfoService) SpringBeanUtil.getBean("hrStaffPersonInfoService");
            List<HrStaffPersonInfo> hrStaffPersonInfoServiceList = hrStaffPersonInfoService.findList(hqlInfo);
//            获取hrStaffPersonExperienceContractService
            this.setHrStaffPersonExperienceContractService((IHrStaffPersonExperienceContractService) SpringBeanUtil.getBean("hrStaffPersonExperienceContractService"));
//            获取sysOrgElementService
            this.setSysOrgElementService((ISysOrgElementService) SpringBeanUtil.getBean("sysOrgElementService"));
            CompDbcp baseModel  = DBsourceUtils.getDBSource(THIRDDB);

//            jobContext.logMessage("执行sql语句:" + sql);
            for (HrStaffPersonInfo staff : hrStaffPersonInfoServiceList) {
                getContract(jobContext, staff);
                getSysOrg(jobContext, staff);
                this.role = getRole(jobContext, staff,this.sysOrgElementService);
                jobContext.logMessage("同步人员业务信息表HR_PERSON" + staff.getFdName());
                //write a sql check if the staff.getFdId() id exist in database if exist insert else update

                this.sqlmap = setHR_PERSON(staff);
                String sql = prepareSQL(sqlmap, "PERSON");
//                String sql = "replace into HR_PERSON(PERSONID, CORPID, CORPCODE, CORPNAME, CORPCODE_GZ) " +
//                        "values('" + staff.getFdId()+ "','"
//                        + staff.getFdName()+ "','"
//                        + staff.getFdName()+ "','"
//                        + "role"  + "','"
//                        + "嘉兴国投2')";

                jobContext.logMessage("执行sql语句:" + sql);
                Connection con = getConnection(baseModel);
                Statement stmt = con.createStatement();
                int rs = stmt.executeUpdate(sql);
                stmt.close();
                con.close();





//                JSONObject jsonObject = new JSONObject();
//                jsonObject.put("ProductID",staff.getFdId());
//                jsonObject.put("Description",staff.getFdOrgType());
//                jsonObject.put("Price",staff.getFdOrgType());
//                jsonObject.put("Quantity",staff.getFdOrgType());
//                jsonObject.put("Name",staff.getFdName());
//                invokeSingleApi(jsonObject,"http://127.0.0.1:8000/products");
            }
//            invokeApi(personListToJsonArray((List<SysOrgElement>) lsstaff, true), "http://127.0.0.1:8000/products");
        } catch (Exception e){
            jobContext.logError("同步人员信息失败" + e.getMessage());
        }


    }

    @Override
    public Map<String, Object> setHR_PERSON(HrStaffPersonInfo staff) throws Exception {

//        这里一一对应key value
        Map<String, Object> sqlmap = new HashMap<>();
        sqlmap.put("PERSONID", staff.getFdId());
        sqlmap.put("CORPID", 101);
        sqlmap.put("CORPCODE", "浙江嘉兴国有资本投资运营有限公司(本部)");
        sqlmap.put("CORPNAME", "浙江嘉兴国有资本投资运营有限公司(本部)");
        sqlmap.put("BILLID", staff.getFdId());
        sqlmap.put("NAME", staff.getFdName());
        sqlmap.put("CARDID",staff.getFdStaffNo());  //staff.getFdStaffNo()
        sqlmap.put("SEX", staff.getFdSex());
        sqlmap.put("BIRTHDAY", staff.getFdDateOfBirth());
        sqlmap.put("IDENTITYID", staff.getFdIdCard());
        sqlmap.put("MARRIAGE", staff.getFdMaritalStatus());
        sqlmap.put("NATION", staff.getFdNation());
        sqlmap.put("NATIVEPLACE", staff.getFdNativePlace());
        sqlmap.put("HUKOU_ADDRESS", staff.getFdHomeplace());
        sqlmap.put("POLITY", staff.getFdPoliticalLandscape());

        // check staff.getFdDateOfParty() and staff.getFdDateOfGroup() if both null set null else set Party or Group if both not null (set Party)
//        如果为空就会报错  暂时去掉
//        if(staff.getFdDateOfParty() == null)
//        {
//            if(staff.getFdDateOfGroup() == null)
//            {
//                sqlmap.put("POLITYDATE", null);
//            }
//            else {
//                sqlmap.put("POLITYDATE", staff.getFdDateOfGroup());
//            }
//        }
//        else {
//            sqlmap.put("POLITYDATE",null);
//        }

        sqlmap.put("STRINGFIELD6", staff.getFdHealth());
        sqlmap.put("TELEPHONENUMBER", staff.getFdMobileNo());
        sqlmap.put("EMAIL", staff.getFdEmail());
        sqlmap.put("ADDRESS", staff.getFdLivingPlace());
        sqlmap.put("DEPT_NAME", this.department.getName());
        sqlmap.put("DEPT_CODE", this.department.getCode());
        sqlmap.put("DEPT_ID", this.department.getId());
        sqlmap.put("ROLE_NAME", this.role.getName());
        sqlmap.put("ROLE_CODE", this.role.getId());
        sqlmap.put("ROLE_ID", this.role.getId());
//        sqlmap.put("JOBDATE", staff.getFdWorkTime());
//        sqlmap.put("CORPDATE", staff.getFdTimeOfEnterprise());
        sqlmap.put("SERVICESTATUS_MODEL", WORK_STATUS_MAP.get(staff.getFdStatus()).getWorkCode());
        sqlmap.put("SERVICESTATUS_NAME", WORK_STATUS_MAP.get(staff.getFdStatus()).getName());
        sqlmap.put("SERVICESTATUS_CODE", WORK_STATUS_MAP.get(staff.getFdStatus()).getTypeCode());
//        sqlmap.put("PASSDATE", staff.getFdPositiveTime());
//        sqlmap.put("DIMISSIONDATE", staff.getFdLeaveTime());
        sqlmap.put("PERSONKIND", staff.getFdStaffType());

        sqlmap.put("AGREEMENT_SIGN", 1);
        System.out.println("StringUtils.getFdStaffType() = " + StringUtils.isEmpty(this.contract.getAgreementType()));
        if(!StringUtils.isEmpty(this.contract.getAgreementType()))
        {
            sqlmap.put("AGREEMENT_TYPE", AGREEMENTTYPE.get(this.contract.getAgreementType()));
//        sqlmap.put("AGREEMENTPERIOD", )     //合同期限待定
            sqlmap.put("AGREEMENTDATE", this.contract.getAgreementBeginDate());
            if(!this.contract.getIsLongTerm())
            {
                sqlmap.put("AGREEMENT_ENDDATE", this.contract.getAgreementEndDate());
            }
        }

        return sqlmap;

    }
}
