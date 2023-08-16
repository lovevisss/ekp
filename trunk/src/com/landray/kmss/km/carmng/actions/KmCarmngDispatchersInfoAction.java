package com.landray.kmss.km.carmng.actions;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;

import com.landray.kmss.common.actions.ExtendAction;
import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.exception.NoRecordException;
import com.landray.kmss.common.exception.UnexpectedRequestException;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.common.test.TimeCounter;
import com.landray.kmss.constant.SysAuthConstant;
import com.landray.kmss.km.carmng.forms.KmCarmngApplicationForm;
import com.landray.kmss.km.carmng.forms.KmCarmngDispatchersInfoForm;
import com.landray.kmss.km.carmng.forms.KmCarmngDispatchersInfoListForm;
import com.landray.kmss.km.carmng.model.KmCarmngApplication;
import com.landray.kmss.km.carmng.model.KmCarmngDispatchersInfo;
import com.landray.kmss.km.carmng.model.KmCarmngMotorcadeSet;
import com.landray.kmss.km.carmng.service.IKmCarmngApplicationService;
import com.landray.kmss.km.carmng.service.IKmCarmngDispatchersInfoListService;
import com.landray.kmss.km.carmng.service.IKmCarmngDispatchersInfoService;
import com.landray.kmss.sys.log.util.UserOperHelper;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.sys.organization.service.ISysOrgPersonService;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.HQLUtil;
import com.landray.kmss.util.KmssMessages;
import com.landray.kmss.util.KmssReturnPage;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.util.UserUtil;
import com.landray.kmss.web.action.ActionForm;
import com.landray.kmss.web.action.ActionForward;
import com.landray.kmss.web.action.ActionMapping;
import com.sunbor.web.tag.Page;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 创建日期 2010-三月-24
 * 
 * @author 黄郴
 */
public class KmCarmngDispatchersInfoAction extends ExtendAction

{

	private static final Logger log = org.slf4j.LoggerFactory.getLogger(KmCarmngDispatchersInfoAction.class);

	protected IKmCarmngDispatchersInfoService kmCarmngDispatchersInfoService;
	protected IKmCarmngDispatchersInfoListService kmCarmngDispatchersInfoListService;

	@Override
	protected IKmCarmngDispatchersInfoService getServiceImp(
			HttpServletRequest request) {
		if (kmCarmngDispatchersInfoService == null) {
            kmCarmngDispatchersInfoService = (IKmCarmngDispatchersInfoService) getBean("kmCarmngDispatchersInfoService");
        }
		return kmCarmngDispatchersInfoService;
	}

	protected IKmCarmngDispatchersInfoListService getDispatchersInfoListServiceImp() {
		if (kmCarmngDispatchersInfoListService == null) {
            kmCarmngDispatchersInfoListService = (IKmCarmngDispatchersInfoListService) getBean(
                    "kmCarmngDispatchersInfoListService");
        }
		return kmCarmngDispatchersInfoListService;
	}

	private IKmCarmngApplicationService kmCarmngApplicationService;

	public IKmCarmngApplicationService getKmCarmngApplicationService() {
		if (kmCarmngApplicationService == null) {
			kmCarmngApplicationService = (IKmCarmngApplicationService) getBean("kmCarmngApplicationService");
		}
		return this.kmCarmngApplicationService;
	}

	protected ISysOrgPersonService sysOrgPersonService;

	protected ISysOrgPersonService getSysOrgPersonServiceImp(
			HttpServletRequest request) {
		if (sysOrgPersonService == null) {
			sysOrgPersonService = (ISysOrgPersonService) getBean("sysOrgPersonService");
		}
		return sysOrgPersonService;
	}

	public ActionForward addBatch(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		TimeCounter.logCurrentTime("Action-add", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			ActionForm newForm = createNewForm(mapping, form, request, response);
			if (newForm != form) {
                request.setAttribute(getFormName(newForm, request), newForm);
            }
		} catch (Exception e) {
			messages.addError(e);
		}

		TimeCounter.logCurrentTime("Action-add", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages).addButton(KmssReturnPage.BUTTON_CLOSE)
					.save(request);
			return getActionForward("failure", mapping, form, request, response);
		} else {
			return getActionForward("edit", mapping, form, request, response);
		}
	}

	@Override
	protected ActionForm createNewForm(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String fdAppId = request.getParameter("fdAppId");
		String listFdId = request.getParameter("listFdId");
		String[] ids = null;
		if (StringUtil.isNotNull(listFdId)) {
			ids = listFdId.split(";");
		}
		String fdApplicationIds = "";
		String fdApplicationNames = "";
		KmCarmngMotorcadeSet fdMotorcade = null;
		String fdStartTime = "";
		String fdEndTime = "";
		// 用于记录第一个申请单的相关信息进行显示
		if (StringUtil.isNull(fdAppId)) {
			for (int i = 0; i < ids.length; i++) {
				String id = ids[i];
				KmCarmngApplication kmCarmngApplication = (KmCarmngApplication) getKmCarmngApplicationService()
						.findByPrimaryKey(id);
				if (fdMotorcade == null) {
					fdMotorcade = kmCarmngApplication.getFdMotorcade();
				}
				if (StringUtil.isNull(fdStartTime)) {
					fdStartTime = DateUtil.convertDateToString(
							kmCarmngApplication.getFdStartTime(),
							DateUtil.TYPE_DATETIME, Locale.getDefault());
				}
				if (StringUtil.isNull(fdEndTime)) {
					fdEndTime = DateUtil.convertDateToString(
							kmCarmngApplication.getFdEndTime(),
							DateUtil.TYPE_DATETIME, Locale.getDefault());
				}
				fdApplicationNames += kmCarmngApplication.getDocSubject() + ";";
				fdApplicationIds += kmCarmngApplication.getFdId() + ";";
			}
		} else {
			String id = fdAppId;
			KmCarmngApplication kmCarmngApplication = (KmCarmngApplication) getKmCarmngApplicationService()
					.findByPrimaryKey(id);
			if (fdMotorcade == null) {
				fdMotorcade = kmCarmngApplication.getFdMotorcade();
			}
			if (StringUtil.isNull(fdStartTime)) {
				fdStartTime = DateUtil.convertDateToString(kmCarmngApplication
						.getFdStartTime(), DateUtil.TYPE_DATETIME, Locale
						.getDefault());
			}
			if (StringUtil.isNull(fdEndTime)) {
				fdEndTime = DateUtil.convertDateToString(kmCarmngApplication
						.getFdEndTime(), DateUtil.TYPE_DATETIME, Locale
						.getDefault());
			}
			fdApplicationNames += kmCarmngApplication.getDocSubject() + ";";
			fdApplicationIds += kmCarmngApplication.getFdId() + ";";
			KmCarmngApplicationForm kmCarmngApplicationForm = new KmCarmngApplicationForm();
			kmCarmngApplicationForm = (KmCarmngApplicationForm) getKmCarmngApplicationService()
					.cloneModelToForm(kmCarmngApplicationForm, kmCarmngApplication, new RequestContext(request));
			request.setAttribute("kmCarmngApplicationForm", kmCarmngApplicationForm);
		}
		super.createNewForm(mapping, form, request, response);
		KmCarmngDispatchersInfoForm kmCarmngDispatchersInfoForm = (KmCarmngDispatchersInfoForm) form;
		if (fdMotorcade != null && fdMotorcade.getFdRegister() != null) {
			kmCarmngDispatchersInfoForm.setFdRegisterId(fdMotorcade.getFdRegister().getFdId());
			kmCarmngDispatchersInfoForm.setFdRegisterName(fdMotorcade.getFdRegister().getFdName());
		}
		SysOrgElement person = UserUtil.getUser();
		kmCarmngDispatchersInfoForm.setDocCreatorId(person.getFdId());
		kmCarmngDispatchersInfoForm.setDocCreatorName(person.getFdName());
		kmCarmngDispatchersInfoForm.setDocCreateTime(DateUtil
				.convertDateToString(new Date(), DateUtil.TYPE_DATETIME, Locale
						.getDefault()));
		kmCarmngDispatchersInfoForm.setFdApplicationIds(
				fdApplicationIds.substring(0, fdApplicationIds.length() - 1));
		// 去掉字符串最后的分号 by张文添
		kmCarmngDispatchersInfoForm.setFdApplicationNames(fdApplicationNames
				.substring(0, fdApplicationNames.length() - 1));
		kmCarmngDispatchersInfoForm.setFdStartTime(fdStartTime);
		kmCarmngDispatchersInfoForm.setFdEndTime(fdEndTime);

		// 增加申请单的超链接by张文添
		String[] fdApplicationName = fdApplicationNames.substring(0,
				fdApplicationNames.length() - 1).split(";");
		String[] fdApplicationId = fdApplicationIds.substring(0,
				fdApplicationIds.length() - 1).split(";");
		Map<String, String> map = new HashMap<String, String>();
		if(null != fdApplicationId && fdApplicationId.length > 1) {
			for (int i = 0; i < fdApplicationId.length; i++) {
				map.put(fdApplicationId[i], fdApplicationName[i]);
			}
		}else {
			map.put(fdApplicationId.toString(), fdApplicationName.toString());
		}
		request.setAttribute("map", map);
		if (fdMotorcade != null) {
			request.setAttribute("fdMotorcadeId", fdMotorcade.getFdId());
		}
		if (StringUtil.isNull(kmCarmngDispatchersInfoForm.getFdDispatchersType())) {
			kmCarmngDispatchersInfoForm.setFdDispatchersType("0");
		}
		if (StringUtil.isNull(kmCarmngDispatchersInfoForm.getFdNotifyPerson())) {
			kmCarmngDispatchersInfoForm.setFdNotifyPerson("0;1;2");
		}
		return kmCarmngDispatchersInfoForm;
	}

	@Override
	public ActionForward update(ActionMapping mapping, ActionForm form, HttpServletRequest request,
								HttpServletResponse response) throws Exception {
		TimeCounter.logCurrentTime("Action-save", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			if (!"POST".equals(request.getMethod())) {
                throw new UnexpectedRequestException();
            }

			KmCarmngDispatchersInfoForm kmCarmngDispatchersInfoForm = (KmCarmngDispatchersInfoForm) form;
			List<KmCarmngDispatchersInfoListForm> willRemoveList = new ArrayList<KmCarmngDispatchersInfoListForm>();
			List<KmCarmngDispatchersInfoListForm> formList = kmCarmngDispatchersInfoForm.getFdDispatchersInfoListForm();
			for (KmCarmngDispatchersInfoListForm kmCarmngDispatchersInfoListForm : formList) {

				if (StringUtil.isNull(kmCarmngDispatchersInfoListForm.getFdDispatchersInfoId())) {
					willRemoveList.add(kmCarmngDispatchersInfoListForm);
				}
			}
			formList.removeAll(willRemoveList);
			
			getServiceImp(request).update((IExtendForm) form, new RequestContext(request));
		} catch (Exception e) {
			messages.addError(e);
		}

		TimeCounter.logCurrentTime("Action-save", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages).save(request);
			return getActionForward("edit", mapping, form, request, response);
		} else {
			KmssReturnPage.getInstance(request).addMessages(messages).addButton(KmssReturnPage.BUTTON_CLOSE)
					.save(request);
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
			KmCarmngDispatchersInfoForm kmCarmngDispatchersInfoForm = (KmCarmngDispatchersInfoForm) form;
			String fdApplicationIds = kmCarmngDispatchersInfoForm
					.getFdApplicationIds();
			if(StringUtil.isNotNull(fdApplicationIds)){
				List<KmCarmngDispatchersInfoListForm> willRemoveList = new ArrayList<KmCarmngDispatchersInfoListForm>();
				List<KmCarmngDispatchersInfoListForm> formList = kmCarmngDispatchersInfoForm
						.getFdDispatchersInfoListForm();
				for (KmCarmngDispatchersInfoListForm kmCarmngDispatchersInfoListForm : formList) {

					if (StringUtil.isNull(kmCarmngDispatchersInfoListForm.getFdDispatchersInfoId())) {
						willRemoveList.add(kmCarmngDispatchersInfoListForm);
					}
				}
				formList.removeAll(willRemoveList);
				((IKmCarmngDispatchersInfoService) getServiceImp(request)).add(
						(IExtendForm) form, new RequestContext(request));
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

	/*
	 * 在edit页面中增加申请单的超链接
	 */
	@Override
	protected void loadActionForm(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		form.reset(mapping, request);
		IExtendForm rtnForm = null;
		String id = request.getParameter("fdId");
		if (!StringUtil.isNull(id)) {
			IBaseModel model = getServiceImp(request).findByPrimaryKey(id,
					null, true);
			if (model != null) {
				rtnForm = getServiceImp(request).convertModelToForm(
						(IExtendForm) form, model, new RequestContext(request));
				UserOperHelper.logFind(model);
			}
		}
		if (rtnForm == null) {
            throw new NoRecordException();
        }
		KmCarmngDispatchersInfoForm kmCarmngDispatchersInfoForm = (KmCarmngDispatchersInfoForm) rtnForm;
		String[] fdApplicationId = kmCarmngDispatchersInfoForm
				.getFdApplicationIds().substring(0, kmCarmngDispatchersInfoForm.getFdApplicationIds().length())
				.split(";");
		request.setAttribute("appSize", fdApplicationId.length);

		// 如果不是批量调度，直接查出申请单信息
		if (fdApplicationId.length == 1) {
			KmCarmngApplicationForm kmCarmngApplicationForm = new KmCarmngApplicationForm();
			IBaseModel kmCarmngApplication = getKmCarmngApplicationService()
					.findByPrimaryKey(fdApplicationId[0]);
			kmCarmngApplicationForm = (KmCarmngApplicationForm) getKmCarmngApplicationService()
					.cloneModelToForm(kmCarmngApplicationForm, kmCarmngApplication, new RequestContext(request));
			request.setAttribute("kmCarmngApplicationForm", kmCarmngApplicationForm);
		}

		// 返回有权限的回车登记
		if (!"1".equals(kmCarmngDispatchersInfoForm.getFdFlag())) {
			List<KmCarmngDispatchersInfoListForm> l = kmCarmngDispatchersInfoForm.getFdDispatchersInfoListForm();
			List authArr = new ArrayList();
			for (int i = 0; i < l.size(); i++) {
				KmCarmngDispatchersInfoListForm kmCarmngDispatchersInfoListForm = l.get(i);
				if (UserUtil.checkAuthentication(
						"/km/carmng/km_carmng_register_info/kmCarmngRegisterInfo.do?method=add&fdDispatchInfoListId="
								+ kmCarmngDispatchersInfoListForm.getFdId(),
						"get")) {
					authArr.add(kmCarmngDispatchersInfoListForm.getFdId());
				}
			}
			request.setAttribute("authArr", authArr);
			if (authArr.size() == 1) {
				request.setAttribute("fdDispatchersInfoListId", authArr.get(0));
			}
		}
		if (StringUtil.isNull(kmCarmngDispatchersInfoForm.getFdDispatchersType())) {
			kmCarmngDispatchersInfoForm.setFdDispatchersType("0");
		}
		if (StringUtil.isNull(kmCarmngDispatchersInfoForm.getFdNotifyPerson())) {
			kmCarmngDispatchersInfoForm.setFdNotifyPerson("0;1;2");
		}
		request.setAttribute(getFormName(rtnForm, request), rtnForm);
	}

	public ActionForward search(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-search", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			HQLInfo hqlInfo = new HQLInfo();
			String whereBlock = "1 < 2";
			whereBlock = StringUtil.linkString(whereBlock, " and ",
					getWhereBlockByStartTime(request));
			whereBlock = StringUtil.linkString(whereBlock, " and ",
					getWhereBlockByEndTime(request));
			whereBlock = StringUtil.linkString(whereBlock, " and ",
					getWhereBlockByCarInfoNo(request, hqlInfo));

			hqlInfo.setWhereBlock(whereBlock);
			hqlInfo.setOrderBy("kmCarmngDispatchersInfo.fdStartTime desc");
			if (StringUtil.isNotNull((String) request
					.getAttribute("fdStartTime"))) {
				hqlInfo.setParameter("fdStartTime", DateUtil
						.convertStringToDate((String) request
								.getAttribute("fdStartTime"),
								DateUtil.TYPE_DATETIME, Locale.getDefault()));
			}
			if (StringUtil
					.isNotNull((String) request.getAttribute("fdEndTime"))) {
				hqlInfo.setParameter("fdEndTime", DateUtil.convertStringToDate(
						(String) request.getAttribute("fdEndTime"),
						DateUtil.TYPE_DATETIME, Locale.getDefault()));
			}
			List kmCarmngDispatchersInfoList = getServiceImp(request).findList(
					hqlInfo);
			// 记录操作日志
			UserOperHelper.logFindAll(kmCarmngDispatchersInfoList,
					getServiceImp(request).getModelName());
			request.setAttribute("kmCarmngDispatchersInfoList",
					kmCarmngDispatchersInfoList);
		} catch (Exception e) {
			messages.addError(e);
		}

		TimeCounter.logCurrentTime("Action-search", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages)
					.addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
			return getActionForward("failure", mapping, form, request, response);
		} else {
			return getActionForward("search", mapping, form, request, response);
		}
	}

	private String getWhereBlockByCarInfoNo(HttpServletRequest request,
			HQLInfo hqlInfo) {
		String whereBlock = "";
		String fdCarInfoNo = request.getParameter("fdCarInfoNo");
		if (StringUtil.isNotNull(fdCarInfoNo)) {
			whereBlock = "kmCarmngDispatchersInfo.fdCarInfo.fdNo like :fdCarInfoNo";
			hqlInfo.setParameter("fdCarInfoNo", "%" + fdCarInfoNo + "%");
			request.setAttribute("fdCarInfoNo", fdCarInfoNo);
		}
		hqlInfo.setWhereBlock(whereBlock);
		return hqlInfo.getWhereBlock();
	}

	private String getWhereBlockByEndTime(HttpServletRequest request) {
		String whereBlock = "";
		String fdEndTime = request.getParameter("fdEndTime");
		java.util.Date nowDate = new java.util.Date();
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(nowDate);
		calendar.set(Calendar.DAY_OF_MONTH, 0);
		calendar.add(Calendar.DAY_OF_MONTH, 1);
		if (StringUtil.isNull(fdEndTime)) {
			fdEndTime = DateUtil.convertDateToString(nowDate,
					DateUtil.TYPE_DATETIME, Locale.getDefault());

		}
		if (StringUtil.isNotNull(fdEndTime)) {
			whereBlock = "kmCarmngDispatchersInfo.fdEndTime <= :fdEndTime";
			request.setAttribute("fdEndTime", fdEndTime);
		}
		return whereBlock;
	}

	private String getWhereBlockByStartTime(HttpServletRequest request) {
		String whereBlock = "";
		String fdStartTime = request.getParameter("fdStartTime");
		java.util.Date nowDate = new java.util.Date();
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(nowDate);
		calendar.set(Calendar.DAY_OF_MONTH, 0);
		calendar.add(Calendar.DAY_OF_MONTH, 1);
		if (StringUtil.isNull(fdStartTime)) {
			fdStartTime = DateUtil.convertDateToString(calendar.getTime(),
					DateUtil.TYPE_DATETIME, Locale.getDefault());

		}
		if (StringUtil.isNotNull(fdStartTime)) {
			whereBlock = "kmCarmngDispatchersInfo.fdStartTime >= :fdStartTime";
			request.setAttribute("fdStartTime", fdStartTime);
		}

		return whereBlock;
	}

	public void saveExportExcel(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-saveExportExcel", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			HQLInfo hqlInfo = new HQLInfo();
			String whereBlock = "1 < 2";
			whereBlock = StringUtil.linkString(whereBlock, " and ",
					getWhereBlockByStartTime(request));
			whereBlock = StringUtil.linkString(whereBlock, " and ",
					getWhereBlockByEndTime(request));
			whereBlock = StringUtil.linkString(whereBlock, " and ",
					getWhereBlockByCarInfoNo(request, hqlInfo));

			hqlInfo.setWhereBlock(whereBlock);
			hqlInfo.setOrderBy("kmCarmngDispatchersInfo.fdStartTime desc");
			if (StringUtil.isNotNull((String) request
					.getAttribute("fdStartTime"))) {
				hqlInfo.setParameter("fdStartTime", DateUtil
						.convertStringToDate((String) request
								.getAttribute("fdStartTime"),
								DateUtil.TYPE_DATETIME, Locale.getDefault()));
			}
			if (StringUtil
					.isNotNull((String) request.getAttribute("fdEndTime"))) {
				hqlInfo.setParameter("fdEndTime", DateUtil.convertStringToDate(
						(String) request.getAttribute("fdEndTime"),
						DateUtil.TYPE_DATETIME, Locale.getDefault()));
			}
			List kmCarmngDispatchersInfoList = getServiceImp(request).findList(
					hqlInfo);
			((IKmCarmngDispatchersInfoListService) getServiceImp(request))
					.saveExportExcel(kmCarmngDispatchersInfoList, response);
		} catch (Exception e) {
			messages.addError(e);
		}
		TimeCounter.logCurrentTime("Action-saveExportExcel", false, getClass());
	}

	private List findDispatchInfoListByMotoId(String fdMotorcadeId) throws Exception {
		HQLInfo hqlInfo = new HQLInfo();
		hqlInfo.setSelectBlock("kmCarmngDispatchersInfoList.fdId");
		hqlInfo.setWhereBlock(" kmCarmngDispatchersInfoList.fdMotorcadeId =:fdMotorcadeId");
		hqlInfo.setParameter("fdMotorcadeId", fdMotorcadeId);
		List fs = getDispatchersInfoListServiceImp().findList(hqlInfo);
		return fs;
	}

	@Override
	protected void changeFindPageHQLInfo(HttpServletRequest request,
										 HQLInfo hqlInfo) throws Exception {
		super.changeFindPageHQLInfo(request, hqlInfo);
		String whereBlock = hqlInfo.getWhereBlock();
		String fdMotorCadeId = request.getParameter("fdMotorcadeId");
		if (StringUtil.isNotNull(fdMotorCadeId)) {
			List list = findDispatchInfoListByMotoId(fdMotorCadeId);
			if (!list.isEmpty()) {
				String whereBlock1 = HQLUtil.buildLogicIN(
						"kmCarmngDispatchersInfo.fdDispatchersInfoList.fdId",
						list);
				if (StringUtil.isNotNull(whereBlock)) {
					whereBlock = whereBlock + " and " + whereBlock1;
				} else {
					whereBlock = whereBlock1;
				}
			} else {
				whereBlock = StringUtil.isNotNull(whereBlock) ? whereBlock += " and 1=2" : "1=2";
			}
		}
		hqlInfo.setWhereBlock(whereBlock);
	}

	public ActionForward listByCarmngInfo(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		TimeCounter.logCurrentTime("Action-listByCarmngInfo", true, getClass());
		KmssMessages messages = new KmssMessages();
		String fdCarId = request.getParameter("fdCarId");
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
			if (StringUtil.isNotNull(fdCarId)) {
				String whereBlock = "kmCarmngDispatchersInfo.fdCarInfo.fdId =:fdCarId";
				hqlInfo.setParameter("fdCarId", fdCarId);
				hqlInfo.setWhereBlock(whereBlock);
			}
			hqlInfo.setAuthCheckType(SysAuthConstant.AUTH_CHECK_NONE);
			Page page = getServiceImp(request).findPage(hqlInfo);
			request.setAttribute("queryPage", page);
		} catch (Exception e) {
			messages.addError(e);
		}

		TimeCounter
				.logCurrentTime("Action-listByCarmngInfo", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages)
					.addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
			return getActionForward("failure", mapping, form, request, response);
		} else {
			return getActionForward("list", mapping, form, request, response);
		}
	}

	public ActionForward listByMotorCade(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		TimeCounter.logCurrentTime("Action-listByMotorCade", true, getClass());
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
			changeFindPageHQLInfo(request, hqlInfo);
			hqlInfo.setAuthCheckType(SysAuthConstant.AUTH_CHECK_NONE);
			Page page = getServiceImp(request).findPage(hqlInfo);
			// 记录操作日志
			UserOperHelper.logFindAll(page.getList(),
					getServiceImp(request).getModelName());
			request.setAttribute("queryPage", page);
		} catch (Exception e) {
			messages.addError(e);
		}

		TimeCounter.logCurrentTime("Action-listByMotorCade", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages)
					.addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
			return getActionForward("failure", mapping, form, request, response);
		} else {
			return getActionForward("listByMotorCade", mapping, form, request,
					response);
		}
	}

	@Override
	// 重写排序方法
	protected String getFindPageOrderBy(HttpServletRequest request,
			String curOrderBy) throws Exception {
		if (StringUtil.isNull(curOrderBy)) {
			curOrderBy = " kmCarmngDispatchersInfo.fdFlag asc,kmCarmngDispatchersInfo.docCreateTime desc";// " kmCarmngDispatchersInfo.fdFlag asc and kmCarmngDispatchersInfo.docCreateTime asc";
		}
		return curOrderBy;

	}

	/**
	 * @Title: dispatchOrNot
	 * @Description: TODO(用于判断调度车辆或驾驶员是否已经调度)
	 * @param @param mapping
	 * @param @param form
	 * @param @param request
	 * @param @param response
	 * @param @return
	 * @param @throws Exception 设定文件
	 * @return ActionForward 返回类型
	 * @throws
	 */
	public ActionForward dispatchOrNot(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String fdCarInfoId = request.getParameter("fdCarInfoId");
		String fdDriverId = request.getParameter("fdDriverId");
		String fdStartTime = request.getParameter("fdStartTime");
		String fdEndTime = request.getParameter("fdEndTime");
		fdStartTime += ":00";
		fdEndTime += ":59";
		Date startDate = DateUtil.convertStringToDate(fdStartTime,
				DateUtil.TYPE_DATETIME, Locale.getDefault());
		Date endDate = DateUtil.convertStringToDate(fdEndTime,
				DateUtil.TYPE_DATETIME, Locale.getDefault());
		HQLInfo hqlInfo = new HQLInfo();
		hqlInfo
				.setWhereBlock(" (kmCarmngDispatchersInfo.fdCarInfo.fdId='" + fdCarInfoId
						+ "' or kmCarmngDispatchersInfo.fdDriverId='" + fdDriverId
						+ "') and (kmCarmngDispatchersInfo.fdFlag='0' and kmCarmngDispatchersInfo.fdStartTime<=:endDate and kmCarmngDispatchersInfo.fdEndTime>=:startDate)");
		hqlInfo.setParameter("endDate", endDate);
		hqlInfo.setParameter("startDate", startDate);
		List applicationList = getServiceImp(request).findList(hqlInfo);
		if (applicationList == null || applicationList.isEmpty()) {
			response(response, "0");
		} else {
            response(response, "1");
        }
		return null;
	}

	private void response(HttpServletResponse response, String message)
			throws Exception {
		response.setCharacterEncoding("UTF-8");
		response.getOutputStream().write(message.getBytes("UTF-8"));
	}

	// 根据所选驾驶员查询手机号码
	public ActionForward selectPhoneNumber(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String fdId = request.getParameter("fdId");
		if (StringUtil.isNotNull(fdId)) {
			SysOrgPerson person = (SysOrgPerson) getSysOrgPersonServiceImp(
					request).findByPrimaryKey(fdId);
			JSONObject obj = new JSONObject();
			if (StringUtil.isNotNull(person.getFdMobileNo())) {
				obj.put("phoneNumber", person.getFdMobileNo());
			} else {
				obj.put("phoneNumber", "");
			}
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(obj.toString());
		}
		return null;
	}

	/**
	 * <p>查询调用单信息 by carId</p>
	 * @author 孙佳
	 * @throws IOException 
	 * @throws Exception 
	 */
	public String selectDispatchersInfoByCarId(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		JSONArray array = new JSONArray();
		List<String> checkList = new ArrayList<String>();
		try{
			JSONObject object = null;
			String carIds = request.getParameter("carId");
			String startTime = request.getParameter("startTime");
			String fdEndTime = request.getParameter("fdEndTime");
			String fdId = request.getParameter("fdId");
			Date startDate = DateUtil.convertStringToDate(startTime, DateUtil.PATTERN_DATETIME, Locale.getDefault());
			Date endDate = DateUtil.convertStringToDate(fdEndTime, DateUtil.PATTERN_DATETIME, Locale.getDefault());
			if (StringUtil.isNotNull(carIds)) {
				String[] carId = carIds.split(",");
				HQLInfo hqlInfo = new HQLInfo();
				for (int i = 0; i < carId.length; i++) {
					List dispatchInfoList = findDispatchInfoListBycarId(carId[i]);
					if(null != dispatchInfoList && dispatchInfoList.size() > 0){
						String whereBlock = HQLUtil.buildLogicIN("kmCarmngDispatchersInfo.fdDispatchersInfoList.fdId", dispatchInfoList);
						whereBlock += " and kmCarmngDispatchersInfo.fdStartTime <= :fdEndTime and kmCarmngDispatchersInfo.fdEndTime>=:startTime and kmCarmngDispatchersInfo.fdFlag != '1'";
						if (StringUtil.isNotNull(fdId)) {
							whereBlock += " and kmCarmngDispatchersInfo.fdId != :fdId";
						}
						hqlInfo.setWhereBlock(whereBlock);
						/*hqlInfo.setParameter("fdCarInfoId", "%" + carId[i] + "%");*/
						hqlInfo.setParameter("fdEndTime", endDate);
						hqlInfo.setParameter("startTime", startDate);
						hqlInfo.setParameter("fdId", fdId);
						List<KmCarmngDispatchersInfo> list = getServiceImp(request).findList(hqlInfo);
						if (null != list && list.size() > 0) {
							for (KmCarmngDispatchersInfo dispatchersInfo : list) {
								object = new JSONObject();
								String[] applicationIds = dispatchersInfo.getFdApplicationIds().split(",");
								for(int j=0; j<applicationIds.length; j++){
									KmCarmngApplication application = (KmCarmngApplication) getKmCarmngApplicationService().findByPrimaryKey(applicationIds[j]);
									String applicationFdId = application.getFdId();
									object.put("fdId", applicationFdId);
									object.put("docSubject", application.getDocSubject());
									if (!checkList.contains(applicationFdId)) {
										checkList.add(applicationFdId);
										array.add(object);
									}
								}
							}
						}
					}
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error("", e);
		}
		response.setCharacterEncoding("UTF-8");
		response.getWriter().append(array.toString());
		response.getWriter().flush();
		response.getWriter().close();
		return null;
	}

	private List findDispatchInfoListBycarId(String carId) throws Exception {
		HQLInfo hqlInfo = new HQLInfo();
		hqlInfo.setSelectBlock("kmCarmngDispatchersInfoList.fdId");
		hqlInfo.setWhereBlock(" kmCarmngDispatchersInfoList.fdCarInfo.fdId =:carId");
		hqlInfo.setParameter("carId", carId);
		List fs = getDispatchersInfoListServiceImp().findList(hqlInfo);
		return fs;
	}
}
