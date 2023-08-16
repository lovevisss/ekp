package com.landray.kmss.km.carmng.model;

import java.util.Date;

import com.landray.kmss.common.convertor.ModelToFormPropertyMap;
import com.landray.kmss.common.model.BaseModel;
import com.landray.kmss.km.carmng.forms.KmCarmngInfringeInfoForm;
import com.landray.kmss.sys.attachment.forms.AttachmentDetailsForm;
import com.landray.kmss.sys.attachment.model.IAttachment;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.util.AutoHashMap;

/**
 * 创建日期 2010-三月-24
 * 
 * @author 叶中奇 违章信息
 */
public class KmCarmngInfringeInfo extends BaseModel implements IAttachment{

	/*
	 * 车牌号码
	 */
	protected KmCarmngInfomation fdVehiclesInfo;

	/*
	 * 违章时间
	 */
	protected Date fdInfringeTime;

	/*
	 * 违章费用
	 */
	protected Double fdInfringeFee;

	/*
	 * 违章地点
	 */
	protected String fdInfringeSite;

	/*
	 * 违章人
	 */
	protected String fdInfringePersonId;

	protected String fdInfringePersonName;

	/*
	 * 违章事由
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

	public KmCarmngInfringeInfo() {
		super();
	}

	/**
	 * @return 返回 违章时间
	 */
	public Date getFdInfringeTime() {
		return fdInfringeTime;
	}

	/**
	 * @param fdInfringeTime
	 *            要设置的 违章时间
	 */
	public void setFdInfringeTime(Date fdInfringeTime) {
		this.fdInfringeTime = fdInfringeTime;
	}

	/**
	 * @return 返回 违章费用
	 */
	public Double getFdInfringeFee() {
		return fdInfringeFee;
	}

	/**
	 * @param fdInfringeFee
	 *            要设置的 违章费用
	 */
	public void setFdInfringeFee(Double fdInfringeFee) {
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

	@Override
    public Class getFormClass() {
		return KmCarmngInfringeInfoForm.class;
	}

	public KmCarmngInfomation getFdVehiclesInfo() {
		return this.fdVehiclesInfo;
	}

	public void setFdVehiclesInfo(KmCarmngInfomation fdVehiclesInfo) {
		this.fdVehiclesInfo = fdVehiclesInfo;
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

	public SysOrgElement getDocCreator() {
		return this.docCreator;
	}
	
	public void setDocCreator(SysOrgElement docCreator) {
		this.docCreator = docCreator;
	}
	
	private static ModelToFormPropertyMap toFormPropertyMap  = null;

	@Override
    public  ModelToFormPropertyMap getToFormPropertyMap() {
		if(toFormPropertyMap == null){
			toFormPropertyMap  = new ModelToFormPropertyMap();
			toFormPropertyMap.put("docCreator.fdId", "docCreatorId");
			toFormPropertyMap.put("docCreator.fdName", "docCreatorName");
			toFormPropertyMap.put("fdVehiclesInfo.fdId", "fdVehiclesInfoId");
			toFormPropertyMap.put("fdVehiclesInfo.fdNo", "fdVehiclesInfoNo");
			toFormPropertyMap.put("fdVehiclesInfo.docSubject", "fdVehiclesInfoName");
			toFormPropertyMap.put("fdVehiclesInfo.fdVehichesType.fdName", "fdVehiclesCategoryName");
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
