package com.landray.kmss.group.sync.service.spring;

import com.landray.kmss.group.sync.service.IHrSyncService;
import com.landray.kmss.hr.staff.model.HrStaffPersonInfo;

import java.util.HashMap;
import java.util.Map;

import static com.landray.kmss.group.sync.constant.BeglGroupConstant.AGREEMENTTYPE;
import static com.landray.kmss.group.sync.constant.BeglGroupConstant.WORK_STATUS_MAP;

public class PersonSyncService extends HrSyncService implements IHrSyncService {

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
}
