package com.landray.kmss.km.carmng.model;

import java.util.Date;
import java.util.List;

import com.landray.kmss.common.convertor.ModelConvertor_ModelListToString;
import com.landray.kmss.common.convertor.ModelToFormPropertyMap;
import com.landray.kmss.common.model.BaseModel;
import com.landray.kmss.km.carmng.forms.KmCarmngDriversInfoForm;
import com.landray.kmss.sys.attachment.forms.AttachmentDetailsForm;
import com.landray.kmss.sys.attachment.model.IAttachment;
import com.landray.kmss.sys.notify.interfaces.ISysNotifyModel;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.util.AutoHashMap;

/**
 * 创建日期 2010-三月-24
 * 
 * @author 叶中奇 驾驶员信息
 */
public class KmCarmngDriversInfo extends BaseModel implements ISysNotifyModel,
		IAttachment {

	/*
	 * 排序号
	 */
	protected Integer fdOrder;

	/*
	 * 姓名
	 */
	protected String fdName;

	protected String fdSysId;

	protected String fdType;

	/*
	 * 所属车队
	 */
	protected KmCarmngMotorcadeSet fdMotorcade;

	/*
	 * 驾龄
	 */
	protected String fdDriveYear;

	/*
	 * 驾照号
	 */
	protected String fdDriverNumber;

	/*
	 * 年审时间
	 */
	protected Date fdAnnualAuditingTime;

	/*
	 * 证件类型
	 */
	protected String fdCredentialsType;

	/*
	 * 初次领证时间
	 */
	protected Date fdCredentialsTime;

	/*
	 * 有效期限
	 */
	protected Date fdValidTime;

	/*
	 * 年审频率
	 */
	protected String fdAnnualExamFrequency;

	/*
	 * 证件号码
	 */
	protected String fdCredentialsNumber;

	/*
	 * 身份证号
	 */
	protected String fdIdentificationNumber;

	/*
	 * 联系方式
	 */
	protected String fdRelationInfo;

	/*
	 * 手机
	 */
	protected String fdRelationPhone;

	/*
	 * 通知方式
	 */
	protected String fdNotifyType;

	/*
	 * 通知人
	 */
	List fdNotifyPersons;

	/*
	 * 备注
	 */
	protected String fdRemark;

	/*
	 * 创建者
	 */
	protected SysOrgElement docCreator;

	/*
	 * 创建时间
	 */
	protected Date docCreateTime;

	protected String fdIsValidation;

	public String getFdIsValidation() {
		return this.fdIsValidation;
	}

	public void setFdIsValidation(String fdIsValidation) {
		this.fdIsValidation = fdIsValidation;
	}

	public KmCarmngDriversInfo() {
		super();
	}

	/**
	 * @return 返回 排序号
	 */
	public Integer getFdOrder() {
		return fdOrder;
	}

	/**
	 * @param fdOrder
	 *            要设置的 排序号
	 */
	public void setFdOrder(Integer fdOrder) {
		this.fdOrder = fdOrder;
	}

	/**
	 * @return 返回 姓名
	 */
	public String getFdName() {
		return fdName;
	}

	/**
	 * @param fdName
	 *            要设置的 姓名
	 */
	public void setFdName(String fdName) {
		this.fdName = fdName;
	}

	/**
	 * @return 返回 驾龄
	 */
	public String getFdDriveYear() {
		return fdDriveYear;
	}

	/**
	 * @param fdDriveYear
	 *            要设置的 驾龄
	 */
	public void setFdDriveYear(String fdDriveYear) {
		this.fdDriveYear = fdDriveYear;
	}

	/**
	 * @return 返回 驾照号
	 */
	public String getFdDriverNumber() {
		return fdDriverNumber;
	}

	/**
	 * @param fdDriverNumber
	 *            要设置的 驾照号
	 */
	public void setFdDriverNumber(String fdDriverNumber) {
		this.fdDriverNumber = fdDriverNumber;
	}

	/**
	 * @return 返回 年审时间
	 */
	public Date getFdAnnualAuditingTime() {
		return fdAnnualAuditingTime;
	}

	/**
	 * @param fdAnnualAuditingTime
	 *            要设置的 年审时间
	 */
	public void setFdAnnualAuditingTime(Date fdAnnualAuditingTime) {
		this.fdAnnualAuditingTime = fdAnnualAuditingTime;
	}

	/**
	 * @return 返回 证件类型
	 */
	public String getFdCredentialsType() {
		return fdCredentialsType;
	}

	/**
	 * @param fdCredentialsType
	 *            要设置的 证件类型
	 */
	public void setFdCredentialsType(String fdCredentialsType) {
		this.fdCredentialsType = fdCredentialsType;
	}

	/**
	 * @return 返回 初次领证时间
	 */
	public Date getFdCredentialsTime() {
		return fdCredentialsTime;
	}

	/**
	 * @param fdCredentialsTime
	 *            要设置的 初次领证时间
	 */
	public void setFdCredentialsTime(Date fdCredentialsTime) {
		this.fdCredentialsTime = fdCredentialsTime;
	}

	/**
	 * @return 返回 有效期限
	 */
	public Date getFdValidTime() {
		return fdValidTime;
	}

	/**
	 * @param fdValidTime
	 *            要设置的 有效期限
	 */
	public void setFdValidTime(Date fdValidTime) {
		this.fdValidTime = fdValidTime;
	}

	/**
	 * @return 返回 年审频率
	 */
	public String getFdAnnualExamFrequency() {
		return fdAnnualExamFrequency;
	}

	/**
	 * @param fdAnnualExamFrequency
	 *            要设置的 年审频率
	 */
	public void setFdAnnualExamFrequency(String fdAnnualExamFrequency) {
		this.fdAnnualExamFrequency = fdAnnualExamFrequency;
	}

	/**
	 * @return 返回 证件号码
	 */
	public String getFdCredentialsNumber() {
		return fdCredentialsNumber;
	}

	/**
	 * @param fdCredentialsNumber
	 *            要设置的 证件号码
	 */
	public void setFdCredentialsNumber(String fdCredentialsNumber) {
		this.fdCredentialsNumber = fdCredentialsNumber;
	}

	/**
	 * @return 返回 身份证号
	 */
	public String getFdIdentificationNumber() {
		return fdIdentificationNumber;
	}

	/**
	 * @param fdIdentificationNumber
	 *            要设置的 身份证号
	 */
	public void setFdIdentificationNumber(String fdIdentificationNumber) {
		this.fdIdentificationNumber = fdIdentificationNumber;
	}

	/**
	 * @return 返回 联系方式
	 */
	public String getFdRelationInfo() {
		return fdRelationInfo;
	}

	/**
	 * @param fdRelationInfo
	 *            要设置的 联系方式
	 */
	public void setFdRelationInfo(String fdRelationInfo) {
		this.fdRelationInfo = fdRelationInfo;
	}

	/**
	 * @return 返回 手机
	 */
	public String getFdRelationPhone() {
		return fdRelationPhone;
	}

	/**
	 * @param fdRelationPhone
	 *            要设置的 手机
	 */
	public void setFdRelationPhone(String fdRelationPhone) {
		this.fdRelationPhone = fdRelationPhone;
	}

	/**
	 * @return 返回 通知方式
	 */
	public String getFdNotifyType() {
		return fdNotifyType;
	}

	/**
	 * @param fdNotifyType
	 *            要设置的 通知方式
	 */
	public void setFdNotifyType(String fdNotifyType) {
		this.fdNotifyType = fdNotifyType;
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

	@Override
    public Class getFormClass() {
		return KmCarmngDriversInfoForm.class;
	}

	private static ModelToFormPropertyMap toFormPropertyMap = null;

	@Override
    public ModelToFormPropertyMap getToFormPropertyMap() {
		if (toFormPropertyMap == null) {
			toFormPropertyMap = new ModelToFormPropertyMap();
			toFormPropertyMap.put("docCreator.fdId", "docCreatorId");
			toFormPropertyMap.put("docCreator.fdName", "docCreatorName");
			toFormPropertyMap.put("fdMotorcade.fdId", "fdMotorcadeId");
			toFormPropertyMap.put("fdMotorcade.fdName", "fdMotorcadeName");
			toFormPropertyMap.put("fdNotifyPersons",
					new ModelConvertor_ModelListToString(
							"fdNotifyPersonIds:fdNotifyPersonNames",
							"fdId:fdName"));
		}
		return toFormPropertyMap;
	}

	public KmCarmngMotorcadeSet getFdMotorcade() {
		return this.fdMotorcade;
	}

	public void setFdMotorcade(KmCarmngMotorcadeSet fdMotorcade) {
		this.fdMotorcade = fdMotorcade;
	}

	public List<SysOrgElement> getFdNotifyPersons() {
		return this.fdNotifyPersons;
	}

	public void setFdNotifyPersons(List<SysOrgElement> fdNotifyPersons) {
		this.fdNotifyPersons = fdNotifyPersons;
	}

	public SysOrgElement getDocCreator() {
		return this.docCreator;
	}

	public void setDocCreator(SysOrgElement docCreator) {
		this.docCreator = docCreator;
	}

	public String getFdSysId() {
		return this.fdSysId;
	}

	public void setFdSysId(String fdSysId) {
		this.fdSysId = fdSysId;
	}

	public String getFdType() {
		return this.fdType;
	}

	public void setFdType(String fdType) {
		this.fdType = fdType;
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
