package com.landray.kmss.group.sync.service;

import com.landray.kmss.sys.quartz.interfaces.SysQuartzJobContext;

public interface IFamilyMemberService {

    public void FamilyMemberSync(SysQuartzJobContext jobContext) throws Exception;

}
