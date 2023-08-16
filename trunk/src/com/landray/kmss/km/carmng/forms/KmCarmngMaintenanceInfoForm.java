package com.landray.kmss.km.carmng.forms;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.web.action.ActionMapping;

import com.landray.kmss.common.convertor.FormConvertor_IDToModel;
import com.landray.kmss.common.convertor.FormToModelPropertyMap;
import com.landray.kmss.common.forms.ExtendForm;
import com.landray.kmss.km.carmng.model.KmCarmngInfomation;
import com.landray.kmss.km.carmng.model.KmCarmngMaintenanceInfo;
import com.landray.kmss.sys.attachment.forms.AttachmentDetailsForm;
import com.landray.kmss.sys.attachment.forms.IAttachmentForm;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.util.AutoHashMap;

/**
 * 创建日期 2010-三月-24
 * 
 * @author 叶中奇
 */
public class KmCarmngMaintenanceInfoForm extends ExtendForm implements IAttachmentForm {
	/*
	 * 车牌信息ID
	 */
	private String fdVehiclesInfoId = null;

	private String fdVehiclesInfoName = null;

	private String fdVehiclesInfoNo = null;

	private String fdVehiclesCategoryName = null;
	/*
	 * 保养日期
	 */
	private String fdMaintenanceTime = null;

	public String getFdVehiclesInfoName() {
		return this.fdVehiclesInfoName;
	}

	public void setFdVehiclesInfoName(String fdVehiclesInfoName) {
		this.fdVehiclesInfoName = fdVehiclesInfoName;
	}

	public String getFdVehiclesInfoNo() {
		return this.fdVehiclesInfoNo;
	}

	public void setFdVehiclesInfoNo(String fdVehiclesInfoNo) {
		this.fdVehiclesInfoNo = fdVehiclesInfoNo;
	}

	public String getFdVehiclesCategoryName() {
		return this.fdVehiclesCategoryName;
	}

	public void setFdVehiclesCategoryName(String fdVehiclesCategoryName) {
		this.fdVehiclesCategoryName = fdVehiclesCategoryName;
	}

	public String getFdPersonName() {
		return this.fdPersonName;
	}

	public void setFdPersonName(String fdPersonName) {
		this.fdPersonName = fdPersonName;
	}

	public String getDocCreatorName() {
		return this.docCreatorName;
	}

	public void setDocCreatorName(String docCreatorName) {
		this.docCreatorName = docCreatorName;
	}

	/*
	 * 保养费
	 */
	private String fdMaintenanceFee = null;
	/*
	 * 送修人
	 */
	private String fdPersonId = null;
	
	public String getFdPersonId() {
		return this.fdPersonId;
	}

	public void setFdPersonId(String fdPersonId) {
		this.fdPersonId = fdPersonId;
	}

	private String fdPersonName = null;
	/*
	 * 维修费
	 */
	private String fdRepairFee = null;
	/*
	 * 备注
	 */
	private String fdRemark = null;
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
	 * @return 返回 车牌信息ID
	 */
	public String getFdVehiclesInfoId() {
		return fdVehiclesInfoId;
	}

	/**
	 * @param fdVehiclesInfoId
	 *            要设置的 车牌信息ID
	 */
	public void setFdVehiclesInfoId(String fdVehiclesInfoId) {
		this.fdVehiclesInfoId = fdVehiclesInfoId;
	}

	/**
	 * @return 返回 保养日期
	 */
	public String getFdMaintenanceTime() {
		return fdMaintenanceTime;
	}

	/**
	 * @param fdMaintenanceTime
	 *            要设置的 保养日期
	 */
	public void setFdMaintenanceTime(String fdMaintenanceTime) {
		this.fdMaintenanceTime = fdMaintenanceTime;
	}

	/**
	 * @return 返回 保养费
	 */
	public String getFdMaintenanceFee() {
		return fdMaintenanceFee;
	}

	/**
	 * @param fdMaintenanceFee
	 *            要设置的 保养费
	 */
	public void setFdMaintenanceFee(String fdMaintenanceFee) {
		this.fdMaintenanceFee = fdMaintenanceFee;
	}

	/**
	 * @return 返回 维修费
	 */
	public String getFdRepairFee() {
		return fdRepairFee;
	}

	/**
	 * @param fdRepairFee
	 *            要设置的 维修费
	 */
	public void setFdRepairFee(String fdRepairFee) {
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

	/*
	 * （非 Javadoc）
	 * 
	 * @seecom.landray.kmss.web.action.ActionForm#reset(org.apache.struts.action.
	 * ActionMapping, javax.servlet.http.HttpServletRequest)
	 */
	@Override
    public void reset(ActionMapping mapping, HttpServletRequest request) {
		fdVehiclesInfoId = null;
		fdVehiclesInfoName = null;
		fdVehiclesInfoNo = null;
		fdVehiclesCategoryName = null;
		fdMaintenanceTime = null;
		fdMaintenanceFee = null;
		fdPersonName = null;
		fdRepairFee = null;
		fdRemark = null;
		docCreateTime = null;
		docCreatorId = null;
		docCreatorName = null;
		super.reset(mapping, request);
	}

	@Override
    public Class getModelClass() {
		return KmCarmngMaintenanceInfo.class;
	}

	private static FormToModelPropertyMap toModelPropertyMap = null;

	@Override
    public FormToModelPropertyMap getToModelPropertyMap() {
		if (toModelPropertyMap == null) {
			toModelPropertyMap = new FormToModelPropertyMap();
			toModelPropertyMap.put("docCreatorId", new FormConvertor_IDToModel(
					"docCreator", SysOrgElement.class));
			toModelPropertyMap.put("fdVehiclesInfoId",
					new FormConvertor_IDToModel("fdVehiclesInfo",
							KmCarmngInfomation.class));
		}
		return toModelPropertyMap;
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
