package com.landray.kmss.km.carmng.model;

import java.util.Date;

import com.landray.kmss.common.convertor.ModelToFormPropertyMap;
import com.landray.kmss.common.model.IBaseTreeModel;
import com.landray.kmss.km.carmng.forms.KmCarmngCategoryForm;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.sys.simplecategory.model.SysSimpleCategoryAuthTmpModel;
import com.landray.kmss.util.ModelUtil;
import com.landray.kmss.util.ObjectUtil;

/**
 * 创建日期 2010-三月-24
 * 
 * @author 叶中奇 类别设置
 */
public class KmCarmngCategory extends SysSimpleCategoryAuthTmpModel implements
		IBaseTreeModel {

	/*
	 * 父类别
	 */
	protected IBaseTreeModel fdParent;

	/*
	 * 创建时间
	 */
	protected Date docCreateTime;

	/*
	 * 创建者
	 */
	protected SysOrgPerson docCreator;

	public KmCarmngCategory() {
		super();
	}

	//change by lizhaojie 2018-11-13
	/**
	 * @return 返回 创建时间
	 */
	@Override
    public Date getDocCreateTime() {
		return docCreateTime;
	}

	/**
	 * @param docCreateTime
	 *            要设置的 创建时间
	 */
	@Override
    public void setDocCreateTime(Date docCreateTime) {
		this.docCreateTime = docCreateTime;
	}

	@Override
    public SysOrgPerson getDocCreator() {
		return docCreator;
	}

	@Override
    public void setDocCreator(SysOrgPerson docCreator) {
		this.docCreator = docCreator;
	}

	@Override
    public Class getFormClass() {
		return KmCarmngCategoryForm.class;
	}

	@Override
    public IBaseTreeModel getFdParent() {
		return getHbmParent();
	}

	@Override
    public void setFdParent(IBaseTreeModel parent) {
		if (!ObjectUtil.equals(getHbmParent(), parent)) {
			ModelUtil.checkTreeCycle(this, parent, "fdParent");
			setHbmParent(parent);
		}
	}

	@Override
    public IBaseTreeModel getHbmParent() {
		return fdParent;
	}

	@Override
    public void setHbmParent(IBaseTreeModel parent) {
		this.fdParent = parent;
	}

	private static ModelToFormPropertyMap toFormPropertyMap = null;

	@Override
    public ModelToFormPropertyMap getToFormPropertyMap() {
		if (toFormPropertyMap == null) {
			toFormPropertyMap = new ModelToFormPropertyMap();
			toFormPropertyMap.putAll(super.getToFormPropertyMap());

			toFormPropertyMap.put("docCreator.fdId", "docCreatorId");
			toFormPropertyMap.put("docCreator.fdName", "docCreatorName");
			toFormPropertyMap.put("fdParent.fdName", "fdParentName");
			toFormPropertyMap.put("fdParent.fdId", "fdParentId");
		}
		return toFormPropertyMap;
	}

}
