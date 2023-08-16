
package com.landray.kmss.km.carmng.actions;

import java.io.PrintWriter;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.ArrayUtils;
import org.json.simple.JSONObject;

import com.landray.kmss.common.actions.ExtendAction;
import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.exception.NoRecordException;
import com.landray.kmss.common.exception.UnexpectedRequestException;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.common.test.TimeCounter;
import com.landray.kmss.component.bklink.util.CompBklinkUtil;
import com.landray.kmss.km.carmng.forms.KmCarmngInfomationForm;
import com.landray.kmss.km.carmng.interfaces.Constants;
import com.landray.kmss.km.carmng.model.KmCarmngCategory;
import com.landray.kmss.km.carmng.model.KmCarmngMotorcadeSet;
import com.landray.kmss.km.carmng.service.IKmCarmngCategoryService;
import com.landray.kmss.km.carmng.service.IKmCarmngInfomationService;
import com.landray.kmss.km.carmng.service.IKmCarmngMotorcadeSetService;
import com.landray.kmss.sys.authorization.constant.ISysAuthConstant;
import com.landray.kmss.sys.authorization.interfaces.SysAuthAreaUtils;
import com.landray.kmss.sys.organization.model.SysOrgElement;
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


/**
 * 创建日期 2010-三月-24
 * @author 叶中奇
 */
public class KmCarmngInfomationAction extends ExtendAction

{
	protected IKmCarmngInfomationService kmCarmngInfomationService;

	@Override
	protected IKmCarmngInfomationService getServiceImp(HttpServletRequest request) {
		if(kmCarmngInfomationService == null) {
            kmCarmngInfomationService = (IKmCarmngInfomationService)getBean("kmCarmngInfomationService");
        }
		return kmCarmngInfomationService;
	}
	
	private IKmCarmngCategoryService kmCarmngCategoryService ;
	
	public IKmCarmngCategoryService getKmCarmngCategoryService() {
		if(kmCarmngCategoryService == null){
			kmCarmngCategoryService = (IKmCarmngCategoryService) getBean("kmCarmngCategoryService");
		}
		return this.kmCarmngCategoryService;
	}

	private IKmCarmngMotorcadeSetService kmCarmngMotorcadeSetService ;
	
	
	
	public IKmCarmngMotorcadeSetService getKmCarmngMotorcadeSetService() {
		if(kmCarmngMotorcadeSetService == null){
			kmCarmngMotorcadeSetService = (IKmCarmngMotorcadeSetService) getBean("kmCarmngMotorcadeSetService");
		}
		return this.kmCarmngMotorcadeSetService;
	}


	@Override
	protected ActionForm createNewForm(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		super.createNewForm(mapping, form, request, response);
		String categoryId = request.getParameter("categoryId");
		String motorcadeId = request.getParameter("motorcadeId");
		KmCarmngInfomationForm kmCarmngInfomationForm = (KmCarmngInfomationForm) form;
		kmCarmngInfomationForm.setDocCreateTime(DateUtil.convertDateToString(new Date(), DateUtil.TYPE_DATETIME,Locale.getDefault()));
		SysOrgElement person = UserUtil.getUser();
		kmCarmngInfomationForm.setDocCreatorId(person.getFdId());
		kmCarmngInfomationForm.setDocCreatorName(person.getFdName());
		kmCarmngInfomationForm.setDocStatus(Constants.KMCARMNG_TYPE_USE);
		if(StringUtil.isNotNull(categoryId)){
			KmCarmngCategory  kmCarmngCategory  = (KmCarmngCategory) getKmCarmngCategoryService().findByPrimaryKey(categoryId);
			kmCarmngInfomationForm.setFdVehichesTypeId(kmCarmngCategory.getFdId());
			kmCarmngInfomationForm.setFdVehichesTypeName(kmCarmngCategory.getFdName());
		}
		if(StringUtil.isNotNull(motorcadeId)){
			KmCarmngMotorcadeSet kmCarmngMotorcadeSet =  (KmCarmngMotorcadeSet)getKmCarmngMotorcadeSetService().findByPrimaryKey(motorcadeId);
			if(kmCarmngMotorcadeSet != null){
				kmCarmngInfomationForm.setFdMotorcadeId(kmCarmngMotorcadeSet.getFdId());
				kmCarmngInfomationForm.setFdMotorcadeName(kmCarmngMotorcadeSet.getFdName());
			}
		}
		return kmCarmngInfomationForm;
		
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
			KmCarmngInfomationForm kmCarmngInfomationForm=(KmCarmngInfomationForm)form;
			if(StringUtil.isNull(kmCarmngInfomationForm.getFdSysDriverId())){
				kmCarmngInfomationForm.setFdSysDriverId(null);
			}
			getServiceImp(request).add((IExtendForm) form,
					new RequestContext(request));
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
	/**
	 * 将浏览器提交的表单数据更新到数据库中。<br>
	 * 该操作一般以HTTP的POST方式触发。
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return 执行成功，返回success页面，否则返回edit页面
	 * @throws Exception
	 */
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
			KmCarmngInfomationForm kmCarmngInfomationForm=(KmCarmngInfomationForm)form;
			if(StringUtil.isNull(kmCarmngInfomationForm.getFdSysDriverId())){
				kmCarmngInfomationForm.setFdSysDriverId(null);
			}
			getServiceImp(request).update((IExtendForm) form,
					new RequestContext(request));
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
	
	@Override
	protected void changeFindPageHQLInfo(HttpServletRequest request,
										 HQLInfo hqlInfo) throws Exception {
		String categoryId = request.getParameter("categoryId");		
		String motorcadeId = request.getParameter("motorcadeId");		
		String docStatus = request.getParameter("docStatus");	
		String whereBlock = hqlInfo.getWhereBlock();
		if(StringUtil.isNull(whereBlock)){
			whereBlock = "1=1 ";
		}
		if(StringUtil.isNotNull(categoryId)){			
			KmCarmngCategory kmCarmngCategory = (KmCarmngCategory) this.getKmCarmngCategoryService().findByPrimaryKey(categoryId);
			whereBlock += " and kmCarmngInfomation.fdVehichesType.fdHierarchyId like :fdHierarchyId";
			hqlInfo.setParameter("fdHierarchyId", "%"+kmCarmngCategory.getFdHierarchyId()+"%");
		}
		if(StringUtil.isNotNull(docStatus)){
				whereBlock += " and kmCarmngInfomation.docStatus = :docStatus";
				hqlInfo.setParameter("docStatus",docStatus);

		}	
		if(StringUtil.isNotNull(motorcadeId)){
			whereBlock += " and kmCarmngInfomation.fdMotorcade.fdId = :motorcadeId";
			hqlInfo.setParameter("motorcadeId",motorcadeId);
		}
		hqlInfo.setWhereBlock(whereBlock);
	}

	private String getFindWhereBlockByMotorcade(HttpServletRequest request) {
		String motorcadeId = request.getParameter("motorcadeId");		
		String whereBlock = "";		
		whereBlock = "kmCarmngInfomation.fdMotorcade.fdId = '"+motorcadeId+"'";
		return whereBlock;
	}

	private String getFindWhereBlockByStatus(HttpServletRequest request) {
		String whereBlock = "";
		String docStatus = request.getParameter("docStatus");
		if(StringUtil.isNotNull(docStatus)){
			whereBlock = "kmCarmngInfomation.docStatus = '"+docStatus+"'";
		}
		return whereBlock;
	}
	
	@Override
	protected void loadActionForm(ActionMapping mapping, ActionForm form,
								  HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		super.loadActionForm(mapping, form, request, response);
		KmCarmngInfomationForm kmCarmngInfomationForm = (KmCarmngInfomationForm) form;
		String fdAnnuaCheckTime = kmCarmngInfomationForm.getFdAnnuaCheckTime();
		String fdInsutanceTime = kmCarmngInfomationForm.getFdInsutanceTime();
		if(StringUtil.isNotNull(fdInsutanceTime)){
			fdInsutanceTime = fdInsutanceTime.substring(0, 10);
			kmCarmngInfomationForm.setFdInsutanceTime(fdInsutanceTime);
		}
		if(StringUtil.isNotNull(fdAnnuaCheckTime)){
			fdAnnuaCheckTime = fdAnnuaCheckTime.substring(0, 10);
			kmCarmngInfomationForm.setFdAnnuaCheckTime(fdAnnuaCheckTime);
		}	
		String ids = getServiceImp(request).getCarPicIdsByCarId(
				kmCarmngInfomationForm.getFdId());
		if (StringUtil.isNotNull(ids)) {
			request.setAttribute("firstImgId", ids.split(";")[0]);
			//request.setAttribute("imgUrlIds", ids);
		}
	}
	
	@Override
	protected String getFindPageOrderBy(HttpServletRequest request,
			String curOrderBy) throws Exception {
		if(StringUtil.isNull(curOrderBy)){
			curOrderBy = "kmCarmngInfomation.docCreateTime desc";
		}
		return curOrderBy;
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
                getServiceImp(request).delete(id);
            }
		} catch (Exception e) {
			messages.addError(e);
			String forwardTemp = CompBklinkUtil.isDeleteConstraintException(e);
			if (StringUtil.isNotNull(forwardTemp)) {//存在约束健
				messages.addMsg(new KmssMessage("km-carmng:kmCarmngInfomation.constraint.error"));	
			}
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
		JSONObject json = new JSONObject();
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
				getServiceImp(request).delete(ids);
			}

		} catch (Exception e) {
			messages.addError(e);	
			json.put("result", "failure");
			String forwardTemp = CompBklinkUtil.isDeleteConstraintException(e);
			if (StringUtil.isNotNull(forwardTemp)) {//存在约束健
				json.put("msg",ResourceUtil.getString("km-carmng:kmCarmngInfomation.constraint.error", request.getLocale())); //
			}else{
				json.put("msg",e.getMessage());
			}
		}

		KmssReturnPage.getInstance(request).addMessages(messages).addButton(
				KmssReturnPage.BUTTON_RETURN).save(request);
		TimeCounter.logCurrentTime("Action-deleteall", false, getClass());
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		if (!messages.hasError()){
			json.put("result", "success");
			json.put("msg",ResourceUtil.getString("return.optSuccess", request.getLocale()));
		}
		out.print(json.toString());
		return null;
	}
	
	/**
	 * 根据id值加载车辆信息，ajax调用
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward loadCarByIds(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String ids = request.getParameter("fdCarIds");
		String fdStartTime = request.getParameter("fdStartTime");
		String fdEndTime = request.getParameter("fdEndTime");
		String[] fdIds = ids.split(";");
		if (StringUtil.isNotNull(ids)) {
			JSONArray jsonArr = getServiceImp(request).loadCarByIds(fdIds, fdStartTime, fdEndTime);
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(jsonArr.toString());
		}
		return null;
	}
	
}

