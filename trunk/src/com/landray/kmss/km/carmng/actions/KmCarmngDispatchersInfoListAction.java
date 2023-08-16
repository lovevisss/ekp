package com.landray.kmss.km.carmng.actions;

import java.util.Calendar;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.CacheMode;
import org.hibernate.query.NativeQuery;
import org.hibernate.type.StandardBasicTypes;

import com.landray.kmss.common.actions.ExtendAction;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.dao.IBaseDao;
import com.landray.kmss.common.test.TimeCounter;
import com.landray.kmss.km.carmng.model.KmCarmngDispatchersInfoList;
import com.landray.kmss.km.carmng.service.IKmCarmngDispatchersInfoListService;
import com.landray.kmss.sys.log.util.UserOperHelper;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.KmssMessages;
import com.landray.kmss.util.KmssReturnPage;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.web.action.ActionForm;
import com.landray.kmss.web.action.ActionForward;
import com.landray.kmss.web.action.ActionMapping;

import net.sf.json.JSONObject;

public class KmCarmngDispatchersInfoListAction extends ExtendAction {

	protected IKmCarmngDispatchersInfoListService kmCarmngDispatchersInfoListService;

	@Override
	protected IKmCarmngDispatchersInfoListService getServiceImp(HttpServletRequest request) {
		if (kmCarmngDispatchersInfoListService == null) {
            kmCarmngDispatchersInfoListService = (IKmCarmngDispatchersInfoListService) getBean(
                    "kmCarmngDispatchersInfoListService");
        }
		return kmCarmngDispatchersInfoListService;
	}


	public ActionForward search(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-search", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			HQLInfo hqlInfo = new HQLInfo();
			String whereBlock = "1 < 2";
			whereBlock = StringUtil.linkString(whereBlock, " and ",
					getWhereBlockByStartTime(request));
			whereBlock = StringUtil.linkString(whereBlock, " and ",
					getWhereBlockByEndTime(request));
			whereBlock = StringUtil.linkString(whereBlock, " and ",
					getWhereBlockByCarInfoNo(request, hqlInfo));

			hqlInfo.setWhereBlock(whereBlock);
			hqlInfo.setOrderBy("kmCarmngDispatchersInfoList.fdDispatchersInfo.fdStartTime desc");
			if (StringUtil.isNotNull((String) request
					.getAttribute("fdStartTime"))) {
				hqlInfo.setParameter("fdStartTime", DateUtil
						.convertStringToDate((String) request
								.getAttribute("fdStartTime"),
								DateUtil.TYPE_DATETIME, Locale.getDefault()));
			}
			if (StringUtil
					.isNotNull((String) request.getAttribute("fdEndTime"))) {
				hqlInfo.setParameter("fdEndTime", DateUtil.convertStringToDate(
						(String) request.getAttribute("fdEndTime"),
						DateUtil.TYPE_DATETIME, Locale.getDefault()));
			}

			List<KmCarmngDispatchersInfoList> list = getServiceImp(request).findList(
					hqlInfo);
			// 记录操作日志
			UserOperHelper.logFindAll(list,
					getServiceImp(request).getModelName());
			JSONObject pathJson = new JSONObject();
			JSONObject applicationJson = new JSONObject();
			for (KmCarmngDispatchersInfoList kmCarmngDispatchersInfoList : list) {
				IBaseDao baseDao = (IBaseDao) SpringBeanUtil.getBean("KmssBaseDao");
				String sql = "select m.fd_departure,m.fd_application_path,m.fd_destination, "
						+ "(SELECT fd_name FROM sys_org_element WHERE fd_id = fd_application_person) AS personName, "
						+ "(SELECT fd_name FROM sys_org_element WHERE fd_id = fd_application_dept) AS deptName, "
						+ "(SELECT fd_name FROM sys_org_element WHERE fd_id = (SELECT fd_parentid FROM sys_org_element WHERE fd_id = fd_application_dept)) AS gsName "
						+ " from km_carmng_application m where m.fd_id in ('"
						+ kmCarmngDispatchersInfoList.getFdDispatchersInfo().getFdApplicationIds().replace(";", "','")
						+ "')";
				NativeQuery query = baseDao.getHibernateSession().createNativeQuery(sql);
				query.setCacheable(true);
				query.setCacheMode(CacheMode.NORMAL);
				query.setCacheRegion("km-carmng");
				// 增加别名
				query.addScalar("fd_departure", StandardBasicTypes.STRING)
						.addScalar("fd_application_path",StandardBasicTypes.STRING)
						.addScalar("fd_destination", StandardBasicTypes.STRING)
						.addScalar("personName",StandardBasicTypes.STRING)
						.addScalar("deptName",StandardBasicTypes.STRING)
						.addScalar("gsName", StandardBasicTypes.STRING);
				for (Object obj : query.list()) {
					Object[] result = (Object[]) obj;
					String fdDeparture = (String) result[0];
					String fdApplicationPath = (String) result[1];
					String fdDestination = (String) result[2];
					String pathStr = "";
					if (StringUtil.isNotNull(fdDeparture)) {
						pathStr += fdDeparture + "-";
					}
					if (StringUtil.isNotNull(fdApplicationPath)) {
						pathStr += fdApplicationPath + "-";
					}
					if (StringUtil.isNotNull(fdDestination)) {
						pathStr += fdDestination;
					}
					pathJson.element(kmCarmngDispatchersInfoList.getFdId(),
							pathStr);
					// 用车申请
					String applicationResult[] = new String[3];
					applicationResult[0] = (String)result[3];
					applicationResult[1] = (String)result[4];
					applicationResult[2] = (String)result[5];
					applicationJson.element(
							kmCarmngDispatchersInfoList.getFdId(),
							applicationResult);
				}
			}
			request.setAttribute("pathJson", pathJson);
			request.setAttribute("applicationJson", applicationJson);
			request.setAttribute("kmCarmngDispatchersInfoList", list);
		} catch (Exception e) {
			messages.addError(e);
		}

		TimeCounter.logCurrentTime("Action-search", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages)
					.addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
			return getActionForward("failure", mapping, form, request, response);
		} else {
			return getActionForward("search", mapping, form, request, response);
		}
	}

	private String getWhereBlockByCarInfoNo(HttpServletRequest request,
			HQLInfo hqlInfo) {
		String whereBlock = "";
		String fdCarInfoNo = request.getParameter("fdCarInfoNo");
		if (StringUtil.isNotNull(fdCarInfoNo)) {
			whereBlock = "kmCarmngDispatchersInfoList.fdCarInfo.fdNo like :fdCarInfoNo";
			hqlInfo.setParameter("fdCarInfoNo", "%" + fdCarInfoNo + "%");
			request.setAttribute("fdCarInfoNo", fdCarInfoNo);
		}
		hqlInfo.setWhereBlock(whereBlock);
		return hqlInfo.getWhereBlock();
	}

	private String getWhereBlockByEndTime(HttpServletRequest request) {
		String whereBlock = "";
		String fdEndTime = request.getParameter("fdEndTime");
		java.util.Date nowDate = new java.util.Date();
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(nowDate);
		calendar.set(Calendar.DAY_OF_MONTH, 0);
		calendar.add(Calendar.DAY_OF_MONTH, 1);
		if (StringUtil.isNull(fdEndTime)) {
			fdEndTime = DateUtil.convertDateToString(nowDate,
					DateUtil.TYPE_DATETIME, Locale.getDefault());

		}
		if (StringUtil.isNotNull(fdEndTime)) {
			whereBlock = "kmCarmngDispatchersInfoList.fdDispatchersInfo.fdEndTime <= :fdEndTime";
			request.setAttribute("fdEndTime", fdEndTime);
		}
		return whereBlock;
	}

	private String getWhereBlockByStartTime(HttpServletRequest request) {
		String whereBlock = "";
		String fdStartTime = request.getParameter("fdStartTime");
		java.util.Date nowDate = new java.util.Date();
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(nowDate);
		calendar.set(Calendar.DAY_OF_MONTH, 0);
		calendar.add(Calendar.DAY_OF_MONTH, 1);
		if (StringUtil.isNull(fdStartTime)) {
			fdStartTime = DateUtil.convertDateToString(calendar.getTime(),
					DateUtil.TYPE_DATETIME, Locale.getDefault());

		}
		if (StringUtil.isNotNull(fdStartTime)) {
			whereBlock = "kmCarmngDispatchersInfoList.fdDispatchersInfo.fdStartTime >= :fdStartTime";
			request.setAttribute("fdStartTime", fdStartTime);
		}

		return whereBlock;
	}

	public void saveExportExcel(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-saveExportExcel", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			HQLInfo hqlInfo = new HQLInfo();
			String whereBlock = "1 < 2";
			whereBlock = StringUtil.linkString(whereBlock, " and ",
					getWhereBlockByStartTime(request));
			whereBlock = StringUtil.linkString(whereBlock, " and ",
					getWhereBlockByEndTime(request));
			whereBlock = StringUtil.linkString(whereBlock, " and ",
					getWhereBlockByCarInfoNo(request, hqlInfo));

			hqlInfo.setWhereBlock(whereBlock);
			hqlInfo.setOrderBy("kmCarmngDispatchersInfoList.fdDispatchersInfo.fdStartTime desc");
			if (StringUtil.isNotNull((String) request
					.getAttribute("fdStartTime"))) {
				hqlInfo.setParameter("fdStartTime", DateUtil
						.convertStringToDate((String) request
								.getAttribute("fdStartTime"),
								DateUtil.TYPE_DATETIME, Locale.getDefault()));
			}
			if (StringUtil
					.isNotNull((String) request.getAttribute("fdEndTime"))) {
				hqlInfo.setParameter("fdEndTime", DateUtil.convertStringToDate(
						(String) request.getAttribute("fdEndTime"),
						DateUtil.TYPE_DATETIME, Locale.getDefault()));
			}
			List kmCarmngDispatchersInfoList = getServiceImp(request).findList(
					hqlInfo);
			// 记录操作日志
			UserOperHelper.logFindAll(kmCarmngDispatchersInfoList,
					getServiceImp(request).getModelName());
			((IKmCarmngDispatchersInfoListService) getServiceImp(request))
					.saveExportExcel(kmCarmngDispatchersInfoList, response);
		} catch (Exception e) {
			messages.addError(e);
		}
		TimeCounter.logCurrentTime("Action-saveExportExcel", false, getClass());
	}

}
