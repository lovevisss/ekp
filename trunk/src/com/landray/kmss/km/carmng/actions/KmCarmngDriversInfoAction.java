package com.landray.kmss.km.carmng.actions;

import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.landray.kmss.web.action.ActionForm;
import com.landray.kmss.web.action.ActionMapping;

import com.landray.kmss.common.actions.ExtendAction;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.km.carmng.forms.KmCarmngDriversInfoForm;
import com.landray.kmss.km.carmng.model.KmCarmngDriversInfo;
import com.landray.kmss.km.carmng.model.KmCarmngMotorcadeSet;
import com.landray.kmss.km.carmng.service.IKmCarmngDriversInfoService;
import com.landray.kmss.km.carmng.service.IKmCarmngMotorcadeSetService;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.util.CriteriaUtil;
import com.landray.kmss.util.CriteriaValue;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.util.UserUtil;

/**
 * 创建日期 2010-三月-24
 * 
 * @author 黄郴
 */
public class KmCarmngDriversInfoAction extends ExtendAction

{
	protected IKmCarmngDriversInfoService kmCarmngDriversInfoService;

	@Override
	protected IBaseService getServiceImp(HttpServletRequest request) {
		if (kmCarmngDriversInfoService == null) {
            kmCarmngDriversInfoService = (IKmCarmngDriversInfoService) getBean("kmCarmngDriversInfoService");
        }
		return kmCarmngDriversInfoService;
	}

	private IKmCarmngMotorcadeSetService kmCarmngMotorcadeSetService;

	public IKmCarmngMotorcadeSetService getKmCarmngMotorcadeSetService() {
		if (kmCarmngMotorcadeSetService == null) {
			kmCarmngMotorcadeSetService = (IKmCarmngMotorcadeSetService) getBean("kmCarmngMotorcadeSetService");
		}
		return this.kmCarmngMotorcadeSetService;
	}

	@Override
	protected ActionForm createNewForm(ActionMapping mapping, ActionForm form,
									   HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		super.createNewForm(mapping, form, request, response);
		String motorcadeId = request.getParameter("motorcadeId");
		KmCarmngDriversInfoForm kmCarmngDriversInfoForm = (KmCarmngDriversInfoForm) form;
		if (StringUtil.isNotNull(motorcadeId)) {
			KmCarmngMotorcadeSet kmCarmngMotorcadeSet = (KmCarmngMotorcadeSet) getKmCarmngMotorcadeSetService()
					.findByPrimaryKey(motorcadeId);
			if (kmCarmngMotorcadeSet != null) {
				kmCarmngDriversInfoForm.setFdMotorcadeId(kmCarmngMotorcadeSet.getFdId());
				kmCarmngDriversInfoForm.setFdMotorcadeName(kmCarmngMotorcadeSet.getFdName());
			}
		}
		SysOrgElement person = UserUtil.getUser();
		kmCarmngDriversInfoForm.setDocCreatorId(person.getFdId());
		kmCarmngDriversInfoForm.setDocCreatorName(person.getFdName());
		kmCarmngDriversInfoForm.setDocCreateTime(DateUtil.convertDateToString(
				new Date(), DateUtil.TYPE_DATETIME, Locale.getDefault()));
		return kmCarmngDriversInfoForm;
	}

	@Override
	protected void loadActionForm(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		super.loadActionForm(mapping, form, request, response);
		KmCarmngDriversInfoForm kmCarmngDriversInfoForm = (KmCarmngDriversInfoForm) form;
		if (StringUtil.isNotNull(kmCarmngDriversInfoForm.getFdValidTime())) {
			kmCarmngDriversInfoForm.setFdValidTime(kmCarmngDriversInfoForm
					.getFdValidTime().substring(0, 10));
		}
		if (StringUtil.isNotNull(kmCarmngDriversInfoForm
				.getFdAnnualAuditingTime())) {
			kmCarmngDriversInfoForm
					.setFdAnnualAuditingTime(kmCarmngDriversInfoForm
							.getFdAnnualAuditingTime().substring(0, 10));
		}
		if (StringUtil
				.isNotNull(kmCarmngDriversInfoForm.getFdCredentialsTime())) {
			kmCarmngDriversInfoForm
					.setFdCredentialsTime(kmCarmngDriversInfoForm
							.getFdCredentialsTime().substring(0, 10));

		}
	}
	@Override
	protected void changeFindPageHQLInfo(HttpServletRequest request,
										 HQLInfo hqlInfo) throws Exception {
		super.changeFindPageHQLInfo(request, hqlInfo);
		CriteriaValue cv = new CriteriaValue(request);
		CriteriaUtil.buildHql(cv, hqlInfo, KmCarmngDriversInfo.class);
		String where = "";
		// 按车队
		String motorcadeId = request.getParameter("motorcadeId");
		if (StringUtil.isNotNull(motorcadeId)) {
			where = StringUtil.linkString(hqlInfo.getWhereBlock(), " and ", " fdMotorcade.fdId=:motorcadeId ");
			hqlInfo.setWhereBlock(where);
			hqlInfo.setParameter("motorcadeId", motorcadeId);
		}
		// 按标题查询
		String fdName = request.getParameter("fdSearchName");
		if(StringUtil.isNull(fdName)){
			fdName = cv.poll("fdSearchName");
		}
		if (StringUtil.isNotNull(fdName)) {
			where = StringUtil.linkString(hqlInfo.getWhereBlock(), " and ", " fdName like :fdName ");
			hqlInfo.setWhereBlock(where);
			hqlInfo.setParameter("fdName", "%" + fdName + "%");
		}
	}
		
}
