package com.landray.kmss.km.carmng.service;

import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.km.carmng.model.KmCarmngRegisterInfo;


/**
 * 创建日期 2010-三月-24
 * @author 叶中奇
 * 回车登记单业务对象接口
 */
public interface IKmCarmngRegisterInfoService  extends IBaseService {
   
	public KmCarmngRegisterInfo getRegisterByDispatchersId(String dispatchersId) throws Exception;
}
