package com.landray.kmss.km.carmng.service.spring;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.common.service.BaseServiceImp;
import com.landray.kmss.constant.SysNotifyConstant;
import com.landray.kmss.km.carmng.model.KmCarmngApplication;
import com.landray.kmss.km.carmng.model.KmCarmngDispatchersInfo;
import com.landray.kmss.km.carmng.model.KmCarmngDispatchersInfoList;
import com.landray.kmss.km.carmng.model.KmCarmngRegisterInfo;
import com.landray.kmss.km.carmng.model.KmCarmngUserFeeInfo;
import com.landray.kmss.km.carmng.service.IKmCarmngApplicationService;
import com.landray.kmss.km.carmng.service.IKmCarmngDispatchersInfoListService;
import com.landray.kmss.km.carmng.service.IKmCarmngDispatchersInfoService;
import com.landray.kmss.km.carmng.service.IKmCarmngRegisterInfoService;
import com.landray.kmss.km.carmng.service.IKmCarmngUserFeeInfoService;
import com.landray.kmss.sys.notify.interfaces.ISysNotifyMainCoreService;
import com.landray.kmss.sys.notify.interfaces.NotifyContext;
import com.landray.kmss.sys.notify.interfaces.NotifyReplace;
import com.landray.kmss.sys.organization.interfaces.ISysOrgCoreService;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.util.StringUtil;

/**
 * 创建日期 2010-三月-24
 * 
 * @author 叶中奇 回车登记单业务接口实现
 */
public class KmCarmngRegisterInfoServiceImp extends BaseServiceImp implements
		IKmCarmngRegisterInfoService {

	private IKmCarmngApplicationService kmCarmngApplicationService = null;

	private IKmCarmngUserFeeInfoService kmCarmngUserFeeInfoService = null;

	private IKmCarmngDispatchersInfoService kmCarmngDispatchersInfoService = null;
	
	private IKmCarmngDispatchersInfoListService kmCarmngDispatchersInfoListService = null;

	public void setKmCarmngDispatchersInfoListService(
			IKmCarmngDispatchersInfoListService kmCarmngDispatchersInfoListService) {
		this.kmCarmngDispatchersInfoListService = kmCarmngDispatchersInfoListService;
	}

	private ISysNotifyMainCoreService sysNotifyMainCoreService;

	public void setSysNotifyMainCoreService(
			ISysNotifyMainCoreService sysNotifyMainCoreService) {
		this.sysNotifyMainCoreService = sysNotifyMainCoreService;
	}

	public void setKmCarmngApplicationService(
			IKmCarmngApplicationService kmCarmngApplicationService) {
		this.kmCarmngApplicationService = kmCarmngApplicationService;
	}

	public void setKmCarmngUserFeeInfoService(
			IKmCarmngUserFeeInfoService kmCarmngUserFeeInfoService) {
		this.kmCarmngUserFeeInfoService = kmCarmngUserFeeInfoService;
	}

	public void setKmCarmngDispatchersInfoService(
			IKmCarmngDispatchersInfoService kmCarmngDispatchersInfoService) {
		this.kmCarmngDispatchersInfoService = kmCarmngDispatchersInfoService;
	}

	@Override
	public String add(IBaseModel modelObj) throws Exception {
		KmCarmngRegisterInfo kmCarmngRegisterInfo = (KmCarmngRegisterInfo) modelObj;
		String id = super.add(modelObj);

		KmCarmngDispatchersInfoList kmCarmngDispatchersInfoList = kmCarmngRegisterInfo.getFdDispatchInfoList();
		kmCarmngDispatchersInfoList.setFdFlag("1");
		kmCarmngDispatchersInfoList.setFdRegisterId(id);
		kmCarmngDispatchersInfoListService.update(kmCarmngDispatchersInfoList);
		KmCarmngDispatchersInfo kmCarmngDispatchersInfo = kmCarmngRegisterInfo.getFdDispatchInfoList()
				.getFdDispatchersInfo();

		// 删除对应车辆的回车登记待办
		sysNotifyMainCoreService.getTodoProvider().removeTodo(kmCarmngDispatchersInfo,
				"registerNotify_" + kmCarmngDispatchersInfoList.getFdId());

		String fdApplicationIds = kmCarmngDispatchersInfo.getFdApplicationIds();
		String[] applicationIds = fdApplicationIds.split(";");
		List kmCarmngApplicationList = new ArrayList();
		Set userPersonList = new HashSet();
		Map<Object, Set> depetMap = new HashMap<Object, Set>();
		for (int i = 0; i < applicationIds.length; i++) {
			String applicationId = applicationIds[i];
			KmCarmngApplication kmCarmngApplication = (KmCarmngApplication) kmCarmngApplicationService
					.findByPrimaryKey(applicationId);
			kmCarmngApplicationList.add(kmCarmngApplication);
			List valueList = kmCarmngApplication.getFdUserPersons();
			userPersonList.addAll(valueList);
			SysOrgElement dept = kmCarmngApplication.getFdApplicationDept();
			depetMap.put(null != dept ? dept : "null_" + i, userPersonList);
		}
		int number = userPersonList.size();
		Double fdFuelFee = 0.0;
		Double fdCarwashFee = 0.0;
		Double fdStopFee = 0.0;
		Double fdTurnpikeFee = 0.0;
		Double fdOtherFee = 0.0;
		Double fdMileageNumber = 0.0;
		if (kmCarmngRegisterInfo.getFdFuelFee() != null) {
			fdFuelFee = kmCarmngRegisterInfo.getFdFuelFee() / number;
		}
		if (kmCarmngRegisterInfo.getFdCarwashFee() != null) {
			fdCarwashFee = kmCarmngRegisterInfo.getFdCarwashFee() / number;
		}
		if (kmCarmngRegisterInfo.getFdStopFee() != null) {
			fdStopFee = kmCarmngRegisterInfo.getFdStopFee() / number;
		}
		if (kmCarmngRegisterInfo.getFdTurnpikeFee() != null) {
			fdTurnpikeFee = kmCarmngRegisterInfo.getFdTurnpikeFee() / number;
		}
		if (kmCarmngRegisterInfo.getFdOtherFee() != null) {
			fdOtherFee = kmCarmngRegisterInfo.getFdOtherFee() / number;
		}
		if (kmCarmngRegisterInfo.getFdMileageBeforeNumber() == null) {
			kmCarmngRegisterInfo.setFdMileageBeforeNumber(new Double(0));
		}
		if (kmCarmngRegisterInfo.getFdMileageAfterNumber() == null) {
			kmCarmngRegisterInfo.setFdMileageAfterNumber(new Double(0));
		}

		// fdMileageNumber = (kmCarmngRegisterInfo.getFdMileageAfterNumber()
		// -
		// kmCarmngRegisterInfo
		// .getFdMileageBeforeNumber())
		// / number;
		// by zhangwt
		fdMileageNumber = (kmCarmngRegisterInfo.getFdMileageNumber()) / number;
		for (Map.Entry<Object, Set> entry : depetMap.entrySet()) {
			for (Iterator itera = entry.getValue().iterator(); itera.hasNext();) {
				SysOrgElement sysOrgElement = (SysOrgElement) itera.next();
				KmCarmngUserFeeInfo kmCarmngUserFeeInfo = new KmCarmngUserFeeInfo();
				kmCarmngUserFeeInfo.setFdUser(sysOrgElement);
				if (entry.getKey() instanceof SysOrgElement) {
					kmCarmngUserFeeInfo.setFdApplicationDept((SysOrgElement) entry.getKey());
				} else {
					kmCarmngUserFeeInfo.setFdApplicationDept(sysOrgElement.getFdParent());
				}
				kmCarmngUserFeeInfo.setFdFuelFee(fdFuelFee);
				kmCarmngUserFeeInfo.setFdOtherFee(fdOtherFee);
				kmCarmngUserFeeInfo.setFdStopFee(fdStopFee);
				kmCarmngUserFeeInfo.setFdTurnpikeFee(fdTurnpikeFee);
				kmCarmngUserFeeInfo.setFdCarwashFee(fdCarwashFee);
				kmCarmngUserFeeInfo.setFdUseStartTime(kmCarmngRegisterInfo.getFdStartTime());
				kmCarmngUserFeeInfo.setFdUseEndTime(kmCarmngRegisterInfo.getFdEndTime());
				kmCarmngUserFeeInfo.setFdMileageNumber(fdMileageNumber);
				kmCarmngUserFeeInfo.setFdVehicles(kmCarmngRegisterInfo.getFdDispatchInfoList().getFdCarInfo());
				kmCarmngUserFeeInfo.setKmDispatchersInfo(kmCarmngDispatchersInfo);
				kmCarmngUserFeeInfoService.add(kmCarmngUserFeeInfo);
			}
		}

		Boolean fdIsDispatched = true;
		List<KmCarmngDispatchersInfoList> fdDispatchersInfoList = kmCarmngDispatchersInfo.getFdDispatchersInfoList();
		for (int i = 0; i < fdDispatchersInfoList.size(); i++) {
			KmCarmngDispatchersInfoList infoList = fdDispatchersInfoList.get(i);
			if (!"1".equals(infoList.getFdFlag())) {
				fdIsDispatched = false;
			}
		}
		if (fdIsDispatched) {
			kmCarmngDispatchersInfo.setFdFlag("1");
			for (Iterator itera = kmCarmngApplicationList.iterator(); itera.hasNext();) {
				KmCarmngApplication kmCarmngApplication = (KmCarmngApplication) itera.next();
				kmCarmngApplication.setFdIsDispatcher(4); // 待评价
				kmCarmngApplicationService.update(kmCarmngApplication);
				saveSendNotify(kmCarmngApplication);
				ISysOrgCoreService sysOrgCoreService = (ISysOrgCoreService) SpringBeanUtil.getBean("sysOrgCoreService");
				// 回车登记员
				SysOrgElement fdRegister = kmCarmngApplication.getFdMotorcade().getFdRegister();
				List sysOrgElementList = new ArrayList();
				sysOrgElementList.add(fdRegister);

				// 车辆全部回车完，删除调度单回车登记员的回车登记待办
				sysOrgElementList.add(kmCarmngDispatchersInfo.getFdRegister()); // 当前用车调度的回车登记员：有可能跟车队的登记员不同
				List persons = sysOrgCoreService.expandToPerson(sysOrgElementList);

				sysNotifyMainCoreService.getTodoProvider().removePersons(kmCarmngDispatchersInfo,
						"sendRegisterKmCarmngApplicationNotify", persons);
			}
			kmCarmngDispatchersInfoService.update(kmCarmngDispatchersInfo);
		}
		return id;
	}

	public void saveSendNotify(KmCarmngApplication kmCarmngApplication)
			throws Exception {
		sendTodoFromResource(kmCarmngApplication);
	}

	private NotifyReplace getNotifyReplace(KmCarmngApplication kmCarmngApplication) {
		NotifyReplace notifyReplace = new NotifyReplace();
		notifyReplace.addReplaceText("km-carmnag:kmCarmngApplication.docSubject", kmCarmngApplication.getDocSubject());
		return notifyReplace;
	}

	private HashMap getReplaceMap(KmCarmngApplication kmCarmngApplication) {
		HashMap replaceMap = new HashMap();
		replaceMap.put("km-carmnag:kmCarmngApplication.docSubject",
				kmCarmngApplication.getDocSubject());
		return replaceMap;
	}

	/**
	 * 向申请人发送待阅“出车情况已登记，请查看，主题：......”
	 * @param kmCarmngApplication
	 * @throws Exception
	 */
	private void sendTodoFromResource(KmCarmngApplication kmCarmngApplication)
			throws Exception {
		NotifyContext notifyContext = sysNotifyMainCoreService
				.getContext("km-carmng:kmCarmngApplication.dispatcher.notify.3");
		notifyContext.setNotifyType("todo");
		notifyContext.setFlag(SysNotifyConstant.NOTIFY_TODOTYPE_ONCE);//待阅
		notifyContext.setKey("sendKmCarmngApplicationNotify");
		List targets = new ArrayList();
		targets.add(kmCarmngApplication.getFdApplicationPerson());
		notifyContext.setNotifyTarget(targets);
		sysNotifyMainCoreService.sendNotify(kmCarmngApplication, notifyContext, getNotifyReplace(kmCarmngApplication));
	}

	@Override
	public void update(IBaseModel modelObj) throws Exception {
		KmCarmngRegisterInfo kmCarmngRegisterInfo = (KmCarmngRegisterInfo) modelObj;
		KmCarmngDispatchersInfo kmCarmngDispatchersInfo = kmCarmngRegisterInfo.getFdDispatchInfoList()
				.getFdDispatchersInfo();
		String fdApplicationIds = kmCarmngDispatchersInfo.getFdApplicationIds();
		String[] applicationIds = fdApplicationIds.split(";");
		List kmCarmngApplicationList = new ArrayList();
		Set userPersonList = new HashSet();
		for (int i = 0; i < applicationIds.length; i++) {
			String applicationId = applicationIds[i];
			KmCarmngApplication kmCarmngApplication = (KmCarmngApplication) kmCarmngApplicationService
					.findByPrimaryKey(applicationId);
			kmCarmngApplicationList.add(kmCarmngApplication);
			List valueList = kmCarmngApplication.getFdUserPersons();
			userPersonList.addAll(valueList);
		}
		HQLInfo hqlInfo = new HQLInfo();
		hqlInfo.setWhereBlock("kmCarmngUserFeeInfo.kmDispatchersInfo.fdId = '"
				+ kmCarmngDispatchersInfo.getFdId() + "'");
		List userFeeList = kmCarmngUserFeeInfoService.findList(hqlInfo);
		int number = userPersonList.size();
		Double fdFuelFee = 0.0;
		Double fdCarwashFee = 0.0;
		Double fdStopFee = 0.0;
		Double fdTurnpikeFee = 0.0;
		Double fdOtherFee = 0.0;
		Double fdMileageNumber = 0.0;
		if (kmCarmngRegisterInfo.getFdFuelFee() != null) {
			fdFuelFee = kmCarmngRegisterInfo.getFdFuelFee() / number;
		}
		if (kmCarmngRegisterInfo.getFdCarwashFee() != null) {
			fdCarwashFee = kmCarmngRegisterInfo.getFdCarwashFee() / number;
		}
		if (kmCarmngRegisterInfo.getFdStopFee() != null) {
			fdStopFee = kmCarmngRegisterInfo.getFdStopFee() / number;
		}
		if (kmCarmngRegisterInfo.getFdTurnpikeFee() != null) {
			fdTurnpikeFee = kmCarmngRegisterInfo.getFdTurnpikeFee() / number;
		}
		if (kmCarmngRegisterInfo.getFdOtherFee() != null) {
			fdOtherFee = kmCarmngRegisterInfo.getFdOtherFee() / number;
		}
		if (kmCarmngRegisterInfo.getFdMileageBeforeNumber() == null) {
			kmCarmngRegisterInfo.setFdMileageBeforeNumber(new Double(0));
		}
		if (kmCarmngRegisterInfo.getFdMileageAfterNumber() == null) {
			kmCarmngRegisterInfo.setFdMileageAfterNumber(new Double(0));
		}
		// fdMileageNumber = (kmCarmngRegisterInfo.getFdMileageAfterNumber() -
		// kmCarmngRegisterInfo
		// .getFdMileageBeforeNumber())
		// / number;
		fdMileageNumber = (kmCarmngRegisterInfo.getFdMileageNumber()) / number;
		for (Iterator itera = userFeeList.iterator(); itera.hasNext();) {
			KmCarmngUserFeeInfo kmCarmngUserFeeInfo = (KmCarmngUserFeeInfo) itera
					.next();
			kmCarmngUserFeeInfo.setFdFuelFee(fdFuelFee);
			kmCarmngUserFeeInfo.setFdOtherFee(fdOtherFee);
			kmCarmngUserFeeInfo.setFdStopFee(fdStopFee);
			kmCarmngUserFeeInfo.setFdTurnpikeFee(fdTurnpikeFee);
			kmCarmngUserFeeInfo.setFdCarwashFee(fdCarwashFee);
			kmCarmngUserFeeInfo.setFdMileageNumber(fdMileageNumber);
			kmCarmngUserFeeInfo.setFdUseStartTime(kmCarmngRegisterInfo
					.getFdStartTime());
			kmCarmngUserFeeInfo.setFdUseEndTime(kmCarmngRegisterInfo
					.getFdEndTime());
			kmCarmngUserFeeInfoService.update(kmCarmngUserFeeInfo);
		}
	}

	@Override
	public KmCarmngRegisterInfo getRegisterByDispatchersId(String dispatchersId)
			throws Exception {
		if (StringUtil.isNull(dispatchersId)){
			return null;
		}
		HQLInfo hqlInfo = new HQLInfo();
		hqlInfo.setWhereBlock("kmCarmngRegisterInfo.fdDispatchers.fdId = '"+ dispatchersId + "'");
		hqlInfo.setOrderBy("kmCarmngRegisterInfo.fdRegisterTime desc");	
		List registerList = this.getBaseDao().findList(hqlInfo);
		if (registerList!=null && registerList.size()>0){
			return (KmCarmngRegisterInfo)registerList.get(0);
		}
		return null;
	}
	
	
}
