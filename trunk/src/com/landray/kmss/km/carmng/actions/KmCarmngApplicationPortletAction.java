package com.landray.kmss.km.carmng.actions;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.landray.kmss.common.actions.ExtendAction;
import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.test.TimeCounter;
import com.landray.kmss.km.carmng.service.IKmCarmngApplicationService;
import com.landray.kmss.sys.log.util.UserOperHelper;
import com.landray.kmss.util.KmssMessages;
import com.landray.kmss.util.KmssReturnPage;
import com.landray.kmss.web.action.ActionForm;
import com.landray.kmss.web.action.ActionForward;
import com.landray.kmss.web.action.ActionMapping;

/**
 * 创建日期 2013-11-16
 * 
 * @author 朱湖强
 */
public class KmCarmngApplicationPortletAction extends ExtendAction {
	protected IKmCarmngApplicationService kmCarmngApplicationService;

	@Override
	protected IKmCarmngApplicationService
			getServiceImp(HttpServletRequest request) {
		if (kmCarmngApplicationService == null) {
            kmCarmngApplicationService = (IKmCarmngApplicationService) getBean("kmCarmngApplicationService");
        }
		return kmCarmngApplicationService;
	}

	public ActionForward listPortlet(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-listPortlet", true, getClass());
		KmssMessages messages = new KmssMessages();
		RequestContext requestCtx = new RequestContext(request);
		Map<String, ?> rtnMap = null;
		try {
			rtnMap = getServiceImp(request).listPortlet(requestCtx);
		} catch (Exception e) {
			messages.addError(e);
		}
		TimeCounter.logCurrentTime("Action-listPortlet", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages)
					.addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
			UserOperHelper.setOperSuccess(false);
			return getActionForward("failure", mapping, form, request, response);
		} else {
			String dataview = request.getParameter("dataview");
			if ("classic".equals(dataview)) {// 视图展现方式:classic(简单列表)
				request.setAttribute("lui-source", rtnMap.get("datas"));
				UserOperHelper.setOperSuccess(true);
				return getActionForward("lui-source", mapping, form, request,
						response);
			} else {// 视图展现方式:listtable(列表)
				request.setAttribute("queryPage", rtnMap.get("page"));
				return getActionForward("listPortlet", mapping, form, request,
						response);
			}
		}
	}

}
