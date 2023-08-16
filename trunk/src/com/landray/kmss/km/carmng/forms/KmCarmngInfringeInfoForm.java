package com.landray.kmss.km.carmng.forms;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.web.action.ActionMapping;

import com.landray.kmss.common.convertor.FormConvertor_IDToModel;
import com.landray.kmss.common.convertor.FormToModelPropertyMap;
import com.landray.kmss.common.forms.ExtendForm;
import com.landray.kmss.km.carmng.model.KmCarmngInfomation;
import com.landray.kmss.km.carmng.model.KmCarmngInfringeInfo;
import com.landray.kmss.sys.attachment.forms.AttachmentDetailsForm;
import com.landray.kmss.sys.attachment.forms.IAttachmentForm;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.util.AutoHashMap;

/**
 * 创建日期 2010-三月-24
 * 
 * @author 叶中奇
 */
public class KmCarmngInfringeInfoForm extends ExtendForm implements IAttachmentForm {
	/*
	 * 车牌号码
	 */
	private String fdVehiclesInfoId = null;

	private String fdVehiclesInfoNo = null;
	
	private String fdVehiclesInfoName = null;
	
	private String fdVehiclesCategoryName = null;
	/*
	 * 违章时间
	 */
	private String fdInfringeTime = null;
	/*
	 * 违章费用
	 */
	private String fdInfringeFee = null;
	/*
	 * 违章地点
	 */
	private String fdInfringeSite = null;
	/*
	 * 违章人
	 */
	private String fdInfringePersonId = null;

	private String fdInfringePersonName = null;
	/*
	 * 违章事由
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
	 * @return 返回 车牌号码
	 */
	public String getFdVehiclesInfoId() {
		return fdVehiclesInfoId;
	}

	/**
	 * @param fdVehiclesInfoId
	 *            要设置的 车牌号码
	 */
	public void setFdVehiclesInfoId(String fdVehiclesInfoId) {
		this.fdVehiclesInfoId = fdVehiclesInfoId;
	}

	/**
	 * @return 返回 违章时间
	 */
	public String getFdInfringeTime() {
		return fdInfringeTime;
	}

	/**
	 * @param fdInfringeTime
	 *            要设置的 违章时间
	 */
	public void setFdInfringeTime(String fdInfringeTime) {
		this.fdInfringeTime = fdInfringeTime;
	}

	/**
	 * @return 返回 违章费用
	 */
	public String getFdInfringeFee() {
		return fdInfringeFee;
	}

	/**
	 * @param fdInfringeFee
	 *            要设置的 违章费用
	 */
	public void setFdInfringeFee(String fdInfringeFee) {
		this.fdInfringeFee = fdInfringeFee;
	}

	/**
	 * @return 返回 违章地点
	 */
	public String getFdInfringeSite() {
		return fdInfringeSite;
	}

	/**
	 * @param fdInfringeSite
	 *            要设置的 违章地点
	 */
	public void setFdInfringeSite(String fdInfringeSite) {
		this.fdInfringeSite = fdInfringeSite;
	}

	/**
	 * @return 返回 违章事由
	 */
	public String getFdRemark() {
		return fdRemark;
	}

	/**
	 * @param fdRemark
	 *            要设置的 违章事由
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

	public String getFdVehiclesInfoNo() {
		return this.fdVehiclesInfoNo;
	}

	public void setFdVehiclesInfoNo(String fdVehiclesInfoNo) {
		this.fdVehiclesInfoNo = fdVehiclesInfoNo;
	}

	public String getFdInfringePersonId() {
		return this.fdInfringePersonId;
	}

	public void setFdInfringePersonId(String fdInfringePersonId) {
		this.fdInfringePersonId = fdInfringePersonId;
	}

	public String getFdInfringePersonName() {
		return this.fdInfringePersonName;
	}

	public void setFdInfringePersonName(String fdInfringePersonName) {
		this.fdInfringePersonName = fdInfringePersonName;
	}

	public String getDocCreatorName() {
		return this.docCreatorName;
	}

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
		fdVehiclesInfoId = null;
		fdVehiclesInfoNo = null;
		fdInfringeTime = null;
		fdInfringeFee = null;
		fdInfringeSite = null;
		fdInfringePersonId = null;
		fdInfringePersonName = null;
		fdRemark = null;
		docCreateTime = null;
		docCreatorId = null;
		docCreatorName = null;
		super.reset(mapping, request);
	}
	
	public String getFdVehiclesInfoName() {
		return this.fdVehiclesInfoName;
	}

	public void setFdVehiclesInfoName(String fdVehiclesInfoName) {
		this.fdVehiclesInfoName = fdVehiclesInfoName;
	}

	public String getFdVehiclesCategoryName() {
		return this.fdVehiclesCategoryName;
	}

	public void setFdVehiclesCategoryName(String fdVehiclesCategoryName) {
		this.fdVehiclesCategoryName = fdVehiclesCategoryName;
	}
	
	

	@Override
    public Class getModelClass() {
		return KmCarmngInfringeInfo.class;
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
