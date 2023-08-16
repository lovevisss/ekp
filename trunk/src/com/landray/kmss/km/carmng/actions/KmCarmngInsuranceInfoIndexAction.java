package com.landray.kmss.km.carmng.actions;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.landray.kmss.common.actions.DataAction;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.common.test.TimeCounter;
import com.landray.kmss.km.carmng.model.KmCarmngInsuranceInfo;
import com.landray.kmss.km.carmng.service.IKmCarmngInfomationService;
import com.landray.kmss.km.carmng.service.IKmCarmngInsuranceInfoService;
import com.landray.kmss.sys.config.model.SysConfigParameters;
import com.landray.kmss.sys.log.util.UserOperHelper;
import com.landray.kmss.util.CriteriaUtil;
import com.landray.kmss.util.CriteriaValue;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.KmssMessages;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.web.action.ActionForm;
import com.landray.kmss.web.action.ActionForward;
import com.landray.kmss.web.action.ActionMapping;
import com.sunbor.web.tag.Page;

/**
 * 创建日期 2015/02/09
 * 
 * @author wangtf
 */

public class KmCarmngInsuranceInfoIndexAction extends DataAction {
	protected IKmCarmngInsuranceInfoService kmCarmngInsuranceInfoService;
	protected IKmCarmngInfomationService kmCarmngInfomationService;

	@Override
	protected IBaseService getCategoryServiceImp(HttpServletRequest request) {
		return null;
	}

	@Override
	protected String getParentProperty() {
		return null;
	}

	@Override
	protected IBaseService getServiceImp(HttpServletRequest request) {
		if (kmCarmngInsuranceInfoService == null) {
            kmCarmngInsuranceInfoService = (IKmCarmngInsuranceInfoService) getBean("kmCarmngInsuranceInfoService");
        }
		return kmCarmngInsuranceInfoService;
	}
	protected IKmCarmngInfomationService getCarmngInfomationService() {
		if (kmCarmngInfomationService == null) {
            kmCarmngInfomationService = (IKmCarmngInfomationService) getBean("kmCarmngInfomationService");
        }
		return kmCarmngInfomationService;
	}

	@Override
	protected void changeFindPageHQLInfo(HttpServletRequest request,
										 HQLInfo hqlInfo) throws Exception {
		// super.changeFindPageHQLInfo(request, hqlInfo);
		String orderby = request.getParameter("orderby");
		String ordertype = request.getParameter("ordertype");
		boolean isReserve = false;
		if (ordertype != null && "down".equalsIgnoreCase(ordertype)) {
			isReserve = true;
		}
		if (isReserve) {
            orderby += " desc";
        }
		if (StringUtil.isNull(orderby)) {
			orderby = "docCreateTime";
		}
		CriteriaValue cv = new CriteriaValue(request);
		CriteriaUtil.buildHql(cv, hqlInfo, KmCarmngInsuranceInfo.class);
		buildHomeZoneHql(cv, hqlInfo, request);
		hqlInfo.setOrderBy(orderby);
		Page page = getServiceImp(request).findPage(hqlInfo);
		request.setAttribute("queryPage", page);
	}

	private void buildHomeZoneHql(CriteriaValue cv, HQLInfo hqlInfo,
			HttpServletRequest request) {
		String fdMotorcade = cv.poll("fdMotorcade");
		String fdVehichesType = cv.poll("fdVehichesType");
		String fdNo = cv.poll("fdVehiclesInfo.fdNo");
		String fdCarId = request.getParameter("fdCarId");
		String flag = request.getParameter("flag");
		String whereStr = hqlInfo.getWhereBlock();
		StringBuilder where = new StringBuilder(
				StringUtil.isNull(whereStr) ? "1=1 " : whereStr);
		if (StringUtil.isNotNull(fdMotorcade)) {
			where
					.append(" and kmCarmngInsuranceInfo.fdVehiclesInfo.fdMotorcade.fdId=:fdMotorcade");
			hqlInfo.setParameter("fdMotorcade", fdMotorcade);
		}
		if (StringUtil.isNotNull(fdVehichesType)) {
			where
					.append(" and kmCarmngInsuranceInfo.fdVehiclesInfo.fdVehichesType.fdId=:fdVehichesType");
			hqlInfo.setParameter("fdVehichesType", fdVehichesType);
		}
		if (StringUtil.isNotNull(fdNo)) {
			where.append(" and kmCarmngInsuranceInfo.fdVehiclesInfo.fdNo like :fdNo");
			hqlInfo.setParameter("fdNo", "%" + fdNo.trim() + "%");
		}	
		if (StringUtil.isNotNull(flag)) {
			where
					.append(" and kmCarmngInsuranceInfo.fdVehiclesInfo.fdId=:fdCarId");
			hqlInfo.setParameter("fdCarId", fdCarId);
		}
		hqlInfo.setWhereBlock(where.toString());
	}
	
	// 返回保险数据，以JSON返回
	public ActionForward listInsurance(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-calendar", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			String s_pageno = request.getParameter("pageno");
			String s_rowsize = request.getParameter("rowsize");
			String orderby = request.getParameter("orderby");
			String ordertype = request.getParameter("ordertype");
			boolean isReserve = false;
			if (ordertype != null && "down".equalsIgnoreCase(ordertype)) {
				isReserve = true;
			}
			int pageno = 0;
			int rowsize = SysConfigParameters.getRowSize();
			if (s_pageno != null && s_pageno.length() > 0) {
				pageno = Integer.parseInt(s_pageno);
			}
			if (s_rowsize != null && s_rowsize.length() > 0) {
				rowsize = Integer.parseInt(s_rowsize);
			}
			if (isReserve) {
                orderby += " desc";
            }
			HQLInfo hqlInfo = new HQLInfo();
			hqlInfo.setOrderBy(orderby);
			hqlInfo.setPageNo(pageno);
			hqlInfo.setRowSize(rowsize);
			changeFindPageHQLInfo(request, hqlInfo);
			Page page = getServiceImp(request).findPage(hqlInfo);
			//获取保险信息
			List<KmCarmngInsuranceInfo> mains = page.getList();
			// 记录操作日志
			UserOperHelper.logFindAll(mains,
					getServiceImp(request).getModelName());
			UserOperHelper.setOperSuccess(true);
			// 组装成JSON
			JSONArray array = new JSONArray();
			int index = mains.size();
			for (KmCarmngInsuranceInfo main : mains) {
				JSONObject dispatchersInfo = genCarmngInsuranceInfoJSON(main, request);
				array.add(dispatchersInfo);
			}
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(array.toString());
		} catch (Exception e) {
			messages.addError(e);
			e.printStackTrace();
		}
		TimeCounter.logCurrentTime("Action-calendar", true, getClass());
		return null;
	}
	
	
	
	//登记日期   车牌号  保险日期  保险金额 保险价值  保险单号
	// 历史用车JSON
	private JSONObject genCarmngInsuranceInfoJSON(KmCarmngInsuranceInfo kmCarmngInsuranceInfo,
			HttpServletRequest request) throws Exception {
		JSONObject dispatchersInfo = new JSONObject();
		Date date = new Date();
		dispatchersInfo.put("type", "insurance");
		//登记日期
		Date fdRegisterTime = kmCarmngInsuranceInfo.getFdRegisterTime();
		dispatchersInfo.put("registerDate", DateUtil.convertDateToString(fdRegisterTime,
				DateUtil.PATTERN_DATE));
		// 车牌号
		dispatchersInfo.put("fdVehiclesNo", kmCarmngInsuranceInfo.getFdVehiclesInfo().getFdNo());
		//保险日期
		Date start = kmCarmngInsuranceInfo.getFdInsuranceStartTime();
		dispatchersInfo.put("start", DateUtil.convertDateToString(start,
				DateUtil.PATTERN_DATE));
		Date end = kmCarmngInsuranceInfo.getFdInsuranceEndTime();
		dispatchersInfo.put("end", DateUtil.convertDateToString(end,
				DateUtil.PATTERN_DATE));
		
		String ids = getCarmngInfomationService().getCarPicIdsByCarId(kmCarmngInsuranceInfo.getFdVehiclesInfo().getFdId());
		if(StringUtil.isNotNull(ids)){
			dispatchersInfo.put("carImg",request.getContextPath()+"/sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId="+ids.split(";")[0]);
		} else {
			dispatchersInfo.put("carImg", request.getContextPath()
					+ "/km/asset/mobile/js/list/item/defaulthead.jpg");
		}
		//保险金额
		dispatchersInfo.put("fdInsuranceFee",kmCarmngInsuranceInfo.getFdInsuranceFee());
		//保险价值
		dispatchersInfo.put("fdInsurancePrice",kmCarmngInsuranceInfo.getFdInsurancePrice());
		//保单号
		dispatchersInfo.put("fdInsuranceNo",kmCarmngInsuranceInfo.getFdInsuranceNo());
		
		return dispatchersInfo;
	}
}