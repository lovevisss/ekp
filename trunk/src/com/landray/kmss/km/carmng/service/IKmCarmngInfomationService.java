package com.landray.kmss.km.carmng.service;

import com.landray.kmss.common.service.IBaseService;

import net.sf.json.JSONArray;


/**
 * 创建日期 2010-三月-24
 * @author 叶中奇
 * 车辆信息业务对象接口
 */
public interface IKmCarmngInfomationService  extends IBaseService {
	/**
	 * 获取车辆的图片
	 */
	public String getCarPicIdsByCarId(String fdId) throws Exception;

	/**
	 * 根据id值查找车辆信息
	 * @param fdEndTime 
	 * @param fdStartTime 
	 * 
	 * @param fdClaimantId
	 * @return
	 * @throws Exception
	 */
	public JSONArray loadCarByIds(String[] fdIds, String fdStartTime, String fdEndTime) throws Exception;

}
