package com.landray.kmss.km.carmng.dao.hibernate;

import com.landray.kmss.common.dao.BaseDaoImp;
import com.landray.kmss.km.carmng.dao.IKmCarmngApplicationDao;

/**
 * 创建日期 2010-三月-24
 * 
 * @author 叶中奇 用车申请数据访问接口实现
 */
public class KmCarmngApplicationDaoImp extends BaseDaoImp implements
		IKmCarmngApplicationDao {
	// @Override
	// public String add(IBaseModel modelObj) throws Exception {
	// KmCarmngApplication kmCarmngApplication = (KmCarmngApplication) modelObj;
	// SysOrgElement sysOrgPerson = UserUtil.getUser();
	// SysOrgElement fdDispatchers = (SysOrgElement)
	// kmCarmngApplication.getFdMotorcade().getFdDispatchers();
	// if(sysOrgPerson.getFdId().equals(fdDispatchers.getFdId()) && !
	// kmCarmngApplication.getDocStatus().equals(SysDocConstant.DOC_STATUS_DRAFT)){
	// kmCarmngApplication.setDocStatus(SysDocConstant.DOC_STATUS_PUBLISH);
	// }
	// return super.add(kmCarmngApplication);
	// }

}
