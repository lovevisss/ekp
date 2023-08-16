package com.landray.kmss.km.carmng.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.landray.kmss.common.actions.DataAction;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.common.test.TimeCounter;
import com.landray.kmss.constant.SysAuthConstant.CheckType;
import com.landray.kmss.km.carmng.model.KmCarmngApplication;
import com.landray.kmss.km.carmng.service.IKmCarmngApplicationService;
import com.landray.kmss.km.carmng.service.IKmCarmngMotorcadeSetService;
import com.landray.kmss.sys.config.model.SysConfigParameters;
import com.landray.kmss.sys.log.util.UserOperHelper;
import com.landray.kmss.util.CriteriaUtil;
import com.landray.kmss.util.CriteriaValue;
import com.landray.kmss.util.KmssMessages;
import com.landray.kmss.util.KmssReturnPage;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.web.action.ActionForm;
import com.landray.kmss.web.action.ActionForward;
import com.landray.kmss.web.action.ActionMapping;
import com.sunbor.web.tag.Page;

import net.sf.json.JSONObject;

/**
 * 创建日期 2015/02/09
 * 
 * @author wangtf
 */

public class KmCarmngApplicationIndexAction extends DataAction {
	protected IKmCarmngApplicationService kmCarmngApplicationService;
	protected IKmCarmngMotorcadeSetService kmCarmngMotorcadeSetService;

	@Override
	protected IBaseService getCategoryServiceImp(HttpServletRequest request) {
		if (kmCarmngMotorcadeSetService == null) {
            kmCarmngMotorcadeSetService = (IKmCarmngMotorcadeSetService) getBean("kmCarmngMotorcadeSetService");
        }
		return kmCarmngMotorcadeSetService;
	}

	@Override
	protected String getParentProperty() {
		return "fdMotorcade";
	}

	@Override
	protected IBaseService getServiceImp(HttpServletRequest request) {
		if (kmCarmngApplicationService == null) {
            kmCarmngApplicationService = (IKmCarmngApplicationService) getBean("kmCarmngApplicationService");
        }
		return kmCarmngApplicationService;
	}

	public ActionForward listByDispatchers(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		TimeCounter.logCurrentTime("Action-list", true, getClass());
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
			if (!orderby.contains("kmCarmngApplication")) {
				orderby = "kmCarmngApplication." + orderby;
			}
			if (isReserve) {
                orderby += " desc";
            }
			HQLInfo hqlInfo = new HQLInfo();
			hqlInfo.setOrderBy(orderby);
			hqlInfo.setPageNo(pageno);
			hqlInfo.setRowSize(rowsize);
			// changeFindPageHQLInfo(request, hqlInfo);
			String whereStr = hqlInfo.getWhereBlock();
			StringBuilder where = new StringBuilder(
					StringUtil.isNull(whereStr) ? "1=1 " : whereStr);
			CriteriaValue cv = new CriteriaValue(request);
			where.append(" and kmCarmngApplication.docStatus='30'");
			where.append(" and kmCarmngApplication.fdIsDispatcher='1'");
			hqlInfo.setWhereBlock(where.toString());
			CriteriaUtil.buildHql(cv, hqlInfo, KmCarmngApplication.class);
			hqlInfo.setCheckParam(CheckType.AuthCheck, "attenper");
			Page page = getServiceImp(request).findPage(hqlInfo);
			// 记录操作日志
			UserOperHelper.logFindAll(page.getList(),
					getServiceImp(request).getModelName());
			request.setAttribute("queryPage", page);
		} catch (Exception e) {
			messages.addError(e);
		}

		TimeCounter.logCurrentTime("Action-list", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages)
					.addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
			return getActionForward("failure", mapping, form, request, response);
		} else {
			return getActionForward("listByDispatchers", mapping, form,
					request, response);
		}
	}

	@Override
	protected void changeFindPageHQLInfo(HttpServletRequest request,
										 HQLInfo hqlInfo) throws Exception {
		super.changeFindPageHQLInfo(request, hqlInfo);
		String whereStr = hqlInfo.getWhereBlock();
		StringBuilder where = new StringBuilder(
				StringUtil.isNull(whereStr) ? "1=1 " : whereStr);
		CriteriaValue cv = new CriteriaValue(request);
		String[] docStatus = cv.polls("docStatus");
		//fdIsDispatcher: 1-通过，2-出车，3-完成，4-待评价
		if (docStatus != null) {
			for (int j = 0; j < docStatus.length; j++) {
				if (docStatus.length > 1) {
					whereStr = hqlInfo.getWhereBlock();
					if (StringUtil.isNull(whereStr)) {
						where = new StringBuilder("1=0");
					}
					if ("10".equals(docStatus[j])) {
						where.append(" or kmCarmngApplication.docStatus='10'");
					}
					if ("20".equals(docStatus[j])) {
						where.append(" or kmCarmngApplication.docStatus='20'");
					}
					if ("11".equals(docStatus[j])) {
						where.append(" or kmCarmngApplication.docStatus='11'");
					}
					if ("00".equals(docStatus[j])) {
						where.append(" or kmCarmngApplication.docStatus='00'");
					}
					if ("30".equals(docStatus[j])) {
						where.append(" or (kmCarmngApplication.docStatus='30' and kmCarmngApplication.fdIsDispatcher='1')");
					}
					if ("31".equals(docStatus[j])) {
						where.append(" or kmCarmngApplication.fdIsDispatcher='2'");
					}
					if ("32".equals(docStatus[j])) {
						where.append(" or (kmCarmngApplication.fdIsDispatcher in ('3','4'))");
					}
					hqlInfo.setWhereBlock(where.toString());
				} else {
					docStatus[j] = docStatus[j].toLowerCase();
					if ("10".equals(docStatus[j])) {
						where.append(" and kmCarmngApplication.docStatus='10'");
					}
					if ("20".equals(docStatus[j])) {
						where.append(" and kmCarmngApplication.docStatus='20'");
					}
					if ("11".equals(docStatus[j])) {
						where.append(" and kmCarmngApplication.docStatus='11'");
					}
					if ("00".equals(docStatus[j])) {
						where.append(" and kmCarmngApplication.docStatus='00'");
					}
					if ("30".equals(docStatus[j])) {
						where.append(" and kmCarmngApplication.docStatus='30'");
						where.append(" and kmCarmngApplication.fdIsDispatcher='1'");
					}
					if ("31".equals(docStatus[j])) {
						where.append(" and kmCarmngApplication.docStatus='30'");
						where.append(" and kmCarmngApplication.fdIsDispatcher='2'");
					}
					if ("32".equals(docStatus[j])) {
						where.append(" and kmCarmngApplication.docStatus='30'");
						where.append(" and kmCarmngApplication.fdIsDispatcher in ('3','4')");
					}
				}
			}
		}
		hqlInfo.setWhereBlock(where.toString());
		CriteriaUtil.buildHql(cv, hqlInfo, KmCarmngApplication.class);
		//Page page = getServiceImp(request).findPage(hqlInfo);
		//request.setAttribute("queryPage", page);
	}

	@Override
	protected String getFindPageOrderBy(HttpServletRequest request,
										String curOrderBy) throws Exception {
		super.getFindPageOrderBy(request, curOrderBy);
		String orderby = request.getParameter("orderby");
		String ordertype = request.getParameter("ordertype");
		boolean isReserve = false;
		if (ordertype != null && "down".equalsIgnoreCase(ordertype)) {
			isReserve = true;
		}
		if (isReserve) {
            orderby += " desc";
        }
		if (orderby != null
				&& ("docStatus".endsWith(orderby) || "docStatus desc"
						.endsWith(orderby))) {
			orderby += ',' + "fdIsDispatcher desc";
		}
		return orderby;
	}
	
	public ActionForward count(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		TimeCounter.logCurrentTime("Action-count", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			HQLInfo hqlInfo = new HQLInfo();
			hqlInfo.setSelectBlock("count(*)");
			this.changeFindPageHQLInfo(request, hqlInfo);
			String mobile = request.getParameter("mobile");
			if ("true".equals(mobile)){
				String docStatus = request.getParameter("docStatus");
				String fdIsDispatcher = request.getParameter("fdIsDispatcher");
				if (StringUtil.isNotNull(docStatus) && StringUtil.isNotNull(fdIsDispatcher)){
					String whereStr = hqlInfo.getWhereBlock();
					whereStr = whereStr +" and kmCarmngApplication.docStatus='"+docStatus+"' ";
					whereStr = whereStr +" and kmCarmngApplication.fdIsDispatcher='"+fdIsDispatcher+"' ";
					hqlInfo.setWhereBlock(whereStr);
				}
			}
			hqlInfo.setOrderBy(null);
			@SuppressWarnings("unchecked")
			Page page = getServiceImp(request).findPage(hqlInfo);
			request.setAttribute("lui-source",
					new JSONObject().element("count", page.getTotalrows()));
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