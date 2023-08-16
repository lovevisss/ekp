package com.landray.kmss.km.carmng.service.spring;

import java.util.List;

import org.hibernate.query.Query;

import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.common.service.BaseServiceImp;
import com.landray.kmss.km.carmng.model.KmCarmngDriversInfo;
import com.landray.kmss.km.carmng.model.KmCarmngInfomation;
import com.landray.kmss.km.carmng.service.IKmCarmngDriversInfoService;
import com.landray.kmss.km.carmng.service.IKmCarmngInfomationService;
import com.landray.kmss.util.SpringBeanUtil;

/**
 * 创建日期 2010-三月-24
 * 
 * @author 叶中奇 驾驶员信息业务接口实现
 */
public class KmCarmngDriversInfoServiceImp extends BaseServiceImp implements
		IKmCarmngDriversInfoService {

	protected IKmCarmngInfomationService kmCarmngInfomationService;

	protected IKmCarmngInfomationService getKmCarmngInfomationService() {
		if (kmCarmngInfomationService == null) {
            kmCarmngInfomationService = (IKmCarmngInfomationService) SpringBeanUtil
                    .getBean("kmCarmngInfomationService");
        }
		return kmCarmngInfomationService;
	}

	@Override
	public void update(IBaseModel modelObj) throws Exception {
		KmCarmngDriversInfo driversInfo = (KmCarmngDriversInfo) modelObj;
		super.update(modelObj);
		//更新车辆绑定的驾驶员姓名
		HQLInfo hqlInfo = new HQLInfo();
		hqlInfo.setWhereBlock("kmCarmngInfomation.fdDriverId = :fdDriverId");
		hqlInfo.setParameter("fdDriverId", modelObj.getFdId());
		List<KmCarmngInfomation> list = getKmCarmngInfomationService().findList(hqlInfo);
		for (KmCarmngInfomation infomation : list) {
			infomation.setFdDriverName(driversInfo.getFdName());
			getKmCarmngInfomationService().update(infomation);
		}
	}

	@Override
	public void delete(IBaseModel modelObj) throws Exception {
		String fdDriverId = modelObj.getFdId();
		String hql = "update com.landray.kmss.km.carmng.model.KmCarmngInfomation set fdDriverId=NULL,fdDriverName=NULL where fdDriverId=:_fdDriverId";
		Query query = getKmCarmngInfomationService().getBaseDao()
				.getHibernateSession().createQuery(hql);
		query.setParameter("_fdDriverId", fdDriverId);
		query.executeUpdate();
		super.delete(modelObj);
	}
}
