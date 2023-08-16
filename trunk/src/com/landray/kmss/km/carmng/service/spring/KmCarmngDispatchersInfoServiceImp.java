package com.landray.kmss.km.carmng.service.spring;

import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.common.service.BaseServiceImp;
import com.landray.kmss.constant.SysNotifyConstant;
import com.landray.kmss.km.carmng.forms.KmCarmngDispatchersInfoForm;
import com.landray.kmss.km.carmng.model.KmCarmngApplication;
import com.landray.kmss.km.carmng.model.KmCarmngDispatchersInfo;
import com.landray.kmss.km.carmng.model.KmCarmngDispatchersInfoList;
import com.landray.kmss.km.carmng.model.KmCarmngDispatchersLog;
import com.landray.kmss.km.carmng.model.KmCarmngDriversInfo;
import com.landray.kmss.km.carmng.service.IKmCarmngApplicationService;
import com.landray.kmss.km.carmng.service.IKmCarmngDispatchersInfoService;
import com.landray.kmss.km.carmng.service.IKmCarmngDispatchersLogService;
import com.landray.kmss.km.carmng.service.IKmCarmngDriversInfoService;
import com.landray.kmss.sys.log.util.UserOperHelper;
import com.landray.kmss.sys.notify.dao.ISysNotifyShortMessageSendDao;
import com.landray.kmss.sys.notify.interfaces.ISysNotifyMainCoreService;
import com.landray.kmss.sys.notify.interfaces.ISysNotifyModel;
import com.landray.kmss.sys.notify.interfaces.ISysNotifyTodoProvider;
import com.landray.kmss.sys.notify.interfaces.NotifyContext;
import com.landray.kmss.sys.notify.interfaces.NotifyReplace;
import com.landray.kmss.sys.notify.model.SysNotifyShortMessageSend;
import com.landray.kmss.sys.organization.interfaces.ISysOrgCoreService;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.ResourceUtil;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.util.UserUtil;
import org.slf4j.Logger;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

/**
 * 创建日期 2010-三月-24
 * 
 * @author 叶中奇 调度信息业务接口实现
 */
public class KmCarmngDispatchersInfoServiceImp extends BaseServiceImp implements
		IKmCarmngDispatchersInfoService {

	private IKmCarmngApplicationService kmCarmngApplicationService;

	public void setKmCarmngApplicationService(IKmCarmngApplicationService kmCarmngApplicationService) {
		this.kmCarmngApplicationService = kmCarmngApplicationService;
	}

	private IKmCarmngDriversInfoService kmCarmngDriversInfoService;

	public void setKmCarmngDriversInfoService(IKmCarmngDriversInfoService kmCarmngDriversInfoService) {
		this.kmCarmngDriversInfoService = kmCarmngDriversInfoService;
	}

	// 注入短信通知方式的dao by zhangwt
	private ISysNotifyShortMessageSendDao sysNotifyShortMessageSendDao;

	public void setSysNotifyShortMessageSendDao(
			ISysNotifyShortMessageSendDao sysNotifyShortMessageSendDao) {
		this.sysNotifyShortMessageSendDao = sysNotifyShortMessageSendDao;
	}

	private IKmCarmngDispatchersLogService kmCarmngDispatchersLogService;

	public void setKmCarmngDispatchersLogService(IKmCarmngDispatchersLogService kmCarmngDispatchersLogService) {
		this.kmCarmngDispatchersLogService = kmCarmngDispatchersLogService;
	}
	
	private static final Logger logger = org.slf4j.LoggerFactory.getLogger(KmCarmngDispatchersInfoServiceImp.class);

	// 增加地址外的司机发送短信通知功能
	@Override
	public String add(IExtendForm form, RequestContext requestContext)
			throws Exception {
		UserOperHelper.logAdd(getModelName());
		IBaseModel model = convertFormToModel(form, null, requestContext);
		KmCarmngDispatchersInfo kmCarmngDispatchersInfo = (KmCarmngDispatchersInfo) model;
		String fdApplicationIds = kmCarmngDispatchersInfo.getFdApplicationIds();
		String[] applicationIds = fdApplicationIds.split(";");

		if ("0".equals(kmCarmngDispatchersInfo.getFdDispatchersType())) {
			//调度派车
			String fdCarInfoIds = "";
			String fdCarInfoNames = "";
			for (KmCarmngDispatchersInfoList kmCarmngDispatchersInfoList : kmCarmngDispatchersInfo
					.getFdDispatchersInfoList()) {
				fdCarInfoIds += kmCarmngDispatchersInfoList.getFdCarInfo().getFdId() + ";";
				fdCarInfoNames += kmCarmngDispatchersInfoList.getFdCarInfoNo() + ";";
			}
			if (StringUtil.isNotNull(fdCarInfoIds) && StringUtil.isNotNull(fdCarInfoNames)) {
				kmCarmngDispatchersInfo.setFdCarInfoIds(fdCarInfoIds.substring(0, fdCarInfoIds.lastIndexOf(";")));
				kmCarmngDispatchersInfo.setFdCarInfoNames(fdCarInfoNames.substring(0, fdCarInfoNames.lastIndexOf(";")));
			}

			// 给每位申请人发送代办通知
			for (int i = 0; i < applicationIds.length; i++) {
				String applicationId = applicationIds[i];
				KmCarmngApplication kmCarmngApplication = (KmCarmngApplication) kmCarmngApplicationService
						.findByPrimaryKey(applicationId);
				if (kmCarmngApplication != null) {
					// 将调度车辆的司机，车队调度人员和回车登记员加到申请单可阅读者
					List toAddReaders = kmCarmngApplication.getAuthReaders();
					if (toAddReaders == null) {
						toAddReaders = new ArrayList();
					}
					if (kmCarmngDispatchersInfo.getFdRegister() != null) {
						toAddReaders.add(kmCarmngDispatchersInfo.getFdRegister());
					}
					List fdDispatchersInfoList = kmCarmngDispatchersInfo.getFdDispatchersInfoList();
					ISysOrgCoreService sysOrgCoreService = (ISysOrgCoreService) SpringBeanUtil
							.getBean("sysOrgCoreService");
					StringBuffer driverMsg = new StringBuffer();
					for (int j = 0; j < fdDispatchersInfoList.size(); j++) {
						KmCarmngDispatchersInfoList k = (KmCarmngDispatchersInfoList) fdDispatchersInfoList.get(j);
						if (StringUtil.isNotNull(k.getFdDriverId())) {
							boolean isExist = kmCarmngDriversInfoService.getBaseDao().isExist(KmCarmngDriversInfo.class.getName(),k.getFdDriverId());
							if(isExist) {
								KmCarmngDriversInfo kmCarmngDriversInfo = (KmCarmngDriversInfo) kmCarmngDriversInfoService
										.findByPrimaryKey(k.getFdDriverId());
								if (kmCarmngDriversInfo != null && StringUtil.isNotNull(kmCarmngDriversInfo.getFdSysId())) {
									SysOrgElement s = sysOrgCoreService.findByPrimaryKey(kmCarmngDriversInfo.getFdSysId());
									if (s != null && !toAddReaders.contains(s)) {
										toAddReaders.add(s);
									}
								}else {
									isExist=false;
								}
							} 
							if (!isExist && k.getFdSysDriver() != null && !toAddReaders.contains(k.getFdSysDriver())) {
								toAddReaders.add(k.getFdSysDriver());
							}
							 
						}

						if (k.getFdCarInfo().getFdMotorcade().getFdDispatchers() != null
								&& !toAddReaders.contains(k.getFdCarInfo().getFdMotorcade().getFdDispatchers())) {
							toAddReaders.add(k.getFdCarInfo().getFdMotorcade().getFdDispatchers());
						}
						if (k.getFdCarInfo().getFdMotorcade().getFdRegister() != null
								&& !toAddReaders.contains(k.getFdCarInfo().getFdMotorcade().getFdRegister())) {
							toAddReaders.add(k.getFdCarInfo().getFdMotorcade().getFdRegister());
						}

						driverMsg.append(k.getFdDriverName() + "("
								+ k.getFdRelationPhone() + ")");
						if (j != fdDispatchersInfoList.size() - 1) {
                            driverMsg.append("、");
                        }
					}
					kmCarmngApplication.setAuthReaders(toAddReaders);
					kmCarmngApplication.setFdIsDispatcher(new Integer(2));

					kmCarmngApplicationService.getBaseDao().update(kmCarmngApplication);
					kmCarmngApplicationService.saveSendNotify(kmCarmngApplication,
							(StringUtil.isNotNull(kmCarmngApplication.getFdNotifyPerson())
									&& kmCarmngApplication.getFdNotifyPerson().contains("1"))
													? kmCarmngApplication
															.getFdUserPersons()
													: null,
							driverMsg);

					// 车队设置——调度员
					SysOrgElement fdDispatchers = kmCarmngApplication.getFdMotorcade().getFdDispatchers();
					List sysOrgElementList = new ArrayList();
					sysOrgElementList.add(fdDispatchers);
					List persons = sysOrgCoreService.expandToPerson(sysOrgElementList);
					// 清理向调度员发送的待办“车辆申请已通过，请调度派车，主题：%km-carmnag:kmCarmngApplication.docSubject%”
					sysNotifyMainCoreService.getTodoProvider().removePersons(kmCarmngApplication,
							"sendKmCarmngApplicationPublishNotify", persons);
				}
			}

			// 回车登记员发待办
			//sendRegisterFromResource(kmCarmngDispatchersInfo);

			// 司机发待办
			for (KmCarmngDispatchersInfoList k : kmCarmngDispatchersInfo.getFdDispatchersInfoList()) {
				if (k.getFdSysDriver() == null) {// 驾驶员为空

					// 扩展地址本外司机短信通知方式notify.10
					sendDriverFromOuter(kmCarmngDispatchersInfo, k, false);
					sendRegisterFromResource2(kmCarmngDispatchersInfo, k);
				} else {

					// 给驾驶员发送待阅notify.10
					sendDriverFromResource(kmCarmngDispatchersInfo, k);
					sendRegisterFromResource2(kmCarmngDispatchersInfo, k);
					// saveSendNotify(kmCarmngDispatchersInfo);
				}
			}
		} else {
			//调度不派车---调度信息状态为【不派车】，同时用车申请置为【完成】。
			initDispatchersInfo(kmCarmngDispatchersInfo);

			for (String applicationId : applicationIds) {
				KmCarmngApplication kmCarmngApplication = (KmCarmngApplication) kmCarmngApplicationService
						.findByPrimaryKey(applicationId);
				if (null != kmCarmngApplication) {
					kmCarmngApplication.setFdIsDispatcher(new Integer(3));
					kmCarmngApplicationService.getBaseDao().update(kmCarmngApplication);
					removeNoCarNotifyFromDispatchers(kmCarmngApplication);
					//给申请人、联系人和用车人发送待阅通知
					sendNoCarNotify(kmCarmngDispatchersInfo, kmCarmngApplication,
							"km-carmng:kmCarmngApplication.dispatcher.no.car.notify");
				}
			}
		}

		//调度日志
		saveDispatchersLog(kmCarmngDispatchersInfo);

		String id = super.add(model);
		return id;

	}
	
	@Override
	public void update(IExtendForm form, RequestContext requestContext) throws Exception {
		KmCarmngDispatchersInfo oldmodel = (KmCarmngDispatchersInfo) this.findByPrimaryKey(form.getFdId(), null, true);
		List<KmCarmngDispatchersInfoList> oldDispatchersInfoList = oldmodel.getFdDispatchersInfoList();
		//将驾驶员和回车登记员的【回车登记】待办删除
		List<SysOrgElement> oldList = new ArrayList();
		for (KmCarmngDispatchersInfoList k : oldDispatchersInfoList) {
			if (k.getFdSysDriver() != null) {// 驾驶员为空
				oldList.add(k.getFdSysDriver());
			}
			sysNotifyMainCoreService.getTodoProvider().remove(oldmodel, "registerNotify_" + k.getFdId());
		}
		sysNotifyMainCoreService.getTodoProvider().removePersons(oldmodel, "sendDriverKmCarmngApplicationNotify",
				oldList);

		KmCarmngDispatchersInfoForm kmCarmngDispatchersInfoForm = (KmCarmngDispatchersInfoForm) form;
		if ("1".equals(kmCarmngDispatchersInfoForm.getFdDispatchersType())) {
			kmCarmngDispatchersInfoForm.getFdDispatchersInfoListForm().clear();
		}
		IBaseModel model = convertFormToModel(form, null, requestContext);
		KmCarmngDispatchersInfo kmCarmngDispatchersInfo = (KmCarmngDispatchersInfo) model;
		List<KmCarmngDispatchersInfoList> fdDispatchersInfoList = kmCarmngDispatchersInfo.getFdDispatchersInfoList();
		String fdApplicationIds = kmCarmngDispatchersInfo.getFdApplicationIds();
		String[] applicationIds = fdApplicationIds.split(";");
		if ("0".equals(kmCarmngDispatchersInfo.getFdDispatchersType())) {
			//将调度单状态设为出车
			kmCarmngDispatchersInfo.setFdFlag("0");
			List<SysOrgElement> nowList = new ArrayList();
			List nowOuterList = new ArrayList();
			for (KmCarmngDispatchersInfoList k : fdDispatchersInfoList) {
				if (k.getFdSysDriver() == null) {// 驾驶员为空
					// 给回车登记员发送待阅notify.2
					// sendRegisterFromResource(kmCarmngDispatchersInfo);
					// 扩展地址本外司机短信通知方式notify.10
					nowOuterList.add(k.getFdDriverId());
				} else {
					// 给回车登记员发送待阅notify.2
					// sendRegisterFromResource(kmCarmngDispatchersInfo);
					// 给驾驶员发送待阅notify.10
					nowList.add(k.getFdSysDriver());
				}
			}

			// 给变更的司机重新发通知
			for (KmCarmngDispatchersInfoList k : oldDispatchersInfoList) {
				if (k.getFdSysDriver() != null) {// 驾驶员为空
					if (!nowList.contains(k.getFdSysDriver())) {
						sendDriverDispatherChange(kmCarmngDispatchersInfo, k);
					}
				} else {
					sendDriverFromOuter(kmCarmngDispatchersInfo, k, true);
				}
			}

			UserOperHelper.logUpdate(getModelName());
			//IBaseModel model = convertFormToModel(form, null, requestContext);
			kmCarmngDispatchersInfo.getAuthAllReaders().addAll(oldList);
			String fdCarInfoIds = "";
			String fdCarInfoNames = "";
			for (KmCarmngDispatchersInfoList kmCarmngDispatchersInfoList : kmCarmngDispatchersInfo
					.getFdDispatchersInfoList()) {
				fdCarInfoIds += kmCarmngDispatchersInfoList.getFdCarInfo().getFdId() + ";";
				fdCarInfoNames += kmCarmngDispatchersInfoList.getFdCarInfoNo() + ";";
			}
			if (StringUtil.isNotNull(fdCarInfoIds) && StringUtil.isNotNull(fdCarInfoNames)) {
				kmCarmngDispatchersInfo.setFdCarInfoIds(fdCarInfoIds.substring(0, fdCarInfoIds.lastIndexOf(";")));
				kmCarmngDispatchersInfo.setFdCarInfoNames(fdCarInfoNames.substring(0, fdCarInfoNames.lastIndexOf(";")));
			}
			for (int i = 0; i < applicationIds.length; i++) {
				String applicationId = applicationIds[i];
				KmCarmngApplication kmCarmngApplication = (KmCarmngApplication) kmCarmngApplicationService
						.findByPrimaryKey(applicationId);
				if (kmCarmngApplication != null) {
					// 将调度车辆的司机，车队调度人员和回车登记员加到申请单可阅读者
					List toAddReaders = kmCarmngApplication.getAuthReaders();
					if (toAddReaders == null) {
						toAddReaders = new ArrayList();
					}
					if (kmCarmngDispatchersInfo.getFdRegister() != null) {
						toAddReaders.add(kmCarmngDispatchersInfo.getFdRegister());
					}
					ISysOrgCoreService sysOrgCoreService = (ISysOrgCoreService) SpringBeanUtil
							.getBean("sysOrgCoreService");
					StringBuffer driverMsg = new StringBuffer();
					for (int j = 0; j < fdDispatchersInfoList.size(); j++) {
						KmCarmngDispatchersInfoList k = (KmCarmngDispatchersInfoList) fdDispatchersInfoList.get(j);
						KmCarmngDriversInfo kmCarmngDriversInfo = (KmCarmngDriversInfo) kmCarmngDriversInfoService
								.findByPrimaryKey(k.getFdDriverId());
						if (kmCarmngDriversInfo != null && StringUtil.isNotNull(kmCarmngDriversInfo.getFdSysId())) {
							SysOrgElement s = sysOrgCoreService.findByPrimaryKey(kmCarmngDriversInfo.getFdSysId());
							if (s != null && !toAddReaders.contains(s)) {
								toAddReaders.add(s);
							}
						} else {
							if (k.getFdSysDriver() != null && !toAddReaders.contains(k.getFdSysDriver())) {
								toAddReaders.add(k.getFdSysDriver());
							}
						}
						if (k.getFdCarInfo().getFdMotorcade().getFdDispatchers() != null
								&& !toAddReaders.contains(k.getFdCarInfo().getFdMotorcade().getFdDispatchers())) {
							toAddReaders.add(k.getFdCarInfo().getFdMotorcade().getFdDispatchers());
						}
						if (k.getFdCarInfo().getFdMotorcade().getFdRegister() != null
								&& !toAddReaders.contains(k.getFdCarInfo().getFdMotorcade().getFdRegister())) {
							toAddReaders.add(k.getFdCarInfo().getFdMotorcade().getFdRegister());
						}

						driverMsg.append(k.getFdDriverName() + "("
								+ k.getFdRelationPhone() + ")");
						if (j != fdDispatchersInfoList.size() - 1) {
                            driverMsg.append("、");
                        }
					}
					kmCarmngApplication.setAuthReaders(toAddReaders);
					kmCarmngApplication.setFdIsDispatcher(new Integer(2));
					kmCarmngApplicationService.getBaseDao().update(kmCarmngApplication);
					kmCarmngApplicationService.sendNotify_update(kmCarmngApplication,
							(StringUtil.isNotNull(kmCarmngApplication.getFdNotifyPerson())
									&& kmCarmngApplication.getFdNotifyPerson().contains("1"))
													? kmCarmngApplication
															.getFdUserPersons()
													: null,
							driverMsg);
				}
			}

			// 回车登记员发待办#169722当勾选了待办通知后，无需再单独发送待办给回车登记员
			//sendRegisterFromResource(kmCarmngDispatchersInfo);

			for (KmCarmngDispatchersInfoList k : kmCarmngDispatchersInfo.getFdDispatchersInfoList()) {
				if (k.getFdSysDriver() == null) {// 驾驶员为空
					// 给回车登记员发送待阅notify.2
					// sendRegisterFromResource(kmCarmngDispatchersInfo);
					// 扩展地址本外司机短信通知方式notify.10
					sendDriverFromOuter(kmCarmngDispatchersInfo, k, false);
					sendRegisterFromResource2(kmCarmngDispatchersInfo, k);
				} else {
					// 给回车登记员发送待阅notify.2
					// sendRegisterFromResource(kmCarmngDispatchersInfo);
					// 给驾驶员发送待阅notify.10
					sendDriverFromResource(kmCarmngDispatchersInfo, k);
					sendRegisterFromResource2(kmCarmngDispatchersInfo, k);
					// saveSendNotify(kmCarmngDispatchersInfo);
				}
			}
		} else {
			//调度不派车---调度信息状态为【不派车】，同时用车申请置为【完成】。
			//删除回车登记员待办
			sysNotifyMainCoreService.getTodoProvider().remove(oldmodel, "sendRegisterKmCarmngApplicationNotify");

			sendNoCarDriverNotify(kmCarmngDispatchersInfo, oldList);

			for (String applicationId : applicationIds) {
				KmCarmngApplication kmCarmngApplication = (KmCarmngApplication) kmCarmngApplicationService
						.findByPrimaryKey(applicationId);
				if (null != kmCarmngApplication) {
					kmCarmngApplication.setFdIsDispatcher(new Integer(3));
					kmCarmngApplicationService.getBaseDao().update(kmCarmngApplication);
					removeNoCarNotifyFromDispatchers(kmCarmngApplication);
					//给申请人、联系人和用车人发送待阅通知
					sendNoCarNotify(kmCarmngDispatchersInfo, kmCarmngApplication,
							"km-carmng:kmCarmngApplication.dispatcher.no.car.notify.update");
				}
			}
			initDispatchersInfo(kmCarmngDispatchersInfo);
		}

		//保存调度日志
		saveDispatchersLog(kmCarmngDispatchersInfo);
		super.update(model);
	}

	private void sendDriverDispatherChange(KmCarmngDispatchersInfo kmCarmngDispatchersInfo,
			KmCarmngDispatchersInfoList kmCarmngDispatchersInfoList) throws Exception {
		NotifyContext notifyContext = sysNotifyMainCoreService
				.getContext("km-carmng:kmCarmngApplication.dispatcher.notify.11");
		notifyContext.setNotifyType(kmCarmngDispatchersInfo.getFdNotifyType());
		notifyContext.setFlag(SysNotifyConstant.NOTIFY_TODOTYPE_ONCE);// 待阅
		notifyContext.setKey("sendDriverKmCarmngApplicationNotify");
		List targets = new ArrayList();
		targets.add(kmCarmngDispatchersInfoList.getFdSysDriver());
		notifyContext.setNotifyTarget(targets);
		sysNotifyMainCoreService.sendNotify(kmCarmngDispatchersInfo, notifyContext,
				getDriverNotifyReplace(kmCarmngDispatchersInfo, kmCarmngDispatchersInfoList));
	}

	// 注入通知机制
	private ISysNotifyMainCoreService sysNotifyMainCoreService;

	public void setSysNotifyMainCoreService(
			ISysNotifyMainCoreService sysNotifyMainCoreService) {
		this.sysNotifyMainCoreService = sysNotifyMainCoreService;
	}

	// 申请人的替换文本
	private NotifyReplace getRegisterNotifyReplace2(
			KmCarmngDispatchersInfo kmCarmngDispatchersInfo,
			KmCarmngDispatchersInfoList kmCarmngDispatchersInfoList) {
		String carNoString = kmCarmngDispatchersInfoList.getFdCarInfoNo();
		NotifyReplace notifyReplace = new NotifyReplace();
		String bundle = "km-carmng";
		String message = ResourceUtil.getString("kmCarmngInfomation.fdNo",
				bundle) + "(" + carNoString + "),"
				+ ResourceUtil.getString("kmCarmng.fdUseTime", bundle) + "("
				+ DateUtil.convertDateToString(
						kmCarmngDispatchersInfo.getFdStartTime(),
						DateUtil.TYPE_DATETIME,
						Locale.getDefault())
				+ ResourceUtil.getString("kmCarmng.message.title0", bundle)
				+ DateUtil.convertDateToString(
						kmCarmngDispatchersInfo.getFdEndTime(),
						DateUtil.TYPE_DATETIME, Locale.getDefault())
				+ ")";
		notifyReplace.addReplaceText("km-carmnag:kmCarmngDispatcher.message",
				message);
		return notifyReplace;
	}

	// 申请人的替换文本
	private HashMap getRegisterReplaceMap2(KmCarmngDispatchersInfo kmCarmngDispatchersInfo,
			KmCarmngDispatchersInfoList kmCarmngDispatchersInfoList) {
		String carNoString = kmCarmngDispatchersInfoList.getFdCarInfoNo();
		HashMap replaceMap = new HashMap();
		String bundle = "km-carmng";
		String message = ResourceUtil.getString("kmCarmngInfomation.fdNo", bundle) + "(" + carNoString + "),"
				+ ResourceUtil.getString("kmCarmng.fdUseTime", bundle) + "("
				+ DateUtil.convertDateToString(kmCarmngDispatchersInfo.getFdStartTime(), DateUtil.TYPE_DATETIME,
						Locale.getDefault())
				+ ResourceUtil.getString("kmCarmng.message.title0", bundle) + DateUtil.convertDateToString(
						kmCarmngDispatchersInfo.getFdEndTime(), DateUtil.TYPE_DATETIME, Locale.getDefault())
				+ ")";
		replaceMap.put("km-carmnag:kmCarmngDispatcher.message", message);
		return replaceMap;
	}

	// 申请人的替换文本
	private NotifyReplace getRegisterNotifyReplace(
			KmCarmngDispatchersInfo kmCarmngDispatchersInfo) {
		String carNoString = "";
		for (KmCarmngDispatchersInfoList k : kmCarmngDispatchersInfo
				.getFdDispatchersInfoList()) {
			carNoString += k.getFdCarInfoNo() + ";";
		}
		if (StringUtil.isNotNull(carNoString)) {
			carNoString = carNoString.substring(0, carNoString.length() - 1);
		}
		NotifyReplace notifyReplace = new NotifyReplace();
		String bundle = "km-carmng";
		String message = ResourceUtil.getString("kmCarmngInfomation.fdNo",
				bundle)
				+ "("
				+ carNoString
				+ "),"
				+ ResourceUtil.getString("kmCarmng.fdUseTime", bundle)
				+ "("
				+ DateUtil.convertDateToString(kmCarmngDispatchersInfo
						.getFdStartTime(), DateUtil.TYPE_DATETIME, Locale
								.getDefault())
				+ ResourceUtil.getString("kmCarmng.message.title0", bundle)
				+ DateUtil.convertDateToString(kmCarmngDispatchersInfo
						.getFdEndTime(), DateUtil.TYPE_DATETIME, Locale
								.getDefault())
				+ ")";
		notifyReplace.addReplaceText("km-carmnag:kmCarmngDispatcher.message",
				message);
		return notifyReplace;
	}

	// 申请人的替换文本
	private HashMap getRegisterReplaceMap(KmCarmngDispatchersInfo kmCarmngDispatchersInfo) {
		String carNoString = "";
		for (KmCarmngDispatchersInfoList k : kmCarmngDispatchersInfo.getFdDispatchersInfoList()) {
			carNoString += k.getFdCarInfoNo() + ";";
		}
		if (StringUtil.isNotNull(carNoString)) {
			carNoString = carNoString.substring(0, carNoString.length() - 1);
		}
		HashMap replaceMap = new HashMap();
		String bundle = "km-carmng";
		String message = ResourceUtil.getString("kmCarmngInfomation.fdNo",
				bundle)
				+ "("
				+ carNoString
				+ "),"
				+ ResourceUtil.getString("kmCarmng.fdUseTime", bundle)
				+ "("
				+ DateUtil.convertDateToString(kmCarmngDispatchersInfo
						.getFdStartTime(), DateUtil.TYPE_DATETIME, Locale
						.getDefault())
				+ ResourceUtil.getString("kmCarmng.message.title0", bundle)
				+ DateUtil.convertDateToString(kmCarmngDispatchersInfo
						.getFdEndTime(), DateUtil.TYPE_DATETIME, Locale
						.getDefault()) + ")";
		replaceMap.put("km-carmnag:kmCarmngDispatcher.message", message);
		return replaceMap;
	}

	private NotifyReplace getDriverNotifyReplace(
			KmCarmngDispatchersInfo kmCarmngDispatchersInfo,
			KmCarmngDispatchersInfoList kmCarmngDispatchersInfoList) {
		NotifyReplace notifyReplace = new NotifyReplace();
		notifyReplace.addReplaceText(
				"km-carmng:kmCarmngDispatcherInfo.fdCarInfo",
				kmCarmngDispatchersInfoList.getFdCarInfoNo());
		notifyReplace.addReplaceDate(
				"km-carmng:kmCarmngDispatcherInfo.fdUseTime",
				kmCarmngDispatchersInfo.getFdStartTime(),
				"datetime");
		return notifyReplace;
	}

	// 驾驶员的替换文本
	private HashMap getDriverReplaceMap(KmCarmngDispatchersInfo kmCarmngDispatchersInfo,
			KmCarmngDispatchersInfoList kmCarmngDispatchersInfoList) {
		HashMap replaceMap = new HashMap();
		replaceMap.put("km-carmng:kmCarmngDispatcherInfo.fdCarInfo",
				kmCarmngDispatchersInfoList.getFdCarInfoNo());
		replaceMap.put("km-carmng:kmCarmngDispatcherInfo.fdUseTime", DateUtil
				.convertDateToString(kmCarmngDispatchersInfo.getFdStartTime(),
						DateUtil.TYPE_DATETIME, Locale.getDefault()));
		return replaceMap;
	}

	/**
	 * 给驾驶员发送待阅“您负责驾驶的车牌号为......的车辆将于......出车，请关注！”
	 * 
	 * @param kmCarmngDispatchersInfo
	 * @throws Exception
	 */
	private void sendDriverFromResource(KmCarmngDispatchersInfo kmCarmngDispatchersInfo,
			KmCarmngDispatchersInfoList kmCarmngDispatchersInfoList) throws Exception {
		NotifyContext notifyContext = sysNotifyMainCoreService
				.getContext("km-carmng:kmCarmngApplication.dispatcher.notify.10");
		notifyContext.setNotifyType(kmCarmngDispatchersInfo.getFdNotifyType());
		notifyContext.setFlag(SysNotifyConstant.NOTIFY_TODOTYPE_ONCE);// 待阅
		notifyContext.setKey("sendDriverKmCarmngApplicationNotify");
		List targets = new ArrayList();
		targets.add(kmCarmngDispatchersInfoList.getFdSysDriver());
		notifyContext.setNotifyTarget(targets);
		sysNotifyMainCoreService.sendNotify(kmCarmngDispatchersInfo,
				notifyContext,
				getDriverNotifyReplace(kmCarmngDispatchersInfo,
						kmCarmngDispatchersInfoList));
	}

	/**
	 * 发送给外部驾驶员
	 * 
	 * @param kmCarmngDispatchersInfo
	 * @throws Exception
	 */
	private void sendDriverFromOuter(
			KmCarmngDispatchersInfo kmCarmngDispatchersInfo, KmCarmngDispatchersInfoList kmCarmngDispatchersInfoList,
			Boolean isChange)
			throws Exception {
		if (StringUtil.isNotNull(kmCarmngDispatchersInfoList.getFdDriverId())
				&& StringUtil.isNotNull(kmCarmngDispatchersInfoList
						.getFdRelationPhone())) {
			SysNotifyShortMessageSend model = new SysNotifyShortMessageSend();
			String conent = ResourceUtil.getString(
					"kmCarmngApplication.dispatcher.notify.10.subject",
					"km-carmng");
			if (isChange) {
				conent = ResourceUtil.getString("kmCarmngApplication.dispatcher.notify.11.subject", "km-carmng");
			}
			conent = StringUtil.replace(conent,
					"%km-carmng:kmCarmngDispatcherInfo.fdCarInfo%",
					kmCarmngDispatchersInfoList.getFdCarInfoNo());
			conent = StringUtil.replace(conent,
					"%km-carmng:kmCarmngDispatcherInfo.fdUseTime%", DateUtil
							.convertDateToString(kmCarmngDispatchersInfo
									.getFdStartTime(), DateUtil.TYPE_DATETIME,
									Locale.getDefault()));
			model.setFdContent(conent); // 设置短信内容
			model.setFdSendType((byte) 1); // 设置短信为立即发送
			model.setFdSentTimes((byte) 0); // 设置已发次数为0
			model.setFdFailTimes((byte) 0); // 设置发送失败次数为0
			model.setFdFlag((byte) 1); // 设置发送标志为“待发送”
			model.setFdReceiverId(kmCarmngDispatchersInfoList.getFdDriverId());
			model.setFdReceiver(kmCarmngDispatchersInfoList.getFdDriverName());
			model.setFdReceiverNumber(kmCarmngDispatchersInfoList
					.getFdRelationPhone()); // 设置接收方手机号
			if (kmCarmngDispatchersInfo.getDocCreator() != null) {
				model.setFdSenderId(kmCarmngDispatchersInfo.getDocCreator()
						.getFdId()); // 设置发送者
				model.setFdSender(kmCarmngDispatchersInfo.getDocCreator()
						.getFdName()); // 设置发送者
			}
			model.setFdCreateTime(new Date()); // 记录创建时间
			sysNotifyShortMessageSendDao.add(model);
		}
	}

	/**
	 * 给驾驶员发送待阅“您负责驾驶的车牌号为......的车辆将于......出车，请关注！”
	 * 
	 * @param kmCarmngDispatchersInfo
	 * @throws Exception
	 */
	private void sendRegisterFromResource2(KmCarmngDispatchersInfo kmCarmngDispatchersInfo,
			KmCarmngDispatchersInfoList kmCarmngDispatchersInfoList) throws Exception {

		sysNotifyMainCoreService.getTodoProvider().remove(kmCarmngDispatchersInfo,
				"registerNotify_" + kmCarmngDispatchersInfoList.getFdId());

		NotifyContext notifyContext = sysNotifyMainCoreService
				.getContext("km-carmng:kmCarmngApplication.dispatcher.notify.2");
		notifyContext.setNotifyType(kmCarmngDispatchersInfo.getFdNotifyType());
		notifyContext.setFlag(SysNotifyConstant.NOTIFY_TODOTYPE_MANUAL);// 待办
		notifyContext.setKey("registerNotify_" + kmCarmngDispatchersInfoList.getFdId());
		List targets = new ArrayList();
		if (kmCarmngDispatchersInfoList.getFdSysDriver() != null
				&& !targets.contains(kmCarmngDispatchersInfoList.getFdSysDriver())) {
			targets.add(kmCarmngDispatchersInfoList.getFdSysDriver());
		}
		
		SysOrgElement fdRegister1 = kmCarmngDispatchersInfoList.getFdCarInfo().getFdMotorcade().getFdRegister();
		SysOrgElement fdRegister2 = kmCarmngDispatchersInfo.getFdRegister();
		if (fdRegister1 != null) {
			if (!targets.contains(fdRegister2) && fdRegister1 != fdRegister2) {
				targets.add(fdRegister2);
			}
			if (kmCarmngDispatchersInfoList.getFdSysDriver() != null && fdRegister1 != kmCarmngDispatchersInfoList.getFdSysDriver()) {
				targets.remove(fdRegister1);
			}
		}
		notifyContext.setNotifyTarget(targets);
		// 向回车登记员发送待办“车辆调度通过，回车请做好登记，调度信息：%km-carmnag:kmCarmngDispatcher.message%”
		sysNotifyMainCoreService.sendNotify(kmCarmngDispatchersInfo,
				notifyContext,
				getRegisterNotifyReplace2(kmCarmngDispatchersInfo,
						kmCarmngDispatchersInfoList));
	}

	/**
	 * 给回车登记员发送待办“车辆调度通过，回车请做好登记，调度信息：......”
	 * 
	 * @param kmCarmngDispatchersInfo
	 * @throws Exception
	 */
	private void sendRegisterFromResource(
			KmCarmngDispatchersInfo kmCarmngDispatchersInfo) throws Exception {

		sysNotifyMainCoreService.getTodoProvider().remove(kmCarmngDispatchersInfo,
				"sendRegisterKmCarmngApplicationNotify");

		NotifyContext notifyContext = sysNotifyMainCoreService
				.getContext("km-carmng:kmCarmngApplication.dispatcher.notify.2");
		notifyContext.setNotifyType("todo");
		notifyContext.setFlag(SysNotifyConstant.NOTIFY_TODOTYPE_MANUAL);// 待办
		notifyContext.setKey("sendRegisterKmCarmngApplicationNotify");
		List targets = new ArrayList();
		targets.add(kmCarmngDispatchersInfo.getFdRegister());
		notifyContext.setNotifyTarget(targets);
		// 向回车登记员发送待办“车辆调度通过，回车请做好登记，调度信息：%km-carmnag:kmCarmngDispatcher.message%”
		sysNotifyMainCoreService.sendNotify(kmCarmngDispatchersInfo,
				notifyContext,
				getRegisterNotifyReplace(kmCarmngDispatchersInfo));
	}

	@Override
	public void delete(IBaseModel modelObj) throws Exception {
		KmCarmngDispatchersInfo kmCarmngDispatchersInfo = (KmCarmngDispatchersInfo) modelObj;
		String fdApplicationIds = kmCarmngDispatchersInfo.getFdApplicationIds();
		String[] applicationIds = fdApplicationIds.split(";");
		for (int i = 0; i < applicationIds.length; i++) {
			String applicationId = applicationIds[i];
			KmCarmngApplication kmCarmngApplication = (KmCarmngApplication) kmCarmngApplicationService
					.findByPrimaryKey(applicationId, null, true);
			if (kmCarmngApplication != null) {
				kmCarmngApplication.setFdIsDispatcher(1);
				kmCarmngApplicationService.update(kmCarmngApplication);
			}
		}
		super.delete(modelObj);
	}

	/**
	 * <p>
	 * 		新增调度不派车通知处理
	 * 		您申请的用车未能安排派车，请链接查看详细原因，主题：XXXXX
	 * </p>
	 * @param kmCarmngDispatchersInfo
	 * @author 孙佳
	 * @throws Exception 
	 */
	private void sendNoCarNotify(KmCarmngDispatchersInfo kmCarmngDispatchersInfo,
			KmCarmngApplication kmCarmngApplication, String content) throws Exception {
		NotifyContext notifyContext = sysNotifyMainCoreService
				.getContext(content);
		notifyContext.setNotifyType(kmCarmngDispatchersInfo.getFdNotifyType());
		notifyContext.setFlag(SysNotifyConstant.NOTIFY_TODOTYPE_ONCE);// 待阅
		notifyContext.setKey("sendNoCarNotify");
		List targets = new ArrayList();
		//申请人
		targets.add(kmCarmngApplication.getDocCreator());
		//用车人
		if (StringUtil.isNotNull(kmCarmngApplication.getFdNotifyPerson())
				&& kmCarmngApplication.getFdNotifyPerson().contains("1")) {
			targets.addAll(kmCarmngApplication.getFdUserPersons());
		}
		//联系人
		targets.add(kmCarmngApplication.getFdApplicationPerson());
		notifyContext.setNotifyTarget(targets);

		NotifyReplace notifyReplace = new NotifyReplace();
		notifyReplace.addReplaceText("km-carmng:kmCarmngApplication.docSubject", kmCarmngApplication.getDocSubject());
		sysNotifyMainCoreService.sendNotify(kmCarmngApplication, notifyContext, notifyReplace);
	}

	/**
	 * <p>
	 * 		更新调度不派车通知处理
	 * 		待阅通知驾驶员：您之前安排的出车已调整为不出车，请链接查看详细原因，主题：XXXXX
	 * </p>
	 * @param kmCarmngDispatchersInfo
	 * @param kmCarmngDispatchersInfoList
	 * @throws Exception
	 * @author 孙佳
	 */
	private void sendNoCarDriverNotify(KmCarmngDispatchersInfo kmCarmngDispatchersInfo,
			List list) throws Exception {
		NotifyContext notifyContext = sysNotifyMainCoreService
				.getContext("km-carmng:kmCarmngApplication.dispatcher.no.car.notify.driver");
		notifyContext.setNotifyType(kmCarmngDispatchersInfo.getFdNotifyType());
		notifyContext.setFlag(SysNotifyConstant.NOTIFY_TODOTYPE_ONCE);// 待阅
		notifyContext.setKey("sendNoCarDriverNotify");
		List targets = new ArrayList();
		targets.addAll(list);
		notifyContext.setNotifyTarget(targets);
		NotifyReplace notifyReplace = new NotifyReplace();
		notifyReplace.addReplaceText("km-carmng:kmCarmngApplication.docSubject", kmCarmngDispatchersInfo.getFdApplicationNames());
		sysNotifyMainCoreService.sendNotify(kmCarmngDispatchersInfo, notifyContext, notifyReplace);
	}
	
	/**
	 * <p>
	 * 不调度派车，移除调度员派车通知处理
	 * </p>
	 * 
	 * @param kmCarmngDispatchersInfo
	 * @author lwc
	 * @throws Exception
	 */
	private void removeNoCarNotifyFromDispatchers(
			KmCarmngApplication kmCarmngApplication)
			throws Exception {
		ISysNotifyTodoProvider todoProvider = sysNotifyMainCoreService
				.getTodoProvider();
		if (todoProvider != null) {
			try {
				todoProvider.remove((ISysNotifyModel) kmCarmngApplication,
						"sendKmCarmngApplicationPublishNotify",
						null, null);
			} catch (Exception ex) {
				logger.error("不调度移除调度人代办失败", ex);
			}
		}
	}

	/**
	 * <p>调度派车更改为调度不派车，初始化数据</p>
	 * @param kmCarmngDispatchersInfo
	 * @author 孙佳
	 */
	private void initDispatchersInfo(KmCarmngDispatchersInfo kmCarmngDispatchersInfo) {
		kmCarmngDispatchersInfo.setFdFlag("2");
		kmCarmngDispatchersInfo.setFdStartTime(null);
		kmCarmngDispatchersInfo.setFdEndTime(null);
		kmCarmngDispatchersInfo.setFdCarInfoIds(null);
		kmCarmngDispatchersInfo.setFdCarInfoNames(null);
	}


	/**
	 * <p>保存调度记录</p>
	 * @author 孙佳
	 * @param kmCarmngDispatchersInfo 
	 * @throws Exception 
	 */
	private void saveDispatchersLog(KmCarmngDispatchersInfo kmCarmngDispatchersInfo) throws Exception {
		KmCarmngDispatchersLog modelObj = new KmCarmngDispatchersLog();
		modelObj.setFdDispatchersId(kmCarmngDispatchersInfo.getFdId());
		modelObj.setDocCreator(UserUtil.getUser());
		modelObj.setFdDispatchersTime(new Date());
		if ("0".equals(kmCarmngDispatchersInfo.getFdDispatchersType())) {
			modelObj.setFdCarIds(kmCarmngDispatchersInfo.getFdCarInfoIds());
			modelObj.setFdCarNames(kmCarmngDispatchersInfo.getFdCarInfoNames());
			modelObj.setFdStartTime(kmCarmngDispatchersInfo.getFdStartTime());
			modelObj.setFdEndTime(kmCarmngDispatchersInfo.getFdEndTime());
		} else {
			modelObj.setFdRemark(kmCarmngDispatchersInfo.getFdRemark());
		}
		modelObj.setFdIsCar("0".equals(kmCarmngDispatchersInfo.getFdDispatchersType()) ? true : false);
		kmCarmngDispatchersLogService.add(modelObj);
	}
}
