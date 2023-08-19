package com.landray.kmss.km.carmng.service;

import com.landray.kmss.sys.quartz.interfaces.SysQuartzJobContext;

public interface KmCarmngHrQuartzService {
    public void runHrsync(SysQuartzJobContext jobContext) throws Exception;
}
