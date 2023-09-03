package com.landray.kmss.group.sync.service;

import com.landray.kmss.hr.staff.model.HrStaffPersonInfo;
import com.landray.kmss.sys.quartz.interfaces.SysQuartzJobContext;

import java.util.Map;

public interface IHrSyncService {

    void HrSync(SysQuartzJobContext context) throws Exception;

    Map<String, Object> setHR_PERSON(HrStaffPersonInfo staff) throws Exception;
}
