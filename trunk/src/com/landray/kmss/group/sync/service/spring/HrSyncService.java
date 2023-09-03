package com.landray.kmss.group.sync.service.spring;

import DBstep.iDBManager2000;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.component.dbop.model.CompDbcp;
import com.landray.kmss.component.dbop.util.CompDbcpUtil;
import com.landray.kmss.group.sync.model.Contract;
import com.landray.kmss.group.sync.model.Department;
import com.landray.kmss.group.sync.service.IHrSyncService;
import com.landray.kmss.hr.staff.model.HrStaffPersonExperienceContract;
import com.landray.kmss.hr.staff.model.HrStaffPersonInfo;
import com.landray.kmss.hr.staff.service.IHrStaffPersonExperienceContractService;
import com.landray.kmss.hr.staff.service.IHrStaffPersonInfoService;
import com.landray.kmss.sys.organization.service.ISysOrgElementService;
import com.landray.kmss.sys.quartz.interfaces.SysQuartzJobContext;
import com.landray.kmss.sys.util.DBsourceUtils;
import com.landray.kmss.util.ClassUtils;
import com.landray.kmss.util.SpringBeanUtil;

import java.sql.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.landray.kmss.group.sync.constant.BeglGroupConstant.*;
import static com.landray.kmss.sys.util.DBsourceUtils.getConnection;
import static com.landray.kmss.sys.util.DBsourceUtils.prepareSQL;

public class HrSyncService implements IHrSyncService {
//    引入hrStaffPersonInfo表
    private ISysOrgElementService sysOrgElementService;
    private IHrStaffPersonInfoService hrStaffPersonInfoService;
    private IHrStaffPersonExperienceContractService hrStaffPersonExperienceContractService;
//合同信息
HrStaffPersonExperienceContract contractinfo = null;
    protected Contract contract = new Contract();
    protected Department department = new Department();
    private Map<String, Object> sqlmap = new HashMap<>();


    iDBManager2000 iDBManager2000 = new iDBManager2000();

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
            this.hrStaffPersonExperienceContractService = (IHrStaffPersonExperienceContractService) SpringBeanUtil.getBean("hrStaffPersonExperienceContractService");
//            获取sysOrgElementService
            this.sysOrgElementService = (ISysOrgElementService) SpringBeanUtil.getBean("sysOrgElementService");
            CompDbcp baseModel  = DBsourceUtils.getDBSource(THIRDDB);

//            jobContext.logMessage("执行sql语句:" + sql);
            for (HrStaffPersonInfo staff : hrStaffPersonInfoServiceList) {
                getContract(jobContext, staff);
                getSysOrg(jobContext, staff);
                jobContext.logMessage("同步人员业务信息表HR_PERSON" + staff.getFdName());
                //write a sql check if the staff.getFdId() id exist in database if exist insert else update

                this.sqlmap = setHR_PERSON(staff);
                String sql = prepareSQL(sqlmap, "HR_PERSON");
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

    private void getSysOrg(SysQuartzJobContext jobContext, HrStaffPersonInfo staff) throws Exception {
        iDBManager2000.OpenConnection();
        String selSql = "select * "
                + "from sys_org_element "
                + "where fd_id = '"+ staff.getFdId() + " '";
        System.out.println(selSql);
        ResultSet result = iDBManager2000.ExecuteQuery(selSql);
        jobContext.logMessage("result" + result);
        while (result.next()){
            this.department.setId(result.getString("fd_no"));
            this.department.setName(result.getString("fd_name"));
            this.department.setCode(result.getString("fd_name"));
        }

        iDBManager2000.CloseConnection();
    }



    private void getContract(SysQuartzJobContext jobContext, HrStaffPersonInfo staff) throws Exception {

        iDBManager2000.OpenConnection();
        String selSql = "select * "
                + "from hr_staff_person_exp_cont "
                + "where fd_person_info_id = '"+ staff.getFdId() + " '";
        System.out.println(selSql);
        ResultSet result = iDBManager2000.ExecuteQuery(selSql);
        jobContext.logMessage("result" + result);
        while (result.next()){
            this.contract.setAgreementType(result.getString("fd_cont_status"));
            this.contract.setAgreementBeginDate(result.getDate("fd_begin_date"));
            this.contract.setAgreementEndDate(result.getDate("fd_end_date"));
        }

        iDBManager2000.CloseConnection();
//        HQLInfo hqlexp = new HQLInfo();
//        String whereexp = " fdPersonInfoId = '" + staff.getFdId() + "'";
//        jobContext.logMessage("where" + whereexp);
//        hqlexp.setWhereBlock(whereexp);
//        jobContext.logMessage("set where");
//        List<HrStaffPersonExperienceContract> hrStaffPersonExperienceContractList= hrStaffPersonExperienceContractService.findList(hqlexp);
//        if(hrStaffPersonExperienceContractList != null)
//        {
//            this.contractinfo = hrStaffPersonExperienceContractList.get(0);
//            jobContext.logMessage("contract" + contractinfo);
//        }
//        else {
//            jobContext.logMessage("contract is null");
//        }

    }

    //编写对应的sql语句

//按照表格填充内容
public Map<String, Object> setHR_PERSON(HrStaffPersonInfo staff) throws Exception {

//        这里一一对应key value
        Map<String, Object> sqlmap = new HashMap<>();
        sqlmap.put("PERSONID", staff.getFdId());
        sqlmap.put("CORPID", 101);
        sqlmap.put("CORPCODE", "浙江嘉兴国有资本投资运营有限公司(本部)");
        sqlmap.put("CORPNAME", "浙江嘉兴国有资本投资运营有限公司(本部)");
        sqlmap.put("CORPCODE_GZ", 101);
        sqlmap.put("CORPNAME_GZ", "浙江嘉兴国有资本投资运营有限公司(本部)");
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
        sqlmap.put("ROLE_NAME", "待定");
        sqlmap.put("ROLE_CODE", "待定");
        sqlmap.put("ROLE_ID", "待定");
//        sqlmap.put("JOBDATE", staff.getFdWorkTime());
//        sqlmap.put("CORPDATE", staff.getFdTimeOfEnterprise());
        sqlmap.put("SERVICESTATUS_MODEL", WORK_STATUS_MAP.get(staff.getFdStatus()).getWorkCode());
        sqlmap.put("SERVICESTATUS_NAME", WORK_STATUS_MAP.get(staff.getFdStatus()).getName());
        sqlmap.put("SERVICESTATUS_CODE", WORK_STATUS_MAP.get(staff.getFdStatus()).getTypeCode());
//        sqlmap.put("PASSDATE", staff.getFdPositiveTime());
//        sqlmap.put("DIMISSIONDATE", staff.getFdLeaveTime());
        sqlmap.put("PERSONKIND", staff.getFdStaffType());
        sqlmap.put("FRIST_KNOWLEDGE", staff.getFdHighestEducation());
        sqlmap.put("FRIST_SCHOOLKIND", staff.getFdHighestDegree());

        sqlmap.put("AGREEMENT_SIGN", 1);
        if(this.contractinfo != null)
        {
            sqlmap.put("AGREEMENT_TYPE", AGREEMENTTYPE.get(this.contractinfo.getFdContType()));
//        sqlmap.put("AGREEMENTPERIOD", )     //合同期限待定
            sqlmap.put("AGREEMENTDATE", this.contractinfo.getFdBeginDate());
            sqlmap.put("AGREEMENT_ENDDATE", this.contractinfo.getFdEndDate());
        }

        return sqlmap;

    }




    public void setHrStaffPersonExperienceContractService(IHrStaffPersonExperienceContractService hrStaffPersonExperienceContractService) {
        this.hrStaffPersonExperienceContractService = hrStaffPersonExperienceContractService;
    }



    public void setHrStaffPersonInfoService(IHrStaffPersonInfoService hrStaffPersonInfoService) {
        this.hrStaffPersonInfoService = hrStaffPersonInfoService;
    }

    public void setSysOrgElementService(ISysOrgElementService iSysOrgElementService) {
        this.sysOrgElementService = iSysOrgElementService;
    }

}
