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
import com.landray.kmss.km.carmng.model.KmCarmngInfringeInfo;
import com.landray.kmss.km.carmng.service.IKmCarmngDriversInfoService;
import com.landray.kmss.km.carmng.service.IKmCarmngInfringeInfoService;
import com.landray.kmss.sys.config.model.SysConfigParameters;
import com.landray.kmss.sys.log.util.UserOperHelper;
import com.landray.kmss.sys.person.interfaces.PersonInfoServiceGetter;
import com.landray.kmss.util.CriteriaUtil;
import com.landray.kmss.util.CriteriaValue;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.KmssMessages;
import com.landray.kmss.util.NumberUtil;
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

public class KmCarmngInfringeInfoIndexAction extends DataAction {
	protected IKmCarmngInfringeInfoService kmCarmngInfringeInfoService;
	
	protected IKmCarmngDriversInfoService kmCarmngDriversInfoService;

	@Override
	protected IBaseService getCategoryServiceImp(HttpServletRequest request) {
		return null;
	}

	@Override
	protected String getParentProperty() {
		return null;
	}
	protected IKmCarmngDriversInfoService getDriverService(){
		if (kmCarmngDriversInfoService == null) {
            kmCarmngDriversInfoService = (IKmCarmngDriversInfoService) getBean("kmCarmngDriversInfoService");
        }
		return kmCarmngDriversInfoService;
	}
	@Override
	protected IBaseService getServiceImp(HttpServletRequest request) {
		if (kmCarmngInfringeInfoService == null) {
            kmCarmngInfringeInfoService = (IKmCarmngInfringeInfoService) getBean("kmCarmngInfringeInfoService");
        }
		return kmCarmngInfringeInfoService;
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
		CriteriaUtil.buildHql(cv, hqlInfo, KmCarmngInfringeInfo.class);
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
					.append(" and kmCarmngInfringeInfo.fdVehiclesInfo.fdMotorcade.fdId=:fdMotorcade");
			hqlInfo.setParameter("fdMotorcade", fdMotorcade);
		}
		if (StringUtil.isNotNull(fdVehichesType)) {
			where
					.append(" and kmCarmngInfringeInfo.fdVehiclesInfo.fdVehichesType.fdId=:fdVehichesType");
			hqlInfo.setParameter("fdVehichesType", fdVehichesType);
		}
		if (StringUtil.isNotNull(fdNo)) {
			where.append(" and kmCarmngInfringeInfo.fdVehiclesInfo.fdNo like :fdNo");
			hqlInfo.setParameter("fdNo","%" + fdNo.trim() + "%" );
		}
		if (StringUtil.isNotNull(flag)) {
			where
					.append(" and kmCarmngInfringeInfo.fdVehiclesInfo.fdId=:fdCarId");
			hqlInfo.setParameter("fdCarId", fdCarId);
		}
		hqlInfo.setWhereBlock(where.toString());
	}
	
	// 返回违章数据，以JSON返回
	public ActionForward listInfringe(ActionMapping mapping, ActionForm form,
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
			request.setAttribute("queryPage", page);
			//获取历史用车申请
			List<KmCarmngInfringeInfo> mains = page.getList();
			// 记录操作日志
			UserOperHelper.logFindAll(mains,
					getServiceImp(request).getModelName());
			UserOperHelper.setOperSuccess(true);
			// 组装成JSON
			JSONArray array = new JSONArray();
			int index = mains.size();
			for (KmCarmngInfringeInfo main : mains) {
				JSONObject dispatchersInfo = genCarmngInfringeInfoJSON(main, request);
				array.add(dispatchersInfo);
			}
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(array.toString());
		} catch (Exception e) {
			messages.addError(e);
			e.printStackTrace();
		}
		TimeCounter.logCurrentTime("Action-calendar", true, getClass());
//		if (messages.hasError()) {
//			KmssReturnPage.getInstance(request).addMessages(messages)
//					.addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
//			return getActionForward("failure", mapping, form, request, response);
//		} else {
//			return getActionForward("listInfringe", mapping, form, request, response);
//		}
		return null;
	}
	
	
	
	//时间   驾驶员   车牌号  违章费  违章地
	// 历史用车JSON
	private JSONObject genCarmngInfringeInfoJSON(KmCarmngInfringeInfo kmCarmngInfringeInfo,
			HttpServletRequest request) throws Exception {
		JSONObject dispatchersInfo = new JSONObject();
		Date date = new Date();
		dispatchersInfo.put("type", "infringe");
		//违章时间
		Date infringeTime = kmCarmngInfringeInfo.getFdInfringeTime();
		dispatchersInfo.put("infringeTime", DateUtil.convertDateToString(infringeTime,
				DateUtil.PATTERN_DATETIME));
		
		if(StringUtil.isNotNull(kmCarmngInfringeInfo.getFdInfringePersonId())){
			KmCarmngDriversInfo kCarmngDriversInfo = (KmCarmngDriversInfo)getDriverService().findByPrimaryKey(kmCarmngInfringeInfo.getFdInfringePersonId());
			//驾驶员
			String fdHost = kmCarmngInfringeInfo.getFdInfringePersonName();
			String src = PersonInfoServiceGetter.getPersonHeadimageUrl(kCarmngDriversInfo.getFdSysId());
			if (!PersonInfoServiceGetter.isFullPath(src)) {
				src = request.getContextPath() + src;
			}
			dispatchersInfo.put("fdHost", fdHost);// 驾驶员
			dispatchersInfo.put("hostsrc", src);// 驾驶员头像
		}
		dispatchersInfo.put("fdVehiclesNo", kmCarmngInfringeInfo.getFdVehiclesInfo().getFdNo());// 车牌号 
		dispatchersInfo.put("fdInfringeFee", NumberUtil.roundDecimal(kmCarmngInfringeInfo.getFdInfringeFee()));// 违章费
		dispatchersInfo.put("fdInfringeSite", kmCarmngInfringeInfo.getFdInfringeSite());// 违章地
		
		return dispatchersInfo;
	}
}