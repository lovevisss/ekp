package com.landray.kmss.km.carmng.actions;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Queue;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.landray.kmss.common.actions.ExtendAction;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.dao.HQLWrapper;
import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.common.test.TimeCounter;
import com.landray.kmss.constant.SysAuthConstant;
import com.landray.kmss.km.carmng.model.KmCarmngApplication;
import com.landray.kmss.km.carmng.model.KmCarmngDispatchersInfoList;
import com.landray.kmss.km.carmng.model.KmCarmngInfomation;
import com.landray.kmss.km.carmng.model.KmCarmngMotorcadeSet;
import com.landray.kmss.km.carmng.service.IKmCarmngApplicationService;
import com.landray.kmss.km.carmng.service.IKmCarmngDispatchersInfoListService;
import com.landray.kmss.km.carmng.service.IKmCarmngDispatchersInfoService;
import com.landray.kmss.km.carmng.service.IKmCarmngInfomationService;
import com.landray.kmss.km.carmng.service.IKmCarmngMotorcadeSetService;
import com.landray.kmss.sys.config.model.SysConfigParameters;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.util.ArrayUtil;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.HQLUtil;
import com.landray.kmss.util.KmssMessages;
import com.landray.kmss.util.ResourceUtil;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.util.UserUtil;
import com.landray.kmss.web.action.ActionForm;
import com.landray.kmss.web.action.ActionForward;
import com.landray.kmss.web.action.ActionMapping;
import com.sunbor.web.tag.Page;

import edu.emory.mathcs.backport.java.util.Arrays;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 用车资源日历 Action
 */
public class KmCarmngCalendarAction extends ExtendAction {

	protected IKmCarmngMotorcadeSetService kmCarmngMotorcadeSetService;

	protected IBaseService getCarmngMotorcadeSetServiceImp() {
		if (kmCarmngMotorcadeSetService == null) {
            kmCarmngMotorcadeSetService = (IKmCarmngMotorcadeSetService) getBean("kmCarmngMotorcadeSetService");
        }
		return kmCarmngMotorcadeSetService;
	}

	protected IKmCarmngInfomationService kmCarmngInfomationService;

	@Override
	protected IKmCarmngInfomationService getServiceImp(HttpServletRequest request) {
		if (kmCarmngInfomationService == null) {
            kmCarmngInfomationService = (IKmCarmngInfomationService) getBean("kmCarmngInfomationService");
        }
		return kmCarmngInfomationService;
	}
	
	protected IKmCarmngDispatchersInfoService kmCarmngDispatchersInfoService;

	protected IKmCarmngDispatchersInfoService getCarmngDispatchersInfoServiceImp(
			HttpServletRequest request) {
		if (kmCarmngDispatchersInfoService == null) {
            kmCarmngDispatchersInfoService = (IKmCarmngDispatchersInfoService) getBean("kmCarmngDispatchersInfoService");
        }
		return kmCarmngDispatchersInfoService;
	}

	protected IKmCarmngDispatchersInfoListService kmCarmngDispatchersInfoListService;

	protected IKmCarmngDispatchersInfoListService getDispatchersInfoListServiceImp() {
		if (kmCarmngDispatchersInfoListService == null) {
            kmCarmngDispatchersInfoListService = (IKmCarmngDispatchersInfoListService) getBean(
                    "kmCarmngDispatchersInfoListService");
        }
		return kmCarmngDispatchersInfoListService;
	}

	protected IKmCarmngApplicationService kmCarmngApplicationService;

	protected IKmCarmngApplicationService getKmCarmngApplicationServiceImp() {
		if (kmCarmngApplicationService == null) {
            kmCarmngApplicationService = (IKmCarmngApplicationService) getBean("kmCarmngApplicationService");
        }
		return kmCarmngApplicationService;
	}

	//车队日历数据，以JSON返回
	public ActionForward rescalendar(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-rescalendar", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			List<String> motorcadeSetIds = new ArrayList<String>();
			//查询车队信息
			JSONObject category = genCategoryJSON(motorcadeSetIds);
			//车辆
			Page resourcePage = getCarmng(request, motorcadeSetIds);
			List<KmCarmngInfomation> resources = resourcePage.getList();
			//用车申请
			List<KmCarmngDispatchersInfoList> infoLists = getDispatchersInfo(request);

			JSONObject result = new JSONObject();

			//车队信息
			result.put("category", category);
			//车辆信息
			JSONObject json = new JSONObject();
			json.put("total", resourcePage.getTotalrows());
			json.put("rowsize", resourcePage.getRowsize());
			result.put("resource", json);
			//用车信息
			result.put("main", genResCalendarJSON(resources, infoLists, request));

			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(result.toString());
		} catch (Exception e) {
			messages.addError(e);
			e.printStackTrace();
		}
		TimeCounter.logCurrentTime("Action-rescalendar", true, getClass());
		return null;
	}

	/**
	 * <p>查询所有车辆</p>
	 * @param request
	 * @return
	 * @author 孙佳
	 * @throws Exception 
	 */
	private Page getCarmng(HttpServletRequest request, List<String> motorcadeSets) throws Exception {
		HQLInfo hql = new HQLInfo();
		int pageno = 0;
		String s_pageno = request.getParameter("pageno");
		String selectedCategories = request.getParameter("selectedCategories");
		if (s_pageno != null && s_pageno.length() > 0) {
			pageno = Integer.parseInt(s_pageno);
		}
		String whereBlock = " kmCarmngInfomation.docStatus = 1 ";
		if (StringUtil.isNull(selectedCategories)) {
			whereBlock += " and 1 = 2 ";
		} else if (!"all".equals(selectedCategories)) {
			whereBlock += HQLUtil.buildLogicIN(" and kmCarmngInfomation.fdMotorcade.fdId ",
					ArrayUtil.convertArrayToList(selectedCategories.split("\\s*[;,]\\s*")));
		} else {
			whereBlock += HQLUtil.buildLogicIN(" and kmCarmngInfomation.fdMotorcade.fdId ", motorcadeSets);
		}
		hql.setWhereBlock(whereBlock);
		hql.setPageNo(pageno);
		hql.setRowSize(SysConfigParameters.getRowSize());
		Page page = getServiceImp(request).findPage(hql);
		return page;
	}

	// 生成资源日历所需要的JSON
	private JSONObject genResCalendarJSON(List<KmCarmngInfomation> resources,
			List<KmCarmngDispatchersInfoList> infoLists, HttpServletRequest request) throws Exception {
		JSONObject result = new JSONObject();
		for (KmCarmngInfomation resource : resources) {
			JSONObject json = new JSONObject();
			json.put("fdId", resource.getFdId());
			json.put("name", resource.getDocSubject() + "<br/>(" + resource.getFdNo() + ")");// 车辆名称
			json.put("fdNo", resource.getFdNo());// 车辆名称
			json.put("detail", resource.getFdRemark());// 车辆备注
			json.put("seats", resource.getDocStatus());// 容纳人数
			json.put("list", new JSONArray());// 使用该资源的记录列表
			result.put(resource.getFdId(), json);
		}

		Queue queueMeeting = convertToQueue(infoLists);
		KmCarmngDispatchersInfoList main = (KmCarmngDispatchersInfoList) queueMeeting.poll();
		// 按召开时间排序输出
		while (main != null) {
			if (main.getFdCarInfo().getFdId() != null && result.containsKey(main.getFdCarInfo().getFdId())) {
				JSONObject json = (JSONObject) result.get(main.getFdCarInfo().getFdId());
				JSONArray list = (JSONArray) json.get("list");
				getListJSON(main, list);
			}
			main = (KmCarmngDispatchersInfoList) queueMeeting.poll();
		}
		return result;
	}

	private Queue<Object> convertToQueue(List<?> list) {
		Queue<Object> queue = new LinkedList();
		for (Object item : list) {
			queue.offer(item);
		}
		return queue;
	}

	//车队JSON
	private JSONObject genCategoryJSON(List<String> motorcadeSetIds)
			throws Exception {
		JSONObject json = new JSONObject();
		HQLInfo hql = new HQLInfo();
		hql.setOrderBy(" kmCarmngMotorcadeSet.fdOrder ");
		String whereBlock = "1=1";
		hql.setAuthCheckType(SysAuthConstant.AUTH_CHECK_READER);
		/*if (UserUtil.checkRole("ROLE_KMCARMNG_ATTEMPER")) {
			whereBlock += " and 1 = 1";
		} else if (UserUtil.checkRole("ROLE_KMCARMNG_MOTORCADE_ATTEMPER")) {
			whereBlock += " and kmCarmngMotorcadeSet.fdDispatchers.fdId =:userId";
			hql.setParameter("userId", UserUtil.getKMSSUser().getUserId());
		} else {
			whereBlock += " and 1 = 0";
		}*/
		hql.setWhereBlock(whereBlock);
		List<KmCarmngMotorcadeSet> list = getCarmngMotorcadeSetServiceImp().findList(hql);
		for (KmCarmngMotorcadeSet category : list) {
			JSONObject j = new JSONObject();
			j.put("name", category.getFdName());
			json.put(category.getFdId(), j);
			motorcadeSetIds.add(category.getFdId());
		}
		return json;
	}

	/**
	 * <p>获取所有用车调度信息</p>
	 * @return
	 * @author 孙佳
	 * @throws Exception 
	 */
	private List<KmCarmngDispatchersInfoList> getDispatchersInfo(HttpServletRequest request)
			throws Exception {
		JSONArray array = new JSONArray();
		JSONObject json = null;
		HQLInfo hqlInfo = new HQLInfo();
		String fdStart = request.getParameter("fdStart");// 开始时间
		Date startDateTime = DateUtil.convertStringToDate(fdStart, ResourceUtil.getString("date.format.date"));
		String fdEnd = request.getParameter("fdEnd");// 结束时间
		Date endDateTime = DateUtil.convertStringToDate(fdEnd, ResourceUtil.getString("date.format.date"));
		hqlInfo.setWhereBlock(
				" kmCarmngDispatchersInfoList.fdDispatchersInfo.fdEndTime >=:fdStart and kmCarmngDispatchersInfoList.fdDispatchersInfo.fdStartTime <=:fdEnd");
		hqlInfo.setParameter("fdStart", startDateTime);
		hqlInfo.setParameter("fdEnd", endDateTime);
		return getDispatchersInfoListServiceImp().findList(hqlInfo);
	}
	
	/**
	 * <p>组装用车记录json</p>
	 * @param main
	 * @param request
	 * @return
	 * @author 孙佳
	 * @throws Exception 
	 */
	private void getListJSON(KmCarmngDispatchersInfoList main, JSONArray list) throws Exception {
		JSONObject json = null;
		String dept, docCreaterDept;
		JSONArray fdUserPersons = null;
		Map<String, String> userMap = null;
		List<KmCarmngApplication> appList = getCarmngApplication(main.getFdDispatchersInfo().getFdApplicationIds());
		if (null != appList && appList.size() > 0) {
			for (KmCarmngApplication app : appList) {
				json = new JSONObject();
				fdUserPersons = new JSONArray();
				userMap = new HashMap<String, String>();
				dept = "";
				docCreaterDept = "";
				json.put("fdId", main.getFdDispatchersInfo().getFdId());
				json.put("title", app.getDocSubject());
				json.put("status", app.getDocStatus());
				json.put("fdIsDispatcher", app.getFdIsDispatcher());
				if(null != app.getFdUserPersons() && app.getFdUserPersons().size() > 0){
					for (int i = 0; i < app.getFdUserPersons().size(); i++) {
						SysOrgElement element = (SysOrgElement) app.getFdUserPersons().get(i);
						dept = null != element.getFdParent() ? '(' + element.getFdParent().getFdName() + ')' : "";
						userMap.put("fdId", element.getFdId());
						userMap.put("fdName", element.getFdName() + dept);

						fdUserPersons.add(userMap);
					}
				}
				json.put("fdUserPersons", fdUserPersons.toString());
				if (main.getFdDispatchersInfo().getDocCreator().getFdParent() != null) {
					docCreaterDept = main.getFdDispatchersInfo().getDocCreator().getFdParent().getFdName();
				}
				json.put("docCreator", main.getFdDispatchersInfo().getDocCreator().getFdName() + "(" + docCreaterDept + ")");
				json.put("docCreatorId", main.getFdDispatchersInfo().getDocCreator().getFdId());
				json.put("start", DateUtil.convertDateToString(main.getFdDispatchersInfo().getFdStartTime(),
						DateUtil.TYPE_DATETIME, UserUtil.getKMSSUser().getLocale()));
				json.put("end", DateUtil.convertDateToString(main.getFdDispatchersInfo().getFdEndTime(),
						DateUtil.TYPE_DATETIME, UserUtil.getKMSSUser().getLocale()));
				list.add(json);
			}
		}
	}

	/**
	 * <p>获取用车申请记录</p>
	 * @param fdApplicationIds
	 * @return
	 * @throws Exception
	 * @author 孙佳
	 */
	private List<KmCarmngApplication> getCarmngApplication(String fdApplicationIds) throws Exception{
		HQLInfo hqlInfo = new HQLInfo();
		HQLWrapper hqlWrapper = HQLUtil.buildPreparedLogicIN(" kmCarmngApplication.fdId ", "kmCarmngApplication" + "0_",
				Arrays.asList(fdApplicationIds.split(";")));
		hqlInfo.setWhereBlock(hqlWrapper.getHql());
		hqlInfo.setParameter(hqlWrapper.getParameterList());

		return getKmCarmngApplicationServiceImp().findList(hqlInfo);
	}



}
