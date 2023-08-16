package com.landray.kmss.km.carmng.service;

import java.util.List;
import java.util.Map;

import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.km.carmng.model.KmCarmngApplication;
import com.landray.kmss.sys.metadata.interfaces.IExtendDataService;

/**
 * 创建日期 2010-三月-24
 * 
 * @author 叶中奇 用车申请业务对象接口
 */
public interface IKmCarmngApplicationService extends IExtendDataService {
	void saveSendNotify(KmCarmngApplication kmCarmngApplication, List otherUser,
			StringBuffer driverMsg)
			throws Exception;

	/**
	 * <p>变更调度发送待阅</p>
	 * @param kmCarmngApplication
	 * @throws Exception
	 * @author 孙佳
	 */
	public void sendNotify_update(KmCarmngApplication kmCarmngApplication,
			List otherUser, StringBuffer driverMsg) throws Exception;

	/**
	 * 车辆申请门户部件数据源
	 * 
	 * @param request
	 *            请求
	 * @return
	 * @throws Exception
	 */
	public Map<String, ?> listPortlet(RequestContext request) throws Exception;

}
