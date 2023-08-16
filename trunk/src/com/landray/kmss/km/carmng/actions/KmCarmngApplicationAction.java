package com.landray.kmss.km.carmng.actions;

import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.ArrayUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.landray.kmss.common.actions.ExtendAction;
import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.dao.HQLWrapper;
import com.landray.kmss.common.exception.NoRecordException;
import com.landray.kmss.common.exception.UnexpectedRequestException;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.common.service.ICoreOuterService;
import com.landray.kmss.common.test.TimeCounter;
import com.landray.kmss.constant.SysDocConstant;
import com.landray.kmss.km.carmng.forms.KmCarmngApplicationForm;
import com.landray.kmss.km.carmng.model.KmCarmngApplication;
import com.landray.kmss.km.carmng.model.KmCarmngApplicationConfig;
import com.landray.kmss.km.carmng.model.KmCarmngDispatchersInfo;
import com.landray.kmss.km.carmng.model.KmCarmngEvaluation;
import com.landray.kmss.km.carmng.model.KmCarmngMotorcadeSet;
import com.landray.kmss.km.carmng.model.KmCarmngPath;
import com.landray.kmss.km.carmng.service.IKmCarmngApplicationService;
import com.landray.kmss.km.carmng.service.IKmCarmngDispatchersInfoService;
import com.landray.kmss.km.carmng.service.IKmCarmngEvaluationService;
import com.landray.kmss.km.carmng.service.IKmCarmngMotorcadeSetService;
import com.landray.kmss.km.carmng.service.IKmCarmngRegisterInfoService;
import com.landray.kmss.sys.authorization.constant.ISysAuthConstant;
import com.landray.kmss.sys.authorization.interfaces.SysAuthAreaUtils;
import com.landray.kmss.sys.log.util.UserOperHelper;
import com.landray.kmss.sys.organization.interfaces.ISysOrgCoreService;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.sys.workflow.interfaces.SysFlowUtil;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.HQLUtil;
import com.landray.kmss.util.HtmlToMht;
import com.landray.kmss.util.KmssMessage;
import com.landray.kmss.util.KmssMessages;
import com.landray.kmss.util.KmssReturnPage;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.util.UserUtil;
import com.landray.kmss.web.action.ActionForm;
import com.landray.kmss.web.action.ActionForward;
import com.landray.kmss.web.action.ActionMapping;
import com.sunbor.web.tag.Page;

import edu.emory.mathcs.backport.java.util.Arrays;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 创建日期 2010-三月-24
 * 
 * @author 黄郴
 */
public class KmCarmngApplicationAction extends ExtendAction

{
	protected IKmCarmngApplicationService kmCarmngApplicationService;


	@Override
	protected IKmCarmngApplicationService getServiceImp(
			HttpServletRequest request) {
		if (kmCarmngApplicationService == null) {
            kmCarmngApplicationService = (IKmCarmngApplicationService) getBean("kmCarmngApplicationService");
        }
		return kmCarmngApplicationService;
	}

	private ICoreOuterService dispatchCoreService;

	protected ICoreOuterService getDispatchCoreService() {
		if (dispatchCoreService == null) {
			dispatchCoreService = (ICoreOuterService) getBean("dispatchCoreService");
		}
		return dispatchCoreService;
	}

	protected IKmCarmngMotorcadeSetService kmCarmngMotorcadeSetService;

	public IKmCarmngMotorcadeSetService getKmCarmngMotorcadeSetService() {
		if (kmCarmngMotorcadeSetService == null) {
			kmCarmngMotorcadeSetService = (IKmCarmngMotorcadeSetService) getBean("kmCarmngMotorcadeSetService");
		}
		return kmCarmngMotorcadeSetService;
	}

	protected IKmCarmngDispatchersInfoService kmCarmngDispatchersInfoService;

	public IKmCarmngDispatchersInfoService getKmCarmngDispatchersInfoService() {
		if (kmCarmngDispatchersInfoService == null) {
			kmCarmngDispatchersInfoService = (IKmCarmngDispatchersInfoService) getBean("kmCarmngDispatchersInfoService");
		}
		return kmCarmngDispatchersInfoService;
	}

	protected IKmCarmngEvaluationService kmCarmngEvaluationService;

	public IKmCarmngEvaluationService getKmCarmngEvaluationService() {
		if (kmCarmngEvaluationService == null) {
			kmCarmngEvaluationService = (IKmCarmngEvaluationService) getBean("kmCarmngEvaluationService");
		}
		return kmCarmngEvaluationService;
	}

	protected IKmCarmngRegisterInfoService kmCarmngRegisterInfoService;
	
	public IKmCarmngRegisterInfoService getKmCarmngRegisterInfoService() {
		if (kmCarmngRegisterInfoService == null) {
			kmCarmngRegisterInfoService = (IKmCarmngRegisterInfoService) getBean("kmCarmngRegisterInfoService");
		}
		return kmCarmngRegisterInfoService;
	}

	protected ISysOrgCoreService sysOrgCoreService;

	protected ISysOrgCoreService getSysOrgServiceImp(HttpServletRequest request) {
		if (sysOrgCoreService == null) {
            sysOrgCoreService = (ISysOrgCoreService) getBean("sysOrgCoreService");
        }
		return sysOrgCoreService;
	}


	@Override
	protected ActionForm createNewForm(ActionMapping mapping, ActionForm form,
									   HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Boolean effective = new Boolean(true);
		request.setAttribute("effective", effective);
		KmCarmngApplicationForm kmCarmngApplicationForm = (KmCarmngApplicationForm) super
				.createNewForm(mapping, form, request, response);
		kmCarmngApplicationForm.setDocCreateTime(DateUtil.convertDateToString(
				new Date(), DateUtil.TYPE_DATETIME, Locale.getDefault()));
		SysOrgElement person = UserUtil.getUser();
		kmCarmngApplicationForm.setDocCreatorId(person.getFdId());
		kmCarmngApplicationForm.setDocCreatorName(person.getFdName());
		kmCarmngApplicationForm.setFdApplicationPersonId(person.getFdId());
		kmCarmngApplicationForm.setFdApplicationPersonName(person.getFdName());
		SysOrgElement dept = UserUtil.getUser().getFdParent();
		if (dept != null) {
			kmCarmngApplicationForm.setFdApplicationDeptId(dept.getFdId());
			kmCarmngApplicationForm.setFdApplicationDeptName(dept.getDeptLevelNames());
		}
		kmCarmngApplicationForm
				.setFdApplicationPersonPhone(((SysOrgPerson) person)
						.getFdMobileNo());
		kmCarmngApplicationForm.setFdApplicationTime(DateUtil
				.convertDateToString(new Date(), DateUtil.TYPE_DATE, Locale
						.getDefault()));
		kmCarmngApplicationForm.setFdUserNumber("1");
		kmCarmngApplicationForm.setFdUserPersonIds(person.getFdId());
		kmCarmngApplicationForm.setFdUserPersonNames(person.getFdName());
		String fdTempletId = request.getParameter("fdMotorcadeId");
		if (StringUtil.isNotNull(fdTempletId)) {
			KmCarmngMotorcadeSet kmCarmngMotorcadeSet = (KmCarmngMotorcadeSet) getKmCarmngMotorcadeSetService()
					.findByPrimaryKey(fdTempletId);
			kmCarmngApplicationForm.setFdMotorcadeId(kmCarmngMotorcadeSet.getFdId());
			kmCarmngApplicationForm.setFdMotorcadeName(kmCarmngMotorcadeSet.getFdName());
			kmCarmngApplicationForm.setFdMotorcadeRemark(kmCarmngMotorcadeSet.getFdRemark());
			kmCarmngApplicationForm.setMethod_GET("add");
			// 启动模板流程
			kmCarmngApplicationForm.getSysWfBusinessForm().setCanStartProcess("true");
			getDispatchCoreService().initFormSetting(kmCarmngApplicationForm, "kmCarmngMotorcadeSet",
					kmCarmngMotorcadeSet, "kmCarmngMotorcadeSet", new RequestContext(request));
		}
		return kmCarmngApplicationForm;
	}
	
	
	public ActionForward change(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-change", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			if (!"POST".equals(request.getMethod())&&!"GET".equals(request.getMethod())) {
                throw new UnexpectedRequestException();
            }
			if(StringUtil.isNull(request.getParameter("method_GET"))){
				String fdMotorcadeId=request.getParameter("fdMotorcadeId");
				String url = "/km/carmng/km_carmng_application/kmCarmngApplication.do?method=add&fdMotorcadeId="+fdMotorcadeId+"&s_css=default";
				request.getRequestDispatcher(url).forward(request,
						response);
				return null;
			}
			KmCarmngApplicationForm kmCarmngApplicationForm = (KmCarmngApplicationForm) form;
			String fdTempletId = kmCarmngApplicationForm.getFdMotorcadeId();
			if (StringUtil.isNull(fdTempletId)) {
				messages.addMsg(new KmssMessage("km-carmng:kmCarmngApplication.workflow.null"));
				messages.setHasError();
			}else{
				KmCarmngMotorcadeSet kmCarmngMotorcadeSet = (KmCarmngMotorcadeSet) getKmCarmngMotorcadeSetService()
						.findByPrimaryKey(fdTempletId);
				kmCarmngApplicationForm.setFdMotorcadeId(kmCarmngMotorcadeSet
						.getFdId());
				kmCarmngApplicationForm.setFdMotorcadeName(kmCarmngMotorcadeSet
						.getFdName());
				kmCarmngApplicationForm
						.setFdMotorcadeRemark(kmCarmngMotorcadeSet
								.getFdRemark());
				kmCarmngApplicationForm.setMethod_GET("add");
				request.setAttribute("change", "true");
				// 启动模板流程
				kmCarmngApplicationForm.getSysWfBusinessForm()
						.setCanStartProcess("true");
				getDispatchCoreService().initFormSetting(
						kmCarmngApplicationForm, "kmCarmngMotorcadeSet",
						kmCarmngMotorcadeSet, "kmCarmngMotorcadeSet",
						new RequestContext(request));
			}
		} catch (Exception e) {
			messages.addError(e);
		}

		TimeCounter.logCurrentTime("Action-save", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages)
					.addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
			return getActionForward("failure", mapping, form, request, response);
		} else {
			return getActionForward("edit", mapping, form, request, response);
		}
	}

	protected String getFindPageWhereBlockByDispatchers(
			HttpServletRequest request) throws Exception {
		String whereBlock = null;
		String docStatus = request.getParameter("docStatus");
		String fdIsDispatcher = request.getParameter("fdIsDispatcher");
		if (StringUtil.isNotNull(docStatus)) {
			whereBlock = StringUtil.linkString(getFindPageByStatus(request),
					" and ", whereBlock);
		}
		if (StringUtil.isNotNull(fdIsDispatcher)) {
			whereBlock = StringUtil.linkString(
					" kmCarmngApplication.fdIsDispatcher = 1 ", " and ",
					whereBlock);
		}
		return whereBlock;
	}

	protected String getFindPageByStatus(HttpServletRequest request)
			throws Exception {
		String whereBlock = null;
		String docStatus = request.getParameter("docStatus");
		if ("draft".equals(docStatus)) {
			docStatus = "10";
		}
		if ("wait".equals(docStatus)) {
			docStatus = "20";
		}
		if ("publish".equals(docStatus)) {
			docStatus = "30";
		}
		if ("discard".equals(docStatus)) {
			docStatus = "00";
		}
		if ("refuse".equals(docStatus)) {
			docStatus = "11";
		}

		if (SysDocConstant.DOC_STATUS_DRAFT.equals(docStatus)) { // 草稿
			whereBlock = " kmCarmngApplication.docStatus='10' ";
		} else if (SysDocConstant.DOC_STATUS_EXAMINE.equals(docStatus)) { // 待审
			whereBlock = " kmCarmngApplication.docStatus='20' ";
		} else if (SysDocConstant.DOC_STATUS_DISCARD.equals(docStatus)) { // 废弃
			whereBlock = " kmCarmngApplication.docStatus='00' ";
		} else if (SysDocConstant.DOC_STATUS_PUBLISH.equals(docStatus)) { // 发布
			whereBlock = " kmCarmngApplication.docStatus='30' ";
		} else if (SysDocConstant.DOC_STATUS_REFUSE.equals(docStatus)) { // 驳回
			whereBlock = " kmCarmngApplication.docStatus='11' ";
		}
		return whereBlock;
	}

	@Override
	protected void changeFindPageHQLInfo(HttpServletRequest request,
										 HQLInfo hqlInfo) throws Exception {
		super.changeFindPageHQLInfo(request, hqlInfo);
		String whereBlock = hqlInfo.getWhereBlock();
		if (StringUtil.isNull(whereBlock)) {
			whereBlock = " 1=1 ";
		}
		String docStatus = request.getParameter("docStatus");
		String myDoc = request.getParameter("myDoc");
		String fdIsDispatcher = request.getParameter("isDispatcher");
		if (StringUtil.isNotNull(docStatus)) {
			whereBlock = StringUtil.linkString(getFindPageByStatus(request),
					" and ", whereBlock);
		} else {
			if (!StringUtil.isNotNull(myDoc)) {
				whereBlock = StringUtil.linkString(
						" kmCarmngApplication.docStatus !='10' ", " and ",
						whereBlock);
			}
		}
		if (StringUtil.isNotNull(myDoc)) {

			whereBlock += " and kmCarmngApplication.docCreator.fdId=:fdId ";
			hqlInfo.setParameter("fdId", UserUtil.getUser().getFdId());
		}
		if (StringUtil.isNotNull(fdIsDispatcher)) {
			whereBlock = StringUtil.linkString(
					" kmCarmngApplication.fdIsDispatcher =:fdIsDispatcher ",
					" and ", whereBlock);
			hqlInfo.setParameter("fdIsDispatcher", Integer
					.parseInt(fdIsDispatcher));
		}
		hqlInfo.setWhereBlock(whereBlock);
		String type = request.getParameter("flowType");
		// 已审列表
		if ("executed".equals(type)) {
			SysFlowUtil.buildLimitBlockForMyApproved("kmCarmngApplication",
					hqlInfo);
		}
		// 待审列表
		if ("unExecuted".equals(type)) {
			SysFlowUtil.buildLimitBlockForMyApproval("kmCarmngApplication",
					hqlInfo);
		}
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
			int rowsize = 0;
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
			// changeFindPageHQLInfo(request, hqlInfo);
			hqlInfo.setWhereBlock(getFindPageWhereBlockByDispatchers(request));
			// hqlInfo.setOrderBy("kmCarmngApplication.docCreateTime desc");
			hqlInfo.setAuthCheckType("dispatchersReader");
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

	public ActionForward listApplicationByIds(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		KmssMessages messages = new KmssMessages();
		HQLInfo hqlInfo = new HQLInfo();
		String fdApplicationIds = request.getParameter("fdApplicationIds");
		HQLWrapper hqlWrapper = HQLUtil.buildPreparedLogicIN(" kmCarmngApplication.fdId ", "kmCarmngApplication" + "0_",
				Arrays.asList(fdApplicationIds.split(";")));
		hqlInfo.setWhereBlock(hqlWrapper.getHql());
		hqlInfo.setParameter(hqlWrapper.getParameterList());

		List<KmCarmngApplication> list = getServiceImp(request).findList(hqlInfo);
		// 记录操作日志
		UserOperHelper.logFindAll(list, getServiceImp(request).getModelName());
		UserOperHelper.setOperSuccess(true);
		if ("true".equals(request.getParameter("mobile"))) {
			request.setAttribute("appList", list);
			TimeCounter.logCurrentTime("Action-list", false, getClass());
			if (messages.hasError()) {
				KmssReturnPage.getInstance(request).addMessages(messages)
						.addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
				return getActionForward("failure", mapping, form, request, response);
			} else {
				return getActionForward("listAppByIds", mapping, form,
						request, response);
			}
		}else{
			// 子类自己处理JOSN数组
			JSONArray array = handleJSONArray(list);
	
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(array);
			response.getWriter().flush();
			response.getWriter().close();
			return null;
		}
	}
	
	public JSONArray handleJSONArray(List<KmCarmngApplication> list) {
		JSONArray array = new JSONArray();
		for (KmCarmngApplication app : list) {
			JSONObject obj = new JSONObject();
			obj.put("fdId", app.getFdId());
			obj.put("docSubject", app.getDocSubject());
			obj.put("fdUnerNumber", app.getFdUserNumber());
			obj.put("fdApplicationPersonId", app.getFdApplicationPerson().getFdId());
			obj.put("fdApplicationPersonName", app.getFdApplicationPerson().getFdName());
			obj.put("fdApplicationPersonPhone", app.getFdApplicationPersonPhone());
			if (app.getFdUserPersons().size() > 0) {
				String fdUserName = "";
				for (int i = 0; i < app.getFdUserPersons().size(); i++) {
					SysOrgElement org = (SysOrgElement) app.getFdUserPersons().get(i);
					fdUserName += org.getFdName() + ";";
				}
				if (StringUtil.isNotNull(fdUserName)) {
					fdUserName = fdUserName.substring(0, fdUserName.lastIndexOf(";"));
				}
				obj.put("fdUserPersons", fdUserName);
			}
			obj.put("fdOtherUsers", app.getFdOtherUsers());
			obj.put("fdApplicationReason", app.getFdApplicationReason());
			obj.put("fdDeparture", app.getFdDeparture());
			obj.put("fdDepartureCoordinate", app.getFdDepartureCoordinate());
			obj.put("fdDepartureDetail", app.getFdDepartureDetail());
			obj.put("fdDestination", app.getFdDestination());
			obj.put("fdDestinationCoordinate", app.getFdDestinationCoordinate());
			obj.put("fdDestinationDetail", app.getFdDestinationDetail());
			obj.put("fdPath", app.getFdApplicationPath());
			if (app.getFdPaths() != null) {
				JSONArray pathArr = new JSONArray();
				for (int j = 0; j < app.getFdPaths().size(); j++) {
					JSONObject pathjson = new JSONObject();
					KmCarmngPath path = app.getFdPaths().get(j);
					pathjson.put("fdDestination", path.getFdDestination());
					pathjson.put("fdDestinationCoordinate", path.getFdDestinationCoordinate());
					pathjson.put("fdDestinationDetail", path.getFdDestinationDetail());
					pathArr.add(pathjson);
				}
				obj.put("fdApplicationPath", pathArr);
			}
			array.add(obj);
		}
		return array;
	}

	public ActionForward listByDispatchersForInfo(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		TimeCounter.logCurrentTime("Action-listByDispatchersForInfo", true,
				getClass());
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
			int rowsize = 0;
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
			// String fdDispatchersId = request.getParameter("fdDispatchersId");
			// if (StringUtil.isNotNull(fdDispatchersId)){
			// KmCarmngDispatchersInfo kmCarmngDispatchersInfo =
			// (KmCarmngDispatchersInfo)getKmCarmngDispatchersInfoService().findByPrimaryKey(fdDispatchersId);
			// String userId = UserUtil.getKMSSUser().getUserId();
				//如果登录用户跟调度单驾驶员是同一个人则不进行数据过滤
				// if (kmCarmngDispatchersInfo.getFdSysDriver()!=null){
				// if
				// (userId.equals(kmCarmngDispatchersInfo.getFdSysDriver().getFdId())){
				// hqlInfo.setAuthCheckType(HQLInfo.AUTH_CHECK_NONE);
				// }
				// }
			// }
			String fdApplicationIds = request.getParameter("fdApplicationIds");
			fdApplicationIds = fdApplicationIds.substring(0, fdApplicationIds.lastIndexOf(";"));
			// fdApplicationIds = fdApplicationIds.replace(";", "','");
			// hqlInfo.setWhereBlock("kmCarmngApplication.fdId in (:fdApplicationIds)");
			// hqlInfo.setParameter("fdApplicationIds",
			// "'"+fdApplicationIds+"'");
			HQLWrapper hqlWrapper = HQLUtil.buildPreparedLogicIN(
					" kmCarmngApplication.fdId ","kmCarmngApplication"+ "0_", Arrays
							.asList(fdApplicationIds.split(";")));
			hqlInfo.setWhereBlock(hqlWrapper.getHql());
			hqlInfo.setParameter(hqlWrapper.getParameterList());

			Page page = getServiceImp(request).findPage(hqlInfo);
			// 记录操作日志
			UserOperHelper.logFindAll(page.getList(),
					getServiceImp(request).getModelName());
			request.setAttribute("queryPage", page);
		} catch (Exception e) {
			messages.addError(e);
		}

		TimeCounter.logCurrentTime("Action-listByDispatchersForInfo", false,
				getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages)
					.addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
			return getActionForward("failure", mapping, form, request, response);
		} else {
			return getActionForward("listByDispatchersForInfo", mapping, form,
					request, response);
		}
	}

	@Override
	protected void loadActionForm(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		form.reset(mapping, request);
		IExtendForm rtnForm = null;
		String id = request.getParameter("fdId");
		if (!StringUtil.isNull(id)) {
			List<KmCarmngDispatchersInfo> dispatchersInfoList = getKmCarmngDispatchersInfoService()
					.findList("kmCarmngDispatchersInfo.fdApplicationIds like '%" + id + "%'", null);
									
			IBaseModel model = getServiceImp(request).findByPrimaryKey(id,null, true);
					
			KmCarmngApplication kmCarmngApplication = (KmCarmngApplication) model;
			if (!dispatchersInfoList.isEmpty()) {
				KmCarmngDispatchersInfo kmCarmngDispatchersInfo = dispatchersInfoList.get(0);
				kmCarmngApplication.setKmCarmngDispatchersInfo(kmCarmngDispatchersInfo);
			}

			List<KmCarmngEvaluation> kmCarmngEvaluationList = getKmCarmngEvaluationService()
					.findList("kmCarmngEvaluation.fdApplication.fdId = '" + id + "'", null);
			if (!kmCarmngEvaluationList.isEmpty()) {
				KmCarmngEvaluation kmCarmngEvaluation = kmCarmngEvaluationList.get(0);
				kmCarmngApplication.setKmCarmngEvaluation(kmCarmngEvaluation);
			}

			if (model != null) {
				rtnForm = getServiceImp(request).convertModelToForm(
						(IExtendForm) form, kmCarmngApplication,
						new RequestContext(request));
				UserOperHelper.logFind(model);
			}
		}
		if (rtnForm == null) {
            throw new NoRecordException();
        }
		request.setAttribute(getFormName(rtnForm, request), rtnForm);
	}

	@Override
	public ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-delete", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			if (!"GET".equals(request.getMethod())) {
                throw new UnexpectedRequestException();
            }
			String id = request.getParameter("fdId");
			if (StringUtil.isNull(id)) {
                messages.addError(new NoRecordException());
            } else {
				KmCarmngApplication kmCarmngApplication = (KmCarmngApplication) getServiceImp(
						request).findByPrimaryKey(id);
				getServiceImp(request).delete(kmCarmngApplication);
			}
		} catch (Exception e) {
			messages.addError(e);
		}

		KmssReturnPage.getInstance(request).addMessages(messages).addButton(
				KmssReturnPage.BUTTON_CLOSE).save(request);
		TimeCounter.logCurrentTime("Action-delete", false, getClass());
		if (messages.hasError()) {
            return getActionForward("failure", mapping, form, request, response);
        } else {
            return getActionForward("success", mapping, form, request, response);
        }
	}

	@Override
	public ActionForward deleteall(ActionMapping mapping, ActionForm form,
								   HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-deleteall", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			if (!"POST".equals(request.getMethod())) {
                throw new UnexpectedRequestException();
            }
			String[] ids = request.getParameterValues("List_Selected");

			if (ISysAuthConstant.IS_AREA_ENABLED) {
				String[] authIds = SysAuthAreaUtils.removeNoAuthIds(ids,
						request, "method=delete&fdId=${id}");
				int noAuthIdNum = ids.length - authIds.length;
				if (noAuthIdNum > 0) {
					messages.addMsg(new KmssMessage(
							"sys-authorization:area.batch.operation.info",
							noAuthIdNum));
				}

				if (!ArrayUtils.isEmpty(authIds)) {
                    getServiceImp(request).delete(authIds);
                }
			} else if (ids != null) {
				List<KmCarmngApplication> carmngApplications = getServiceImp(
						request).findByPrimaryKeys(ids);
				for (KmCarmngApplication carmngApp : carmngApplications) {
					getServiceImp(request).delete(carmngApp);
				}
			}
		} catch (Exception e) {
			messages.addError(e);
		}

		KmssReturnPage.getInstance(request).addMessages(messages).addButton(
				KmssReturnPage.BUTTON_RETURN).save(request);
		TimeCounter.logCurrentTime("Action-deleteall", false, getClass());
		if (messages.hasError()) {
            return getActionForward("failure", mapping, form, request, response);
        } else {
            return getActionForward("success", mapping, form, request, response);
        }
	}

	@Override
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-save", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			if (!"POST".equals(request.getMethod())) {
                throw new UnexpectedRequestException();
            }
			getServiceImp(request).add((IExtendForm) form,
					new RequestContext(request));
			KmCarmngApplicationForm kmCarmngApplicationForm = (KmCarmngApplicationForm) form;
			if (kmCarmngApplicationForm.getDocStatus().equals(
					SysDocConstant.DOC_STATUS_DRAFT)) {
				KmssReturnPage.getInstance(request).addMessages(messages)
						.addButton(
								"button.back",
								"kmCarmngApplication.do?method=edit&fdId="
										+ request.getParameter("fdId"), false)
						.save(request);
			}
		} catch (Exception e) {
			messages.addError(e);
		}

		TimeCounter.logCurrentTime("Action-save", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages).save(
					request);
			return getActionForward("edit", mapping, form, request, response);
		} else {
			KmssReturnPage.getInstance(request).addMessages(messages)
					.addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
			return getActionForward("success", mapping, form, request, response);

		}
	}

	@Override
	public ActionForward update(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-update", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			if (!"POST".equals(request.getMethod())) {
                throw new UnexpectedRequestException();
            }
			getServiceImp(request).update((IExtendForm) form,
					new RequestContext(request));
			KmCarmngApplicationForm kmCarmngApplicationForm = (KmCarmngApplicationForm) form;
			if (kmCarmngApplicationForm.getDocStatus().equals(
					SysDocConstant.DOC_STATUS_DRAFT)) {
				KmssReturnPage.getInstance(request).addMessages(messages)
						.addButton(
								"button.back",
								"kmCarmngApplication.do?method=edit&fdId="
										+ request.getParameter("fdId"), false)
						.save(request);
			}
		} catch (Exception e) {
			messages.addError(e);
		}
		TimeCounter.logCurrentTime("Action-update", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages).save(
					request);
			return getActionForward("edit", mapping, form, request, response);
		} else {
			KmssReturnPage.getInstance(request).addMessages(messages)
					.addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
			return getActionForward("success", mapping, form, request, response);
		}
	}

	public ActionForward deleteDraft(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		return super.deleteall(mapping, form, request, response);
	}

	@Override
	protected String getFindPageOrderBy(HttpServletRequest request,
			String curOrderBy) throws Exception {
		if (StringUtil.isNull(curOrderBy)) {
			curOrderBy = "kmCarmngApplication.docCreateTime desc";
		}
		return curOrderBy;
	}

	/**
	 * 打印流程文档
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward print(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		HtmlToMht.setLocaleWhenExport(request);
		view(mapping, form, request, response);
		String base = "";
		String info = "";
		String note = "";
		KmCarmngApplicationConfig kmCarmngApplicationConfig = new KmCarmngApplicationConfig();
		base = kmCarmngApplicationConfig.getBase();
		info = kmCarmngApplicationConfig.getInfo();
		note = kmCarmngApplicationConfig.getNote();
		request.setAttribute("base", base);
		request.setAttribute("info", info);
		request.setAttribute("note", note);
		return mapping.findForward("print");
	}

	public ActionForward getApplicantDept(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		TimeCounter.logCurrentTime("Action-save", true, getClass());
		KmssMessages messages = new KmssMessages();
		String fdApplicationId = request.getParameter("fdApplicationId");
		String deptId = "", deptName = "", fdMobileNo = "";
		try {
			if (StringUtil.isNotNull(fdApplicationId)) {
				SysOrgPerson person = (SysOrgPerson) getSysOrgServiceImp(request).findByPrimaryKey(fdApplicationId,
						SysOrgPerson.class);
				if (person.getFdParent() != null) {
					deptId = person.getFdParent().getFdId();
					deptName = person.getFdParent().getFdName();
					fdMobileNo = person.getFdMobileNo();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			messages.addError(e);
		}
		KmssReturnPage.getInstance(request).addMessages(messages).addButton(KmssReturnPage.BUTTON_RETURN).save(request);
		TimeCounter.logCurrentTime("Action-save", false, getClass());
		JSONObject json = new JSONObject();
		json.put("deptId", deptId);
		json.put("deptName", deptName);
		json.put("fdMobileNo", fdMobileNo);
		response.setCharacterEncoding("UTF-8");
		response.getWriter().append(json.toString());
		response.getWriter().flush();
		response.getWriter().close();
		return null;
	}

	//==================================AI接口开始===================================//
	private static final Logger logger = org.slf4j.LoggerFactory.getLogger(KmCarmngApplicationAction.class);
	public ActionForward saveCarmng(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-update", true, getClass());
		JSONObject json = new JSONObject();
		try {
			String fdMotorcadeId = request.getParameter("fdMotorcadeId");
			String fdDeparture = request.getParameter("fdDeparture");
			String fdDestination = request.getParameter("fdDestination");
			String fdStartTime = request.getParameter("fdStartTime");
			String fdEndTime = request.getParameter("fdEndTime");
			if (StringUtil.isNotNull(fdMotorcadeId)
					&& StringUtil.isNotNull(fdDeparture)
					&& StringUtil.isNotNull(fdDestination)
					&& StringUtil.isNotNull(fdStartTime)
					&& StringUtil.isNotNull(fdEndTime)) {
				SysOrgPerson person = UserUtil.getUser();
				KmCarmngApplicationForm carmngForm = new KmCarmngApplicationForm();
				String docSubject = DateUtil.convertDateToString(new Date(), "yyyy年MM月dd日");
				docSubject = person.getFdName()+docSubject+"申请用车";
				carmngForm.setDocSubject(docSubject);
				carmngForm.setMethod_GET("add");
				carmngForm.setDocStatus("20");
				carmngForm.setFdOutStatus("0");
				carmngForm.setFdIsDispatcher("1");
				carmngForm.setFdMotorcadeId(fdMotorcadeId);
				carmngForm.setFdApplicationPersonId(person.getFdId());
				carmngForm.setFdApplicationPersonName(person.getFdName());
				String tel = person.getFdMobileNo();
				if(StringUtil.isNull(tel)) {
                    tel = person.getFdWorkPhone();
                }
				if(StringUtil.isNull(tel)) {
                    tel = " ";
                }
				carmngForm.setFdApplicationPersonPhone(tel);
				if(person.getFdParent()!=null) {
                    carmngForm.setFdApplicationDeptId(person.getFdParent().getFdId());
                }
				carmngForm.setFdUserNumber("1");
				carmngForm.setFdUserPersonIds(person.getFdId());
				carmngForm.setFdUserPersonNames(person.getFdName());
				carmngForm.setDocCreateTime(DateUtil.convertDateToString(new Date(), DateUtil.PATTERN_DATETIME, request.getLocale()));
				carmngForm.setDocCreatorId(person.getFdId());
				carmngForm.setDocCreatorName(person.getFdName());
				carmngForm.setFdApplicationTime(DateUtil.convertDateToString(new Date(), DateUtil.TYPE_DATE, Locale.getDefault()));
				carmngForm.setFdDeparture(fdDeparture);				
				carmngForm.setFdDestination(fdDestination);				
				carmngForm.setFdStartTime(fdStartTime);
				carmngForm.setFdEndTime(fdEndTime);
				
				RequestContext rc = new RequestContext(request);
				rc.setParameter("method", "save");
				rc.setParameter("method_GET", "add");
				
				if (StringUtil.isNotNull(fdMotorcadeId)) {
					KmCarmngMotorcadeSet kmCarmngMotorcadeSet = (KmCarmngMotorcadeSet) getKmCarmngMotorcadeSetService()
							.findByPrimaryKey(fdMotorcadeId);
					carmngForm.setFdMotorcadeId(kmCarmngMotorcadeSet.getFdId());
					carmngForm.setFdMotorcadeName(kmCarmngMotorcadeSet.getFdName());
					carmngForm.setFdMotorcadeRemark(kmCarmngMotorcadeSet.getFdRemark());
					carmngForm.setMethod_GET("add");
					// 启动模板流程
					carmngForm.getSysWfBusinessForm().setCanStartProcess("true");
					getDispatchCoreService().initFormSetting(carmngForm, "kmCarmngMotorcadeSet",
							kmCarmngMotorcadeSet, "kmCarmngMotorcadeSet", new RequestContext(request));
				}
				getServiceImp(request).add(carmngForm, rc);
				json.put("errcode", 0);
				json.put("data", carmngForm.getFdId());
				json.put("errmsg", "ok");
			}else{
				json.put("errcode", 1);
				json.put("data","");
				json.put("errmsg", "参数为空");
			}
		} catch (Exception e) {
			logger.error("", e);
			json.put("errcode", 1);
			json.put("data","");
			json.put("errmsg", e.getMessage());
		}
	
		TimeCounter.logCurrentTime("Action-update", false, getClass());
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().println(json.toString());
		return null;
	}
	
	public ActionForward carTeam(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		JSONObject result = new JSONObject();
		JSONArray ja = new JSONArray();
		try {
			String whereBlock = "kmCarmngMotorcadeSet.isEffective = 'true' or kmCarmngMotorcadeSet.isEffective is null";
			List<KmCarmngMotorcadeSet> cars = getKmCarmngMotorcadeSetService().findList(whereBlock, "kmCarmngMotorcadeSet.fdId desc");
			JSONObject json = null;
			for(KmCarmngMotorcadeSet car:cars){
				json = new JSONObject();
				json.put("id", car.getFdId());
				json.put("name", car.getFdName());
				ja.add(json);
			}
			result.put("data", ja);
			result.put("errcode", 0);
			result.put("errmsg", "ok");
		} catch (Exception e) {
			result.put("data", ja);
			result.put("errcode", 1);
			result.put("errmsg", e.getMessage());
		}
		TimeCounter.logCurrentTime("Action-signature", false, getClass());
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		logger.info(result.toString());
		response.getWriter().println(result.toString());
		return null;
	}
	//==================================AI接口结束===================================//
}
