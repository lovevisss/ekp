package com.landray.kmss.km.carmng.actions;

import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.landray.kmss.common.actions.ExtendAction;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.common.test.TimeCounter;
import com.landray.kmss.km.carmng.forms.KmCarmngEvaluationForm;
import com.landray.kmss.km.carmng.model.KmCarmngEvaluation;
import com.landray.kmss.km.carmng.service.IKmCarmngEvaluationService;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.util.CriteriaUtil;
import com.landray.kmss.util.CriteriaValue;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.KmssMessages;
import com.landray.kmss.util.KmssReturnPage;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.util.UserUtil;
import com.landray.kmss.web.action.ActionForm;
import com.landray.kmss.web.action.ActionForward;
import com.landray.kmss.web.action.ActionMapping;

import net.sf.json.JSONObject;

public class KmCarmngEvaluationAction extends ExtendAction

{
	protected IKmCarmngEvaluationService kmCarmngEvaluationService;

	@Override
	protected IBaseService getServiceImp(HttpServletRequest request) {
		if (kmCarmngEvaluationService == null) {
            kmCarmngEvaluationService = (IKmCarmngEvaluationService) getBean("kmCarmngEvaluationService");
        }
		return kmCarmngEvaluationService;
	}

	@Override
	protected ActionForm createNewForm(ActionMapping mapping, ActionForm form, HttpServletRequest request,
									   HttpServletResponse response) throws Exception {
		super.createNewForm(mapping, form, request, response);
		String fdApplicationId = request.getParameter("fdAppId");
		KmCarmngEvaluationForm kmCarmngEvaluationForm = (KmCarmngEvaluationForm) form;
		SysOrgElement person = UserUtil.getUser();
		kmCarmngEvaluationForm.setFdApplicationId(fdApplicationId);
		kmCarmngEvaluationForm.setFdEvaluatorId(person.getFdId());
		kmCarmngEvaluationForm.setFdEvaluatorName(person.getFdName());
		kmCarmngEvaluationForm.setFdEvaluationTime(
				DateUtil.convertDateToString(new Date(), DateUtil.TYPE_DATETIME, Locale.getDefault()));
		return kmCarmngEvaluationForm;
	}

	@Override
	protected void changeFindPageHQLInfo(HttpServletRequest request, HQLInfo hqlInfo) throws Exception {
		super.changeFindPageHQLInfo(request, hqlInfo);

		CriteriaValue cv = new CriteriaValue(request);
		CriteriaUtil.buildHql(cv, hqlInfo, KmCarmngEvaluation.class);
		String fdAppName = cv.poll("fdAppName");
		if (StringUtil.isNotNull(fdAppName)) {
			String where = hqlInfo.getWhereBlock();
			where = StringUtil.linkString(where, " and ",
					" kmCarmngEvaluation.fdApplication.docSubject like :fdAppName");
			hqlInfo.setParameter("fdAppName", "%" + fdAppName.trim() + "%");
			hqlInfo.setWhereBlock(where);
		}
	}

	public ActionForward count(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		TimeCounter.logCurrentTime("Action-count", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			HQLInfo hqlInfo = new HQLInfo();
			hqlInfo.setSelectBlock("count(*)");
			this.changeFindPageHQLInfo(request, hqlInfo);
			hqlInfo.setOrderBy(null);
			@SuppressWarnings("unchecked")
			List<Object> list = getServiceImp(request).findList(hqlInfo);
			request.setAttribute("lui-source", new JSONObject().element("count", list.get(0)));
		} catch (Exception e) {
			messages.addError(e);
		}
		TimeCounter.logCurrentTime("Action-count", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages).addButton(KmssReturnPage.BUTTON_CLOSE)
					.save(request);
			return getActionForward("failure", mapping, form, request, response);
		} else {
			return getActionForward("lui-source", mapping, form, request, response);
		}
	}
}
