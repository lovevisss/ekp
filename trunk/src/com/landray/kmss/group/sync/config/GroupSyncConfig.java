package com.landray.kmss.group.sync.config;

import com.landray.kmss.sys.appconfig.model.BaseAppConfig;
/**
 * 人员同步配置页面
 **/
public class GroupSyncConfig extends BaseAppConfig {

    public GroupSyncConfig() throws Exception {
    }

    @Override
    public String getJSPUrl() {
            return "/group/sync/attendance_sync_config.jsp";
    }


    public String getValue(String name) {
        return super.getValue(name);
    }

    @Override
    protected void setValue(String name, String value) {
        super.setValue(name, value);
        try {
            super.save();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }


    public static GroupSyncConfig get(){
        try {
            return new GroupSyncConfig();
        } catch (Exception e) {
            return null;
        }
    }
}

