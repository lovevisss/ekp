package com.landray.kmss.km.carmng.transfer;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

import com.landray.kmss.util.DbUtils;
import org.slf4j.Logger;
import com.landray.kmss.sys.admin.transfer.model.SysAdminTransferTask;
import com.landray.kmss.sys.admin.transfer.service.ISysAdminTransferChecker;
import com.landray.kmss.sys.admin.transfer.service.ISysAdminTransferTaskService;
import com.landray.kmss.sys.admin.transfer.service.spring.SysAdminTransferCheckContext;
import com.landray.kmss.sys.admin.transfer.service.spring.SysAdminTransferCheckResult;
import com.landray.kmss.util.SpringBeanUtil;

import javax.sql.DataSource;


public class KmCarmngNewChecker implements ISysAdminTransferChecker {

	protected final Logger logger = org.slf4j.LoggerFactory.getLogger(getClass());

	@Override
    public SysAdminTransferCheckResult check(
			SysAdminTransferCheckContext sysAdminTransferCheckContext) {
		try {
			ISysAdminTransferTaskService sysAdminTransferTaskService = (ISysAdminTransferTaskService) SpringBeanUtil
					.getBean("sysAdminTransferTaskService");
			String uuid = sysAdminTransferCheckContext.getUUID();
			List list = new ArrayList();
			list = sysAdminTransferTaskService.getBaseDao().findValue(null,
					"sysAdminTransferTask.fdUuid='" + uuid + "'", null);
			if (list.size() > 0) {
				SysAdminTransferTask sysAdminTransferTask = (SysAdminTransferTask) list.get(0);
				if (sysAdminTransferTask.getFdStatus() == 1) {
					return SysAdminTransferCheckResult.TASK_STATUS_RUNED;
				}
			}
			//如果km_carmng_dispatchers_info的fd_car_info_id不存在 则不执行
			if(!DbUtils.isExitTableInfo("km_carmng_dispatchers_info","fd_car_info_id")){
				return SysAdminTransferCheckResult.TASK_STATUS_RUNED;
			}
			} catch (Exception e) {
			logger.error("", e);
		}
		return SysAdminTransferCheckResult.TASK_STATUS_NOT_RUNED;
	}
}
