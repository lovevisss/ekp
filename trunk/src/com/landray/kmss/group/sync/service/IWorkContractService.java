package com.landray.kmss.group.sync.service;

import com.landray.kmss.sys.quartz.interfaces.SysQuartzJobContext;

public interface IWorkContractService {
    public void WorkContractSync(SysQuartzJobContext jobContext) throws Exception ;

}
