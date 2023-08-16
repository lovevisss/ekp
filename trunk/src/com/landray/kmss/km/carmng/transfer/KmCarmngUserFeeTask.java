package com.landray.kmss.km.carmng.transfer;

import java.util.List;

import com.landray.kmss.km.carmng.model.KmCarmngApplication;
import com.landray.kmss.km.carmng.model.KmCarmngUserFeeInfo;
import com.landray.kmss.km.carmng.service.IKmCarmngApplicationService;
import com.landray.kmss.km.carmng.service.IKmCarmngUserFeeInfoService;
import com.landray.kmss.sys.admin.transfer.service.ISysAdminTransferTask;
import com.landray.kmss.sys.admin.transfer.service.ISysAdminTransferTaskService;
import com.landray.kmss.sys.admin.transfer.service.spring.SysAdminTransferContext;
import com.landray.kmss.sys.admin.transfer.service.spring.SysAdminTransferResult;
import com.landray.kmss.sys.authentication.transfer.SysAuthTransferChecker;
import com.landray.kmss.util.SpringBeanUtil;

/**
 * <P>用车费用表部门信息数据迁移</P>
 * @author 孙佳
 * @version 1.0 2019年3月19日
 */
public class KmCarmngUserFeeTask extends SysAuthTransferChecker implements
		ISysAdminTransferTask {

	@Override
    public SysAdminTransferResult run(
			SysAdminTransferContext sysAdminTransferContext) {
		String uuid = sysAdminTransferContext.getUUID();
		ISysAdminTransferTaskService sysAdminTransferTaskService = (ISysAdminTransferTaskService) SpringBeanUtil
				.getBean("sysAdminTransferTaskService");
		IKmCarmngApplicationService kmCarmngApplicationService = (IKmCarmngApplicationService) SpringBeanUtil
				.getBean("kmCarmngApplicationService");
		IKmCarmngUserFeeInfoService kmCarmngUserFeeInfoService = (IKmCarmngUserFeeInfoService) SpringBeanUtil
				.getBean("kmCarmngUserFeeInfoService");
		try {
			List<KmCarmngUserFeeInfo> userFee = kmCarmngUserFeeInfoService.findList("fdApplicationDept is null", "");
			for (KmCarmngUserFeeInfo info : userFee) {
				for (String id : info.getKmDispatchersInfo().getFdApplicationIds().split(";")) {
					KmCarmngApplication kmCarmngApplication = (KmCarmngApplication) kmCarmngApplicationService
							.findByPrimaryKey(id);
					List userPersons = kmCarmngApplication.getFdUserPersons();
					if (userPersons.contains(info.getFdUser()) && null != kmCarmngApplication.getFdApplicationDept()) {
						info.setFdApplicationDept(kmCarmngApplication.getFdApplicationDept());
						kmCarmngUserFeeInfoService.update(info);
						break;
					}
				}
				//如果用车申请没有设置部门信息，则取用车的当前部门
				info.setFdApplicationDept(info.getFdUser().getFdParent());
				kmCarmngUserFeeInfoService.update(info);
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("用车费用表部门信息数据迁移", e);
		}
		return SysAdminTransferResult.OK;
	}
}
