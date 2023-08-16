package com.landray.kmss.km.carmng.transfer;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.hibernate.query.Query;

import com.landray.kmss.km.carmng.service.IKmCarmngUserFeeInfoService;
import com.landray.kmss.sys.admin.transfer.service.ISysAdminTransferChecker;
import com.landray.kmss.sys.admin.transfer.service.spring.SysAdminTransferCheckContext;
import com.landray.kmss.sys.admin.transfer.service.spring.SysAdminTransferCheckResult;
import com.landray.kmss.util.SpringBeanUtil;

/**
 * <P>检测迁移任务是否需要执行</P>
 * @author 孙佳
 * @version 1.0 2019年3月19日
 */
public class KmCarmngUserFeeChecker implements ISysAdminTransferChecker {

	protected final Logger logger = org.slf4j.LoggerFactory.getLogger(getClass());

	@Override
    public SysAdminTransferCheckResult check(
			SysAdminTransferCheckContext sysAdminTransferCheckContext) {

		IKmCarmngUserFeeInfoService kmCarmngUserFeeInfoService = (IKmCarmngUserFeeInfoService) SpringBeanUtil
				.getBean("kmCarmngUserFeeInfoService");

		String hql = "select count(*) from KmCarmngUserFeeInfo where fdApplicationDept is null";

		try {
			Query q = kmCarmngUserFeeInfoService.getBaseDao()
					.getHibernateSession().createQuery(hql);
			Long count = (Long) q.uniqueResult();

			if (count == 0) {
				return SysAdminTransferCheckResult.TASK_STATUS_RUNED;
			}

		} catch (Exception e) {
			logger.error("检查用车费用表部门信息是否为空异常", e);
		}
		return SysAdminTransferCheckResult.TASK_STATUS_NOT_RUNED;
	}
}
