
package com.landray.kmss.km.carmng.actions;

import com.landray.kmss.common.actions.ExtendAction;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.common.test.TimeCounter;
import com.landray.kmss.km.carmng.service.IKmCarmngUserFeeInfoService;
import com.landray.kmss.util.KmssMessages;
import com.landray.kmss.util.KmssReturnPage;
import com.landray.kmss.web.action.ActionForm;
import com.landray.kmss.web.action.ActionForward;
import com.landray.kmss.web.action.ActionMapping;
import com.sunbor.web.tag.Page;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.ArrayList;
import java.util.List;


/**
 * 创建日期 2010-三月-24
 * @author 黄郴
 * 车辆统计
 */
public class KmCarmngUserFeeInfoAction extends ExtendAction {
	protected IKmCarmngUserFeeInfoService kmCarmngUserFeeInfoService;

	@Override
	protected IBaseService getServiceImp(HttpServletRequest request) {
		if(kmCarmngUserFeeInfoService == null) {
            kmCarmngUserFeeInfoService = (IKmCarmngUserFeeInfoService)getBean("kmCarmngUserFeeInfoService");
        }
		return kmCarmngUserFeeInfoService;
	}


	public ActionForward count(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-count", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			HQLInfo hqlInfo = new HQLInfo();
			List valueList = ((IKmCarmngUserFeeInfoService) getServiceImp(request)).count(request);
			request.setAttribute("valueList", valueList);
			request.setAttribute("valueListSize", valueList.size());
		} catch (Exception e) {
			messages.addError(e);
		}

		TimeCounter.logCurrentTime("Action-count", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages).addButton(KmssReturnPage.BUTTON_CLOSE)
					.save(request);
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
			List valueList = ((IKmCarmngUserFeeInfoService) getServiceImp(request)).count(request);
			((IKmCarmngUserFeeInfoService)getServiceImp(request)).saveExportExcel(valueList,response,request);
		} catch (Exception e) {
			messages.addError(e);
			e.printStackTrace();
		}
		TimeCounter.logCurrentTime("Action-saveExportExcel", false, getClass());
	}

	/**
	 * <p>车辆使用统计</p>
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 * @author 孙佳
	 */
	public ActionForward carUseCount(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		TimeCounter.logCurrentTime("Action-carUseCount", true, getClass());
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
			//int rowsize = SysConfigParameters.getRowSize();
			int rowsize = 10;
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
			Page page = ((IKmCarmngUserFeeInfoService) getServiceImp(request)).carUseCount(hqlInfo, request);
			request.setAttribute("queryPage", page);
		} catch (Exception e) {
			messages.addError(e);
		}
		TimeCounter.logCurrentTime("Action-carUseCount", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages).addButton(KmssReturnPage.BUTTON_CLOSE)
					.save(request);
			return getActionForward("failure", mapping, form, request, response);
		} else {
			return getActionForward("useCount", mapping, form, request, response);
		}
	}

	public void exportCarUseCountExcel(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		TimeCounter.logCurrentTime("Action-exportCarUseCountExcel", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			HQLInfo hqlInfo = new HQLInfo();
			List list = ((IKmCarmngUserFeeInfoService) getServiceImp(request)).usedCarStatistic(hqlInfo, request);
			((IKmCarmngUserFeeInfoService) getServiceImp(request)).exportCarUseExcel(list, response, request);
		} catch (Exception e) {
			messages.addError(e);
			e.printStackTrace();
		}
		TimeCounter.logCurrentTime("Action-exportCarUseCountExcel", false, getClass());
	}

	/**
	 * <p>查询车辆使用详细记录</p>
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 * @author 孙佳
	 */
	public ActionForward carUseDetail(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		TimeCounter.logCurrentTime("Action-carUseDetail", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			String s_pageno = request.getParameter("pageno");
			String s_rowsize = request.getParameter("rowsize");
			String orderby = request.getParameter("orderby");
			String ordertype = request.getParameter("ordertype");

			String carId = request.getParameter("carId");
			String fdStartDate = request.getParameter("fdStartDate");
			String fdEndDate = request.getParameter("fdEndDate");
			String timeType = request.getParameter("timeType");
			boolean isReserve = false;
			if (ordertype != null && "down".equalsIgnoreCase(ordertype)) {
				isReserve = true;
			}
			int pageno = 0;
			//int rowsize = SysConfigParameters.getRowSize();
			int rowsize = 10;
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
			Page page = ((IKmCarmngUserFeeInfoService) getServiceImp(request)).carUseDetail(hqlInfo, request, false);
			request.setAttribute("queryPage", page);
		} catch (Exception e) {
			messages.addError(e);
		}
		TimeCounter.logCurrentTime("Action-carUseDetail", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages).addButton(KmssReturnPage.BUTTON_CLOSE)
					.save(request);
			return getActionForward("failure", mapping, form, request, response);
		} else {
			return getActionForward("detail", mapping, form, request, response);
		}
	}
	public void exportCarUseDetailExcel(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		TimeCounter.logCurrentTime("Action-exportCarUseDetailExcel", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			HQLInfo hqlInfo = new HQLInfo();
			Page page = ((IKmCarmngUserFeeInfoService) getServiceImp(request)).carUseDetail(hqlInfo, request, true);
			((IKmCarmngUserFeeInfoService) getServiceImp(request)).exportCarUseDetailExcel(page.getList(), response,
					request);
		} catch (Exception e) {
			messages.addError(e);
			e.printStackTrace();
		}
		TimeCounter.logCurrentTime("Action-exportCarUseDetailExcel", false, getClass());
	}

	/**
	 * <p>查询部门或个人用车统计</p>
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 * @author 孙佳
	 */
	public ActionForward queryOrgCount(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		TimeCounter.logCurrentTime("Action-queryOrgCount", true, getClass());
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
			//int rowsize = SysConfigParameters.getRowSize();
			int rowsize = 10;
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
			Page page = ((IKmCarmngUserFeeInfoService) getServiceImp(request)).queryOrgCount(hqlInfo, request);
			request.setAttribute("queryPage", page);

		} catch (Exception e) {
			messages.addError(e);
		}
		TimeCounter.logCurrentTime("Action-queryOrgCount", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages).addButton(KmssReturnPage.BUTTON_CLOSE)
					.save(request);
			return getActionForward("failure", mapping, form, request, response);
		} else {
			return getActionForward("queryOrgCount", mapping, form, request, response);
		}
	}

	public void exportQueryOrgCountExcel(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		TimeCounter.logCurrentTime("Action-exportQueryOrgCountExcel", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			HQLInfo hqlInfo = new HQLInfo();
			int pageNo = 1;
			Page page = null;
			List list = new ArrayList();
			do{
				page = ((IKmCarmngUserFeeInfoService) getServiceImp(request)).queryOrgCount(hqlInfo, request);
				list.addAll(page.getList());
				pageNo ++;
				hqlInfo.setPageNo(pageNo);
			}while (page.isHasNextPage());

			((IKmCarmngUserFeeInfoService) getServiceImp(request)).exportQueryOrgExcel(list, response,
					request);
		} catch (Exception e) {
			messages.addError(e);
			e.printStackTrace();
		}
		TimeCounter.logCurrentTime("Action-exportQueryOrgCountExcel", false, getClass());
	}

	/**
	 * <p>查询部门或用户的用车详细记录</p>
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 * @author 孙佳
	 */
	public ActionForward queryOrgDetail(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		TimeCounter.logCurrentTime("Action-queryOrgDetail", true, getClass());
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
			//int rowsize = SysConfigParameters.getRowSize();
			int rowsize = 10;
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
			Page page = ((IKmCarmngUserFeeInfoService) getServiceImp(request)).queryOrgDetail(hqlInfo, request);
			request.setAttribute("queryPage", page);

		} catch (Exception e) {
			messages.addError(e);
		}
		TimeCounter.logCurrentTime("Action-queryOrgDetail", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages).addButton(KmssReturnPage.BUTTON_CLOSE)
					.save(request);
			return getActionForward("failure", mapping, form, request, response);
		} else {
			return getActionForward("queryOrgDetail", mapping, form, request, response);
		}
	}

	public void exportQueryOrgDetailExcel(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		TimeCounter.logCurrentTime("Action-exportQueryOrgDetailExcel", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			HQLInfo hqlInfo = new HQLInfo();
			int pageNo = 1;
			Page page = null;
			List list = new ArrayList();
			do{
				page = ((IKmCarmngUserFeeInfoService) getServiceImp(request)).queryOrgDetail(hqlInfo, request);
				list.addAll(page.getList());
				pageNo ++;
				hqlInfo.setPageNo(pageNo);
			}while (page.isHasNextPage());

			((IKmCarmngUserFeeInfoService) getServiceImp(request)).exportQueryOrgDetailExcel(list, response,
					request);
		} catch (Exception e) {
			messages.addError(e);
			e.printStackTrace();
		}
		TimeCounter.logCurrentTime("Action-exportQueryOrgDetailExcel", false, getClass());
	}

	/**
	 * <p>驾驶员出车统计</p>
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 * @author 孙佳
	 */
	public ActionForward queryDriverCount(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		TimeCounter.logCurrentTime("Action-queryDriverCount", true, getClass());
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
			//int rowsize = SysConfigParameters.getRowSize();
			int rowsize = 10;
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
			Page page = ((IKmCarmngUserFeeInfoService) getServiceImp(request)).queryDriverCount(hqlInfo, request);
			request.setAttribute("queryPage", page);

		} catch (Exception e) {
			messages.addError(e);
		}
		TimeCounter.logCurrentTime("Action-queryDriverCount", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages).addButton(KmssReturnPage.BUTTON_CLOSE)
					.save(request);
			return getActionForward("failure", mapping, form, request, response);
		} else {
			return getActionForward("queryDriverCount", mapping, form, request, response);
		}
	}
	public void exportQueryDriverExcel(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		TimeCounter.logCurrentTime("Action-exportQueryDriverExcel", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			HQLInfo hqlInfo = new HQLInfo();
			int pageNo = 1;
			Page page = null;
			List list = new ArrayList();
			do{
				page = ((IKmCarmngUserFeeInfoService) getServiceImp(request)).queryDriverCount(hqlInfo, request);
				list.addAll(page.getList());
				pageNo ++;
				hqlInfo.setPageNo(pageNo);
			}while (page.isHasNextPage());

			((IKmCarmngUserFeeInfoService) getServiceImp(request)).exportQueryDriverExcel(list, response, request);
		} catch (Exception e) {
			messages.addError(e);
			e.printStackTrace();
		}
		TimeCounter.logCurrentTime("Action-exportQueryDriverExcel", false, getClass());
	}

	/**
	 * <p>车辆费用汇总统计</p>
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 * @author 孙佳
	 */
	public ActionForward queryCarFeeCount(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		TimeCounter.logCurrentTime("Action-queryCarFeeCount", true, getClass());
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
			//int rowsize = SysConfigParameters.getRowSize();
			int rowsize = 10;
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
			Page page = ((IKmCarmngUserFeeInfoService) getServiceImp(request)).queryCarFeeCount(hqlInfo, request);
			request.setAttribute("queryPage", page);

		} catch (Exception e) {
			messages.addError(e);
		}
		TimeCounter.logCurrentTime("Action-queryCarFeeCount", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages).addButton(KmssReturnPage.BUTTON_CLOSE)
					.save(request);
			return getActionForward("failure", mapping, form, request, response);
		} else {
			return getActionForward("queryCarFeeCount", mapping, form, request, response);
		}
	}

	public void exportQueryCarFeeExcel(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		TimeCounter.logCurrentTime("Action-exportQueryCarFeeExcel", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			HQLInfo hqlInfo = new HQLInfo();
			int pageNo = 1;
			Page page = null;
			List list = new ArrayList();
			do{
				page = ((IKmCarmngUserFeeInfoService) getServiceImp(request)).queryCarFeeCount(hqlInfo, request);
				list.addAll(page.getList());
				pageNo ++;
				hqlInfo.setPageNo(pageNo);
			}while (page.isHasNextPage());

			((IKmCarmngUserFeeInfoService) getServiceImp(request)).exportQueryCarFeeExcel(list, response, request);
		} catch (Exception e) {
			messages.addError(e);
			e.printStackTrace();
		}
		TimeCounter.logCurrentTime("Action-exportQueryCarFeeExcel", false, getClass());
	}

}

