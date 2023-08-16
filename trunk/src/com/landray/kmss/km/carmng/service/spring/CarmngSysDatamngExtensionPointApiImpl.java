package com.landray.kmss.km.carmng.service.spring;

import com.alibaba.fastjson.JSONArray;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.common.module.core.register.annotation.declare.ApiImplement;
import com.landray.kmss.km.carmng.service.ICarmngSysDatamngExtensionPointApi;
import com.landray.kmss.km.carmng.service.IKmCarmngInfomationService;

import java.util.List;
import java.util.Map;

public class CarmngSysDatamngExtensionPointApiImpl implements ICarmngSysDatamngExtensionPointApi {

    private IKmCarmngInfomationService kmCarmngInfomationService;

    public void setKmCarmngInfomationService(IKmCarmngInfomationService kmCarmngInfomationService) {
        this.kmCarmngInfomationService = kmCarmngInfomationService;
    }

    @Override
    @ApiImplement("com.landray.kmss.sys.datamng.depend.ISysDatamngExtensionPointApi")
    public void init(Map<String, JSONArray> extensionPointConfig) throws Exception {

    }

    @Override
    @ApiImplement("com.landray.kmss.sys.datamng.depend.ISysDatamngExtensionPointApi")
    public List<IBaseModel> selectCategory() throws Exception {
        HQLInfo hqlInfo = new HQLInfo();
        hqlInfo.setFromBlock("com.landray.kmss.km.carmng.model.KmCarmngInfomation AS kmCarmngInfomation");
        return kmCarmngInfomationService.findList(hqlInfo);
    }
}
