package com.landray.kmss.km.carmng.transfer;

import java.util.ArrayList;
import java.util.List;

import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.km.carmng.model.KmCarmngDriversInfo;
import com.landray.kmss.km.carmng.service.IKmCarmngDriversInfoService;
import com.landray.kmss.sys.admin.transfer.model.SysAdminTransferTask;
import com.landray.kmss.sys.admin.transfer.service.ISysAdminTransferTask;
import com.landray.kmss.sys.admin.transfer.service.ISysAdminTransferTaskService;
import com.landray.kmss.sys.admin.transfer.service.spring.SysAdminTransferContext;
import com.landray.kmss.sys.admin.transfer.service.spring.SysAdminTransferResult;
import com.landray.kmss.sys.authentication.transfer.SysAuthTransferChecker;
import com.landray.kmss.util.SpringBeanUtil;

/**
 * 权限数据迁移
 * 
 * @author 魏本源
 * @version 1.0 2015-07-09
 */
@SuppressWarnings("all")
public class KmCarmngTransferTask extends SysAuthTransferChecker implements
		ISysAdminTransferTask {

	public SysAdminTransferResult run(
			SysAdminTransferContext sysAdminTransferContext) {
		String uuid = sysAdminTransferContext.getUUID();
		ISysAdminTransferTaskService sysAdminTransferTaskService = (ISysAdminTransferTaskService) SpringBeanUtil
				.getBean("sysAdminTransferTaskService");
		IKmCarmngDriversInfoService kmCarmngDriversInfoService = (IKmCarmngDriversInfoService) SpringBeanUtil
				.getBean("kmCarmngDriversInfoService");
		try {
			List sysAdminTransferTasklist = new ArrayList();
			sysAdminTransferTasklist = sysAdminTransferTaskService.getBaseDao()
					.findValue(null,
							"sysAdminTransferTask.fdUuid='" + uuid + "'", null);
			SysAdminTransferTask sysAdminTransferTask = (SysAdminTransferTask) sysAdminTransferTasklist
					.get(0);
			if (sysAdminTransferTask.getFdStatus() != 1) {
				HQLInfo hqlInfo = new HQLInfo();
				hqlInfo.setFromBlock("KmCarmngDriversInfo kmCarmngDriversInfo");
				hqlInfo.setWhereBlock(" kmCarmngDriversInfo.fdType =:fdType ");
				hqlInfo.setParameter("fdType", "1");

				List<KmCarmngDriversInfo> list = kmCarmngDriversInfoService
						.getBaseDao().findList(hqlInfo);
				for (KmCarmngDriversInfo kmCarmngDriversInfo : list) {
					kmCarmngDriversInfo.setFdSysId("");
					kmCarmngDriversInfoService.update(kmCarmngDriversInfo);
				}
			}
		} catch (Exception e) {
			logger.error("检查车辆管理是否为空异常", e);
		}
		return SysAdminTransferResult.OK;
	}

}
