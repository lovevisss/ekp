package com.landray.kmss.group.sync.service;

import com.landray.kmss.sys.quartz.interfaces.SysQuartzJobContext;

public interface IHrSyncService {

    void HrSync(SysQuartzJobContext context) throws Exception;
}
