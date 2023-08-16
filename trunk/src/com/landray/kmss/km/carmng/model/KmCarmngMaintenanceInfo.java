package com.landray.kmss.km.carmng.model;

import java.util.Date;

import com.landray.kmss.common.convertor.ModelConvertor_Common;
import com.landray.kmss.common.convertor.ModelToFormPropertyMap;
import com.landray.kmss.common.model.BaseModel;
import com.landray.kmss.km.carmng.forms.KmCarmngMaintenanceInfoForm;
import com.landray.kmss.sys.attachment.forms.AttachmentDetailsForm;
import com.landray.kmss.sys.attachment.model.IAttachment;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.util.AutoHashMap;
import com.landray.kmss.util.DateUtil;

/**
 * 创建日期 2010-三月-24
 * 
 * @author 叶中奇 车辆保养
 */
public class KmCarmngMaintenanceInfo extends BaseModel implements IAttachment{

	/*
	 * 车牌信息ID
	 */
	protected KmCarmngInfomation fdVehiclesInfo;

	/*
	 * 保养日期
	 */
	protected Date fdMaintenanceTime;

	/*
	 * 保养费
	 */
	protected Double fdMaintenanceFee;

	/*
	 * 送修人
	 */

	protected String fdPersonId;

	public String getFdPersonId() {
		return this.fdPersonId;
	}

	public void setFdPersonId(String fdPersonId) {
		this.fdPersonId = fdPersonId;
	}

	protected String fdPersonName;

	/*
	 * 维修费
	 */
	protected Double fdRepairFee;

	/*
	 * 备注
	 */
	protected String fdRemark;

	/*
	 * 创建时间
	 */
	protected Date docCreateTime;

	/*
	 * 创建者
	 */
	protected SysOrgElement docCreator;

	public KmCarmngMaintenanceInfo() {
		super();
	}

	/**
	 * @return 返回 保养日期
	 */
	public Date getFdMaintenanceTime() {
		return fdMaintenanceTime;
	}

	/**
	 * @param fdMaintenanceTime
	 *            要设置的 保养日期
	 */
	public void setFdMaintenanceTime(Date fdMaintenanceTime) {
		this.fdMaintenanceTime = fdMaintenanceTime;
	}

	/**
	 * @return 返回 保养费
	 */
	public Double getFdMaintenanceFee() {
		return fdMaintenanceFee;
	}

	/**
	 * @param fdMaintenanceFee
	 *            要设置的 保养费
	 */
	public void setFdMaintenanceFee(Double fdMaintenanceFee) {
		this.fdMaintenanceFee = fdMaintenanceFee;
	}

	/**
	 * @return 返回 维修费
	 */
	public Double getFdRepairFee() {
		return fdRepairFee;
	}

	/**
	 * @param fdRepairFee
	 *            要设置的 维修费
	 */
	public void setFdRepairFee(Double fdRepairFee) {
		this.fdRepairFee = fdRepairFee;
	}

	/**
	 * @return 返回 备注
	 */
	public String getFdRemark() {
		return fdRemark;
	}

	/**
	 * @param fdRemark
	 *            要设置的 备注
	 */
	public void setFdRemark(String fdRemark) {
		this.fdRemark = fdRemark;
	}

	/**
	 * @return 返回 创建时间
	 */
	public Date getDocCreateTime() {
		return docCreateTime;
	}

	/**
	 * @param docCreateTime
	 *            要设置的 创建时间
	 */
	public void setDocCreateTime(Date docCreateTime) {
		this.docCreateTime = docCreateTime;
	}

	public KmCarmngInfomation getFdVehiclesInfo() {
		return this.fdVehiclesInfo;
	}

	public void setFdVehiclesInfo(KmCarmngInfomation fdVehiclesInfo) {
		this.fdVehiclesInfo = fdVehiclesInfo;
	}

	public String getFdPersonName() {
		return this.fdPersonName;
	}

	public void setFdPersonName(String fdPersonName) {
		this.fdPersonName = fdPersonName;
	}

	public SysOrgElement getDocCreator() {
		return this.docCreator;
	}

	public void setDocCreator(SysOrgElement docCreator) {
		this.docCreator = docCreator;
	}

	@Override
    public Class getFormClass() {
		return KmCarmngMaintenanceInfoForm.class;
	}

	private static ModelToFormPropertyMap toFormPropertyMap = null;

	@Override
    public ModelToFormPropertyMap getToFormPropertyMap() {
		if (toFormPropertyMap == null) {
			toFormPropertyMap = new ModelToFormPropertyMap();
			toFormPropertyMap.put("docCreator.fdId", "docCreatorId");
			toFormPropertyMap.put("docCreator.fdName", "docCreatorName");
			toFormPropertyMap.put("docCreator.fdName", "docCreatorName");
			toFormPropertyMap.put("fdVehiclesInfo.fdId", "fdVehiclesInfoId");
			toFormPropertyMap.put("fdVehiclesInfo.docSubject",
					"fdVehiclesInfoName");
			toFormPropertyMap.put("fdVehiclesInfo.fdNo", "fdVehiclesInfoNo");
			toFormPropertyMap.put("fdVehiclesInfo.fdVehichesType.fdName",
					"fdVehiclesCategoryName");
			toFormPropertyMap.put("fdMaintenanceTime",
					new ModelConvertor_Common("fdMaintenanceTime")
							.setDateTimeType(DateUtil.TYPE_DATE));
		}
		return toFormPropertyMap;
	}
	
	/**
	 * 附件实现
	 */
	AutoHashMap autoHashMap = new AutoHashMap(AttachmentDetailsForm.class);

	@Override
    public AutoHashMap getAttachmentForms() {
		return autoHashMap;
	}
}
