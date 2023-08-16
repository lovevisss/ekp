package com.landray.kmss.km.carmng.transfer;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.km.carmng.model.KmCarmngMotorcadeSet;
import com.landray.kmss.km.carmng.service.IKmCarmngMotorcadeSetService;
import com.landray.kmss.sys.admin.transfer.model.SysAdminTransferTask;
import com.landray.kmss.sys.admin.transfer.service.ISysAdminTransferTask;
import com.landray.kmss.sys.admin.transfer.service.ISysAdminTransferTaskService;
import com.landray.kmss.sys.admin.transfer.service.spring.SysAdminTransferContext;
import com.landray.kmss.sys.admin.transfer.service.spring.SysAdminTransferResult;
import com.landray.kmss.util.SpringBeanUtil;

public class KmCarmngMotorcadeSetTask extends KmCarmngMotorcadeSetChecker implements
		ISysAdminTransferTask {
	protected final Logger logger = org.slf4j.LoggerFactory.getLogger(getClass());
	
	@Override
    public SysAdminTransferResult run(
			SysAdminTransferContext sysAdminTransferContext) {
		String uuid=sysAdminTransferContext.getUUID();	
		ISysAdminTransferTaskService sysAdminTransferTaskService=(ISysAdminTransferTaskService)SpringBeanUtil.getBean("sysAdminTransferTaskService");
		IKmCarmngMotorcadeSetService kmCarmngMotorcadeSetService = (IKmCarmngMotorcadeSetService) SpringBeanUtil.getBean("kmCarmngMotorcadeSetService");
		try {
			List sysAdminTransferList=new ArrayList();
			sysAdminTransferList=sysAdminTransferTaskService.getBaseDao().findValue(null, "sysAdminTransferTask.fdUuid='"+uuid+"'", null);		
			SysAdminTransferTask sysAdminTransferTask=(SysAdminTransferTask)sysAdminTransferList.get(0);
			if (sysAdminTransferTask.getFdStatus() != 1) {
				HQLInfo hqlInfo = new HQLInfo();
				hqlInfo.setSelectBlock("kmCarmngMotorcadeSet");
				KmCarmngMotorcadeSet kmCarmngMotorcadeSet = new KmCarmngMotorcadeSet();
				List list = kmCarmngMotorcadeSetService.findValue(hqlInfo);
				if (list != null && list.size() > 0) {
					for (Iterator iter = list.iterator(); iter.hasNext();) {
						kmCarmngMotorcadeSet = (KmCarmngMotorcadeSet) iter.next();
						kmCarmngMotorcadeSetService.update(kmCarmngMotorcadeSet);						
					}
				}
			}
		} catch (Exception e) {
			logger.error("执行旧数据迁移为空异常", e);

		}
		
		return SysAdminTransferResult.OK;
	}
}
