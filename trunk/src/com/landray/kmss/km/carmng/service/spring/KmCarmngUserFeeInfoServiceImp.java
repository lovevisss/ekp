package com.landray.kmss.km.carmng.service.spring;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.model.PeriodTypeModel;
import com.landray.kmss.common.service.BaseServiceImp;
import com.landray.kmss.km.carmng.context.KmCarmngContext;
import com.landray.kmss.km.carmng.dao.IKmCarmngUserFeeInfoDao;
import com.landray.kmss.km.carmng.service.IKmCarmngExcelService;
import com.landray.kmss.km.carmng.service.IKmCarmngUserFeeInfoService;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.sys.organization.service.ISysOrgElementService;
import com.landray.kmss.util.ArrayUtil;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.NumberUtil;
import com.landray.kmss.util.ResourceUtil;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.util.UserUtil;
import com.landray.kmss.util.excel.Column;
import com.sunbor.web.tag.Page;

/**
 * 创建日期 2010-三月-24
 * 
 * @author 叶中奇 部门用车费用表业务接口实现
 */
public class KmCarmngUserFeeInfoServiceImp extends BaseServiceImp implements
		IKmCarmngUserFeeInfoService {

	private IKmCarmngExcelService kmCarmngExcelService;

	public void setKmCarmngExcelService(
			IKmCarmngExcelService kmCarmngExcelService) {
		this.kmCarmngExcelService = kmCarmngExcelService;
	}

	@Override
    public List count(HttpServletRequest request) throws Exception {
		String fdDeptIds = request.getParameter("fdDeptIds");
		String fdDeptNames = request.getParameter("fdDeptNames");
		String deptAll = request.getParameter("deptAll");
		String fdPersonIds = request.getParameter("fdPersonIds");
		String fdPersonNames = request.getParameter("fdPersonNames");
		String fdStartTime = request.getParameter("fdStartTime");
		String fdEndTime = request.getParameter("fdEndTime");
		request.setAttribute("fdDeptIds", fdDeptIds);
		request.setAttribute("fdDeptNames", fdDeptNames);
		request.setAttribute("fdPersonIds", fdPersonIds);
		request.setAttribute("fdPersonNames", fdPersonNames);
		request.setAttribute("fdStartTime", fdStartTime);
		request.setAttribute("fdEndTime", fdEndTime);
		request.setAttribute("deptAll", deptAll);
		ISysOrgElementService sysOrgElementService = (ISysOrgElementService) SpringBeanUtil
				.getBean("sysOrgElementService");
		List<String> personIdList = new ArrayList<String>();
		List<String> list = new ArrayList<String>();
		Set<SysOrgElement> elementSet = new HashSet<SysOrgElement>();
		if (StringUtil.isNotNull(fdDeptIds)) {
			String[] deptIds = fdDeptIds.split(";");
			for (int i = 0; i < deptIds.length; i++) {
				String id = deptIds[i];
				SysOrgElement sysOrgElement = (SysOrgElement) sysOrgElementService
						.findByPrimaryKey(id);
				String whereBlock = null;
				if ("1".equals(deptAll)) {
					whereBlock = "sysOrgElement.fdHierarchyId like '" + sysOrgElement.getFdHierarchyId()
							+ "%' and sysOrgElement.fdOrgType = 8";
				} else {
					whereBlock = "sysOrgElement.hbmParent.fdId = '" + sysOrgElement.getFdId()
							+ "' and sysOrgElement.fdOrgType = 8";
				}
				List elementList = sysOrgElementService.findList(whereBlock, null);
				elementSet.addAll(elementList);
			}
			for (java.util.Iterator<SysOrgElement> itera = elementSet
					.iterator(); itera.hasNext();) {
				SysOrgElement elementObj = itera.next();
				personIdList.add(elementObj.getFdId());
			}
			request.setAttribute("personIdList", personIdList);
		}
		if (StringUtil.isNotNull(fdPersonIds)) {
			String[] personIds = fdPersonIds.split(";");
			for (int i = 0; i < personIds.length; i++) {
				String personId = personIds[i];
				if (personIdList.size() > 0) {
					if (personIdList.contains(personId)) {
						list.add(personId);
					}
				} else {
					list.add(personId);
				}
			}
			request.setAttribute("personIdList", list);
		}

		List rtnList = ((IKmCarmngUserFeeInfoDao) getBaseDao()).count(request);
		return rtnList;
	}

	@Override
    public void saveExportExcel(List valueList, HttpServletResponse response,
                                HttpServletRequest request) throws Exception {
		try {
			String title = ResourceUtil.getString("kmCarmng.excel.export1",
					"km-carmng");
			String fdStartTime = request.getParameter("fdStartTime");
			String fdEndTime = request.getParameter("fdEndTime");
			String fdDeptIds = request.getParameter("fdDeptIds");
			if (StringUtil.isNotNull(fdStartTime) && StringUtil.isNotNull(fdEndTime)) {
				title += " (" + fdStartTime + " - " + fdEndTime + ") ";
			} else if (StringUtil.isNotNull(fdStartTime) || StringUtil.isNotNull(fdEndTime)) {
				if (StringUtil.isNotNull(fdStartTime)) {
					title += " (" + fdStartTime + ") ";
				} else {
					title += " (" + fdEndTime + ") ";
				}
			} else {
				title += " ("
						+ DateUtil.convertDateToString(new Date(),
								DateUtil.TYPE_DATE, UserUtil.getKMSSUser()
										.getLocale())
						+ ") ";
			}
			Column[] cols = null;
			int colSize = 0;
			if (StringUtil.isNull(fdDeptIds)) {
				colSize = 15;
			} else {
				colSize = 11;
			}
			cols = new Column[colSize];
			int count = 0;
			for (int i = 0; i < cols.length; i++) {
				cols[i] = new Column();
			}
			cols[count].setTitleKey("kmCarmng.page.serial");
			cols[++count].setTitleKey("kmCarmngMaintenanceInfo.fdVehiclesInfoId");
			cols[++count].setTitleKey("kmCarmngInfomation.docSubject");

			cols[++count].setTitleKey("kmCarmngInfomation.fdVehichesType");

			cols[++count].setTitleKey("kmCarmngUserFeeInfo.fdMileageNumber");

			if (StringUtil.isNull(fdDeptIds)) {
				cols[++count].setTitleKey("kmCarmngInsuranceInfo.fdInsuranceFee");
				cols[++count].setTitleKey("kmCarmngInfringeInfo.fdInfringeFee");
				cols[++count].setTitleKey("kmCarmngMaintenanceInfo.fdMaintenanceFee");
				cols[++count].setTitleKey("kmCarmngMaintenanceInfo.fdRepairFee");
			}

			cols[++count].setTitleKey("kmCarmngUserFeeInfo.fdStopFee");

			cols[++count].setTitleKey("kmCarmngUserFeeInfo.fdTurnpikeFee");

			cols[++count].setTitleKey("kmCarmngUserFeeInfo.fdFuelFee");

			cols[++count].setTitleKey("kmCarmngUserFeeInfo.fdCarwashFee");

			cols[++count].setTitleKey("kmCarmngUserFeeInfo.fdOtherFee");

			cols[++count].setTitleKey("kmCarmng.fdTotalFee");

			List rowsList = new ArrayList();
			if (valueList.size() == 0) {
				Object[] row = new Object[15];
				row[0] = null;
				row[1] = null;
				row[2] = null;
				row[3] = null;
				row[4] = null;
				row[5] = null;
				row[6] = null;
				row[7] = null;
				row[8] = null;
				row[9] = null;
				row[10] = null;
				row[11] = null;
				row[12] = null;
				row[13] = null;
				row[14] = null;
				rowsList.add(row);
			} else {
				for (int i = 0; i < valueList.size(); i++) {
					Object[] row = new Object[colSize];;
					int rowCount = 0;
					KmCarmngContext kmCarmngContext = (KmCarmngContext) valueList
							.get(i);
					int j = i + 1;
					row[rowCount] = new Integer(j).toString();
					row[++rowCount] = kmCarmngContext.getFdCarNo();
					row[++rowCount] = kmCarmngContext.getFdCarName();
					row[++rowCount] = kmCarmngContext.getFdCarCategoryName();

					row[++rowCount] = NumberUtil.roundDecimal(kmCarmngContext
							.getFdMileageNumber(), "#.##");

					row[++rowCount] = NumberUtil.roundDecimal(kmCarmngContext
							.getFdInsuranceInfoFee(), "#.##");

					if (StringUtil.isNull(fdDeptIds)) {
						row[++rowCount] = NumberUtil.roundDecimal(kmCarmngContext.getFdInfringeFee(), "#.##");
						row[++rowCount] = NumberUtil.roundDecimal(kmCarmngContext.getFdMaintenanceFee(), "#.##");
						row[++rowCount] = NumberUtil.roundDecimal(kmCarmngContext.getFdRepairFee(), "#.##");
						row[++rowCount] = NumberUtil.roundDecimal(kmCarmngContext.getFdStopFee(), "#.##");
					}

					row[++rowCount] = NumberUtil.roundDecimal(kmCarmngContext
							.getFdTurnpikeFee(), "#.##");

					row[++rowCount] = NumberUtil.roundDecimal(kmCarmngContext
							.getFdFuelFee(), "#.##");

					row[++rowCount] = NumberUtil.roundDecimal(kmCarmngContext
							.getFdCarwashFee(), "#.##");

					row[++rowCount] = NumberUtil.roundDecimal(kmCarmngContext
							.getFdOtherFee(), "#.##");

					row[++rowCount] = NumberUtil.roundDecimal(kmCarmngContext
							.getFdTotalFee(), "#.##");
					rowsList.add(row);
				}
			}
			kmCarmngExcelService.export(title, cols, rowsList, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public Page carUseCount(HQLInfo hqlInfo, HttpServletRequest request) {
		Page page = Page.getEmptyPage();
		List list = ((IKmCarmngUserFeeInfoDao) getBaseDao()).carUseCount(page, hqlInfo, request);
		if (null != list && list.size() > 0) {
			Object[] o = null;
			List retList = new ArrayList();
			Map<String, String> map = null;
			for (int i = 0; i < list.size(); i++) {
				if (null != list.get(i)) {
					o = (Object[]) list.get(i);
					map = new HashMap<String, String>();
					map.put("fdCarNo", o[0].toString());
					map.put("fdCarName", o[1].toString());
					map.put("fdVehichesType", o[2].toString());
					map.put("fdCarCategoryName", o[3].toString());
					map.put("fdUseCount", o[5] == null ? "0" : o[5].toString());
					map.put("fdMileageNumber", o[6] == null ? "0" : o[6].toString());
					map.put("fdUseTime", o[7] == null ? "0" : o[7].toString());

					double fdTurnpikeFee = o[8] == null ? 0 : Double.valueOf(o[8].toString());
					double fdFuelFee = o[9] == null ? 0 : Double.valueOf(o[9].toString());
					double fdStopFee = o[10] == null ? 0 : Double.valueOf(o[10].toString());
					double fdCarwashFee = o[11] == null ? 0 : Double.valueOf(o[11].toString());
					double fdOtherFee = o[12] == null ? 0 : Double.valueOf(o[12].toString());
					map.put("fdTurnpikeFee", String.valueOf(fdTurnpikeFee));
					map.put("fdFuelFee", String.valueOf(fdFuelFee));
					map.put("fdStopFee", String.valueOf(fdStopFee));
					map.put("fdCarwashFee", String.valueOf(fdCarwashFee));
					map.put("fdOtherFee", String.valueOf(fdOtherFee));
					map.put("total", String.valueOf(fdFuelFee + fdStopFee + fdCarwashFee + fdOtherFee + fdTurnpikeFee));
					map.put("fdId", o[13].toString());
					retList.add(map);
				}
			}
			page.setList(retList);
		}
		return page;
	}
	
	@Override
	public List usedCarStatistic(HQLInfo hqlInfo, HttpServletRequest request) {
		List list = ((IKmCarmngUserFeeInfoDao) getBaseDao()).usedCarStatistic( hqlInfo, request);
		List retList = new ArrayList();
		Object[] o = null;
		Map<String, String> map = null;
		if (null != list && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				if (null != list.get(i)) {
					o = (Object[]) list.get(i);
					map = new HashMap<String, String>();
					map.put("fdCarNo", o[0].toString());
					map.put("fdCarName", o[1].toString());
					map.put("fdVehichesType", o[2].toString());
					map.put("fdCarCategoryName", o[3].toString());
					map.put("fdUseCount", o[5] == null ? "0" : o[5].toString());
					map.put("fdMileageNumber", o[6] == null ? "0" : o[6].toString());
					map.put("fdUseTime", o[7] == null ? "0" : o[7].toString());

					double fdTurnpikeFee = o[8] == null ? 0 : Double.valueOf(o[8].toString());
					double fdFuelFee = o[9] == null ? 0 : Double.valueOf(o[9].toString());
					double fdStopFee = o[10] == null ? 0 : Double.valueOf(o[10].toString());
					double fdCarwashFee = o[11] == null ? 0 : Double.valueOf(o[11].toString());
					double fdOtherFee = o[12] == null ? 0 : Double.valueOf(o[12].toString());
					map.put("fdTurnpikeFee", String.valueOf(fdTurnpikeFee));
					map.put("fdFuelFee", String.valueOf(fdFuelFee));
					map.put("fdStopFee", String.valueOf(fdStopFee));
					map.put("fdCarwashFee", String.valueOf(fdCarwashFee));
					map.put("fdOtherFee", String.valueOf(fdOtherFee));
					map.put("total", String.valueOf(fdFuelFee + fdStopFee + fdCarwashFee + fdOtherFee + fdTurnpikeFee));
					map.put("fdId", o[13].toString());
					retList.add(map);
				}
			}
		}
		return retList;
	}

	@Override
    public void exportCarUseExcel(List valueList, HttpServletResponse response, HttpServletRequest request) {
		try {
			String title = getTitle(ResourceUtil.getString("kmCarmng.excel.export1", "km-carmng"), request);

			Column[] cols = new Column[14];
			int count = 0;
			for (int i = 0; i < cols.length; i++) {
				cols[i] = new Column();
			}
			cols[count].setTitleKey("kmCarmng.page.serial");
			cols[++count].setTitleKey("kmCarmngMaintenanceInfo.fdVehiclesInfoId");
			cols[++count].setTitleKey("kmCarmngInfomation.docSubject");
			cols[++count].setTitleKey("kmCarmngDriversInfo.fdMotorcadeId");
			cols[++count].setTitleKey("kmCarmngInfomation.fdVehichesType");
			cols[++count].setTitleKey("kmCarmngInfomation.fdUseCount");
			cols[++count].setTitleKey("kmCarmngUserFeeInfo.fdMileageNumber");
			cols[++count].setTitleKey("kmCarmngInfomation.fdUseTime");

			cols[++count].setTitleKey("kmCarmngUserFeeInfo.fdStopFee");
			cols[++count].setTitleKey("kmCarmngUserFeeInfo.fdTurnpikeFee");
			cols[++count].setTitleKey("kmCarmngUserFeeInfo.fdFuelFee");
			cols[++count].setTitleKey("kmCarmngUserFeeInfo.fdCarwashFee");
			cols[++count].setTitleKey("kmCarmngUserFeeInfo.fdOtherFee");
			cols[++count].setTitleKey("kmCarmng.fdTotalFee");

			List rowsList = new ArrayList();
			if (valueList.size() == 0) {
				Object[] row = new Object[14];
				row[0] = null;
				row[1] = null;
				row[2] = null;
				row[3] = null;
				row[4] = null;
				row[5] = null;
				row[6] = null;
				row[7] = null;
				row[8] = null;
				row[9] = null;
				row[10] = null;
				row[11] = null;
				row[12] = null;
				row[13] = null;
				rowsList.add(row);
			} else {
				Map<String, String> map = null;
				for (int i = 0; i < valueList.size(); i++) {
					Object[] row = new Object[14];
					int rowCount = 0;
					map = (Map<String, String>) valueList.get(i);
					row[rowCount] = new Integer(i + 1).toString();
					row[++rowCount] = map.get("fdCarNo");
					row[++rowCount] = map.get("fdCarName");
					row[++rowCount] = map.get("fdVehichesType");
					row[++rowCount] = map.get("fdCarCategoryName");
					row[++rowCount] = map.get("fdUseCount");
					row[++rowCount] = NumberUtil.roundDecimal(map.get("fdMileageNumber"), "#.##");
					row[++rowCount] = map.get("fdUseTime");
					row[++rowCount] = NumberUtil.roundDecimal(map.get("fdStopFee"), "#.##");
					row[++rowCount] = NumberUtil.roundDecimal(map.get("fdTurnpikeFee"), "#.##");
					row[++rowCount] = NumberUtil.roundDecimal(map.get("fdFuelFee"), "#.##"); 
					row[++rowCount] = NumberUtil.roundDecimal(map.get("fdCarwashFee"), "#.##");
					row[++rowCount] = NumberUtil.roundDecimal(map.get("fdOtherFee"), "#.##");
					row[++rowCount] = NumberUtil.roundDecimal(map.get("total"), "#.##");

					rowsList.add(row);
				}
			}
			kmCarmngExcelService.export(title, cols, rowsList, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public Page carUseDetail(HQLInfo hqlInfo, HttpServletRequest request, boolean isExcel) {
		Page page = Page.getEmptyPage();
		List list = null;
		if(isExcel)
		{
			list = ((IKmCarmngUserFeeInfoDao) getBaseDao()).carUseDetail(page, hqlInfo, request, isExcel);
		}
		else
		{
			list = ((IKmCarmngUserFeeInfoDao) getBaseDao()).carUseDetail(page, hqlInfo, request, isExcel);
		}

		if (null != list && list.size() > 0) {
			Object[] o = null;
			List retList = new ArrayList();
			Map<String, Object> map = null;
			for (int i = 0; i < list.size(); i++) {
				if (null != list.get(i)) {
					o = (Object[]) list.get(i);
					map = new HashMap<String, Object>();
					map.put("fdCarNo", o[1].toString());
					map.put("fdCarName", o[2].toString());
					map.put("fdVehichesType", o[3].toString());
					map.put("fdApplicationName", o[5].toString());
					map.put("fdMileageNumber", o[6] == null ? "0" : o[6].toString());
					map.put("fdStartTime", o[7]);
					map.put("fdEndTime", o[8]);
					double fdTurnpikeFee = o[9] == null ? 0 : Double.valueOf(o[9].toString());
					double fdFuelFee = o[10] == null ? 0 : Double.valueOf(o[10].toString());
					double fdStopFee = o[11] == null ? 0 : Double.valueOf(o[11].toString());
					double fdCarwashFee = o[12] == null ? 0 : Double.valueOf(o[12].toString());
					double fdOtherFee = o[13] == null ? 0 : Double.valueOf(o[13].toString());
					map.put("fdTurnpikeFee", String.valueOf(fdTurnpikeFee));
					map.put("fdFuelFee", String.valueOf(fdFuelFee));
					map.put("fdStopFee", String.valueOf(fdStopFee));
					map.put("fdCarwashFee", String.valueOf(fdCarwashFee));
					map.put("fdOtherFee", String.valueOf(fdOtherFee));
					map.put("total", String.valueOf(fdFuelFee + fdStopFee + fdCarwashFee + fdOtherFee + fdTurnpikeFee));
					map.put("fdId", o[14].toString());
					String fdApplicationId = o[0].toString();
					retList.add(map);
				}
			}
			page.setList(retList);
		}
		return page;
	}

	@Override
	public Page queryOrgCount(HQLInfo hqlInfo, HttpServletRequest request) throws Exception {
		Page page = Page.getEmptyPage();
		String fdDeptIds = request.getParameter("fdDeptIds");
		String deptAll = request.getParameter("deptAll");
		String fdPersonIds = request.getParameter("fdPersonIds");
		String type = request.getParameter("type");
		Set<SysOrgElement> elementSet = new HashSet<SysOrgElement>();
		List<String> personIdList = new ArrayList<String>();
		ISysOrgElementService sysOrgElementService = (ISysOrgElementService) SpringBeanUtil
				.getBean("sysOrgElementService");
		if (StringUtil.isNotNull(fdDeptIds)) {
			String[] deptIds = fdDeptIds.split(";");
			for (int i = 0; i < deptIds.length; i++) {
				String id = deptIds[i];
				SysOrgElement sysOrgElement = (SysOrgElement) sysOrgElementService
						.findByPrimaryKey(id);
				String whereBlock = null;
				if ("1".equals(deptAll)) {
					whereBlock = "sysOrgElement.fdHierarchyId like '" + sysOrgElement.getFdHierarchyId()
							+ "%' and sysOrgElement.fdOrgType = 2";
				} else {
					whereBlock = "sysOrgElement.fdId = '" + sysOrgElement.getFdId()
							+ "' and sysOrgElement.fdOrgType = 2";
				}
				List elementList = sysOrgElementService.findList(whereBlock, null);
				elementSet.addAll(elementList);
			}
		} else if (StringUtil.isNotNull(fdPersonIds)) {
			String[] personIds = fdPersonIds.split(";");
			for (int i = 0; i < personIds.length; i++) {
				String id = personIds[i];
				SysOrgElement sysOrgElement = (SysOrgElement) sysOrgElementService.findByPrimaryKey(id);
				String whereBlock = "sysOrgElement.fdHierarchyId like '" + sysOrgElement.getFdHierarchyId()
						+ "%' and sysOrgElement.fdOrgType = 8";
				List elementList = sysOrgElementService.findList(whereBlock, null);
				elementSet.addAll(elementList);
			}
		}
		if (!ArrayUtil.isEmpty(elementSet)) {
			for (java.util.Iterator<SysOrgElement> itera = elementSet.iterator(); itera.hasNext();) {
				SysOrgElement elementObj = itera.next();
				personIdList.add(elementObj.getFdId());
			}
		}
		request.setAttribute("personIdList", personIdList);
		List list = ((IKmCarmngUserFeeInfoDao) getBaseDao()).queryOrgCount(page, hqlInfo, request);
		if (null != list && list.size() > 0) {
			Object[] o = null;
			String fdApplicationDept = null;
			List retList = new ArrayList();
			Map<String, Object> map = null;
			for (int i = 0; i < list.size(); i++) {
				if (null != list.get(i)) {
					o = (Object[]) list.get(i);
					map = new HashMap<String, Object>();
					if (null != o[0]) {
						fdApplicationDept = ((SysOrgElement) sysOrgElementService.findByPrimaryKey(o[0].toString())).getFdName();
						map.put("fdId", o[0].toString());
					}
					map.put("fdApplicationDept", fdApplicationDept);
					map.put("fdUser", fdApplicationDept);
					map.put("fdUseCount", o[1] == null ? "0" : o[1].toString());
					map.put("fdMileageNumber", o[2] == null ? "0" : o[2].toString());
					map.put("fdUseTime", o[3] == null ? "0" : o[3].toString());

					double fdTurnpikeFee = o[4] == null ? 0 : Double.valueOf(o[4].toString());
					double fdFuelFee = o[5] == null ? 0 : Double.valueOf(o[5].toString());
					double fdStopFee = o[6] == null ? 0 : Double.valueOf(o[6].toString());
					double fdCarwashFee = o[7] == null ? 0 : Double.valueOf(o[7].toString());
					double fdOtherFee = o[8] == null ? 0 : Double.valueOf(o[8].toString());
					map.put("fdTurnpikeFee", String.valueOf(fdTurnpikeFee));
					map.put("fdFuelFee", String.valueOf(fdFuelFee));
					map.put("fdStopFee", String.valueOf(fdStopFee));
					map.put("fdCarwashFee", String.valueOf(fdCarwashFee));
					map.put("fdOtherFee", String.valueOf(fdOtherFee));
					map.put("total", String.valueOf(fdFuelFee + fdStopFee + fdCarwashFee + fdOtherFee + fdTurnpikeFee));
					retList.add(map);
				}
			}
			page.setList(retList);
		}
		return page;
	}

	@Override
	public Page queryOrgDetail(HQLInfo hqlInfo, HttpServletRequest request) throws Exception {
		Page page = Page.getEmptyPage();
		List list = ((IKmCarmngUserFeeInfoDao) getBaseDao()).queryOrgDetail(page, hqlInfo, request);
		ISysOrgElementService sysOrgElementService = (ISysOrgElementService) SpringBeanUtil
				.getBean("sysOrgElementService");
		if (null != list && list.size() > 0) {
			Object[] o = null;
			String fdApplicationDept = null, fdUser = null;
			List retList = new ArrayList();
			Map<String, Object> map = null;
			for (int i = 0; i < list.size(); i++) {
				if (null != list.get(i)) {
					o = (Object[]) list.get(i);
					map = new HashMap<String, Object>();
					if (null != o[0]) {
						fdApplicationDept = ((SysOrgElement) sysOrgElementService.findByPrimaryKey(o[0].toString())).getFdName();
					}
					if (null != o[1]) {
						fdUser = ((SysOrgElement) sysOrgElementService.findByPrimaryKey(o[1].toString())).getFdName();
					}
					map.put("fdApplicationDept", fdApplicationDept);
					map.put("fdUser", fdUser);
					map.put("fdApplicationName", o[2].toString());
					map.put("fdStartTime", o[3]);
					map.put("fdEndTime", o[4]);
					map.put("fdMileageNumber", o[6] == null ? "0" : o[6].toString());
					double fdTurnpikeFee = o[7] == null ? 0 : Double.valueOf(o[7].toString());
					double fdFuelFee = o[8] == null ? 0 : Double.valueOf(o[8].toString());
					double fdStopFee = o[9] == null ? 0 : Double.valueOf(o[9].toString());
					double fdCarwashFee = o[10] == null ? 0 : Double.valueOf(o[10].toString());
					double fdOtherFee = o[11] == null ? 0 : Double.valueOf(o[11].toString());
					map.put("fdTurnpikeFee", String.valueOf(fdTurnpikeFee));
					map.put("fdFuelFee", String.valueOf(fdFuelFee));
					map.put("fdStopFee", String.valueOf(fdStopFee));
					map.put("fdCarwashFee", String.valueOf(fdCarwashFee));
					map.put("fdOtherFee", String.valueOf(fdOtherFee));
					map.put("total", String.valueOf(fdFuelFee + fdStopFee + fdCarwashFee + fdOtherFee + fdTurnpikeFee));

					map.put("fdId", o[5].toString());
					retList.add(map);
				}
			}
			page.setList(retList);
		}
		return page;
	}

	@Override
	public Page queryDriverCount(HQLInfo hqlInfo, HttpServletRequest request) {
		Page page = Page.getEmptyPage();
		List list = ((IKmCarmngUserFeeInfoDao) getBaseDao()).queryDriverCount(page, hqlInfo, request);
		if (null != list && list.size() > 0) {
			Object[] o = null;
			List retList = new ArrayList();
			Map<String, Object> map = null;
			for (int i = 0; i < list.size(); i++) {
				if (null != list.get(i)) {
					o = (Object[]) list.get(i);
					map = new HashMap<String, Object>();

					map.put("fdName", o[1].toString());
					map.put("fdMileageNumber", o[2] == null ? "0" : o[2].toString());
					map.put("fdUseTime", o[3] == null ? "0" : o[3].toString());
					map.put("fdUseCount", o[4] == null ? "0" : o[4].toString());
					map.put("infringeCount", o[5] == null ? "0" : o[5].toString());
					retList.add(map);
				}
			}
			page.setList(retList);
		}
		return page;
	}

	@Override
	public Page queryCarFeeCount(HQLInfo hqlInfo, HttpServletRequest request) {
		Page page = Page.getEmptyPage();
		List list = ((IKmCarmngUserFeeInfoDao) getBaseDao()).queryCarFeeCount(page, hqlInfo, request);
		if (null != list && list.size() > 0) {
			Object[] o = null;
			List retList = new ArrayList();
			Map<String, Object> map = null;
			for (int i = 0; i < list.size(); i++) {
				if (null != list.get(i)) {
					o = (Object[]) list.get(i);
					map = new HashMap<String, Object>();
					map.put("fdCarNo", o[0]);
					map.put("fdCarName", o[1].toString());
					map.put("fdMotorcade", o[2].toString()); //所属车队
					map.put("fdCarCategoryName", o[3].toString());
					
					double fdTurnpikeFee = o[6] == null ? 0 : Double.valueOf(o[6].toString());
					double fdFuelFee = o[7] == null ? 0 : Double.valueOf(o[7].toString());
					double fdStopFee = o[8] == null ? 0 : Double.valueOf(o[8].toString());
					double fdCarwashFee = o[9] == null ? 0 : Double.valueOf(o[9].toString());
					double fdOtherFee = o[10] == null ? 0 : Double.valueOf(o[10].toString());
					double fdInfringeFee = o[11] == null ? 0 : Double.valueOf(o[11].toString());
					double fdMaintenanceFee = o[12] == null ? 0 : Double.valueOf(o[12].toString());
					double fdRepairFee = o[13] == null ? 0 : Double.valueOf(o[13].toString());
					double fdInsuranceFee = o[14] == null ? 0
							: Double.valueOf(o[14].toString());
					map.put("fdTurnpikeFee", String.valueOf(fdTurnpikeFee));
					map.put("fdFuelFee", String.valueOf(fdFuelFee));
					map.put("fdInsuranceFee", String.valueOf(fdInsuranceFee));
					map.put("fdStopFee", String.valueOf(fdStopFee));
					map.put("fdCarwashFee", String.valueOf(fdCarwashFee));
					map.put("fdOtherFee", String.valueOf(fdOtherFee));
					map.put("fdInfringeFee", String.valueOf(fdInfringeFee));
					map.put("fdMaintenanceFee", String.valueOf(fdMaintenanceFee));
					map.put("fdRepairFee", String.valueOf(fdRepairFee));
					map.put("total", String.valueOf(fdFuelFee + fdStopFee + fdCarwashFee + fdOtherFee + fdTurnpikeFee
									+ fdInfringeFee + fdMaintenanceFee
									+ fdRepairFee + fdInsuranceFee));
					retList.add(map);
				}
			}
			page.setList(retList);
		}
		return page;
	}

	@Override
	public void exportCarUseDetailExcel(List valueList, HttpServletResponse response, HttpServletRequest request) {
		try {
			String title = getTitle(ResourceUtil.getString("kmCarmng.excel.exportCarUseDetailExcel", "km-carmng"), request);

			Column[] cols = new Column[14];
			int count = 0;
			for (int i = 0; i < cols.length; i++) {
				cols[i] = new Column();
			}
			cols[count].setTitleKey("kmCarmng.page.serial");
			cols[++count].setTitleKey("kmCarmngMaintenanceInfo.fdVehiclesInfoId");
			cols[++count].setTitleKey("kmCarmngInfomation.docSubject");
			cols[++count].setTitleKey("kmCarmngDriversInfo.fdMotorcadeId");
			cols[++count].setTitleKey("kmCarmngEvaluation.fdAppNames");
			cols[++count].setTitleKey("kmCarmngUserFeeInfo.fdUseStartTime");
			cols[++count].setTitleKey("kmCarmngUserFeeInfo.fdUseEndTime");
			cols[++count].setTitleKey("kmCarmngUserFeeInfo.fdMileageNumber"); 
			cols[++count].setTitleKey("kmCarmngUserFeeInfo.fdStopFee");
			cols[++count].setTitleKey("kmCarmngUserFeeInfo.fdTurnpikeFee");
			cols[++count].setTitleKey("kmCarmngUserFeeInfo.fdFuelFee"); 
			cols[++count].setTitleKey("kmCarmngUserFeeInfo.fdCarwashFee");
			cols[++count].setTitleKey("kmCarmngUserFeeInfo.fdOtherFee");
			cols[++count].setTitleKey("kmCarmng.fdTotalFee");

			List rowsList = new ArrayList();
			if (valueList.size() == 0) {
				Object[] row = new Object[14];
				row[0] = null;
				row[1] = null;
				row[2] = null;
				row[3] = null;
				row[4] = null;
				row[5] = null;
				row[6] = null;
				row[7] = null;
				row[8] = null;
				row[9] = null;
				row[10] = null;
				row[11] = null;
				row[12] = null;
				row[13] = null;
				rowsList.add(row);
			} else {
				Map<String, String> map = null;
				for (int i = 0; i < valueList.size(); i++) {
					Object[] row = new Object[14];
					int rowCount = 0;
					map = (Map<String, String>) valueList.get(i);
					row[rowCount] = new Integer(i + 1).toString();
					row[++rowCount] = map.get("fdCarNo");
					row[++rowCount] = map.get("fdCarName");
					row[++rowCount] = map.get("fdVehichesType");
					row[++rowCount] = map.get("fdApplicationName");
					row[++rowCount] = map.get("fdStartTime");
					row[++rowCount] = map.get("fdEndTime");
					row[++rowCount] = NumberUtil.roundDecimal(map.get("fdMileageNumber"), "#.##");
					row[++rowCount] = NumberUtil.roundDecimal(map.get("fdStopFee"), "#.##");
					row[++rowCount] = NumberUtil.roundDecimal(map.get("fdTurnpikeFee"), "#.##");
					row[++rowCount] = NumberUtil.roundDecimal(map.get("fdFuelFee"), "#.##"); 
					row[++rowCount] = NumberUtil.roundDecimal(map.get("fdCarwashFee"), "#.##");
					row[++rowCount] = NumberUtil.roundDecimal(map.get("fdOtherFee"), "#.##");
					row[++rowCount] = NumberUtil.roundDecimal(map.get("total"), "#.##");
					rowsList.add(row);
				}
			}
			kmCarmngExcelService.export(title, cols, rowsList, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void exportQueryOrgExcel(List valueList, HttpServletResponse response, HttpServletRequest request) {
		try {
			String type = request.getParameter("type");
			String title = getTitle(ResourceUtil.getString("kmCarmng.excel.exportCarUseExcel." + type, "km-carmng"),
					request);

			Column[] cols = new Column[11];
			int count = 0;
			for (int i = 0; i < cols.length; i++) {
				cols[i] = new Column();
			}
			cols[count].setTitleKey("kmCarmng.page.serial");
			if ("dept".equals(type)) {
				cols[++count].setTitleKey("kmCarmngUserFeeInfo.fdDeptIds");
			} else if ("person".equals(type)) {
				cols[++count].setTitleKey("kmCarmngRegisterInfo.fdUser");
			}
			cols[++count].setTitleKey("kmCarmngInfomation.fdUseCount");
			cols[++count].setTitleKey("kmCarmngUserFeeInfo.fdMileageNumber");
			cols[++count].setTitleKey("kmCarmngInfomation.fdUseTime");
			
			cols[++count].setTitleKey("kmCarmngUserFeeInfo.fdStopFee");
			cols[++count].setTitleKey("kmCarmngUserFeeInfo.fdTurnpikeFee");
			cols[++count].setTitleKey("kmCarmngUserFeeInfo.fdFuelFee");
			cols[++count].setTitleKey("kmCarmngUserFeeInfo.fdCarwashFee");
			cols[++count].setTitleKey("kmCarmngUserFeeInfo.fdOtherFee");
			cols[++count].setTitleKey("kmCarmng.fdTotalFee");

			List rowsList = new ArrayList();
			if (valueList.size() == 0) {
				Object[] row = new Object[11];
				row[0] = null;
				row[1] = null;
				row[2] = null;
				row[3] = null;
				row[4] = null;
				row[5] = null;
				row[6] = null;
				row[7] = null;
				row[8] = null;
				row[9] = null;
				row[10] = null;
				rowsList.add(row);
			} else {
				Map<String, String> map = null;
				for (int i = 0; i < valueList.size(); i++) {
					Object[] row = new Object[11];
					int rowCount = 0;
					map = (Map<String, String>) valueList.get(i);
					row[rowCount] = new Integer(i + 1).toString();
					if ("dept".equals(type)) {
						row[++rowCount] = map.get("fdApplicationDept");
					} else if ("person".equals(type)) {
						row[++rowCount] = map.get("fdUser");
					}
					row[++rowCount] = map.get("fdUseCount");
					row[++rowCount] = NumberUtil.roundDecimal(map.get("fdMileageNumber"), "#.##");
					row[++rowCount] = map.get("fdUseTime");
					row[++rowCount] = NumberUtil.roundDecimal(map.get("fdStopFee"), "#.##");
					row[++rowCount] = NumberUtil.roundDecimal(map.get("fdTurnpikeFee"), "#.##");
					row[++rowCount] = NumberUtil.roundDecimal(map.get("fdFuelFee"), "#.##"); 
					row[++rowCount] = NumberUtil.roundDecimal(map.get("fdCarwashFee"), "#.##");
					row[++rowCount] = NumberUtil.roundDecimal(map.get("fdOtherFee"), "#.##");
					row[++rowCount] = NumberUtil.roundDecimal(map.get("total"), "#.##");

					rowsList.add(row);
				}
			}
			kmCarmngExcelService.export(title, cols, rowsList, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void exportQueryOrgDetailExcel(List valueList, HttpServletResponse response, HttpServletRequest request) {
		try {
			String type = request.getParameter("type");
			String title = getTitle(
					ResourceUtil.getString("kmCarmng.excel.exportCarUseExcel." + type + ".detail", "km-carmng"),
					request);

			Column[] cols = new Column[12];
			int count = 0;
			for (int i = 0; i < cols.length; i++) {
				cols[i] = new Column();
			}
			cols[count].setTitleKey("kmCarmng.page.serial");
			if ("dept".equals(type)) {
				cols[++count].setTitleKey("kmCarmngUserFeeInfo.fdDeptIds");
			} else if ("person".equals(type)) {
				cols[++count].setTitleKey("kmCarmngRegisterInfo.fdUser");
			}
			cols[++count].setTitleKey("kmCarmngEvaluation.fdAppNames");
			cols[++count].setTitleKey("kmCarmngUserFeeInfo.fdMileageNumber");
			cols[++count].setTitleKey("kmCarmngUserFeeInfo.fdUseStartTime");
			cols[++count].setTitleKey("kmCarmngUserFeeInfo.fdUseEndTime");

			cols[++count].setTitleKey("kmCarmngUserFeeInfo.fdStopFee");
			cols[++count].setTitleKey("kmCarmngUserFeeInfo.fdTurnpikeFee");
			cols[++count].setTitleKey("kmCarmngUserFeeInfo.fdFuelFee");
			cols[++count].setTitleKey("kmCarmngUserFeeInfo.fdCarwashFee");
			cols[++count].setTitleKey("kmCarmngUserFeeInfo.fdOtherFee");
			cols[++count].setTitleKey("kmCarmng.fdTotalFee");

			List rowsList = new ArrayList();
			if (valueList.size() == 0) {
				Object[] row = new Object[12];
				row[0] = null;
				row[1] = null;
				row[2] = null;
				row[3] = null;
				row[4] = null;
				row[5] = null;
				row[6] = null;
				row[7] = null;
				row[8] = null;
				row[9] = null;
				row[10] = null;
				row[11] = null;
				rowsList.add(row);
			} else {
				Map<String, String> map = null;
				for (int i = 0; i < valueList.size(); i++) {
					Object[] row = new Object[12];
					int rowCount = 0;
					map = (Map<String, String>) valueList.get(i);
					row[rowCount] = new Integer(i + 1).toString();
					if ("dept".equals(type)) {
						row[++rowCount] = map.get("fdApplicationDept");
					} else if ("person".equals(type)) {
						row[++rowCount] = map.get("fdUser");
					}
					row[++rowCount] = map.get("fdApplicationName");
					row[++rowCount] = NumberUtil.roundDecimal(map.get("fdMileageNumber"), "#.##");
					row[++rowCount] = map.get("fdStartTime");
					row[++rowCount] = map.get("fdEndTime"); 
					row[++rowCount] = NumberUtil.roundDecimal(map.get("fdStopFee"), "#.##");
					row[++rowCount] = NumberUtil.roundDecimal(map.get("fdTurnpikeFee"), "#.##");
					row[++rowCount] = NumberUtil.roundDecimal(map.get("fdFuelFee"), "#.##");
					row[++rowCount] = NumberUtil.roundDecimal(map.get("fdCarwashFee"), "#.##");
					row[++rowCount] = NumberUtil.roundDecimal(map.get("fdOtherFee"), "#.##");
					row[++rowCount] = NumberUtil.roundDecimal(map.get("total"), "#.##");

					rowsList.add(row);
				}
			}
			kmCarmngExcelService.export(title, cols, rowsList, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void exportQueryDriverExcel(List valueList, HttpServletResponse response, HttpServletRequest request) {
		try {
			String title = getTitle(ResourceUtil.getString("kmCarmng.excel.exportQueryDriverExcel", "km-carmng"),
					request);

			Column[] cols = new Column[6];
			int count = 0;
			for (int i = 0; i < cols.length; i++) {
				cols[i] = new Column();
			}
			cols[count].setTitleKey("kmCarmng.page.serial");
			cols[++count].setTitleKey("kmCarmngInfomation.fdDriverId");
			cols[++count].setTitleKey("kmCarmngInfomation.fdUseCount");
			cols[++count].setTitleKey("kmCarmngUserFeeInfo.fdMileageNumber");
			cols[++count].setTitleKey("kmCarmngInfomation.fdUseTime");
			cols[++count].setTitleKey("kmCarmngInfomation.infringeCount");
			List rowsList = new ArrayList();
			if (valueList.size() == 0) {
				Object[] row = new Object[6];
				row[0] = null;
				row[1] = null;
				row[2] = null;
				row[3] = null;
				row[4] = null;
				row[5] = null;
				rowsList.add(row);
			} else {
				Map<String, String> map = null;
				for (int i = 0; i < valueList.size(); i++) {
					Object[] row = new Object[6];
					int rowCount = 0;
					map = (Map<String, String>) valueList.get(i);
					row[rowCount] = new Integer(i + 1).toString();
					row[++rowCount] = map.get("fdName");
					row[++rowCount] = NumberUtil.roundDecimal(map.get("fdUseCount"), "#.##");
					row[++rowCount] = NumberUtil.roundDecimal(map.get("fdMileageNumber"), "#.##");
					row[++rowCount] = map.get("fdUseTime"); 
					row[++rowCount] = NumberUtil.roundDecimal(map.get("infringeCount"), "#.##");
					rowsList.add(row);
				}
			}
			kmCarmngExcelService.export(title, cols, rowsList, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void exportQueryCarFeeExcel(List valueList, HttpServletResponse response, HttpServletRequest request) {
		try {
			String title = getTitle(ResourceUtil.getString("kmCarmng.excel.exportQueryCarFeeExcel", "km-carmng"),
					request);

			Column[] cols = new Column[15];
			int count = 0;
			for (int i = 0; i < cols.length; i++) {
				cols[i] = new Column();
			}
			cols[count].setTitleKey("kmCarmng.page.serial");
			cols[++count].setTitleKey("kmCarmngMaintenanceInfo.fdVehiclesInfoId");
			cols[++count].setTitleKey("kmCarmngInfomation.docSubject");
			cols[++count].setTitleKey("kmCarmngDriversInfo.fdMotorcadeId");

			cols[++count].setTitleKey("kmCarmngInfomation.fdVehichesType");
			cols[++count].setTitleKey("kmCarmngInfringeInfo.fdInfringeFee");
			cols[++count].setTitleKey("kmCarmngInfomation.fdMaintenanceFee");
			
			cols[++count].setTitleKey("kmCarmngInfomation.fdRepairFee");//维修费用
			
			cols[++count].setTitleKey("kmCarmngInfomation.fdInsurancePrice");

			cols[++count].setTitleKey("kmCarmngUserFeeInfo.fdStopFee");
			cols[++count].setTitleKey("kmCarmngUserFeeInfo.fdTurnpikeFee");
			cols[++count].setTitleKey("kmCarmngUserFeeInfo.fdFuelFee");
			cols[++count].setTitleKey("kmCarmngUserFeeInfo.fdCarwashFee");
			cols[++count].setTitleKey("kmCarmngUserFeeInfo.fdOtherFee");
			cols[++count].setTitleKey("kmCarmng.fdTotalFee");

			List rowsList = new ArrayList();
			if (valueList.size() == 0) {
				Object[] row = new Object[15];
				row[0] = null;
				row[1] = null;
				row[2] = null;
				row[3] = null;
				row[4] = null;
				row[5] = null;
				row[6] = null;
				row[7] = null;
				row[8] = null;
				row[9] = null;
				row[10] = null;
				row[11] = null;
				row[12] = null;
				row[13] = null;
				row[14] = null;
				rowsList.add(row);
			} else {
				Map<String, String> map = null;
				for (int i = 0; i < valueList.size(); i++) {
					Object[] row = new Object[15];
					int rowCount = 0;
					map = (Map<String, String>) valueList.get(i);
					row[rowCount] = new Integer(i + 1).toString();
					row[++rowCount] = map.get("fdCarNo");
					row[++rowCount] = map.get("fdCarName");
					row[++rowCount] = map.get("fdMotorcade");
					row[++rowCount] = map.get("fdCarCategoryName");
					row[++rowCount] = NumberUtil.roundDecimal(map.get("fdInfringeFee"), "#.##");
					row[++rowCount] = NumberUtil.roundDecimal(map.get("fdMaintenanceFee"), "#.##");//保养
					row[++rowCount] = NumberUtil.roundDecimal(map.get("fdRepairFee"), "#.##");//维修费用
					row[++rowCount] = NumberUtil.roundDecimal(map.get("fdInsuranceFee"), "#.##"); //保险
					row[++rowCount] = NumberUtil.roundDecimal(map.get("fdStopFee"), "#.##");
					row[++rowCount] = NumberUtil.roundDecimal(map.get("fdTurnpikeFee"), "#.##");
					row[++rowCount] = NumberUtil.roundDecimal(map.get("fdFuelFee"), "#.##");
					row[++rowCount] = NumberUtil.roundDecimal(map.get("fdCarwashFee"), "#.##");
					row[++rowCount] = NumberUtil.roundDecimal(map.get("fdOtherFee"), "#.##");
					row[++rowCount] = NumberUtil.roundDecimal(map.get("total"), "#.##");
					rowsList.add(row);
				}
			}
			kmCarmngExcelService.export(title, cols, rowsList, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private String getTitle(String title, HttpServletRequest request) throws NumberFormatException, ParseException {
		String fdStartTime = request.getParameter("fdStartDate");
		String fdEndTime = request.getParameter("fdEndDate");
		String timeType = request.getParameter("timeType");
		String startDate = null, endDate = null;
		if (StringUtil.isNotNull(fdStartTime) && StringUtil.isNotNull(fdEndTime)) {
			startDate = convertDate(fdStartTime, timeType, "start");
			endDate = convertDate(fdEndTime, timeType, "end");
			title += " (" + startDate + " - " + endDate + ") ";
		} else if (StringUtil.isNotNull(fdStartTime) || StringUtil.isNotNull(fdEndTime)) {
			if (StringUtil.isNotNull(fdStartTime)) {
				startDate = convertDate(fdStartTime, timeType, "start");
				title += " (" + fdStartTime + ") ";
			} else {
				endDate = convertDate(fdEndTime, timeType, "end");
				title += " (" + fdEndTime + ") ";
			}
		}
		return title;
	}

	private String convertDate(String date, String timeType, String type) throws NumberFormatException, ParseException {
		Date time = null;
		if ("3".equals(timeType)) {
			time = DateUtil.convertStringToDate(date, DateUtil.TYPE_DATE, ResourceUtil.getLocaleByUser());
		} else {
			if ("start".equals(type)) {
				time = PeriodTypeModel.getSinglePeriod(date).getFdStart();
			} else {
				time = PeriodTypeModel.getSinglePeriod(date).getFdEnd();
			}
		}
		return DateUtil.convertDateToString(time, DateUtil.PATTERN_DATE);
	}
}
