package com.landray.kmss.km.carmng.actions;

import com.landray.kmss.common.actions.DataAction;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.common.test.TimeCounter;
import com.landray.kmss.constant.SysAuthConstant;
import com.landray.kmss.km.carmng.model.KmCarmngApplication;
import com.landray.kmss.km.carmng.model.KmCarmngDispatchersInfo;
import com.landray.kmss.km.carmng.service.IKmCarmngApplicationService;
import com.landray.kmss.km.carmng.service.IKmCarmngDispatchersInfoListService;
import com.landray.kmss.km.carmng.service.IKmCarmngDispatchersInfoService;
import com.landray.kmss.sys.config.model.SysConfigParameters;
import com.landray.kmss.sys.log.util.UserOperHelper;
import com.landray.kmss.sys.person.interfaces.PersonInfoServiceGetter;
import com.landray.kmss.util.CriteriaUtil;
import com.landray.kmss.util.CriteriaValue;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.HQLUtil;
import com.landray.kmss.util.KmssMessages;
import com.landray.kmss.util.KmssReturnPage;
import com.landray.kmss.util.ResourceUtil;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.web.action.ActionForm;
import com.landray.kmss.web.action.ActionForward;
import com.landray.kmss.web.action.ActionMapping;
import com.sunbor.web.tag.Page;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

/**
 * 创建日期 2015/03/02
 * 
 * @author wangtf
 */

public class KmCarmngDispatchersInfoIndexAction extends DataAction {
	protected IKmCarmngDispatchersInfoService kmCarmngDispatchersInfoService;

	protected IKmCarmngApplicationService kmCarmngApplicationService;

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
		if (kmCarmngDispatchersInfoService == null) {
            kmCarmngDispatchersInfoService = (IKmCarmngDispatchersInfoService) getBean("kmCarmngDispatchersInfoService");
        }
		return kmCarmngDispatchersInfoService;
	}

	protected IKmCarmngApplicationService getCarmngApplicationServiceImp() {
		if (kmCarmngApplicationService == null) {
            kmCarmngApplicationService = (IKmCarmngApplicationService) getBean("kmCarmngApplicationService");
        }
		return kmCarmngApplicationService;
	}
	
	protected IKmCarmngDispatchersInfoListService kmCarmngDispatchersInfoListService;
	protected IKmCarmngDispatchersInfoListService getDispatchersInfoListServiceImp() {
		if (kmCarmngDispatchersInfoListService == null) {
            kmCarmngDispatchersInfoListService = (IKmCarmngDispatchersInfoListService) getBean(
                    "kmCarmngDispatchersInfoListService");
        }
		return kmCarmngDispatchersInfoListService;
	}

	private List findDispatchInfoList(String propertyName, String[] value) throws Exception {
		List fs = new ArrayList();
		HQLInfo hqlInfo = new HQLInfo();
		hqlInfo.setSelectBlock("kmCarmngDispatchersInfoList.fdId");
		hqlInfo.setWhereBlock(HQLUtil.buildLogicIN(" kmCarmngDispatchersInfoList." + propertyName , Arrays.asList(value)));
		fs = getDispatchersInfoListServiceImp().findList(hqlInfo);
		return fs;
	}

	private List findDispatchInfoListLike(String propertyName, String value) throws Exception {
		List fs = new ArrayList();
		HQLInfo hqlInfo = new HQLInfo();
		hqlInfo.setSelectBlock("kmCarmngDispatchersInfoList.fdId");
		hqlInfo.setWhereBlock(" kmCarmngDispatchersInfoList." + propertyName + " like :param");
		hqlInfo.setParameter("param", "%" + value.trim() + "%");
		fs = getDispatchersInfoListServiceImp().findList(hqlInfo);
		return fs;
	}

	@Override
	protected void changeFindPageHQLInfo(HttpServletRequest request,
										 HQLInfo hqlInfo) throws Exception {
		String fdCarId = request.getParameter("fdCarId");
		String flag = request.getParameter("flag");
		CriteriaValue cv = new CriteriaValue(request);
		String fdMotorcade[] = cv.polls("fdMotorcade");
		String[] fdFlag = cv.polls("fdFlag");
		String fdCarInfoNo = cv.poll("fdCarInfoNo");
		String fdDriverName = cv.poll("fdDriverName");
		if (StringUtil.isNull(fdDriverName)) {
			fdDriverName = cv.poll("fdDriversName");
		}
		String[] fdVehichesType = cv.polls("fdVehichesType");
		String whereStr = hqlInfo.getWhereBlock();
		String where = StringUtil.isNull(whereStr) ? "1=1 " : whereStr;
		// 按车辆Id
		if (StringUtil.isNotNull(flag)) {
			List fdCarInfoIdList = findDispatchInfoListLike("fdCarInfo.fdId", fdCarId);
			if (fdCarInfoIdList.size() > 0) {
				where = StringUtil.linkString(where, " and ",
						HQLUtil.buildLogicIN("kmCarmngDispatchersInfo.fdDispatchersInfoList.fdId", fdCarInfoIdList));
			} else {
				where = "1=0";
			}
		}

		// 按车牌号
		if (StringUtil.isNotNull(fdCarInfoNo)) {
			List fdCarInfoNoList = findDispatchInfoListLike("fdCarInfoNo", fdCarInfoNo);
			if (fdCarInfoNoList.size() > 0) {
			where = StringUtil.linkString(where, " and ",
					HQLUtil.buildLogicIN("kmCarmngDispatchersInfo.fdDispatchersInfoList.fdId",fdCarInfoNoList));
			} else {
				where = StringUtil.linkString(where, " and ", "1=0");

			}
		}
		// 按司机
		if (StringUtil.isNotNull(fdDriverName)) {
			List fdDriversNameList = findDispatchInfoListLike("fdDriverName", fdDriverName);
			if (fdDriversNameList.size() > 0) {
				where = StringUtil.linkString(where, " and ",
						HQLUtil.buildLogicIN("kmCarmngDispatchersInfo.fdDispatchersInfoList.fdId", fdDriversNameList));
			} else {
				where = StringUtil.linkString(where, " and ", "1=0");
			}
		}
		// 按车队
		if (null != fdMotorcade && fdMotorcade.length > 0) {
			List fdMotorcadeList = findDispatchInfoList("fdMotorcadeId", fdMotorcade);
			if (fdMotorcadeList.size() > 0) {
			where = StringUtil.linkString(where, " and ",
						HQLUtil.buildLogicIN("kmCarmngDispatchersInfo.fdDispatchersInfoList.fdId", fdMotorcadeList));
			}else{
				where = StringUtil.linkString(where, " and ", "1=0");
			}
		}
		// 按车辆类型
		if (null != fdVehichesType && fdVehichesType.length > 0) {
			List fdVehichesTypeList = findDispatchInfoList("fdVehichesTypeId", fdVehichesType);
			if (fdVehichesTypeList.size() > 0) {
			where = StringUtil.linkString(where, " and ",
						HQLUtil.buildLogicIN("kmCarmngDispatchersInfo.fdDispatchersInfoList.fdId", fdVehichesTypeList));
			}else{
				where = StringUtil.linkString(where, " and ", "1=0");
			}
		}
		if (null != fdFlag && fdFlag.length > 0) {
			where = StringUtil.linkString(where, " and ", HQLUtil.buildLogicIN("kmCarmngDispatchersInfo.fdFlag", Arrays.asList(fdFlag)));
		}
		hqlInfo.setWhereBlock(where.toString());
		CriteriaUtil.buildHql(cv, hqlInfo, KmCarmngDispatchersInfo.class);
		Page page = getServiceImp(request).findPage(hqlInfo);
		request.setAttribute("queryPage", page);
	}

	// 返回历史用车日历数据，以JSON返回
	public ActionForward historyDispatch(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		TimeCounter.logCurrentTime("Action-calendar", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			// 获取历史用车申请
			List<KmCarmngDispatchersInfo> mains = getKmCarmngDispatchersInfoMains(
					request, true);
			// 记录操作日志
			UserOperHelper.logFindAll(mains,
					getServiceImp(request).getModelName());
			UserOperHelper.setOperSuccess(true);
			// 组装成JSON
			JSONArray array = new JSONArray();
			for (KmCarmngDispatchersInfo main : mains) {
				JSONObject dispatchersInfo = genCarmngDispatchersInfoJSON(main,
						request);
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

	// 返回历史用车日历数据，以JSON返回
	public ActionForward listDispatch(ActionMapping mapping, ActionForm form,
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
			hqlInfo.setAuthCheckType(SysAuthConstant.AUTH_CHECK_NONE);
			changeFindPageHQLInfo(request, hqlInfo);
			Page page = getServiceImp(request).findPage(hqlInfo);
			// 获取历史用车申请
			List<KmCarmngDispatchersInfo> mains = page.getList();
			// 记录操作日志
			UserOperHelper.logFindAll(mains,
					getServiceImp(request).getModelName());
			UserOperHelper.setOperSuccess(true);
			// 组装成JSON
			JSONArray array = new JSONArray();
			for (KmCarmngDispatchersInfo main : mains) {
				JSONObject dispatchersInfo = genCarmngDispatchersInfoJSON(main,
						request);
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

	// 获取指定时间段内的历史用车申请
	private List<KmCarmngDispatchersInfo> getKmCarmngDispatchersInfoMains(
			HttpServletRequest request, Boolean isMyCalendar) throws Exception {
		HQLInfo hql = new HQLInfo();
		String fdStart = request.getParameter("fdStart");// 开始时间
		Date startDateTime = DateUtil.convertStringToDate(fdStart, ResourceUtil
				.getString("date.format.date"));
		String fdEnd = request.getParameter("fdEnd");// 结束时间
		Date endDateTime = DateUtil.convertStringToDate(fdEnd, ResourceUtil
				.getString("date.format.date"));
		String fdCarId = request.getParameter("fdCarId");
		String where = " kmCarmngDispatchersInfo.fdStartTime<:fdEnd and kmCarmngDispatchersInfo.fdEndTime>:fdStart";
		List fdCarInfoIdList = findDispatchInfoListLike("fdCarInfo.fdId", fdCarId);
//		if (fdCarInfoIdList.size() > 0) { //#142949 屏蔽此条件，否则车辆无用车记录查所有出车记录（包括不是自己的出车记录）
			where = StringUtil.linkString(where, " and ",
					HQLUtil.buildLogicIN("kmCarmngDispatchersInfo.fdDispatchersInfoList.fdId", fdCarInfoIdList));
//		}
		hql.setWhereBlock(where);
		hql.setParameter("fdStart", startDateTime);
		hql.setParameter("fdEnd", endDateTime);
		hql.setOrderBy(" kmCarmngDispatchersInfo.fdStartTime ");
		List<KmCarmngDispatchersInfo> list = getServiceImp(request).findValue(
				hql);
		return list;
	}

	// 历史用车JSON
	private JSONObject genCarmngDispatchersInfoJSON(
			KmCarmngDispatchersInfo kmCarmngDispatchersInfo,
			HttpServletRequest request) throws Exception {
		JSONObject dispatchersInfo = new JSONObject();
		Date date = new Date();
		dispatchersInfo.put("type", "dispatcher");
		Date start = kmCarmngDispatchersInfo.getFdStartTime();
		dispatchersInfo.put("start", DateUtil.convertDateToString(start,
				DateUtil.PATTERN_DATETIME));
		Date end = kmCarmngDispatchersInfo.getFdEndTime();
		dispatchersInfo.put("end", DateUtil.convertDateToString(end,
				DateUtil.PATTERN_DATETIME));
		String status = "", statusText = "";
		// if ("0".equals(kmCarmngDispatchersInfo.getFdFlag())) {
		// status = "0";
		// statusText =
		// ResourceUtil.getString("kmCarmngDispatchersInfo.fdFlag1",
		// "km-carmng");
		// }
		// if ("1".equals(kmCarmngDispatchersInfo.getFdFlag())) {
		// status = "1";
		// statusText =
		// ResourceUtil.getString("kmCarmngDispatchersInfo.fdFlag2",
		// "km-carmng");
		// }
		dispatchersInfo.put("fdFlag", kmCarmngDispatchersInfo.getFdFlag());

		List<KmCarmngApplication> Applist = getCarmngApplicationServiceImp()
				.findByPrimaryKeys(
						kmCarmngDispatchersInfo.getFdApplicationIds()
								.split(";"));
		KmCarmngApplication fdApplication = Applist.get(0);
		String fdHost = "";
		String src = "";
		if (fdApplication.getFdApplicationPerson() != null) {
			fdHost += fdApplication.getFdApplicationPerson().getFdName();
			src = PersonInfoServiceGetter.getPersonHeadimageUrl(fdApplication
					.getFdApplicationPerson().getFdId());
		} else {
			src = PersonInfoServiceGetter.DEFAULT_IMG;
		}
		if (!PersonInfoServiceGetter.isFullPath(src)) {
			src = request.getContextPath() + src;
		}
		dispatchersInfo.put("fdHost", fdHost);// 申请人
		dispatchersInfo.put("hostsrc", src);// 申请人头像
		String fdApplicationPhone = "";
		dispatchersInfo.put("fdApplicationPhone", fdApplication
				.getFdApplicationPersonPhone());// 申请人电话
		String fdPlaceName = "";
		if (StringUtil.isNotNull(kmCarmngDispatchersInfo.getFdApplicationNames())) {
			fdPlaceName = kmCarmngDispatchersInfo.getFdApplicationNames();
			dispatchersInfo.put("fdPlaceName", fdPlaceName);// 会议地点
		}
		return dispatchersInfo;
	}
	//计算调度信息l
	public ActionForward count(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		TimeCounter.logCurrentTime("Action-count", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			HQLInfo hqlInfo = new HQLInfo();
			hqlInfo.setSelectBlock("count(*)");
			this.changeFindPageHQLInfo(request, hqlInfo);
			hqlInfo.setOrderBy(null);
			@SuppressWarnings("unchecked")
			List<Object> list = getServiceImp(request).findList(hqlInfo);
			request.setAttribute("lui-source",
					new JSONObject().element("count", list.get(0)));
		} catch (Exception e) {
			messages.addError(e);
		}
		TimeCounter.logCurrentTime("Action-count", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages)
					.addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
			return getActionForward("failure", mapping, form, request, response);
		} else {
			return getActionForward("lui-source", mapping, form, request,
					response);
		}
	}
}