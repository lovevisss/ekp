package com.landray.kmss.km.carmng.service.spring;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.service.IXMLDataBean;
import com.landray.kmss.km.carmng.model.KmCarmngApplication;
import com.landray.kmss.km.carmng.model.KmCarmngCategory;
import com.landray.kmss.km.carmng.model.KmCarmngDispatchersInfo;
import com.landray.kmss.km.carmng.model.KmCarmngDriversInfo;
import com.landray.kmss.km.carmng.model.KmCarmngInfomation;
import com.landray.kmss.km.carmng.model.KmCarmngMotorcadeSet;
import com.landray.kmss.km.carmng.model.KmCarmngPath;
import com.landray.kmss.km.carmng.service.IKmCarmngApplicationService;
import com.landray.kmss.km.carmng.service.IKmCarmngCategoryService;
import com.landray.kmss.km.carmng.service.IKmCarmngDispatchersInfoListService;
import com.landray.kmss.km.carmng.service.IKmCarmngDispatchersInfoService;
import com.landray.kmss.km.carmng.service.IKmCarmngDriversInfoService;
import com.landray.kmss.km.carmng.service.IKmCarmngInfomationService;
import com.landray.kmss.km.carmng.service.IKmCarmngMotorcadeSetService;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.HQLUtil;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.util.UserUtil;

public class KmCarmngInfomationTreeService implements IXMLDataBean {

	private IKmCarmngInfomationService kmCarmngInfomationService = null;

	private IKmCarmngMotorcadeSetService kmCarmngMotorcadeSetService = null;
	
	public void setKmCarmngInfomationService(
			IKmCarmngInfomationService kmCarmngInfomationService) {
		this.kmCarmngInfomationService = kmCarmngInfomationService;
	}

	private IKmCarmngCategoryService kmCarmngCategoryService = null;

	public void setKmCarmngCategoryService(
			IKmCarmngCategoryService kmCarmngCategoryService) {
		this.kmCarmngCategoryService = kmCarmngCategoryService;
	}

	private IKmCarmngDispatchersInfoListService kmCarmngDispatchersInfoListService;

	public void setKmCarmngDispatchersInfoListService(
			IKmCarmngDispatchersInfoListService kmCarmngDispatchersInfoListService) {
		this.kmCarmngDispatchersInfoListService = kmCarmngDispatchersInfoListService;
	}

	private IKmCarmngDispatchersInfoService kmCarmngDispatchersInfoService;

	public void setKmCarmngDispatchersInfoService(
			IKmCarmngDispatchersInfoService kmCarmngDispatchersInfoService) {
		this.kmCarmngDispatchersInfoService = kmCarmngDispatchersInfoService;
	}

	private IKmCarmngApplicationService kmCarmngApplicationService;

	public void setKmCarmngApplicationService(
			IKmCarmngApplicationService kmCarmngApplicationService) {
		this.kmCarmngApplicationService = kmCarmngApplicationService;
	}

	private List findDispatchInfoListBycarId(String carId) throws Exception {
		HQLInfo hqlInfo = new HQLInfo();
		hqlInfo.setSelectBlock("kmCarmngDispatchersInfoList.fdId");
		hqlInfo.setWhereBlock(
				" kmCarmngDispatchersInfoList.fdCarInfo.fdId =:carId");
		hqlInfo.setParameter("carId", carId);
		List fs = kmCarmngDispatchersInfoListService.findList(hqlInfo);
		return fs;
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
				}
				hqlInfo.setWhereBlock(whereBlock);
				hqlInfo.setParameter("fdEndTime", endDate);
				hqlInfo.setParameter("startTime", startDate);
				hqlInfo.setParameter("fdDispId", fdDispId);
				List<KmCarmngDispatchersInfo> list = kmCarmngDispatchersInfoService
						.findList(hqlInfo);
				boolean flag = list != null && !list.isEmpty();
				return flag ? list.get(0) : null;
			}
		}
		return null;
	}
	
	private String getInfo(KmCarmngDispatchersInfo dispInfo, String carName) throws Exception {
		String fdAppId = dispInfo.getFdApplicationIds().split(";")[0];
		KmCarmngApplication carApp = (KmCarmngApplication) kmCarmngApplicationService
				.findByPrimaryKey(fdAppId);
		String fdDeparture = carApp.getFdDeparture();
		String fdDestination = carApp.getFdDestination();
		String startTime = DateUtil.convertDateToString(
				dispInfo.getFdStartTime(), DateUtil.PATTERN_DATETIME,
				Locale.getDefault());
		String endTime = DateUtil.convertDateToString(
				dispInfo.getFdEndTime(), DateUtil.PATTERN_DATETIME,
				Locale.getDefault());
		List<KmCarmngPath> fdPaths = carApp.getFdPaths();
		for (KmCarmngPath path : fdPaths) {
			fdDestination = StringUtil.linkString(fdDestination, "、",
					path.getFdDestination());
		}
		String info = carName + ", 出车时间上有冲突, 行程安排("
				+ fdDeparture + "-"
				+ fdDestination + "), 出车时间(" + startTime + " 至 "
				+ endTime + ")";
		return info;
	}

	@Override
    public List getDataList(RequestContext requestInfo) throws Exception {
		List rtnList = new ArrayList();
		String userNumber = requestInfo.getParameter("userNumber");
		String categoryId = requestInfo.getParameter("categoryId");
		String fdMotorcadeId = requestInfo.getParameter("fdMotorcadeId");
		String kind = requestInfo.getParameter("kind");
		String method = requestInfo.getParameter("method");
		String keyword = requestInfo.getParameter("keyword");
		String fdId = requestInfo.getParameter("fdId");
		String fdDispId = requestInfo.getParameter("fdDispId");
		String fdStartTime = requestInfo.getParameter("fdStartTime");
		String fdEndTime = requestInfo.getParameter("fdEndTime");
		String whereBlock = "";
		HQLInfo hql = new HQLInfo();
		if (StringUtil.isNull(keyword) && StringUtil.isNull(fdMotorcadeId) && "dataList".equals(method)) {
			// 移动端获取数据，没有传车队ID则列出所有的车队
			getAllMotorcadeForMobile(rtnList);
			return rtnList;
		} else if ("detail".equals(method)) {
			KmCarmngInfomation kmCarmngInfomation = (KmCarmngInfomation) kmCarmngInfomationService
					.findByPrimaryKey(fdId);
			Map<String, Object> node = new HashMap<String, Object>();
			getDetailInfo(node,kmCarmngInfomation);
			rtnList.add(node);
			return rtnList;
		} else if ("detailList".equals(method) && StringUtil.isNotNull(fdId)) {
			String[] fdIds = fdId.split(";");
			List<KmCarmngInfomation> kmCarmngInfomationList = kmCarmngInfomationService.findByPrimaryKeys(fdIds);
			for (KmCarmngInfomation kmCarmngInfomation : kmCarmngInfomationList) {
				Map<String, Object> node = new HashMap<String, Object>();
				getDetailInfo(node, kmCarmngInfomation);
				rtnList.add(node);
			}
			return rtnList;
		}
		
		if (StringUtil.isNotNull(categoryId)) {
			KmCarmngCategory kmCarmngCategory = (KmCarmngCategory) kmCarmngCategoryService
					.findByPrimaryKey(categoryId);
			String fdHierarchyId = kmCarmngCategory.getFdHierarchyId();
			whereBlock = "kmCarmngInfomation.fdVehichesType.fdHierarchyId like :fdHierarchyId";
			hql.setParameter("fdHierarchyId", "%" + fdHierarchyId + "%");
		}
		if (StringUtil.isNotNull(fdMotorcadeId)) {
			whereBlock = StringUtil.linkString(whereBlock, " and ",
					"kmCarmngInfomation.fdMotorcade.fdId = :fdMotorcadeId");
			hql.setParameter("fdMotorcadeId", fdMotorcadeId);
		}
		// 调度只查询在役的车辆并且车辆的座位数大于等于随行总人数
		if (StringUtil.isNotNull(kind)) {
			if(StringUtil.isNotNull(whereBlock)){
				whereBlock += " and ";
			}
			whereBlock = whereBlock
					+ " kmCarmngInfomation.docStatus = 1";
		}
		if(StringUtil.isNotNull(userNumber)){
			whereBlock = whereBlock + " and kmCarmngInfomation.fdSeatNumber>=" + userNumber;
		}
		if (StringUtil.isNotNull(keyword)) {
			whereBlock = StringUtil.linkString(whereBlock, " and ", getSearchInfomation(hql, keyword));
		}
		if (StringUtil.isNull(whereBlock)) {
			whereBlock = " 1 > 2";
		}
		hql.setWhereBlock(whereBlock);
		List<KmCarmngInfomation> valueList = kmCarmngInfomationService
				.findList(hql);
		Boolean mobile = "true".equals(requestInfo.getParameter("mobile")); //这里需要区分一下是否来自移动端
		for (KmCarmngInfomation kmCarmngInfomation : valueList) {
			String carId = kmCarmngInfomation.getFdId();
			String carName = kmCarmngInfomation.getDocSubject() + "("
					+ kmCarmngInfomation.getFdNo() + ")";
			Map node = new HashMap();
			node.put("text", kmCarmngInfomation.getFdNo());
			node.put("value", carId);
			node.put("name", carName);
			KmCarmngDispatchersInfo dispInfo = checkConflict(fdDispId,
					fdStartTime, fdEndTime, carId);
			if (dispInfo != null && "0".equals(dispInfo.getFdFlag())) {
				node.put("info", getInfo(dispInfo, carName));
			}
			if (!mobile){ //不是来自移动端，则必须要有id
				node.put("id", carId);
			}			
			node.put("fdCarInfoId", kmCarmngInfomation.getFdId());
			node.put("docSubject", kmCarmngInfomation.getDocSubject());
			node.put("seatNumber", kmCarmngInfomation.getFdSeatNumber());
			node.put("fdVehichesTypeId", kmCarmngInfomation.getFdVehichesType().getFdId());
			node.put("fdVehichesTypeName", kmCarmngInfomation.getFdVehichesType().getFdName());
			node.put("fdDriversName", kmCarmngInfomation.getFdDriverName());
			node.put("fdDriverId", kmCarmngInfomation.getFdDriverId());
			node.put("fdMotorcadeId", kmCarmngInfomation.getFdMotorcade().getFdId());
			node.put("fdMotorcadeName", kmCarmngInfomation.getFdMotorcade().getFdName());
			node.put("fdRegisterId", kmCarmngInfomation.getFdMotorcade()
					.getFdRegister().getFdId());
			node.put("fdRegisterName", kmCarmngInfomation.getFdMotorcade()
					.getFdRegister().getFdName());

			if (StringUtil.isNotNull(kmCarmngInfomation.getFdDriverId())) {
				IKmCarmngDriversInfoService kmCarmngDriversInfoService = (IKmCarmngDriversInfoService) SpringBeanUtil
						.getBean("kmCarmngDriversInfoService");
				if (kmCarmngDriversInfoService != null) {
					kmCarmngDriversInfoService.clearHibernateSession();
					HQLInfo hqlInfo = new HQLInfo();
					hqlInfo.setWhereBlock("kmCarmngDriversInfo.fdId=:driverId");
					hqlInfo.setParameter("driverId", kmCarmngInfomation.getFdDriverId());
					List kmCarmngDriversInfoList = kmCarmngDriversInfoService.findList(hqlInfo);
					if (kmCarmngDriversInfoList.size() > 0) {
						KmCarmngDriversInfo kmCarmngDriversInfo = (KmCarmngDriversInfo) kmCarmngDriversInfoList.get(0);
						if (kmCarmngDriversInfo != null) {
							node.put("fdRelationPhone", kmCarmngDriversInfo.getFdRelationPhone());
							// 内部/外部司机
							if (StringUtil.isNotNull(kmCarmngDriversInfo.getFdSysId())) {
								node.put("sysId", kmCarmngDriversInfo.getFdSysId());
								node.put("fdDriversType", "inner");
							} else {
								node.put("sysId", "");
								node.put("fdDriversType", "outer");
							}
						}
					}
				}
			}
			rtnList.add(node);
		}
		return rtnList;
	}
	private void getDetailInfo(Map<String, Object> node,
			KmCarmngInfomation kmCarmngInfomation) throws Exception {
		node.put("text", kmCarmngInfomation.getFdNo());
		// 移动端使用
		node.put("label", kmCarmngInfomation.getFdNo());
		node.put("fdId", kmCarmngInfomation.getFdId());
		// 移动端使用
		node.put("value", kmCarmngInfomation.getFdId());
		node.put("id", kmCarmngInfomation.getFdId());
		node.put("docSubject", kmCarmngInfomation.getDocSubject());
		node.put("seatNumber", kmCarmngInfomation.getFdSeatNumber());
		node.put("fdVehichesTypeId", kmCarmngInfomation.getFdVehichesType().getFdId());
		node.put("fdVehichesTypeName", kmCarmngInfomation.getFdVehichesType().getFdName());
				
		node.put("fdDriversName",StringUtil.getString(kmCarmngInfomation.getFdDriverName()));
		node.put("fdDriverId",StringUtil.getString(kmCarmngInfomation.getFdDriverId()));

		if (StringUtil.isNotNull(kmCarmngInfomation.getFdDriverId())) {
			IKmCarmngDriversInfoService kmCarmngDriversInfoService = (IKmCarmngDriversInfoService) SpringBeanUtil
					.getBean("kmCarmngDriversInfoService");
			if (kmCarmngDriversInfoService != null) {
				kmCarmngDriversInfoService.clearHibernateSession();
				HQLInfo hqlInfo = new HQLInfo();
				hqlInfo.setWhereBlock("kmCarmngDriversInfo.fdId=:driverId");
				hqlInfo.setParameter("driverId", kmCarmngInfomation.getFdDriverId());

				List kmCarmngDriversInfoList = kmCarmngDriversInfoService.findList(hqlInfo);

				if (kmCarmngDriversInfoList.size() > 0) {
					KmCarmngDriversInfo kmCarmngDriversInfo = (KmCarmngDriversInfo) kmCarmngDriversInfoList.get(0);
					if (kmCarmngDriversInfo != null) {
						node.put("fdRelationPhone", StringUtil.getString(kmCarmngDriversInfo.getFdRelationPhone()));
						// 内部/外部司机
						if (StringUtil.isNotNull(kmCarmngDriversInfo.getFdSysId())) {
							node.put("sysId", kmCarmngDriversInfo.getFdSysId());
							node.put("fdDriversType", "inner");
						} else {
							node.put("sysId", "");
							node.put("fdDriversType", "outer");
						}
					}
				}
			}
		}
	}

	public void getAllMotorcadeForMobile(List rtnList) throws Exception {
		HQLInfo hql = new HQLInfo();
		hql.setOrderBy("kmCarmngMotorcadeSet.fdOrder asc");
		String whereBlock = " 1 = 1 ";
		if (UserUtil.checkRole("ROLE_KMCARMNG_ATTEMPER")) {
			whereBlock += " and 1 = 1";
		} else if (UserUtil.checkRole("ROLE_KMCARMNG_MOTORCADE_ATTEMPER")) {
			String[] postIds = UserUtil.getKMSSUser().getPostIds();
			if (postIds != null && postIds.length > 0) {
				whereBlock += " and (kmCarmngMotorcadeSet.fdDispatchers.fdId =:userId or "
						+ HQLUtil.buildLogicIN("kmCarmngMotorcadeSet.fdDispatchers.fdId",
								Arrays.asList(UserUtil.getKMSSUser().getPostIds()))
						+ ")";
			} else {
				whereBlock += " and kmCarmngMotorcadeSet.fdDispatchers.fdId =:userId";
			}
			hql.setParameter("userId", UserUtil.getKMSSUser().getUserId());
		} else {
			whereBlock += " and 1 = 0";
		}
		hql.setWhereBlock(whereBlock);
		List<KmCarmngMotorcadeSet> categoryList = kmCarmngMotorcadeSetService
				.findValue(hql);
		for (KmCarmngMotorcadeSet kmCarmngMotorcadeSet : categoryList) {
			Map node = new HashMap();
			node.put("text", kmCarmngMotorcadeSet.getFdName());
			node.put("value", kmCarmngMotorcadeSet.getFdId());
			node.put("nodeType", "CATEGORY");
			rtnList.add(node);
		}
	}

	//搜索车辆hql
	private String getSearchInfomation(HQLInfo hql, String keyword) throws Exception {
		HQLInfo hqlInfo = new HQLInfo();
		String whereBlock = " 1 = 1 ";
		if (UserUtil.checkRole("ROLE_KMCARMNG_ATTEMPER")) {
			whereBlock += " and 1 = 1";
		} else if (UserUtil.checkRole("ROLE_KMCARMNG_MOTORCADE_ATTEMPER")) {
			if (UserUtil.getKMSSUser().getPostIds().length > 0) {
				whereBlock += " and (kmCarmngMotorcadeSet.fdDispatchers.fdId =:userId or "
						+ HQLUtil.buildLogicIN("kmCarmngMotorcadeSet.fdDispatchers.fdId",
								Arrays.asList(UserUtil.getKMSSUser().getPostIds()))
						+ ")";
			} else {
				whereBlock += " and kmCarmngMotorcadeSet.fdDispatchers.fdId =:userId";
			}
			hqlInfo.setParameter("userId", UserUtil.getKMSSUser().getUserId());
		} else {
			whereBlock += " and 1 = 0";
		}
		hqlInfo.setWhereBlock(whereBlock);
		hqlInfo.setSelectBlock("kmCarmngMotorcadeSet.fdId");
		List categoryList = kmCarmngMotorcadeSetService.findValue(hqlInfo);
		String where = hql.getWhereBlock();
		where = StringUtil.linkString(where, " and ",
				"(kmCarmngInfomation.fdNo like :keyword or kmCarmngInfomation.docSubject like :keyword)");
		where = StringUtil.linkString(where, " and ",
				HQLUtil.buildLogicIN("kmCarmngInfomation.fdMotorcade.fdId", categoryList));
		hql.setParameter("keyword", "%" + keyword + "%");
		return where;
	}

	public void setKmCarmngMotorcadeSetService(
			IKmCarmngMotorcadeSetService kmCarmngMotorcadeSetService) {
		this.kmCarmngMotorcadeSetService = kmCarmngMotorcadeSetService;
	}
	
	
}
