package com.landray.kmss.km.carmng.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.landray.kmss.common.actions.ExtendAction;
import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.km.carmng.forms.KmCarmngDispatchersLogForm;
import com.landray.kmss.km.carmng.model.KmCarmngDispatchersLog;
import com.landray.kmss.km.carmng.service.IKmCarmngDispatchersLogService;
import com.landray.kmss.sys.config.model.SysConfigParameters;
import com.landray.kmss.sys.log.util.UserOperHelper;
import com.landray.kmss.util.HQLHelper;
import com.landray.kmss.util.KmssMessages;
import com.landray.kmss.util.KmssReturnPage;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.web.action.ActionForm;
import com.landray.kmss.web.action.ActionForward;
import com.landray.kmss.web.action.ActionMapping;
import com.sunbor.web.tag.Page;

public class KmCarmngDispatchersLogAction extends ExtendAction {

	private IKmCarmngDispatchersLogService kmCarmngDispatchersLogService;

	@Override
	public IBaseService getServiceImp(HttpServletRequest request) {
		if (kmCarmngDispatchersLogService == null) {
			kmCarmngDispatchersLogService = (IKmCarmngDispatchersLogService) getBean("kmCarmngDispatchersLogService");
		}
		return kmCarmngDispatchersLogService;
	}

	@Override
	public void changeFindPageHQLInfo(HttpServletRequest request, HQLInfo hqlInfo) throws Exception {
		HQLHelper.by(request).buildHQLInfo(hqlInfo, KmCarmngDispatchersLog.class);
		hqlInfo.setOrderBy(getFindPageOrderBy(request, hqlInfo.getOrderBy()));
	}

	@Override
	public ActionForm createNewForm(ActionMapping mapping, ActionForm form, HttpServletRequest request,
									HttpServletResponse response) throws Exception {
		KmCarmngDispatchersLogForm kmCarmngDispatchersLogForm = (KmCarmngDispatchersLogForm) super.createNewForm(
				mapping, form, request, response);
		((IKmCarmngDispatchersLogService) getServiceImp(request)).initFormSetting((IExtendForm) form,
				new RequestContext(request));
		return kmCarmngDispatchersLogForm;
	}

	public ActionForward getDispatchersLog(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) {
		KmssMessages messages = new KmssMessages();
		try {
			String fdId = request.getParameter("fdId");
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
			String whereBlock = "1=1";
			if (StringUtil.isNotNull(fdId)) {
				whereBlock += " and kmCarmngDispatchersLog.fdDispatchersId =:fdId";
				hqlInfo.setParameter("fdId", fdId);
			} else {
				whereBlock += " and 1=2";
			}
			hqlInfo.setOrderBy(" kmCarmngDispatchersLog.fdDispatchersTime desc");
			hqlInfo.setWhereBlock(whereBlock);
			Page page = getServiceImp(request).findPage(hqlInfo);
			// 添加日志信息
			UserOperHelper.logFindAll(page.getList(), getServiceImp(request).getModelName());
			request.setAttribute("queryPage", page);
		} catch (Exception e) {
			e.printStackTrace();
			messages.addError(e);
		}
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages).addButton(KmssReturnPage.BUTTON_CLOSE)
					.save(request);
			return getActionForward("failure", mapping, form, request, response);
		} else {
			return getActionForward("dispatchersLog", mapping, form, request, response);
		}

	}
}
