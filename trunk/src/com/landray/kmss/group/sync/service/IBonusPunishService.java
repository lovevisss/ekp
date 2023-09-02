package com.landray.kmss.group.sync.service;

import com.landray.kmss.sys.quartz.interfaces.SysQuartzJobContext;

public interface IBonusPunishService {

        void BonusPunishSync(SysQuartzJobContext jobContext) throws Exception;
}
