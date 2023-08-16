
package com.landray.kmss.km.carmng.actions;

import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.landray.kmss.common.actions.ExtendAction;
import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.exception.NoRecordException;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.km.carmng.forms.KmCarmngRegisterInfoForm;
import com.landray.kmss.km.carmng.model.KmCarmngDispatchersInfoList;
import com.landray.kmss.km.carmng.model.KmCarmngRegisterInfo;
import com.landray.kmss.km.carmng.service.IKmCarmngDispatchersInfoListService;
import com.landray.kmss.km.carmng.service.IKmCarmngDispatchersInfoService;
import com.landray.kmss.km.carmng.service.IKmCarmngRegisterInfoService;
import com.landray.kmss.sys.log.util.UserOperHelper;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.util.UserUtil;
import com.landray.kmss.web.action.ActionForm;
import com.landray.kmss.web.action.ActionForward;
import com.landray.kmss.web.action.ActionMapping;


/**
 * 创建日期 2010-三月-24
 * @author 叶中奇
 */
public class KmCarmngRegisterInfoAction extends ExtendAction
{
	protected IKmCarmngRegisterInfoService kmCarmngRegisterInfoService;

	@Override
	protected IBaseService getServiceImp(HttpServletRequest request) {
		if(kmCarmngRegisterInfoService == null) {
            kmCarmngRegisterInfoService = (IKmCarmngRegisterInfoService)getBean("kmCarmngRegisterInfoService");
        }
		return kmCarmngRegisterInfoService;
	}
	
	protected IKmCarmngDispatchersInfoService  kmCarmngDispatchersInfoService;
	
	protected IKmCarmngDispatchersInfoListService kmCarmngDispatchersInfoListService;

	public IKmCarmngDispatchersInfoService getKmCarmngDispatchersInfoService() {
		if(kmCarmngDispatchersInfoService == null){
			kmCarmngDispatchersInfoService = (IKmCarmngDispatchersInfoService)getBean("kmCarmngDispatchersInfoService");
		}
		return this.kmCarmngDispatchersInfoService;
	}

	public IKmCarmngDispatchersInfoListService getKmCarmngDispatchersInfoListService() {
		if (kmCarmngDispatchersInfoListService == null) {
			kmCarmngDispatchersInfoListService = (IKmCarmngDispatchersInfoListService) getBean(
					"kmCarmngDispatchersInfoListService");
		}
		return this.kmCarmngDispatchersInfoListService;
	}

	public Double getFdMileageEndNumber(HttpServletRequest request,
			String fdCarId) throws Exception {
		HQLInfo hqlInfo = new HQLInfo();
		hqlInfo.setSelectBlock("kmCarmngRegisterInfo.fdMileageEndNumber");
		hqlInfo.setJoinBlock(
				"inner join kmCarmngRegisterInfo.fdDispatchInfoList kmCarmngDispatchersInfoList");
		hqlInfo.setWhereBlock(
				"kmCarmngDispatchersInfoList.fdCarInfo.fdId=:fdCarId");
		hqlInfo.setOrderBy("kmCarmngRegisterInfo.fdRegisterTime desc");
		hqlInfo.setParameter("fdCarId", fdCarId);
		List list = getServiceImp(request).findList(hqlInfo);
		if (list != null && !list.isEmpty()) {
            return (Double) list.get(0);
        }
		return new Double(0);
	}

	@Override
	protected ActionForm createNewForm(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		 KmCarmngRegisterInfoForm  kmCarmngRegisterInfoForm = (KmCarmngRegisterInfoForm) form;
		String fdDispatchInfoListId = request.getParameter("fdDispatchInfoListId");
		if (StringUtil.isNotNull(fdDispatchInfoListId)) {
			HQLInfo hql = new HQLInfo();
			hql.setWhereBlock("kmCarmngRegisterInfo.fdDispatchInfoList.fdId = :fdDispatchInfoListId");
			hql.setParameter("fdDispatchInfoListId", fdDispatchInfoListId);
			List registerInfoList = getServiceImp(request).findList(hql);

			if(registerInfoList.size()>0){
				KmCarmngRegisterInfo kmCarmngRegisterInfo = (KmCarmngRegisterInfo)registerInfoList.get(0);
				kmCarmngRegisterInfoForm = (KmCarmngRegisterInfoForm) getServiceImp(request).convertModelToForm(
						kmCarmngRegisterInfoForm, kmCarmngRegisterInfo, new RequestContext(request));
				request.setAttribute("actionMethod", "update");
			}else{
			
			super.createNewForm(mapping, form, request, response);
			KmCarmngDispatchersInfoList kmCarmngDispatchersInfoList = (KmCarmngDispatchersInfoList) getKmCarmngDispatchersInfoListService()
					.findByPrimaryKey(fdDispatchInfoListId);
			if (kmCarmngDispatchersInfoList != null) {
				kmCarmngRegisterInfoForm.setFdCarInfoNo(kmCarmngDispatchersInfoList.getFdCarInfoNo());
				kmCarmngRegisterInfoForm.setFdMotorcadeId(kmCarmngDispatchersInfoList.getFdMotorcadeId());
				kmCarmngRegisterInfoForm.setFdMotorcadeName(kmCarmngDispatchersInfoList.getFdMotorcadeName());
				kmCarmngRegisterInfoForm.setFdDriverId(kmCarmngDispatchersInfoList.getFdDriverId());
				kmCarmngRegisterInfoForm.setFdDriversName(kmCarmngDispatchersInfoList.getFdDriverName());
				Double fdMileageEndNumber = getFdMileageEndNumber(request,
						kmCarmngDispatchersInfoList.getFdCarInfo()
								.getFdId());
				kmCarmngRegisterInfoForm.setFdMileageStartNumber(
						String.valueOf(fdMileageEndNumber));
			}

				kmCarmngRegisterInfoForm.setFdDispatchInfoListId(fdDispatchInfoListId);
				kmCarmngRegisterInfoForm.setFdStartTime(DateUtil.convertDateToString(
						kmCarmngDispatchersInfoList.getFdDispatchersInfo().getFdStartTime(), DateUtil.TYPE_DATETIME,
						Locale.getDefault()));
				kmCarmngRegisterInfoForm.setFdEndTime(
						DateUtil.convertDateToString(kmCarmngDispatchersInfoList.getFdDispatchersInfo().getFdEndTime(),
								DateUtil.TYPE_DATETIME, Locale.getDefault()));
				SysOrgElement person = UserUtil.getUser();
				kmCarmngRegisterInfoForm.setFdRegisterId(person.getFdId());
				kmCarmngRegisterInfoForm.setFdRegisterName(person.getFdName());
				kmCarmngRegisterInfoForm.setFdRegisterTime(
						DateUtil.convertDateToString(new Date(), DateUtil.TYPE_DATETIME, Locale.getDefault()));
				request.setAttribute("actionMethod", "save");
			}
		}
		 return kmCarmngRegisterInfoForm;
	}
	
	@Override
	protected void loadActionForm(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		form.reset(mapping, request);
		IExtendForm rtnForm = null;
		String id = request.getParameter("fdId");
		String fdDispatcherId = request.getParameter("fdDispatcherId");
		if (!StringUtil.isNull(id) ) {
			IBaseModel model = getServiceImp(request).findByPrimaryKey(id,
					null, true);
			if (model != null) {
				rtnForm = getServiceImp(request).convertModelToForm(
						(IExtendForm) form, model, new RequestContext(request));
				UserOperHelper.logFind(model);
			}
		}
		if (!StringUtil.isNull(fdDispatcherId) ) {
			List<KmCarmngRegisterInfo> valueList = getServiceImp(request).findList("kmCarmngRegisterInfo.fdDispatchers.fdId='"+fdDispatcherId+"'", null);
			if(!valueList.isEmpty()){
				IBaseModel model	= valueList.get(0);
				if (model != null) {
                    rtnForm = getServiceImp(request).convertModelToForm(
                            (IExtendForm) form, model, new RequestContext(request));
                }
			}			
		}
		if (rtnForm == null) {
            throw new NoRecordException();
        }
		request.setAttribute(getFormName(rtnForm, request), rtnForm);
	}

	@Override
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		KmCarmngRegisterInfoForm infoForm = (KmCarmngRegisterInfoForm) form;
		String fdDispatchInfoListId = infoForm.getFdDispatchInfoListId();
		HQLInfo hql = new HQLInfo();
		hql.setWhereBlock(
				"kmCarmngRegisterInfo.fdDispatchInfoList.fdId = :fdDispatchInfoListId");
		hql.setParameter("fdDispatchInfoListId", fdDispatchInfoListId);
		List registerInfoList = getServiceImp(request).findList(hql);
		if (registerInfoList.size() > 0) {
			KmCarmngRegisterInfo kmCarmngRegisterInfo = (KmCarmngRegisterInfo) registerInfoList
					.get(0);
			infoForm.setFdId(kmCarmngRegisterInfo.getFdId());
			return super.update(mapping, infoForm, request, response);
		} else {
			return super.save(mapping, form, request, response);
		}
	}
}

