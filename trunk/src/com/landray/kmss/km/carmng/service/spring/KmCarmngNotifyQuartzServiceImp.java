package com.landray.kmss.km.carmng.service.spring;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;

import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.constant.SysNotifyConstant;
import com.landray.kmss.km.carmng.model.KmCarmngInfomation;
import com.landray.kmss.km.carmng.model.KmCarmngInsuranceInfo;
import com.landray.kmss.km.carmng.service.IKmCarmngInfomationService;
import com.landray.kmss.km.carmng.service.IKmCarmngInsuranceInfoService;
import com.landray.kmss.km.carmng.service.IKmCarmngNotifyQuartzService;
import com.landray.kmss.sys.notify.interfaces.ISysNotifyMainCoreService;
import com.landray.kmss.sys.notify.interfaces.NotifyContext;
import com.landray.kmss.sys.notify.interfaces.NotifyReplace;
import com.landray.kmss.sys.quartz.interfaces.SysQuartzJobContext;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.StringUtil;

/**
 * @ClassName: KmCarmngNotifyQuartzServiceImp
 * @Description: TODO(用于定时任务发送保险和年检快到期的通知)
 * @author 张文添
 * @date 2010-11-15 下午07:08:52
 * 
 */
public class KmCarmngNotifyQuartzServiceImp implements
		IKmCarmngNotifyQuartzService {

	private IKmCarmngInsuranceInfoService kmCarmngInsuranceInfoService;

	public void setKmCarmngInsuranceInfoService(
			IKmCarmngInsuranceInfoService kmCarmngInsuranceInfoService) {
		this.kmCarmngInsuranceInfoService = kmCarmngInsuranceInfoService;
	}

	private ISysNotifyMainCoreService sysNotifyMainCoreService;

	public void setSysNotifyMainCoreService(
			ISysNotifyMainCoreService sysNotifyMainCoreService) {
		this.sysNotifyMainCoreService = sysNotifyMainCoreService;
	}

	private IKmCarmngInfomationService kmCarmngInfomationService;

	public void setKmCarmngInfomationService(
			IKmCarmngInfomationService kmCarmngInfomationService) {
		this.kmCarmngInfomationService = kmCarmngInfomationService;
	}

	@Override
	public void runCarmngNotify(SysQuartzJobContext jobContext)
			throws Exception {
		// TODO 自动生成的方法存根
		try {
			notifyInsuranceInfo();
			notifyCarmngInfo();
		} catch (Exception e) {
			// TODO: handle exception
			jobContext.logError(e);
		}
	}

	/**
	 * @Title: notifyCarmngInfo
	 * @Description: TODO(发送年审通知)
	 * @param @throws Exception 设定文件
	 * @return void 返回类型
	 * @throws
	 */
	private void notifyCarmngInfo() throws Exception {
		// TODO 自动生成的方法存根
		Date nowDate = new Date();
		String nowDateStr = DateUtil.convertDateToString(nowDate,
				DateUtil.TYPE_DATE, Locale.getDefault());
		// 当前年份
		int nowDateInt = Integer.parseInt(nowDateStr.substring(0, 4));
		// 当前月份
		int nowMoth = Integer.parseInt(nowDateStr.substring(5, 7));
		String whereBlock = "1 < 2";
		HQLInfo hqlInfo = new HQLInfo();
		hqlInfo.setWhereBlock(whereBlock);
		List carmngInfoList = kmCarmngInfomationService.findList(hqlInfo);
		if (carmngInfoList.isEmpty()) {
            return;
        }
		for (Iterator ite = carmngInfoList.iterator(); ite.hasNext();) {
			KmCarmngInfomation kmCarmngInfomation = (KmCarmngInfomation) ite
					.next();
			if (kmCarmngInfomation == null
					|| kmCarmngInfomation.getFdIsNotify() == null) {
                continue;
            }
			// 是否在年检日期前通知
			if (kmCarmngInfomation.getFdIsNotify()) {
				// #133291 车辆状态为报废不通知
				String fdCarmngStatus = kmCarmngInfomation.getDocStatus();
				if ("3".equals(fdCarmngStatus)) {
					continue;
				}
				// 初次年检时间
				Date fdAnnualCheckTime = kmCarmngInfomation
						.getFdAnnuaCheckTime();
				String fdAnnualCheckTimeStr = DateUtil.convertDateToString(
						fdAnnualCheckTime, DateUtil.TYPE_DATE,
						Locale.getDefault());
				String fdUnit = kmCarmngInfomation.getFdUnit();
				if (StringUtil.isNull(fdAnnualCheckTimeStr)) {
                    continue;
                }
				// 初检-年
				int fdAnnualCheckTimeInt = Integer
						.parseInt(fdAnnualCheckTimeStr.substring(0, 4));
				// 年检频率
				String fdAnnuaCheckFrequency = kmCarmngInfomation
						.getFdAnnuaCheckFrequency();
				int fdAnnuaCheckFrequencyInt = Integer
						.parseInt(fdAnnuaCheckFrequency);
				// 提前通知时间
				Integer fdNotifyBeforeDay = kmCarmngInfomation
						.getFdNotifyBeforeDay();
				// 时间判断
				Calendar nowDateCalendar = Calendar.getInstance();
				nowDateCalendar.setTime(nowDate);
				Calendar annualCheckTimeCalendar = Calendar.getInstance();
				annualCheckTimeCalendar.setTime(fdAnnualCheckTime);
				annualCheckTimeCalendar.add(Calendar.DAY_OF_MONTH,
						-fdNotifyBeforeDay.intValue());
				// 年检频率单位是 年
				if ("1".equals(fdUnit)) {
					if (StringUtil.isNull(fdAnnuaCheckFrequency)
							|| Integer.parseInt(fdAnnuaCheckFrequency) == 0) {
                        continue;
                    }
					if (nowDateInt < fdAnnualCheckTimeInt
							|| ((nowDateInt - fdAnnualCheckTimeInt)
									% fdAnnuaCheckFrequencyInt != 0)) {
                        continue;
                    }
				} else {// 年检频率单位是 月
					if (StringUtil.isNull(fdAnnuaCheckFrequency)
							|| Integer.parseInt(fdAnnuaCheckFrequency) == 0) {
                        continue;
                    }
					int year = (nowDateCalendar.get(Calendar.YEAR)
							- annualCheckTimeCalendar.get(Calendar.YEAR)) * 12;
					int month = nowDateCalendar.get(Calendar.MONTH)
							- annualCheckTimeCalendar.get(Calendar.MONTH);
					int differMonth = Math.abs(year + month);
					// 当前时间<检测时间
					if (nowDateInt < fdAnnualCheckTimeInt
							|| differMonth % fdAnnuaCheckFrequencyInt != 0) {
						continue;
					} else {
						annualCheckTimeCalendar.add(Calendar.MONTH,
								differMonth);
					}
				}
				// 通知人
				List fdNotifyPersons = kmCarmngInfomation.getFdNotifyPersons();
				List targetList = new ArrayList();
				targetList.addAll(fdNotifyPersons);
				String key = "kmCarmngInfoNotifyPersonInfoKey";
				String resource = "km-carmng:kmCarmngInfo.notify.tip4";
				// 判断时间是否相等
				Boolean isSimpleYear = nowDateCalendar
						.get(Calendar.YEAR) == annualCheckTimeCalendar
								.get(Calendar.YEAR);
				Boolean isSimpleMonth = nowDateCalendar
						.get(Calendar.MONTH) == annualCheckTimeCalendar
								.get(Calendar.MONTH);
				Boolean isSimpleDay = nowDateCalendar
						.get(Calendar.DAY_OF_MONTH) == annualCheckTimeCalendar
								.get(Calendar.DAY_OF_MONTH);
				if (("1".equals(fdUnit) && isSimpleMonth && isSimpleDay)
						|| ((("2".equals(fdUnit) || StringUtil.isNull(fdUnit))
								&& isSimpleYear && isSimpleMonth
								&& isSimpleDay))) {
					// 发送待办
					sendTodoFromResource(kmCarmngInfomation, targetList,
							resource, key);
				}
			}
		}
			}

	private void sendTodoFromResource(KmCarmngInfomation kmCarmngInfomation,
			List targetList, String resource, String key) throws Exception {
		// TODO 自动生成的方法存根
		NotifyContext notifyContext = sysNotifyMainCoreService
				.getContext(resource);
		notifyContext.setNotifyType("todo");
		notifyContext.setFlag(SysNotifyConstant.NOTIFY_TODOTYPE_ONCE);
		notifyContext.setKey(key);
		notifyContext.setNotifyTarget(targetList);
		sysNotifyMainCoreService.sendNotify(kmCarmngInfomation, notifyContext,
				getNotifyReplace_forInsurance(kmCarmngInfomation));
	}

	private NotifyReplace getNotifyReplace_forInsurance(
			KmCarmngInfomation kmCarmngInfomation) {
		// TODO 自动生成的方法存根
		NotifyReplace notifyReplace = new NotifyReplace();
		String messages = kmCarmngInfomation.getFdNo();
		notifyReplace.addReplaceText("km-carmng:kmCarmngInfomation.fdNo",
				messages);
		return notifyReplace;
	}

	private HashMap getReplaceMap_forInsurance(
			KmCarmngInfomation kmCarmngInfomation) {
		// TODO 自动生成的方法存根
		HashMap replaceMap = new HashMap();
		String bundle = "km-carmng";
		String messages = kmCarmngInfomation.getFdNo();
		replaceMap.put("km-carmng:kmCarmngInfomation.fdNo", messages);
		return replaceMap;
	}

	/**
	 * @Title: notifyInsuranceInfo
	 * @Description: TODO(发送保险通知)
	 * @param @throws Exception 设定文件
	 * @return void 返回类型
	 * @throws
	 */
	private void notifyInsuranceInfo() throws Exception {
		Date nowDate = new Date();
		String nowDateStr = DateUtil.convertDateToString(nowDate,
				DateUtil.TYPE_DATE, Locale.getDefault());
		String whereBlock = "1 < 2";
		HQLInfo hqlInfo = new HQLInfo();
		hqlInfo.setWhereBlock(whereBlock);
		List insuranceInfoList = kmCarmngInsuranceInfoService.findList(hqlInfo);
		if (insuranceInfoList.isEmpty()) {
            return;
        }
		for (Iterator ite = insuranceInfoList.iterator(); ite.hasNext();) {
			KmCarmngInsuranceInfo kmCarmngInsuranceInfo = (KmCarmngInsuranceInfo) ite
					.next();
			if (kmCarmngInsuranceInfo == null
					|| kmCarmngInsuranceInfo.getFdIsNotify() == null) {
                continue;
            }
			if (kmCarmngInsuranceInfo.getFdIsNotify()) {
				List fdNotifyPersons = kmCarmngInsuranceInfo
						.getFdNotifyPersons();
				Integer fdNotifyBeforeDay = kmCarmngInsuranceInfo
						.getFdNotifyBeforeDay();
				Date insuranceEnDate = kmCarmngInsuranceInfo
						.getFdInsuranceEndTime();
				Calendar calendar = Calendar.getInstance();
				if (insuranceEnDate != null) {
					calendar.setTime(insuranceEnDate);
					calendar.add(Calendar.DAY_OF_MONTH, -fdNotifyBeforeDay
							.intValue());
				}
				if (DateUtil.convertDateToString(calendar.getTime(),
						DateUtil.TYPE_DATE, Locale.getDefault()).equals(
						nowDateStr)) {
					List targetList = new ArrayList();
					targetList.addAll(fdNotifyPersons);
					String key = "kmCarmngInsuranceNotifyPersonInfoKey";
					String resource = "km-carmng:kmCarmngInsuranceInfo.notify.tip4";
					sendTodoFromResource(kmCarmngInsuranceInfo, targetList,
							resource, key);
				}
			}
		}
	}

	private void sendTodoFromResource(
			KmCarmngInsuranceInfo kmCarmngInsuranceInfo, List targetList,
			String resource, String key) throws Exception {
		// TODO 自动生成的方法存根
		NotifyContext notifyContext = sysNotifyMainCoreService
				.getContext(resource);
		notifyContext.setNotifyType("todo");
		notifyContext.setFlag(SysNotifyConstant.NOTIFY_TODOTYPE_ONCE);
		notifyContext.setKey(key);
		notifyContext.setNotifyTarget(targetList);
		sysNotifyMainCoreService.sendNotify(kmCarmngInsuranceInfo,
				notifyContext,
				getNotifyReplace_forInsurance(kmCarmngInsuranceInfo));

	}

	private NotifyReplace getNotifyReplace_forInsurance(
			KmCarmngInsuranceInfo kmCarmngInsuranceInfo) {
		// TODO 自动生成的方法存根
		NotifyReplace notifyReplace = new NotifyReplace();
		String messages = kmCarmngInsuranceInfo.getFdVehiclesInfo().getFdNo();
		notifyReplace.addReplaceText("km-carmng:kmCarmngInfomation.fdNo",
				messages);
		return notifyReplace;
	}

	/**
	 * @Title: getReplaceMap_forInsurance
	 * @Description: TODO(设置替换文本)
	 * @param @param kmCarmngInsuranceInfo
	 * @param @return 设定文件
	 * @return HashMap 返回类型
	 * @throws
	 */
	private HashMap getReplaceMap_forInsurance(
			KmCarmngInsuranceInfo kmCarmngInsuranceInfo) {
		// TODO 自动生成的方法存根
		HashMap replaceMap = new HashMap();
		String bundle = "km-carmng";
		String messages = kmCarmngInsuranceInfo.getFdVehiclesInfo().getFdNo();
		replaceMap.put("km-carmng:kmCarmngInfomation.fdNo", messages);
		return replaceMap;
	}

}
