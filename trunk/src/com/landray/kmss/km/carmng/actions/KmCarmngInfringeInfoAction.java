package com.landray.kmss.km.carmng.actions;

import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.landray.kmss.web.action.ActionForm;
import com.landray.kmss.web.action.ActionForward;
import com.landray.kmss.web.action.ActionMapping;

import com.landray.kmss.common.actions.ExtendAction;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.common.test.TimeCounter;
import com.landray.kmss.km.carmng.forms.KmCarmngInfringeInfoForm;
import com.landray.kmss.km.carmng.service.IKmCarmngInfringeInfoService;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.KmssMessages;
import com.landray.kmss.util.KmssReturnPage;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.util.UserUtil;

/**
 * 创建日期 2010-三月-24
 * 
 * @author 叶中奇
 */
public class KmCarmngInfringeInfoAction extends ExtendAction

{
	protected IKmCarmngInfringeInfoService kmCarmngInfringeInfoService;

	@Override
	protected IBaseService getServiceImp(HttpServletRequest request) {
		if (kmCarmngInfringeInfoService == null) {
            kmCarmngInfringeInfoService = (IKmCarmngInfringeInfoService) getBean("kmCarmngInfringeInfoService");
        }
		return kmCarmngInfringeInfoService;
	}

	@Override
	protected ActionForm createNewForm(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		super.createNewForm(mapping, form, request, response);
		KmCarmngInfringeInfoForm kmCarmngInfringeInfoForm = (KmCarmngInfringeInfoForm) form;
		SysOrgElement person = UserUtil.getUser();
		kmCarmngInfringeInfoForm.setDocCreateTime(DateUtil.convertDateToString(
				new Date(), DateUtil.TYPE_DATETIME, Locale.getDefault()));

		// 车牌号码
		String fdId = request.getParameter("fdCarId");
		if (StringUtil.isNotNull(fdId)) {
            kmCarmngInfringeInfoForm.setFdVehiclesInfoId(fdId);
        }
		String fdNo = request.getParameter("fdNo");
		if (StringUtil.isNotNull(fdNo)) {
            kmCarmngInfringeInfoForm.setFdVehiclesInfoNo(fdNo);
        }
		// 车辆类型
		String fdVehichesType = request.getParameter("fdVehichesType");
		if (StringUtil.isNotNull(fdVehichesType)) {
            kmCarmngInfringeInfoForm.setFdVehiclesCategoryName(fdVehichesType);
        }
		// 车辆名称
		String docSubject = request.getParameter("docSubject");
		if (StringUtil.isNotNull(docSubject)) {
            kmCarmngInfringeInfoForm.setFdVehiclesInfoName(docSubject);
        }
		// 违章人
		String fdDriverId = request.getParameter("fdDriverId");
		if (StringUtil.isNotNull(fdDriverId)) {
            kmCarmngInfringeInfoForm.setFdInfringePersonId(fdDriverId);
        }
		String fdDriverName = request.getParameter("fdDriverName");
		if (StringUtil.isNotNull(fdDriverName)) {
            kmCarmngInfringeInfoForm.setFdInfringePersonName(fdDriverName);
        }

		kmCarmngInfringeInfoForm.setDocCreatorId(person.getFdId());
		kmCarmngInfringeInfoForm.setDocCreatorName(person.getFdName());
		return kmCarmngInfringeInfoForm;
	}

	public ActionForward count(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-count", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			HQLInfo hqlInfo = new HQLInfo();
			List valueList = ((IKmCarmngInfringeInfoService) getServiceImp(request))
					.count(request);
			request.setAttribute("valueList", valueList);
			request.setAttribute("valueListSize", valueList.size());
		} catch (Exception e) {
			messages.addError(e);
		}

		TimeCounter.logCurrentTime("Action-count", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages)
					.addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
			return getActionForward("failure", mapping, form, request, response);
		} else {
			return getActionForward("count", mapping, form, request, response);
		}
	}

	public void saveExportExcel(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-saveExportExcel", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			HQLInfo hqlInfo = new HQLInfo();
			List valueList = ((IKmCarmngInfringeInfoService) getServiceImp(request))
					.count(request);
			((IKmCarmngInfringeInfoService) getServiceImp(request))
					.saveExportExcel(valueList, response, request);
		} catch (Exception e) {
			messages.addError(e);
		}
		TimeCounter.logCurrentTime("Action-saveExportExcel", false, getClass());
	}

	@Override
	protected void changeFindPageHQLInfo(HttpServletRequest request,
										 HQLInfo hqlInfo) throws Exception {
		String fdCarId = request.getParameter("fdCarId");
		String whereBlock = super.getFindPageWhereBlock(request);
		if (StringUtil.isNotNull(fdCarId)) {
			if (StringUtil.isNotNull(whereBlock)) {
				whereBlock = whereBlock + " and "
						+ "kmCarmngInfringeInfo.fdVehiclesInfo.fdId = :fdCarId";

			} else {
				whereBlock = "kmCarmngInfringeInfo.fdVehiclesInfo.fdId = :fdCarId";
			}
			hqlInfo.setParameter("fdCarId", fdCarId);
		}
		hqlInfo.setWhereBlock(whereBlock);
	}

}
