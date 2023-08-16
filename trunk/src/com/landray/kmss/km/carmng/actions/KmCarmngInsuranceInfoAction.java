
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
import com.landray.kmss.km.carmng.forms.KmCarmngInsuranceInfoForm;
import com.landray.kmss.km.carmng.service.IKmCarmngInsuranceInfoService;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.util.UserUtil;


/**
 * 创建日期 2010-三月-24
 * @author 叶中奇
 */
public class KmCarmngInsuranceInfoAction extends ExtendAction

{
	protected IKmCarmngInsuranceInfoService kmCarmngInsuranceInfoService;

	@Override
	protected IBaseService getServiceImp(HttpServletRequest request) {
		if(kmCarmngInsuranceInfoService == null) {
            kmCarmngInsuranceInfoService = (IKmCarmngInsuranceInfoService)getBean("kmCarmngInsuranceInfoService");
        }
		return kmCarmngInsuranceInfoService;
	}
	@Override
	protected ActionForm createNewForm(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		 super.createNewForm(mapping, form, request, response);
		 KmCarmngInsuranceInfoForm  kmCarmngInsuranceInfoForm  = (KmCarmngInsuranceInfoForm) form;
		 kmCarmngInsuranceInfoForm.setDocCreateTime(DateUtil.convertDateToString(new Date(), DateUtil.TYPE_DATETIME,Locale.getDefault()));
		 SysOrgElement person = UserUtil.getUser();
		 kmCarmngInsuranceInfoForm.setDocCreatorId(person.getFdId());
		 kmCarmngInsuranceInfoForm.setDocCreatorName(person.getFdName());
		 
		//车牌号码
		 String fdId = request.getParameter("fdCarId");
			if(StringUtil.isNotNull(fdId)) {
                kmCarmngInsuranceInfoForm.setFdVehiclesInfoId(fdId);
            }
		String fdNo = request.getParameter("fdNo");
		if(StringUtil.isNotNull(fdNo)) {
            kmCarmngInsuranceInfoForm.setFdVehiclesInfoNo(fdNo);
        }
		//车辆类型
		String fdVehichesType = request.getParameter("fdVehichesType");
		if(StringUtil.isNotNull(fdVehichesType)) {
            kmCarmngInsuranceInfoForm.setFdVehiclesCategoryName(fdVehichesType);
        }
		//车辆名称
		String docSubject = request.getParameter("docSubject");
		if(StringUtil.isNotNull(docSubject)) {
            kmCarmngInsuranceInfoForm.setFdVehiclesInfoName(docSubject);
        }
			
		 return kmCarmngInsuranceInfoForm;
	}
	
	@Override
	protected void changeFindPageHQLInfo(HttpServletRequest request,
										 HQLInfo hqlInfo) throws Exception {
		String fdCarId = request.getParameter("fdCarId");
		String whereBlock = super.getFindPageWhereBlock(request);
		if(StringUtil.isNotNull(fdCarId)){			
			if(StringUtil.isNotNull(whereBlock)){
				whereBlock = whereBlock + " and " + "kmCarmngInsuranceInfo.fdVehiclesInfo.fdId = :fdCarId";
			}else{
				whereBlock = "kmCarmngInsuranceInfo.fdVehiclesInfo.fdId = :fdCarId";
			}
			hqlInfo.setParameter("fdCarId", fdCarId);
		}
		hqlInfo.setWhereBlock(whereBlock);
	}
	
}

