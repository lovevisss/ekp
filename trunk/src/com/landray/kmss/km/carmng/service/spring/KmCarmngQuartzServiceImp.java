package com.landray.kmss.km.carmng.service.spring;

import com.landray.kmss.km.carmng.service.IKmCarmngDispatchersInfoService;
import com.landray.kmss.km.carmng.service.IKmCarmngDriversInfoService;
import com.landray.kmss.km.carmng.service.IKmCarmngInfomationService;
import com.landray.kmss.km.carmng.service.IKmCarmngQuartzService;
import com.landray.kmss.sys.notify.interfaces.ISysNotifyMainCoreService;
import com.landray.kmss.sys.organization.service.ISysOrgElementService;
import com.landray.kmss.sys.quartz.interfaces.SysQuartzJobContext;

public class KmCarmngQuartzServiceImp implements IKmCarmngQuartzService {
//	<property name="kmCarmngDispatchersInfoService">
//			<ref bean="kmCarmngDispatchersInfoService" />
//		</property>
//		<property name="kmCarmngDriversInfoService">
//			<ref bean="kmCarmngDriversInfoService" />
//		</property>
//		<property name="kmCarmngInfomationService">
//			<ref bean="kmCarmngInfomationService" />
//		</property>
//		<property name="sysOrgElementService">
//			<ref bean="sysOrgElementService" />
//		</property>
	private IKmCarmngDispatchersInfoService kmCarmngDispatchersInfoService;

	private IKmCarmngDriversInfoService kmCarmngDriversInfoService;

	private IKmCarmngInfomationService kmCarmngInfomationService;

	private ISysOrgElementService sysOrgElementService;

	public void setKmCarmngDispatchersInfoService(
			IKmCarmngDispatchersInfoService kmCarmngDispatchersInfoService) {
		this.kmCarmngDispatchersInfoService = kmCarmngDispatchersInfoService;
	}

	public void setKmCarmngDriversInfoService(
			IKmCarmngDriversInfoService kmCarmngDriversInfoService) {
		this.kmCarmngDriversInfoService = kmCarmngDriversInfoService;
	}

	public void setKmCarmngInfomationService(
			IKmCarmngInfomationService kmCarmngInfomationService) {
		this.kmCarmngInfomationService = kmCarmngInfomationService;
	}

	public void setSysOrgElementService(
			ISysOrgElementService sysOrgElementService) {
		this.sysOrgElementService = sysOrgElementService;
	}

	@Override
    public void runCarmngNotify(SysQuartzJobContext jobContext) {
		try {

			// runCarmngNotifyForDispatcher(jobContext);
			//
			// runCarmngNotifyForDriversInfo(jobContext);
			//
			// runCarmngNotifyForCarInfo(jobContext);

		} catch (Exception e) {
			jobContext.logError(e);
		}

	}

	private ISysNotifyMainCoreService sysNotifyMainCoreService;

	public void setSysNotifyMainCoreService(
			ISysNotifyMainCoreService sysNotifyMainCoreService) {
		this.sysNotifyMainCoreService = sysNotifyMainCoreService;
	}

	// public void saveSendNotify_forDispatchers(
	// KmCarmngDispatchersInfo kmCarmngDispatchersInfo) throws Exception {
	// List targets = new ArrayList();
	// List targets_1 = new ArrayList();
	// List targets_2 = new ArrayList();
	// String key = "";
	// String resource = "";
	// // 发送给用车人
	// String fdStareTime = DateUtil.convertDateToString(
	// kmCarmngDispatchersInfo.getFdStartTime(),
	// DateUtil.TYPE_DATETIME, Locale.getDefault());
	// int fdNotifyMinuterUser = kmCarmngDispatchersInfo.getFdCarInfo()
	// .getFdMotorcade().getFdNotifyMinuterUser();
	// Calendar calendar = Calendar.getInstance();
	// calendar.add(Calendar.MINUTE, fdNotifyMinuterUser);
	// if (DateUtil.convertDateToString(calendar.getTime(),
	// DateUtil.TYPE_DATETIME, Locale.getDefault())
	// .equals(fdStareTime)) {
	// targets.add(kmCarmngDispatchersInfo.getFdUser());
	// key = "kmCarmngDispatcherUserKey";
	// resource = "km-carmng:kmCarmngApplication.dispatcher.notify.5";
	// sendTodoFromResource_forDispatchers(kmCarmngDispatchersInfo,
	// targets, key, resource);
	// KmCarmngDriversInfo kmCarmngDriversInfo = (KmCarmngDriversInfo)
	// kmCarmngDriversInfoService
	// .findByPrimaryKey(kmCarmngDispatchersInfo.getFdDriverId());
	// if ("2".equals(kmCarmngDriversInfo.getFdType())) {
	// SysOrgElement person = (SysOrgElement) sysOrgElementService
	// .findByPrimaryKey(kmCarmngDriversInfo.getFdSysId());
	// targets_1.add(person);
	// }
	// }
	// calendar.add(Calendar.MINUTE, -fdNotifyMinuterUser);
	// int fdNotifyMinuterDriver = kmCarmngDispatchersInfo.getFdCarInfo()
	// .getFdMotorcade().getFdNotifyMinuterDriver();
	// calendar.add(Calendar.MINUTE, fdNotifyMinuterDriver);
	// // 发送给司机
	// if (DateUtil.convertDateToString(calendar.getTime(),
	// DateUtil.TYPE_DATETIME, Locale.getDefault())
	// .equals(fdStareTime)) {
	// key = "kmCarmngDispatcherDriversKey";
	// resource = "km-carmng:kmCarmngApplication.dispatcher.notify.10";
	// sendTodoFromResource_forDispatchersDrivers(kmCarmngDispatchersInfo,
	// targets_1, key, resource);
	// }
	// // 发送给调度员
	// int fdNotifyMinuterDispatchers = kmCarmngDispatchersInfo.getFdCarInfo()
	// .getFdMotorcade().getFdNotifyMinuterDispatchers();
	// calendar.add(Calendar.MINUTE, -fdNotifyMinuterDriver);
	// calendar.add(Calendar.MINUTE, fdNotifyMinuterDispatchers);
	// if (DateUtil.convertDateToString(calendar.getTime(),
	// DateUtil.TYPE_DATETIME, Locale.getDefault())
	// .equals(fdStareTime)) {
	// targets_2.add(kmCarmngDispatchersInfo.getFdCarInfo()
	// .getFdMotorcade().getFdDispatchers());
	// key = "kmCarmngDispatchersKey";
	// resource = "km-carmng:kmCarmngApplication.dispatcher.notify.9";
	// sendTodoFromResource_forDispatchersDrivers(kmCarmngDispatchersInfo,
	// targets_1, key, resource);
	// }
	// }
	//
	// private HashMap getReplaceMap_forDispatchers(
	// KmCarmngDispatchersInfo kmCarmngDispatchersInfo) {
	// HashMap replaceMap = new HashMap();
	// String bundle = "km-carmng";
	// String messages1 = kmCarmngDispatchersInfo.getFdCarInfo().getFdNo();
	// String messages2 = DateUtil.convertDateToString(kmCarmngDispatchersInfo
	// .getFdStartTime(), DateUtil.TYPE_DATETIME, Locale.getDefault())
	// + ResourceUtil.getString("kmCarmng.message.title0", bundle)
	// + DateUtil.convertDateToString(kmCarmngDispatchersInfo
	// .getFdEndTime(), DateUtil.TYPE_DATETIME, Locale
	// .getDefault());
	// String messages3 = kmCarmngDispatchersInfo.getFdDestination();
	// replaceMap.put("km-carmng:kmCarmngDispatcherInfo.fdCarInfo", messages1);
	// replaceMap.put("km-carmng:kmCarmngDispatcherInfo.userTime", messages2);
	// replaceMap.put("km-carmng:kmCarmngDispatcherInfo.fdDestination",
	// messages3);
	// return replaceMap;
	// }
	//
	// private HashMap getReplaceMap_forDispatchersDrivers(
	// KmCarmngDispatchersInfo kmCarmngDispatchersInfo) {
	// HashMap replaceMap = new HashMap();
	// String bundle = "km-carmng";
	// String messages1 = kmCarmngDispatchersInfo.getFdCarInfo().getFdNo();
	// String messages2 = DateUtil.convertDateToString(kmCarmngDispatchersInfo
	// .getFdStartTime(), DateUtil.TYPE_DATETIME, Locale.getDefault());
	// replaceMap.put("km-carmng:kmCarmngDispatcherInfo.fdCarInfo", messages1);
	// replaceMap.put("km-carmng:kmCarmngDispatcherInfo.fdUseTime", messages2);
	// return replaceMap;
	// }
	//
	// private HashMap getReplaceMap_forDrivers_1(
	// KmCarmngDriversInfo kmCarmngDriversInfo) {
	// HashMap replaceMap = new HashMap();
	// String bundle = "km-carmng";
	// String messages1 = kmCarmngDriversInfo.getFdName();
	// replaceMap.put("km-carmng:kmCarmngDriverInfo.fdName", messages1);
	// return replaceMap;
	// }
	//
	// private HashMap getReplaceMap_forDrivers_2(
	// KmCarmngDriversInfo kmCarmngDriversInfo) {
	// HashMap replaceMap = new HashMap();
	// return replaceMap;
	// }
	//
	// private HashMap getReplaceMap_forInfomation(
	// KmCarmngInfomation kmCarmngInfomation) {
	// HashMap replaceMap = new HashMap();
	// String bundle = "km-carmng";
	// String messages1 = kmCarmngInfomation.getFdNo();
	// replaceMap.put("km-carmng:kmCarmngInfomation.fdNo", messages1);
	// return replaceMap;
	// }
	//
	// private void sendTodoFromResource_forDispatchers(
	// KmCarmngDispatchersInfo kmCarmngDispatchersInfo, List targets,
	// String key, String resource) throws Exception {
	// NotifyContext notifyContext = sysNotifyMainCoreService
	// .getContext(resource);
	// if (kmCarmngDispatchersInfo.getFdCarInfo().getFdMotorcade()
	// .getFdNotifyType() != null) {
	// notifyContext.setNotifyType(kmCarmngDispatchersInfo.getFdCarInfo()
	// .getFdMotorcade().getFdNotifyType());
	// } else {
	// return;
	// }
	// notifyContext.setFlag(SysNotifyConstant.NOTIFY_TODOTYPE_ONCE);
	// notifyContext.setKey(key);
	// //targets.add(targets);
	// notifyContext.setNotifyTarget(targets);
	// sysNotifyMainCoreService.send(kmCarmngDispatchersInfo, notifyContext,
	// getReplaceMap_forDispatchers(kmCarmngDispatchersInfo));
	// }
	//
	// private void sendTodoFromResource_forDispatchersDrivers(
	// KmCarmngDispatchersInfo kmCarmngDispatchersInfo, List targets,
	// String key, String resource) throws Exception {
	// NotifyContext notifyContext = sysNotifyMainCoreService
	// .getContext(resource);
	// if (kmCarmngDispatchersInfo.getFdCarInfo().getFdMotorcade()
	// .getFdNotifyType() != null) {
	// notifyContext.setNotifyType(kmCarmngDispatchersInfo.getFdCarInfo()
	// .getFdMotorcade().getFdNotifyType());
	// } else {
	// return;
	// }
	// notifyContext.setFlag(SysNotifyConstant.NOTIFY_TODOTYPE_ONCE);
	// notifyContext.setKey(key);
	// //targets.add(targets);
	// notifyContext.setNotifyTarget(targets);
	// sysNotifyMainCoreService.send(kmCarmngDispatchersInfo, notifyContext,
	// getReplaceMap_forDispatchersDrivers(kmCarmngDispatchersInfo));
	// }
	//
	// private void sendTodoFromResource_forDriversInfo_1(
	// KmCarmngDriversInfo kmCarmngDriversInfo, List targets, String key,
	// String resource) throws Exception {
	// NotifyContext notifyContext = sysNotifyMainCoreService
	// .getContext(resource);
	// if (StringUtil.isNotNull(kmCarmngDriversInfo.getFdNotifyType())) {
	// notifyContext.setNotifyType(kmCarmngDriversInfo.getFdNotifyType());
	// } else {
	// return;
	// }
	// notifyContext.setFlag(SysNotifyConstant.NOTIFY_TODOTYPE_ONCE);
	// notifyContext.setKey(key);
	// //targets.add(targets);
	// notifyContext.setNotifyTarget(targets);
	// sysNotifyMainCoreService.send(kmCarmngDriversInfo, notifyContext,
	// getReplaceMap_forDrivers_1(kmCarmngDriversInfo));
	// }
	//
	// private void sendTodoFromResource_forDriversInfo_2(
	// KmCarmngDriversInfo kmCarmngDriversInfo, List targets, String key,
	// String resource) throws Exception {
	// NotifyContext notifyContext = sysNotifyMainCoreService
	// .getContext(resource);
	// if (StringUtil.isNotNull(kmCarmngDriversInfo.getFdNotifyType())) {
	// notifyContext.setNotifyType(kmCarmngDriversInfo.getFdNotifyType());
	// } else {
	// return;
	// }
	// notifyContext.setFlag(SysNotifyConstant.NOTIFY_TODOTYPE_ONCE);
	// notifyContext.setKey(key);
	// //targets.add(targets);
	// notifyContext.setNotifyTarget(targets);
	// sysNotifyMainCoreService.send(kmCarmngDriversInfo, notifyContext,
	// getReplaceMap_forDrivers_2(kmCarmngDriversInfo));
	// }
	//
	// private void sendTodoFromResource_forInfomation(
	// KmCarmngInfomation kmCarmngInfomation, List targets, String key,
	// String resource) throws Exception {
	// NotifyContext notifyContext = sysNotifyMainCoreService
	// .getContext(resource);
	// if (kmCarmngInfomation.getFdNotifyType() == null) {
	// return;
	// } else {
	// notifyContext.setNotifyType(kmCarmngInfomation.getFdNotifyType());
	// }
	// notifyContext.setFlag(SysNotifyConstant.NOTIFY_TODOTYPE_ONCE);
	// notifyContext.setKey(key);
	// //targets.add(targets);
	// notifyContext.setNotifyTarget(targets);
	// sysNotifyMainCoreService.send(kmCarmngInfomation, notifyContext,
	// getReplaceMap_forInfomation(kmCarmngInfomation));
	// }
	//
	// private void runCarmngNotifyForDispatcher(SysQuartzJobContext jobContext)
	// throws Exception {
	// String nowDateStr = DateUtil.convertDateToString(new Date(),
	// DateUtil.TYPE_DATETIME, Locale.getDefault());
	// String whereBlock = "kmCarmngDispatchersInfo.fdStartTime >= :nowDateStr";
	// HQLInfo hqlInfo = new HQLInfo();
	// hqlInfo.setWhereBlock(whereBlock);
	// hqlInfo.setParameter("nowDateStr", nowDateStr);
	// List dispatchersList = kmCarmngDispatchersInfoService
	// .findValue(hqlInfo);
	// for (Iterator itera = dispatchersList.iterator(); itera.hasNext();) {
	// KmCarmngDispatchersInfo kmCarmngDispatchersInfo =
	// (KmCarmngDispatchersInfo) itera
	// .next();
	// saveSendNotify_forDispatchers(kmCarmngDispatchersInfo);
	// }
	// }
	//
	// private void runCarmngNotifyForCarInfo(SysQuartzJobContext jobContext)
	// throws Exception {
	// Date nowDate = new Date();
	// String nowDateStr = DateUtil.convertDateToString(nowDate,
	// DateUtil.TYPE_DATE, Locale.getDefault());
	// HQLInfo hqlInfo = new HQLInfo();
	// String whereBlock = "1 < 2";
	// hqlInfo.setWhereBlock(whereBlock);
	// List carInformationList = kmCarmngInfomationService.findList(hqlInfo);
	// for (Iterator itera = carInformationList.iterator(); itera.hasNext();) {
	// KmCarmngInfomation kmCarmngInfomation = (KmCarmngInfomation) itera
	// .next();
	// Date fdAnnuaCheckTime = kmCarmngInfomation.getFdAnnuaCheckTime();
	// if (fdAnnuaCheckTime != null) {
	// Calendar calendar = Calendar.getInstance();
	// calendar.setTime(fdAnnuaCheckTime);
	// if (StringUtil.isNotNull(kmCarmngInfomation
	// .getFdAnnuaCheckFrequency())) {
	// calendar.add(Calendar.YEAR, new Integer(kmCarmngInfomation
	// .getFdAnnuaCheckFrequency()).intValue());
	// calendar.add(Calendar.DAY_OF_MONTH, -3);
	// } else {
	// calendar.add(Calendar.DAY_OF_MONTH, -1);
	// }
	// if (DateUtil.convertDateToString(calendar.getTime(),
	// DateUtil.TYPE_DATE, Locale.getDefault()).equals(
	// nowDateStr)) {
	// List targetList = new ArrayList();
	// targetList.add(kmCarmngInfomation.getFdMotorcade()
	// .getFdDispatchers());
	// String key = "kmCarmngInfomationNotifyKey";
	// String resource = "km-carmng:kmCarmngApplication.dispatcher.notify.8";
	// sendTodoFromResource_forInfomation(kmCarmngInfomation,
	// targetList, resource, key);
	// }
	// }
	// }
	// }
	//
	// private void runCarmngNotifyForDriversInfo(SysQuartzJobContext
	// jobContext)
	// throws Exception {
	// Date nowDate = new Date();
	// String nowDateStr = DateUtil.convertDateToString(nowDate,
	// DateUtil.TYPE_DATE, Locale.getDefault());
	// String whereBlock = "1 < 2";
	// HQLInfo hqlInfo = new HQLInfo();
	// hqlInfo.setWhereBlock(whereBlock);
	// List driversList = kmCarmngDriversInfoService.findList(hqlInfo);
	// for (Iterator itera = driversList.iterator(); itera.hasNext();) {
	// KmCarmngDriversInfo kmCarmngDriversInfo = (KmCarmngDriversInfo) itera
	// .next();
	// // 年审时间
	// Date fdAnnualAuditingTime = kmCarmngDriversInfo
	// .getFdAnnualAuditingTime();
	// if (fdAnnualAuditingTime != null) {
	// if (fdAnnualAuditingTime.before(nowDate)) {
	// Calendar calendar = Calendar.getInstance();
	// calendar.setTime(fdAnnualAuditingTime);
	// if (StringUtil.isNotNull(kmCarmngDriversInfo
	// .getFdAnnualExamFrequency())) {
	// calendar.add(Calendar.YEAR, new Integer(
	// kmCarmngDriversInfo.getFdAnnualExamFrequency())
	// .intValue());
	// calendar.add(Calendar.DAY_OF_MONTH, -3);
	// } else {
	// calendar.add(Calendar.DAY_OF_MONTH, -1);
	// }
	// if (DateUtil.convertDateToString(calendar.getTime(),
	// DateUtil.TYPE_DATE, Locale.getDefault()).equals(
	// nowDateStr)) {
	// List targetList = new ArrayList();
	// targetList.addAll(kmCarmngDriversInfo
	// .getFdNotifyPersons());
	// // 发给通知人
	// String key = "kmCarmngDriversNotifyPersonInfoKey";
	// String resource = "km-carmng:kmCarmngApplication.dispatcher.notify.6";
	// sendTodoFromResource_forDriversInfo_1(
	// kmCarmngDriversInfo, targetList, resource, key);
	// // 发给驾驶员
	// if ("2".equals(kmCarmngDriversInfo.getFdType())) {
	// kmCarmngDriversInfo.getFdSysId();
	// SysOrgPerson sysOrgPerson = (SysOrgPerson) sysOrgElementService
	// .findByPrimaryKey(kmCarmngDriversInfo
	// .getFdSysId());
	// targetList.clear();
	// targetList.add(sysOrgPerson);
	// key = "kmCarmngDriversNotifyPersonInfoKey";
	// resource = "km-carmng:kmCarmngApplication.dispatcher.notify.7";
	// sendTodoFromResource_forDriversInfo_2(
	// kmCarmngDriversInfo, targetList, resource,
	// key);
	// }
	// }
	// }
	// }
	// }
	//
	// }
}
