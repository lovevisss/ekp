package com.landray.kmss.km.carmng.model;
import java.util.ArrayList;
import java.util.List;

import com.landray.kmss.common.convertor.ModelToFormPropertyMap;
import com.landray.kmss.km.carmng.forms.KmCarmngMotorcadeSetForm;
import com.landray.kmss.sys.number.interfaces.ISysNumberModel;
import com.landray.kmss.sys.number.model.SysNumberMainMapp;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.sys.right.interfaces.BaseAuthModel;
import com.landray.kmss.sys.workflow.interfaces.ISysWfTemplateModel;
import com.landray.kmss.util.ArrayUtil;
import com.landray.kmss.util.UserUtil;

/**
 * 创建日期 2010-三月-24
 * @author 黄郴
 * 车队设置
 */
public class KmCarmngMotorcadeSet extends BaseAuthModel
		implements ISysWfTemplateModel, ISysNumberModel {


	/**
	 * 
	 */
	private static final long serialVersionUID = 2418783249227890820L;

	/*
	 * 排序号
	 */
	protected Integer fdOrder;
	
	/*
	 * 车队名称
	 */
	protected String fdName;
	
	/*
	 * 调度员
	 */
	protected SysOrgElement fdDispatchers;
	
	/*
	 * 回车登记员
	 */
	protected SysOrgElement fdRegister;
	
	/*
	 * 是否有效
	 */
	protected String isEffective;
	
	/*
	 * 通知司机时间间隔
	 */
	protected Integer fdNotifyMinuterDriver;
	
	/*
	 * 通知调度员时间间隔
	 */
	protected Integer fdNotifyMinuterDispatchers;
	
	/*
	 * 通知用车人员时间间隔
	 */
	protected Integer fdNotifyMinuterUser;
	
	/*
	 * 通知方式
	 */
	protected String fdNotifyType;
	
	/*
	 * 车队描述
	 */
	protected String fdRemark;
	
	
	public KmCarmngMotorcadeSet() {
		super();
	}
	
	
	/**
	 * @return 返回 排序号
	 */
	public Integer getFdOrder() {
		return fdOrder;
	}
	
	/**
	 * @param fdOrder 要设置的 排序号
	 */
	public void setFdOrder(Integer fdOrder) {
		this.fdOrder = fdOrder;
	}
	
	/**
	 * @return 返回 车队名称
	 */
	public String getFdName() {
		return fdName;
	}
	
	/**
	 * @param fdName 要设置的 车队名称
	 */
	public void setFdName(String fdName) {
		this.fdName = fdName;
	}
	
	
	public String getIsEffective() {
		return isEffective;
	}


	public void setIsEffective(String isEffective) {
		this.isEffective = isEffective;
	}


	
	/**
	 * @return 返回 通知司机时间间隔
	 */
	public Integer getFdNotifyMinuterDriver() {
		return fdNotifyMinuterDriver;
	}
	
	/**
	 * @param fdNotifyMinuterDriver 要设置的 通知司机时间间隔
	 */
	public void setFdNotifyMinuterDriver(Integer fdNotifyMinuterDriver) {
		this.fdNotifyMinuterDriver = fdNotifyMinuterDriver;
	}
	
	/**
	 * @return 返回 通知调度员时间间隔
	 */
	public Integer getFdNotifyMinuterDispatchers() {
		return fdNotifyMinuterDispatchers;
	}
	
	/**
	 * @param fdNotifyMinuterDispatchers 要设置的 通知调度员时间间隔
	 */
	public void setFdNotifyMinuterDispatchers(Integer fdNotifyMinuterDispatchers) {
		this.fdNotifyMinuterDispatchers = fdNotifyMinuterDispatchers;
	}
	
	/**
	 * @return 返回 通知用车人员时间间隔
	 */
	public Integer getFdNotifyMinuterUser() {
		return fdNotifyMinuterUser;
	}
	
	/**
	 * @param fdNotifyMinuterUser 要设置的 通知用车人员时间间隔
	 */
	public void setFdNotifyMinuterUser(Integer fdNotifyMinuterUser) {
		this.fdNotifyMinuterUser = fdNotifyMinuterUser;
	}
	
	
	
	/**
	 * @return 返回 车队描述
	 */
	public String getFdRemark() {
		return fdRemark;
	}
	
	/**
	 * @param fdRemark 要设置的 车队描述
	 */
	public void setFdRemark(String fdRemark) {
		this.fdRemark = fdRemark;
	}
	
		
	@Override
	public Class getFormClass() {
		return KmCarmngMotorcadeSetForm.class;
	}
	
	public SysOrgElement getFdDispatchers() {
		return this.fdDispatchers;
	}


	public void setFdDispatchers(SysOrgElement fdDispatchers) {
		this.fdDispatchers = fdDispatchers;
	}


	public SysOrgElement getFdRegister() {
		return this.fdRegister;
	}


	public void setFdRegister(SysOrgElement fdRegister) {
		this.fdRegister = fdRegister;
	}


	public String getFdNotifyType() {
		return this.fdNotifyType;
	}


	public void setFdNotifyType(String fdNotifyType) {
		this.fdNotifyType = fdNotifyType;
	}


	/**
	 * 流程模板
	 */
	private List sysWfTemplateModels;

	@Override
	public List getSysWfTemplateModels() {
		return sysWfTemplateModels;
	}

	@Override
	public void setSysWfTemplateModels(List sysWfTemplateModels) {
		this.sysWfTemplateModels = sysWfTemplateModels;
	}
	
	private static ModelToFormPropertyMap  toFormPropertyMap = null;

	@Override
	public  ModelToFormPropertyMap getToFormPropertyMap() {
		if(toFormPropertyMap  == null){
			toFormPropertyMap = new ModelToFormPropertyMap();
			toFormPropertyMap.putAll(super.getToFormPropertyMap());
			toFormPropertyMap.put("docCreator.fdId", "docCreatorId");
			toFormPropertyMap.put("docCreator.fdName", "docCreatorName");
			toFormPropertyMap.put("fdDispatchers.fdId", "fdDispatchersId");
			toFormPropertyMap.put("fdDispatchers.fdName", "fdDispatchersName");
			toFormPropertyMap.put("fdRegister.fdName", "fdRegisterName");
			toFormPropertyMap.put("fdRegister.fdId", "fdRegisterId");
		}
		return toFormPropertyMap;
	}

	@Override
	public String getDocSubject() {
		return null;
	}
	
	@Override
	public Boolean getAuthReaderFlag() {
		if (getIsEffective() != null
				&& "false".equals(getIsEffective())) {
			return new Boolean(false);
		}
		if (ArrayUtil.isEmpty(getAuthReaders())) {
            return new Boolean(true);
        } else {
            return new Boolean(false);
        }
	}

	// 编号机制
	private SysNumberMainMapp sysNumberMainMapp = new SysNumberMainMapp();
	@Override
	public SysNumberMainMapp getSysNumberMainMappModel() {
		return sysNumberMainMapp;
	}

	@Override
	public void
			setSysNumberMainMappModel(SysNumberMainMapp sysNumberMainMapp1) {
		this.sysNumberMainMapp = sysNumberMainMapp1;
	}
	
	@Override
	protected void recalculateReaderField() {
		// 重新计算可阅读者
		if (authAllReaders == null) {
            authAllReaders = new ArrayList();
        } else {
            authAllReaders.clear();
        }

		if (getIsEffective() != null
				&& "false".equals(getIsEffective())) {
			getAuthReaders().clear();
			getAuthOtherReaders().clear();
		} else {
			if (getAuthReaderFlag().booleanValue()) {
				// everyone
				authAllReaders.add(UserUtil.getEveryoneUser());
				return;
			}
		}
		
		authAllReaders.add(getDocCreator());

		List tmpList = getAuthOtherReaders();
		if (tmpList != null) {
			ArrayUtil.concatTwoList(tmpList, authAllReaders);
		}
		tmpList = getAuthReaders();
		if (tmpList != null) {
			ArrayUtil.concatTwoList(tmpList, authAllReaders);
		}
		ArrayUtil.concatTwoList(authAllEditors, authAllReaders);
	}
	
	@Override
	protected void recalculateEditorField() {
		// 重新计算可编辑者
		if (authAllEditors == null) {
            authAllEditors = new ArrayList();
        } else {
            authAllEditors.clear();
        }

		authAllEditors.add(getDocCreator());

		List tmpList = getAuthOtherEditors();
		if (tmpList != null) {
			ArrayUtil.concatTwoList(tmpList, authAllEditors);
		}

		tmpList = getAuthEditors();
		if (tmpList != null) {
			ArrayUtil.concatTwoList(tmpList, authAllEditors);
		}
	}
	
}
