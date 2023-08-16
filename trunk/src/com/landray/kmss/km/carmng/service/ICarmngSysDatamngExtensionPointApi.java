package com.landray.kmss.km.carmng.service;

import com.alibaba.fastjson.JSONArray;
import com.landray.kmss.common.model.IBaseModel;

import java.util.List;
import java.util.Map;

public interface ICarmngSysDatamngExtensionPointApi {

    /**
     * 数据管理定制入口
     * @param extensionPointConfig
     * @throws Exception
     */
    public void init(Map<String, JSONArray> extensionPointConfig) throws Exception;

    /**
     * 数据管理授权范围分类数据
     *  当它的类型不是全局分类或者简单分类，同时需要有一定条件(如：状态)过滤时，需要实现此接口
     * @return
     * @throws Exception
     */
    public List<IBaseModel> selectCategory() throws Exception;

}
