package com.landray.kmss.km.carmng.service;

import com.landray.kmss.sys.quartz.interfaces.SysQuartzJobContext;

public interface IKmCarmngQuartzService {
	public void runCarmngNotify(SysQuartzJobContext jobContext) throws Exception;
}
