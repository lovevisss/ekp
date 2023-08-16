package com.landray.kmss.km.carmng.service.spring;

import java.util.List;

import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.km.carmng.model.KmCarmngDriversInfo;
import com.landray.kmss.km.carmng.service.IKmCarmngDriversInfoService;
import com.landray.kmss.sys.organization.interfaces.ISysOrgCoreService;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.sys.quartz.interfaces.SysQuartzJobContext;
import com.landray.sso.client.util.StringUtil;

/**
 * <P>定时任务--同步驾驶员手机号码</P>
 * @author 孙佳
 * 2018年12月3日
 */
public class KmCarmngSynMobileQuartzServiceImp {

	private ISysOrgCoreService sysOrgCoreService;

	public void setSysOrgCoreService(ISysOrgCoreService sysOrgCoreService) {
		this.sysOrgCoreService = sysOrgCoreService;
	}


	private IKmCarmngDriversInfoService kmCarmngDriversInfoService;

	public void setKmCarmngDriversInfoService(IKmCarmngDriversInfoService kmCarmngDriversInfoService) {
		this.kmCarmngDriversInfoService = kmCarmngDriversInfoService;
	}


	public void synMobile(SysQuartzJobContext jobContext) {
		try {
			HQLInfo hqlInfo = new HQLInfo();
			String whereBlock = " 1=1 ";
			whereBlock += " and kmCarmngDriversInfo.fdType = 2";
			hqlInfo.setWhereBlock(whereBlock);
			List<KmCarmngDriversInfo> driversInfos = kmCarmngDriversInfoService.findList(hqlInfo);
			if(null != driversInfos && driversInfos.size() > 0){
				for (KmCarmngDriversInfo driversInfo : driversInfos) {
					SysOrgPerson orgPerson = (SysOrgPerson) sysOrgCoreService
							.findByPrimaryKey(driversInfo.getFdSysId(),
									SysOrgPerson.class);
					if (null != orgPerson && StringUtil.isNotNull(orgPerson.getFdMobileNo())
							&& !orgPerson.getFdMobileNo().equals(driversInfo.getFdRelationPhone())) {
						driversInfo.setFdRelationPhone(orgPerson.getFdMobileNo());
						kmCarmngDriversInfoService.update(driversInfo);
					}
				}
			}
		} catch (Exception e) {
			jobContext.logError(e);
		}
	}

}
