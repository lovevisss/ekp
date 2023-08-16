package com.landray.kmss.km.carmng.service.spring;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.service.BaseServiceImp;
import com.landray.kmss.km.carmng.model.KmCarmngApplication;
import com.landray.kmss.km.carmng.model.KmCarmngDispatchersInfo;
import com.landray.kmss.km.carmng.model.KmCarmngInfomation;
import com.landray.kmss.km.carmng.model.KmCarmngPath;
import com.landray.kmss.km.carmng.service.IKmCarmngApplicationService;
import com.landray.kmss.km.carmng.service.IKmCarmngDispatchersInfoListService;
import com.landray.kmss.km.carmng.service.IKmCarmngDispatchersInfoService;
import com.landray.kmss.km.carmng.service.IKmCarmngInfomationService;
import com.landray.kmss.sys.attachment.model.SysAttMain;
import com.landray.kmss.sys.attachment.service.ISysAttMainCoreInnerService;
import com.landray.kmss.util.ArrayUtil;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.HQLUtil;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.util.StringUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
/**
 * 创建日期 2010-三月-24
 * @author 叶中奇
 * 车辆信息业务接口实现
 */
public class KmCarmngInfomationServiceImp extends BaseServiceImp implements IKmCarmngInfomationService {
	protected ISysAttMainCoreInnerService sysAttMainService;

	public void setSysAttMainService(
			ISysAttMainCoreInnerService sysAttMainService) {
		this.sysAttMainService = sysAttMainService;
	}

	@Override
	public String getCarPicIdsByCarId(String fdId) throws Exception {
		try {
			List<SysAttMain> attMainList = new ArrayList<SysAttMain>();
			StringBuffer sb = new StringBuffer();
			attMainList = this.sysAttMainService.findByModelKey(
					"com.landray.kmss.km.carmng.model.KmCarmngInfomation", fdId,
					"kmCarmngPic");
			if (!ArrayUtil.isEmpty(attMainList)) {
				for (int i = 0; i < attMainList.size(); i++) {
					SysAttMain sysAttMain = attMainList.get(i);
					if (i == attMainList.size() - 1) {
						sb.append(sysAttMain.getFdId());
					} else {
						sb.append(sysAttMain.getFdId()).append(";");
					}
				}
			}
			return sb.toString();
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public JSONArray loadCarByIds(String[] fdIds, String fdStartTime, String fdEndTime) throws Exception {
		JSONArray jsonArr = new JSONArray();

		List<KmCarmngInfomation> cardList = this.findByPrimaryKeys(fdIds);

		for (KmCarmngInfomation car : cardList) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("fdCarInfoId", car.getFdId());
			jsonObj.put("fdCarInfoName", car.getDocSubject());
			jsonObj.put("fdCarInfoNo", car.getFdNo());
			jsonObj.put("fdMotorcadeId", car.getFdMotorcade().getFdId());
			jsonObj.put("fdMotorcadeName", car.getFdMotorcade().getFdName());
			jsonObj.put("fdDriverId", car.getFdDriverId());
			jsonObj.put("fdDriverName", car.getFdDriverName());
			jsonObj.put("fdVehichesTypeId", car.getFdVehichesType().getFdId());
			jsonObj.put("fdVehichesTypeName", car.getFdVehichesType().getFdName());
			jsonObj.put("fdRelationPhone", car.getFdRelationPhone());
			jsonObj.put("fdSeatNumber", car.getFdSeatNumber());
			if (car.getFdSysDriver() == null) {
				jsonObj.put("sysId", "");
				jsonObj.put("fdDriversType", "outer");
			} else {
				jsonObj.put("sysId", car.getFdSysDriver().getFdId());
				jsonObj.put("fdDriversType", "inner");
			}
			String ids = this.getCarPicIdsByCarId(car.getFdId());
			String attPath = "/km/asset/mobile/js/list/item/defaulthead.jpg";
			if (StringUtil.isNotNull(ids)) {
				attPath = "/sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId=" + ids.split(";")[0];
			}
			jsonObj.put("attPath", attPath);
			KmCarmngDispatchersInfo dispInfo = checkConflict(null,
					fdStartTime, fdEndTime, car.getFdId());
			jsonObj.put("info", dispInfo == null ? null : getInfo(dispInfo, car.getDocSubject(), car.getFdNo()));

			jsonArr.add(jsonObj);
		}
		return jsonArr;
	}

	private String getInfo(KmCarmngDispatchersInfo dispInfo, String carName, String fdNo) throws Exception {
		String fdAppId = dispInfo.getFdApplicationIds().split(";")[0];
		KmCarmngApplication carApp = (KmCarmngApplication) ((IKmCarmngApplicationService) SpringBeanUtil
				.getBean("kmCarmngApplicationService")).findByPrimaryKey(fdAppId);
		String fdDeparture = carApp.getFdDeparture();
		String fdDestination = carApp.getFdDestination();
		String startTime = DateUtil.convertDateToString(dispInfo.getFdStartTime(), DateUtil.PATTERN_DATETIME,
				Locale.getDefault());
		String endTime = DateUtil.convertDateToString(dispInfo.getFdEndTime(), DateUtil.PATTERN_DATETIME,
				Locale.getDefault());
		List<KmCarmngPath> fdPaths = carApp.getFdPaths();
		for (KmCarmngPath path : fdPaths) {
			fdDestination = StringUtil.linkString(fdDestination, "、", path.getFdDestination());
		}
		String info = carName + "(" + fdNo + ")" + ", 出车时间上有冲突, 行程安排(" + fdDeparture + "-" + fdDestination
				+ "), 出车时间(" + startTime + " 至 " + endTime + ")";
		return info;
	}
	
	private KmCarmngDispatchersInfo checkConflict(String fdDispId,
			String fdStartTime,
			String fdEndTime, String carId) throws Exception {
		if (StringUtil.isNotNull(fdStartTime)
				&& StringUtil.isNotNull(fdEndTime)) {
			Date startDate = DateUtil.convertStringToDate(fdStartTime,
					DateUtil.PATTERN_DATETIME, Locale.getDefault());
			Date endDate = DateUtil.convertStringToDate(fdEndTime,
					DateUtil.PATTERN_DATETIME, Locale.getDefault());
			List fs = findDispatchInfoListBycarId(carId);
			if (fs != null && !fs.isEmpty()) {
				HQLInfo hqlInfo = new HQLInfo();
				hqlInfo.setOrderBy(
						"kmCarmngDispatchersInfo.docCreateTime desc");
				String whereBlock = HQLUtil.buildLogicIN(
						"kmCarmngDispatchersInfo.fdDispatchersInfoList.fdId",
						fs);
				whereBlock += " and kmCarmngDispatchersInfo.fdStartTime <= :fdEndTime and kmCarmngDispatchersInfo.fdEndTime>=:startTime ";
				if (StringUtil.isNotNull(fdDispId)) {
					whereBlock += " and kmCarmngDispatchersInfo.fdId != :fdDispId";
					hqlInfo.setParameter("fdDispId", fdDispId);
				}
				hqlInfo.setWhereBlock(whereBlock);
				hqlInfo.setParameter("fdEndTime", endDate);
				hqlInfo.setParameter("startTime", startDate);
				List<KmCarmngDispatchersInfo> list = ((IKmCarmngDispatchersInfoService) SpringBeanUtil
						.getBean("kmCarmngDispatchersInfoService"))
						.findList(hqlInfo);
				boolean flag = list != null && !list.isEmpty();
				return flag ? list.get(0) : null;
			}
		}
		return null;
	}

	private List findDispatchInfoListBycarId(String carId) throws Exception {
		HQLInfo hqlInfo = new HQLInfo();
		hqlInfo.setSelectBlock("kmCarmngDispatchersInfoList.fdId");
		hqlInfo.setWhereBlock(" kmCarmngDispatchersInfoList.fdCarInfo.fdId =:carId");
		hqlInfo.setParameter("carId", carId);
		List fs = ((IKmCarmngDispatchersInfoListService) SpringBeanUtil.getBean("kmCarmngDispatchersInfoListService"))
				.findList(hqlInfo);
		return fs;
	}
}
