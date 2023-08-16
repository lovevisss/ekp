package com.landray.kmss.km.carmng.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.landray.kmss.common.convertor.ModelConvertor_ModelListToFormList;
import com.landray.kmss.common.convertor.ModelToFormPropertyMap;
import com.landray.kmss.common.model.BaseModel;
import com.landray.kmss.km.carmng.forms.KmCarmngDispatchersInfoForm;
import com.landray.kmss.sys.notify.interfaces.ISysNotifyModel;
import com.landray.kmss.sys.organization.model.SysOrgElement;

/**
 * 创建日期 2010-三月-24
 * 
 * @author 叶中奇 调度信息
 */
public class KmCarmngDispatchersInfo extends BaseModel implements
		ISysNotifyModel {

	/*
	 * 申请单
	 */
	protected String fdApplicationIds;

	protected String fdApplicationNames;

	protected String fdCarInfoIds;

	protected String fdCarInfoNames;

	public String getFdCarInfoIds() {
		return fdCarInfoIds;
	}

	public void setFdCarInfoIds(String fdCarInfoIds) {
		this.fdCarInfoIds = fdCarInfoIds;
	}

	public String getFdCarInfoNames() {
		return fdCarInfoNames;
	}

	public void setFdCarInfoNames(String fdCarInfoNames) {
		this.fdCarInfoNames = fdCarInfoNames;
	}

	public String getFdApplicationNames() {
		return this.fdApplicationNames;
	}

	public void setFdApplicationNames(String fdApplicationNames) {
		this.fdApplicationNames = fdApplicationNames;
	}

	/*
	 * 开始时间
	 */
	protected Date fdStartTime;

	/*
	 * 结束时间
	 */
	protected Date fdEndTime;

	/*
	 * 回车登记员
	 */
	protected SysOrgElement fdRegister;
	

	/*
	 * 调度者
	 */
	protected SysOrgElement docCreator;

	/*
	 * 调度时间
	 */
	protected Date docCreateTime;


	protected String fdFlag;

	public String getFdFlag() {
		return this.fdFlag;
	}

	public void setFdFlag(String fdFlag) {
		this.fdFlag = fdFlag;
	}

	private List<KmCarmngUserFeeInfo> fdUserFees;

	protected List<KmCarmngDispatchersInfoList> fdDispatchersInfoList;

	/*
	 * 所有可阅读者
	 */
	protected List authAllReaders = new ArrayList();

	public List getAuthAllReaders() {
		return authAllReaders;
	}

	public void setAuthAllReaders(List authAllReaders) {
		this.authAllReaders = authAllReaders;
	}

	/*
	 * 所有可编辑者
	 */
	protected List authAllEditors = new ArrayList();

	public List getAuthAllEditors() {
		return authAllEditors;
	}

	public void setAuthAllEditors(List authAllEditors) {
		this.authAllEditors = authAllEditors;
	}

	public List<KmCarmngDispatchersInfoList> getFdDispatchersInfoList() {
		return fdDispatchersInfoList;
	}

	public void setFdDispatchersInfoList(List<KmCarmngDispatchersInfoList> fdDispatchersInfoList) {
		this.fdDispatchersInfoList = fdDispatchersInfoList;
	}

	public List getFdUserFees() {
		return fdUserFees;
	}

	public void setFdUserFees(List<KmCarmngUserFeeInfo> fdUserFees) {
		this.fdUserFees = fdUserFees;
	}
	

	public KmCarmngDispatchersInfo() {
		super();
	}

	public SysOrgElement getFdRegister() {
		return this.fdRegister;
	}

	public void setFdRegister(SysOrgElement fdRegister) {
		this.fdRegister = fdRegister;
	}

	/**
	 * @return 返回 申请单
	 */
	public String getFdApplicationIds() {
		return fdApplicationIds;
	}

	/**
	 * @param fdApplicationIds
	 *            要设置的 申请单
	 */
	public void setFdApplicationIds(String fdApplicationIds) {
		this.fdApplicationIds = fdApplicationIds;
	}

	/**
	 * @return 返回 开始时间
	 */
	public Date getFdStartTime() {
		return fdStartTime;
	}

	/**
	 * @param fdStartTime
	 *            要设置的 开始时间
	 */
	public void setFdStartTime(Date fdStartTime) {
		this.fdStartTime = fdStartTime;
	}

	/**
	 * @return 返回 结束时间
	 */
	public Date getFdEndTime() {
		return fdEndTime;
	}

	/**
	 * @param fdEndTime
	 *            要设置的 结束时间
	 */
	public void setFdEndTime(Date fdEndTime) {
		this.fdEndTime = fdEndTime;
	}

	public SysOrgElement getDocCreator() {
		return this.docCreator;
	}

	public void setDocCreator(SysOrgElement docCreator) {
		this.docCreator = docCreator;
	}

	/**
	 * @return 返回 调度时间
	 */
	public Date getDocCreateTime() {
		return docCreateTime;
	}

	/**
	 * @param docCreateTime
	 *            要设置的 调度时间
	 */
	public void setDocCreateTime(Date docCreateTime) {
		this.docCreateTime = docCreateTime;
	}

	@Override
	public Class getFormClass() {
		return KmCarmngDispatchersInfoForm.class;
	}

	@Override
	public void recalculateFields() {
		recalculateReaderField();
		recalculateEditorField();
	}

	protected void recalculateReaderField() {
		// 重新计算可阅读者
		if (authAllReaders == null) {
            authAllReaders = new ArrayList();
        } else
			// authAllReaders.clear();

		// 添加调度人员
		if (!authAllReaders.contains(getDocCreator())) {
			authAllReaders.add(getDocCreator());
		}
		for (int i = 0; i < this.fdDispatchersInfoList.size(); i++) {
			KmCarmngDispatchersInfoList k = this.fdDispatchersInfoList.get(i);
			if (k.getFdSysDriver() != null && !authAllReaders.contains(k.getFdSysDriver())) {
				authAllReaders.add(k.getFdSysDriver());
			}
			if (k.getFdCarInfo().getFdMotorcade().getFdDispatchers() != null
					&& !authAllReaders.contains(k.getFdCarInfo().getFdMotorcade().getFdDispatchers())) {
				authAllReaders.add(k.getFdCarInfo().getFdMotorcade().getFdDispatchers());
			}
			if (k.getFdCarInfo().getFdMotorcade().getFdRegister() != null
					&& !authAllReaders.contains(k.getFdCarInfo().getFdMotorcade().getFdRegister())) {
				authAllReaders.add(k.getFdCarInfo().getFdMotorcade().getFdRegister());
			}
		}
	}

	protected void recalculateEditorField() {
		// 重新计算可编辑者
		if (authAllEditors == null) {
            authAllEditors = new ArrayList();
        } else {
            authAllEditors.clear();
        }

		authAllEditors.add(getDocCreator());
		for (int i = 0; i < this.fdDispatchersInfoList.size(); i++) {
			KmCarmngDispatchersInfoList k = this.fdDispatchersInfoList.get(i);
			if (k.getFdCarInfo().getFdMotorcade().getFdDispatchers() != null) {
				authAllEditors.add(k.getFdCarInfo().getFdMotorcade().getFdDispatchers());
			}
		}
	}

	private static ModelToFormPropertyMap toFormPropertyMap = null;

	@Override
	public ModelToFormPropertyMap getToFormPropertyMap() {
		if (toFormPropertyMap == null) {
			toFormPropertyMap = new ModelToFormPropertyMap();
			toFormPropertyMap.put("docCreator.fdId", "docCreatorId");
			toFormPropertyMap.put("docCreator.fdName", "docCreatorName");
			toFormPropertyMap.put("fdRegister.fdId", "fdRegisterId");
			toFormPropertyMap.put("fdRegister.fdName", "fdRegisterName");
			toFormPropertyMap.put("fdDispatchersInfoList",
					new ModelConvertor_ModelListToFormList("fdDispatchersInfoListForm"));
		}
		return toFormPropertyMap;
	}

	private java.lang.String fdNotifyType;

	public java.lang.String getFdNotifyType() {
		return fdNotifyType;
	}

	public void setFdNotifyType(java.lang.String fdNotifyType) {
		this.fdNotifyType = fdNotifyType;
	}

	/**
	 * 调度类型
	 */
	private String fdDispatchersType;

	/**
	 * 不派车原因
	 */
	private String fdRemark;

	public String getFdDispatchersType() {
		return fdDispatchersType;
	}

	public void setFdDispatchersType(String fdDispatchersType) {
		this.fdDispatchersType = fdDispatchersType;
	}

	public String getFdRemark() {
		return fdRemark;
	}

	public void setFdRemark(String fdRemark) {
		this.fdRemark = fdRemark;
	}
}
