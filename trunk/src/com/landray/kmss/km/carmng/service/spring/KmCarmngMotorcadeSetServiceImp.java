package com.landray.kmss.km.carmng.service.spring;

import com.landray.kmss.common.service.BaseServiceImp;
import com.landray.kmss.km.carmng.service.IKmCarmngMotorcadeSetService;
import com.landray.kmss.sys.number.interfaces.ISysNumberFlowService;
/**
 * 创建日期 2010-三月-24
 * @author 叶中奇
 * 车队设置业务接口实现
 */
public class KmCarmngMotorcadeSetServiceImp extends BaseServiceImp implements IKmCarmngMotorcadeSetService {
	private ISysNumberFlowService sysNumberFlowService;

	public void setSysNumberFlowService(
			ISysNumberFlowService sysNumberFlowService) {
		this.sysNumberFlowService = sysNumberFlowService;
	}

}
