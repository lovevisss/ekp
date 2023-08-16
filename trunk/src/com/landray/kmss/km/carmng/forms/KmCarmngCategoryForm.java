package com.landray.kmss.km.carmng.forms;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.web.action.ActionMapping;

import com.landray.kmss.common.convertor.FormConvertor_IDToModel;
import com.landray.kmss.common.convertor.FormToModelPropertyMap;
import com.landray.kmss.km.carmng.model.KmCarmngCategory;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.sys.simplecategory.forms.SysSimpleCategoryAuthTmpForm;

/**
 * 创建日期 2010-三月-24
 * 
 * @author 叶中奇
 */
public class KmCarmngCategoryForm extends SysSimpleCategoryAuthTmpForm {
	/*
	 * 排序号
	 */
	private String fdOrder = null;
	/*
	 * 父类别
	 */
	private String fdParentId = null;

	private String fdParentName = null;
	/*
	 * 名称
	 */
	private String fdName = null;
	/*
	 * 层级ID
	 */
	private String fdHierarchyId = null;
	/*
	 * 创建时间
	 */
	private String docCreateTime = null;
	/*
	 * 创建者
	 */
	private String docCreatorId = null;

	private String docCreatorName = null;

	/**
	 * @return 返回 排序号
	 */
	@Override
    public String getFdOrder() {
		return fdOrder;
	}

	/**
	 * @param fdOrder
	 *            要设置的 排序号
	 */
	@Override
    public void setFdOrder(String fdOrder) {
		this.fdOrder = fdOrder;
	}

	/**
	 * @return 返回 父类别
	 */
	@Override
    public String getFdParentId() {
		return fdParentId;
	}

	/**
	 * @param fdParentId
	 *            要设置的 父类别
	 */
	@Override
    public void setFdParentId(String fdParentId) {
		this.fdParentId = fdParentId;
	}

	/**
	 * @return 返回 名称
	 */
	@Override
    public String getFdName() {
		return fdName;
	}

	/**
	 * @param fdName
	 *            要设置的 名称
	 */
	@Override
    public void setFdName(String fdName) {
		this.fdName = fdName;
	}

	/**
	 * @return 返回 层级ID
	 */
	public String getFdHierarchyId() {
		return fdHierarchyId;
	}

	/**
	 * @param fdHierarchyId
	 *            要设置的 层级ID
	 */
	public void setFdHierarchyId(String fdHierarchyId) {
		this.fdHierarchyId = fdHierarchyId;
	}

	/**
	 * @return 返回 创建时间
	 */
	@Override
    public String getDocCreateTime() {
		return docCreateTime;
	}

	/**
	 * @param docCreateTime
	 *            要设置的 创建时间
	 */
	@Override
    public void setDocCreateTime(String docCreateTime) {
		this.docCreateTime = docCreateTime;
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

	@Override
    public String getFdParentName() {
		return fdParentName;
	}

	@Override
    public void setFdParentName(String fdParentName) {
		this.fdParentName = fdParentName;
	}

	@Override
    public String getDocCreatorName() {
		return docCreatorName;
	}

	@Override
    public void setDocCreatorName(String docCreatorName) {
		this.docCreatorName = docCreatorName;
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
		fdParentId = null;
		fdParentName = null;
		fdName = null;
		fdHierarchyId = null;
		docCreateTime = null;
		docCreatorId = null;
		docCreatorName = null;
		super.reset(mapping, request);
	}

	@Override
    public Class getModelClass() {
		return KmCarmngCategory.class;
	}

	private static FormToModelPropertyMap toModelPropertyMap = null;

	@Override
    public FormToModelPropertyMap getToModelPropertyMap() {
		if (toModelPropertyMap == null) {
			toModelPropertyMap = new FormToModelPropertyMap();
			toModelPropertyMap.putAll(super.getToModelPropertyMap());

			toModelPropertyMap.put("docCreatorId", new FormConvertor_IDToModel(
					"docCreator", SysOrgElement.class));
			toModelPropertyMap.put("fdParentId", new FormConvertor_IDToModel(
					"fdParent", KmCarmngCategory.class));
		}
		return toModelPropertyMap;
	}

}
