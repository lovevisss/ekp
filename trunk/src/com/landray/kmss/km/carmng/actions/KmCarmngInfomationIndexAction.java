package com.landray.kmss.km.carmng.actions;

import com.landray.kmss.common.actions.DataAction;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.common.test.TimeCounter;
import com.landray.kmss.km.carmng.model.KmCarmngInfomation;
import com.landray.kmss.km.carmng.service.IKmCarmngInfomationService;
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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 创建日期 2015/02/09
 * 
 * @author wangtf
 */

public class KmCarmngInfomationIndexAction extends DataAction {
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
		CriteriaUtil.buildHql(cv, hqlInfo, KmCarmngInfomation.class);
		buildHomeZoneHql(cv, hqlInfo, request);
		String where = hqlInfo.getWhereBlock();
		// 按车队
		String motorcadeId = request.getParameter("motorcadeId");
		if (StringUtil.isNotNull(motorcadeId)) {
			where = StringUtil.linkString(where, " and ", " fdMotorcade.fdId=:motorcadeId ");
			hqlInfo.setWhereBlock(where);
			hqlInfo.setParameter("motorcadeId", motorcadeId);
		}
		hqlInfo.setOrderBy(orderby);
		Page page = getServiceImp(request).findPage(hqlInfo);
		request.setAttribute("queryPage", page);
	}

	private void buildHomeZoneHql(CriteriaValue cv, HQLInfo hqlInfo,
			HttpServletRequest request) {
		String whereStr = hqlInfo.getWhereBlock();
		StringBuilder where = new StringBuilder(
				StringUtil.isNull(whereStr) ? "1=1 " : whereStr);
		hqlInfo.setWhereBlock(where.toString());
	}
	
	public ActionForward count(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		TimeCounter.logCurrentTime("Action-count", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			HQLInfo hqlInfo = new HQLInfo();
			hqlInfo.setSelectBlock("count(*)");
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