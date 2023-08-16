package com.landray.kmss.km.carmng.forms;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.common.convertor.FormConvertor_IDToModel;
import com.landray.kmss.common.convertor.FormToModelPropertyMap;
import com.landray.kmss.km.carmng.model.KmCarmngMotorcadeSet;
import com.landray.kmss.sys.number.forms.SysNumberMainMappForm;
import com.landray.kmss.sys.number.interfaces.ISysNumberForm;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.sys.right.interfaces.BaseAuthForm;
import com.landray.kmss.sys.workflow.base.forms.SysWfTemplateForm;
import com.landray.kmss.sys.workflow.interfaces.ISysWfTemplateForm;
import com.landray.kmss.util.AutoHashMap;
import com.landray.kmss.web.action.ActionMapping;

/**
 * 创建日期 2010-三月-24
 * 
 * @author 黄郴
 */
public class KmCarmngMotorcadeSetForm extends BaseAuthForm implements
		ISysWfTemplateForm, ISysNumberForm {
	/**
	 * 
	 */
	private static final long serialVersionUID = -4994190091713849641L;
	/*
	 * 排序号
	 */
	private String fdOrder = null;
	/*
	 * 车队名称
	 */
	private String fdName = null;
	/*
	 * 调度员
	 */
	private String fdDispatchersId = null;

	private String fdDispatchersName = null;
	/*
	 * 回车登记员
	 */
	private String fdRegisterId = null;

	private String fdRegisterName = null;
	
	/*
	 * 是否有效
	 */
	private String isEffective = null;
	
	/*
	 * 通知司机时间间隔
	 */
	private String fdNotifyMinuterDriver = null;
	/*
	 * 通知调度员时间间隔
	 */
	private String fdNotifyMinuterDispatchers = null;
	/*
	 * 通知用车人员时间间隔
	 */
	private String fdNotifyMinuterUser = null;
	/*
	 * 通知方式
	 */
	private String fdNotifyType = null;
	/*
	 * 车队描述
	 */
	private String fdRemark = null;
	/*
	 * 创建者
	 */
	private String docCreatorId = null;

	private String docCreatorName = null;
	/*
	 * 创建时间
	 */
	private String docCreateTime = null;

	/**
	 * @return 返回 排序号
	 */
	public String getFdOrder() {
		return fdOrder;
	}

	/**
	 * @param fdOrder
	 *            要设置的 排序号
	 */
	public void setFdOrder(String fdOrder) {
		this.fdOrder = fdOrder;
	}

	/**
	 * @return 返回 车队名称
	 */
	public String getFdName() {
		return fdName;
	}

	/**
	 * @param fdName
	 *            要设置的 车队名称
	 */
	public void setFdName(String fdName) {
		this.fdName = fdName;
	}

	/**
	 * @return 返回 调度员
	 */
	public String getFdDispatchersId() {
		return fdDispatchersId;
	}

	/**
	 * @param fdDispatchersId
	 *            要设置的 调度员
	 */
	public void setFdDispatchersId(String fdDispatchersId) {
		this.fdDispatchersId = fdDispatchersId;
	}

	/**
	 * @return 返回 回车登记员
	 */
	public String getFdRegisterId() {
		return fdRegisterId;
	}

	/**
	 * @param fdRegisterId
	 *            要设置的 回车登记员
	 */
	public void setFdRegisterId(String fdRegisterId) {
		this.fdRegisterId = fdRegisterId;
	}

	public void setIsEffective(String isEffective) {
		this.isEffective = isEffective;
	}

	public String getIsEffective() {
		return isEffective;
	}
	
	/**
	 * @return 返回 通知司机时间间隔
	 */
	public String getFdNotifyMinuterDriver() {
		return fdNotifyMinuterDriver;
	}

	/**
	 * @param fdNotifyMinuterDriver
	 *            要设置的 通知司机时间间隔
	 */
	public void setFdNotifyMinuterDriver(String fdNotifyMinuterDriver) {
		this.fdNotifyMinuterDriver = fdNotifyMinuterDriver;
	}

	/**
	 * @return 返回 通知调度员时间间隔
	 */
	public String getFdNotifyMinuterDispatchers() {
		return fdNotifyMinuterDispatchers;
	}

	/**
	 * @param fdNotifyMinuterDispatchers
	 *            要设置的 通知调度员时间间隔
	 */
	public void setFdNotifyMinuterDispatchers(String fdNotifyMinuterDispatchers) {
		this.fdNotifyMinuterDispatchers = fdNotifyMinuterDispatchers;
	}

	/**
	 * @return 返回 通知用车人员时间间隔
	 */
	public String getFdNotifyMinuterUser() {
		return fdNotifyMinuterUser;
	}

	/**
	 * @param fdNotifyMinuterUser
	 *            要设置的 通知用车人员时间间隔
	 */
	public void setFdNotifyMinuterUser(String fdNotifyMinuterUser) {
		this.fdNotifyMinuterUser = fdNotifyMinuterUser;
	}

	public String getFdDispatchersName() {
		return this.fdDispatchersName;
	}

	public void setFdDispatchersName(String fdDispatchersName) {
		this.fdDispatchersName = fdDispatchersName;
	}

	public String getFdRegisterName() {
		return this.fdRegisterName;
	}

	public void setFdRegisterName(String fdRegisterName) {
		this.fdRegisterName = fdRegisterName;
	}

	public String getFdNotifyType() {
		return this.fdNotifyType;
	}

	public void setFdNotifyType(String fdNotifyType) {
		this.fdNotifyType = fdNotifyType;
	}

	public String getDocCreatorName() {
		return this.docCreatorName;
	}

	public void setDocCreatorName(String docCreatorName) {
		this.docCreatorName = docCreatorName;
	}

	/**
	 * @return 返回 车队描述
	 */
	public String getFdRemark() {
		return fdRemark;
	}

	/**
	 * @param fdRemark
	 *            要设置的 车队描述
	 */
	public void setFdRemark(String fdRemark) {
		this.fdRemark = fdRemark;
	}

	/**
	 * @return 返回 创建者
	 */
	public String getDocCreatorId() {
		return docCreatorId;
	}

	/**
	 * @param docCreatorId
	 *            要设置的 创建者
	 */
	public void setDocCreatorId(String docCreatorId) {
		this.docCreatorId = docCreatorId;
	}

	/**
	 * @return 返回 创建时间
	 */
	public String getDocCreateTime() {
		return docCreateTime;
	}

	/**
	 * @param docCreateTime
	 *            要设置的 创建时间
	 */
	public void setDocCreateTime(String docCreateTime) {
		this.docCreateTime = docCreateTime;
	}

	// 编号机制
	private SysNumberMainMappForm sysNumberMainMappForm = new SysNumberMainMappForm();

	@Override
    public SysNumberMainMappForm getSysNumberMainMappForm() {
		return sysNumberMainMappForm;
	}

	@Override
    public void setSysNumberMainMappForm(SysNumberMainMappForm frm) {
		sysNumberMainMappForm = frm;
	}
	
	/*
	 * （非 Javadoc）
	 * 
	 * @seecom.landray.kmss.web.action.ActionForm#reset(org.apache.struts.action.
	 * ActionMapping, javax.servlet.http.HttpServletRequest)
	 */
	@Override
    public void reset(ActionMapping mapping, HttpServletRequest request) {
		fdOrder = null;
		fdName = null;
		fdDispatchersId = null;
		fdDispatchersName = null;
		fdRegisterId = null;
		fdRegisterName = null;
		fdNotifyMinuterDriver = null;
		fdNotifyMinuterDispatchers = null;
		fdNotifyMinuterUser = null;
		fdNotifyType = null;
		fdRemark = null;
		docCreatorId = null;
		docCreatorName = null;
		docCreateTime = null;
		sysWfTemplateForms.clear();
		super.reset(mapping, request);
	}

	@Override
    public Class getModelClass() {
		return KmCarmngMotorcadeSet.class;
	}

	private AutoHashMap sysWfTemplateForms = new AutoHashMap(
			SysWfTemplateForm.class);

	@Override
    public AutoHashMap getSysWfTemplateForms() {
		return sysWfTemplateForms;
	}
	
	private static FormToModelPropertyMap  toModelPropertyMap  = null;

	@Override
    public  FormToModelPropertyMap getToModelPropertyMap() {
		if(toModelPropertyMap == null){
			toModelPropertyMap  = new FormToModelPropertyMap();
			toModelPropertyMap.putAll(super.getToModelPropertyMap());
			toModelPropertyMap.put("docCreatorId", new FormConvertor_IDToModel("docCreator", SysOrgPerson.class));
			toModelPropertyMap.put("fdDispatchersId", new FormConvertor_IDToModel("fdDispatchers", SysOrgElement.class));
			toModelPropertyMap.put("fdRegisterId", new FormConvertor_IDToModel("fdRegister", SysOrgElement.class));
			
		}
		return toModelPropertyMap;
	}
	
	

}
