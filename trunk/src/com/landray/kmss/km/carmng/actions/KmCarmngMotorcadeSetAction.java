package com.landray.kmss.km.carmng.actions;

import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.ArrayUtils;

import com.landray.kmss.common.actions.ExtendAction;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.exception.NoRecordException;
import com.landray.kmss.common.exception.UnexpectedRequestException;
import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.common.test.TimeCounter;
import com.landray.kmss.component.bklink.util.CompBklinkUtil;
import com.landray.kmss.km.carmng.forms.KmCarmngMotorcadeSetForm;
import com.landray.kmss.km.carmng.model.KmCarmngMotorcadeSet;
import com.landray.kmss.km.carmng.service.IKmCarmngMotorcadeSetService;
import com.landray.kmss.sys.authorization.constant.ISysAuthConstant;
import com.landray.kmss.sys.authorization.interfaces.SysAuthAreaUtils;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.util.CriteriaUtil;
import com.landray.kmss.util.CriteriaValue;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.KmssMessage;
import com.landray.kmss.util.KmssMessages;
import com.landray.kmss.util.KmssReturnPage;
import com.landray.kmss.util.ResourceUtil;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.util.UserUtil;
import com.landray.kmss.web.action.ActionForm;
import com.landray.kmss.web.action.ActionForward;
import com.landray.kmss.web.action.ActionMapping;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 创建日期 2010-三月-24
 * 
 * @author 黄郴
 */
public class KmCarmngMotorcadeSetAction extends ExtendAction {
	protected IKmCarmngMotorcadeSetService kmCarmngMotorcadeSetService;

	@Override
	protected IBaseService getServiceImp(HttpServletRequest request) {
		if (kmCarmngMotorcadeSetService == null) {
            kmCarmngMotorcadeSetService = (IKmCarmngMotorcadeSetService) getBean("kmCarmngMotorcadeSetService");
        }
		return kmCarmngMotorcadeSetService;
	}

	@Override
	protected ActionForm createNewForm(ActionMapping mapping, ActionForm form,
									   HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		super.createNewForm(mapping, form, request, response);
		KmCarmngMotorcadeSetForm kmCarmngMotorcadeSetForm = (KmCarmngMotorcadeSetForm) form;
		SysOrgElement person = UserUtil.getUser();
		kmCarmngMotorcadeSetForm.setDocCreateTime(DateUtil.convertDateToString(
				new Date(), DateUtil.TYPE_DATETIME, Locale.getDefault()));
		kmCarmngMotorcadeSetForm.setDocCreatorId(person.getFdId());
		kmCarmngMotorcadeSetForm.setDocCreatorName(person.getFdName());
		kmCarmngMotorcadeSetForm.setIsEffective("true");
		return kmCarmngMotorcadeSetForm;
	}

	@Override
	protected String getFindPageOrderBy(HttpServletRequest request,
			String curOrderBy) throws Exception {
		if (StringUtil.isNull(curOrderBy)) {
			curOrderBy = "kmCarmngMotorcadeSet.fdOrder asc";
		}
		return curOrderBy;
	}

	/**
	 * 获取筛选器中的筛选项
	 */
	public ActionForward getFdMotorcade(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		HQLInfo hqlInfo = new HQLInfo();
		List<?> result = getServiceImp(request).findList(hqlInfo);
		JSONArray jsonArr = new JSONArray();
		JSONObject jsonObj = new JSONObject();
		for (int i = 0; i < result.size(); i++) {
			KmCarmngMotorcadeSet kmCarmngMotorcadeSet = (KmCarmngMotorcadeSet) result
					.get(i);
			jsonObj.put("text", kmCarmngMotorcadeSet.getFdName());
			jsonObj.put("value", kmCarmngMotorcadeSet.getFdId());
			jsonArr.add(jsonObj);
		}
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(jsonArr.toString());		
		return null;
	}
	@Override
	protected void changeFindPageHQLInfo(HttpServletRequest request,
										 HQLInfo hqlInfo) throws Exception {
		super.changeFindPageHQLInfo(request, hqlInfo);
		CriteriaValue cv = new CriteriaValue(request);
		CriteriaUtil.buildHql(cv, hqlInfo, KmCarmngMotorcadeSet.class);		
		// 按标题查询
		String fdName = request.getParameter("fdSearchName");
		if(StringUtil.isNull(fdName)){
			fdName = cv.poll("fdSearchName");
		}
		if (StringUtil.isNotNull(fdName)) {
			hqlInfo.setWhereBlock(StringUtil.linkString(hqlInfo.getWhereBlock(), " and ",
					" kmCarmngMotorcadeSet.fdName like :fdName "));
			hqlInfo.setParameter("fdName", "%" + fdName + "%");
		}
		
	}

	@Override
	public ActionForward delete(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
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
                getServiceImp(request).delete(id);
            }
		} catch (Exception e) {
			messages.addError(e);
			String forwardTemp = CompBklinkUtil.isDeleteConstraintException(e);
			/*if (StringUtil.isNotNull(forwardTemp)) {//存在约束健
				messages.addMsg(new KmssMessage("km-carmng:kmCarmngMotorcadeSet.delete.erroe"));
			}*/
		}

		KmssReturnPage.getInstance(request).addMessages(messages).addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
		TimeCounter.logCurrentTime("Action-delete", false, getClass());
		if (messages.hasError()) {
            return getActionForward("failure", mapping, form, request, response);
        } else {
            return getActionForward("success", mapping, form, request, response);
        }
	}

	@Override
	public ActionForward deleteall(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		TimeCounter.logCurrentTime("Action-deleteall", true, getClass());
		KmssMessages messages = new KmssMessages();
		JSONObject json = new JSONObject();
		try {
			if (!"POST".equals(request.getMethod())) {
                throw new UnexpectedRequestException();
            }
			String[] ids = request.getParameterValues("List_Selected");

			if (ISysAuthConstant.IS_AREA_ENABLED) {
				String[] authIds = SysAuthAreaUtils.removeNoAuthIds(ids, request, "method=delete&fdId=${id}");
				int noAuthIdNum = ids.length - authIds.length;
				if (noAuthIdNum > 0) {
					messages.addMsg(new KmssMessage("sys-authorization:area.batch.operation.info", noAuthIdNum));
				}

				if (!ArrayUtils.isEmpty(authIds)) {
                    getServiceImp(request).delete(authIds);
                }
			} else if (ids != null) {
				getServiceImp(request).delete(ids);
			}

		} catch (Exception e) {
			messages.addError(e);
			json.put("result", "failure");
			String forwardTemp = CompBklinkUtil.isDeleteConstraintException(e);
			if (StringUtil.isNotNull(forwardTemp)) {//存在约束健
				json.put("msg",
						ResourceUtil.getString("km-carmng:kmCarmngMotorcadeSet.delete.erroe", request.getLocale()));
			} else {
				json.put("msg", e.getMessage());
			}
		}

		KmssReturnPage.getInstance(request).addMessages(messages).addButton(KmssReturnPage.BUTTON_RETURN).save(request);
		TimeCounter.logCurrentTime("Action-deleteall", false, getClass());
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		if (!messages.hasError()) {
			json.put("result", "success");
			json.put("msg", ResourceUtil.getString("return.optSuccess", request.getLocale()));
		}
		out.print(json.toString());
		return null;
	}
}
