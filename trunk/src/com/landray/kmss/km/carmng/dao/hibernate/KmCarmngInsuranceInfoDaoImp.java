package com.landray.kmss.km.carmng.dao.hibernate;

import java.util.Date;

import com.landray.kmss.common.dao.BaseDaoImp;
import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.km.carmng.dao.IKmCarmngInsuranceInfoDao;
import com.landray.kmss.km.carmng.model.KmCarmngInsuranceInfo;
import com.landray.kmss.util.UserUtil;


/**
 * 创建日期 2010-三月-24
 * @author 叶中奇
 * 车辆保险数据访问接口实现
 */
public class KmCarmngInsuranceInfoDaoImp extends BaseDaoImp implements IKmCarmngInsuranceInfoDao {
	
	@Override
    public void update(IBaseModel modelObj) throws Exception {
		KmCarmngInsuranceInfo kmCarmngInsuranceInfo = (KmCarmngInsuranceInfo) modelObj;
		kmCarmngInsuranceInfo.setDocModifyTime(new Date());
		kmCarmngInsuranceInfo.setDocModifier(UserUtil.getUser());
		super.update(kmCarmngInsuranceInfo);
	}


}
