package com.landray.kmss.group.sync.service;

import com.landray.kmss.sys.quartz.interfaces.SysQuartzJobContext;

public interface IWorkShiftSyncService {

        void WorkShiftSync(SysQuartzJobContext jobContext) throws Exception;
}
