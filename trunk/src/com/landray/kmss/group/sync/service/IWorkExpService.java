package com.landray.kmss.group.sync.service;

import com.landray.kmss.sys.quartz.interfaces.SysQuartzJobContext;

public interface IWorkExpService {

    void WorkExpSync(SysQuartzJobContext jobContext) throws Exception;
}
