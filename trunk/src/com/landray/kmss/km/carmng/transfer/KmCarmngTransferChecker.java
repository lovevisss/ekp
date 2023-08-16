package com.landray.kmss.km.carmng.transfer;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.hibernate.query.Query;

import com.landray.kmss.km.carmng.service.IKmCarmngApplicationService;
import com.landray.kmss.sys.admin.transfer.service.ISysAdminTransferChecker;
import com.landray.kmss.sys.admin.transfer.service.spring.SysAdminTransferCheckContext;
import com.landray.kmss.sys.admin.transfer.service.spring.SysAdminTransferCheckResult;
import com.landray.kmss.util.SpringBeanUtil;

/**
 * 检测迁移任务是否需要执行
 * 
 * @author 魏本源
 * @version 1.0 2015-07-09
 */
public class KmCarmngTransferChecker implements ISysAdminTransferChecker {

	protected final Logger logger = org.slf4j.LoggerFactory.getLogger(getClass());

	@Override
    public SysAdminTransferCheckResult check(
			SysAdminTransferCheckContext sysAdminTransferCheckContext) {

		IKmCarmngApplicationService kmCarmngApplicationService = (IKmCarmngApplicationService) SpringBeanUtil
				.getBean("kmCarmngApplicationService");

		String hql = "select count(*) from KmCarmngApplication where 1 = 1";

		try {
			Query q = kmCarmngApplicationService.getBaseDao()
					.getHibernateSession().createQuery(hql);
			Long count = (Long) q.uniqueResult();

			if (count == 0) {
				return SysAdminTransferCheckResult.TASK_STATUS_RUNED;
			}

		} catch (Exception e) {
			logger.error("检查车辆管理是否为空异常", e);
		}
		return SysAdminTransferCheckResult.TASK_STATUS_NOT_RUNED;
	}
}
