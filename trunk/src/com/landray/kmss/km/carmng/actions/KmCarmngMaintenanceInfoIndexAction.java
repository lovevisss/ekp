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
import com.landray.kmss.km.carmng.model.KmCarmngDriversInfo;
import com.landray.kmss.km.carmng.model.KmCarmngMaintenanceInfo;
import com.landray.kmss.km.carmng.service.IKmCarmngDriversInfoService;
import com.landray.kmss.km.carmng.service.IKmCarmngMaintenanceInfoService;
import com.landray.kmss.sys.config.model.SysConfigParameters;
import com.landray.kmss.sys.log.util.UserOperHelper;
import com.landray.kmss.sys.person.interfaces.PersonInfoServiceGetter;
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

public class KmCarmngMaintenanceInfoIndexAction extends DataAction {
	protected IKmCarmngMaintenanceInfoService kmCarmngMaintenanceInfoService;
	protected IKmCarmngDriversInfoService kmCarmngDriversInfoService;
	protected IKmCarmngDriversInfoService getDriverService(){
		if (kmCarmngDriversInfoService == null) {
            kmCarmngDriversInfoService = (IKmCarmngDriversInfoService) getBean("kmCarmngDriversInfoService");
        }
		return kmCarmngDriversInfoService;
	}

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
		if (kmCarmngMaintenanceInfoService == null) {
            kmCarmngMaintenanceInfoService = (IKmCarmngMaintenanceInfoService) getBean("kmCarmngMaintenanceInfoService");
        }
		return kmCarmngMaintenanceInfoService;
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
		CriteriaUtil.buildHql(cv, hqlInfo, KmCarmngMaintenanceInfo.class);
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
					.append(" and kmCarmngMaintenanceInfo.fdVehiclesInfo.fdMotorcade.fdId=:fdMotorcade");
			hqlInfo.setParameter("fdMotorcade", fdMotorcade);
		}
		if (StringUtil.isNotNull(fdVehichesType)) {
			where
					.append(" and kmCarmngMaintenanceInfo.fdVehiclesInfo.fdVehichesType.fdId=:fdVehichesType");
			hqlInfo.setParameter("fdVehichesType", fdVehichesType);
		}
		if (StringUtil.isNotNull(fdNo)) {
			where.append(" and kmCarmngMaintenanceInfo.fdVehiclesInfo.fdNo like :fdNo");
			hqlInfo.setParameter("fdNo","%" + fdNo.trim() + "%");
		}
		
		if (StringUtil.isNotNull(flag)) {
			where
					.append(" and kmCarmngMaintenanceInfo.fdVehiclesInfo.fdId=:fdCarId");
			hqlInfo.setParameter("fdCarId", fdCarId);
		}
		hqlInfo.setWhereBlock(where.toString());
	}
	
	// 返回保养数据，以JSON返回
	public ActionForward lisMaintenancet(ActionMapping mapping, ActionForm form,
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
			//获取保养信息
			List<KmCarmngMaintenanceInfo> mains = page.getList();
			// 记录操作日志
			UserOperHelper.logFindAll(mains,
					getServiceImp(request).getModelName());
			UserOperHelper.setOperSuccess(true);
			// 组装成JSON
			JSONArray array = new JSONArray();
			int index = mains.size();
			for (KmCarmngMaintenanceInfo main : mains) {
				JSONObject dispatchersInfo = genCarmngMaintenanceInfoJSON(main, request);
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
	
	
	
	//保养日期  送修人  车牌号   保险费 
	private JSONObject genCarmngMaintenanceInfoJSON(KmCarmngMaintenanceInfo kmCarmngMaintenanceInfo,
			HttpServletRequest request) throws Exception {
		JSONObject dispatchersInfo = new JSONObject();
		Date date = new Date();
		dispatchersInfo.put("type", "maintenance");
		//保养日期 
		Date fdMaintenanceTime = kmCarmngMaintenanceInfo.getFdMaintenanceTime();
		dispatchersInfo.put("fdMaintenanceTime", DateUtil.convertDateToString(fdMaintenanceTime,
				DateUtil.PATTERN_DATE));
		
		if(StringUtil.isNotNull(kmCarmngMaintenanceInfo.getFdPersonId())){
			KmCarmngDriversInfo kCarmngDriversInfo = (KmCarmngDriversInfo)getDriverService().findByPrimaryKey(kmCarmngMaintenanceInfo.getFdPersonId());
			//送修人
			String fdHost = kmCarmngMaintenanceInfo.getFdPersonName();
			String src = PersonInfoServiceGetter.getPersonHeadimageUrl(kCarmngDriversInfo.getFdSysId());
			if (!PersonInfoServiceGetter.isFullPath(src)) {
				src = request.getContextPath() + src;
			}
			dispatchersInfo.put("fdHost", fdHost);// 驾驶员
			dispatchersInfo.put("hostsrc", src);// 驾驶员头像
		}
		// 车牌号 
		dispatchersInfo.put("fdVehiclesNo", kmCarmngMaintenanceInfo.getFdVehiclesInfo().getFdNo());
		// 保险费 
		dispatchersInfo.put("fdMaintenanceFee", kmCarmngMaintenanceInfo.getFdMaintenanceFee());
		// 保险费 
		dispatchersInfo.put("fdRepairFee", kmCarmngMaintenanceInfo.getFdRepairFee());
		return dispatchersInfo;
	}
}