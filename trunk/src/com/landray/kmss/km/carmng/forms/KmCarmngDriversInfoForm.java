package com.landray.kmss.km.carmng.forms;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.web.action.ActionMapping;

import com.landray.kmss.common.convertor.FormConvertor_IDToModel;
import com.landray.kmss.common.convertor.FormConvertor_IDsToModelList;
import com.landray.kmss.common.convertor.FormToModelPropertyMap;
import com.landray.kmss.common.forms.ExtendForm;
import com.landray.kmss.km.carmng.model.KmCarmngDriversInfo;
import com.landray.kmss.km.carmng.model.KmCarmngMotorcadeSet;
import com.landray.kmss.sys.attachment.forms.AttachmentDetailsForm;
import com.landray.kmss.sys.attachment.forms.IAttachmentForm;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.util.AutoHashMap;

/**
 * 创建日期 2010-三月-24
 * 
 * @author 叶中奇
 */
public class KmCarmngDriversInfoForm extends ExtendForm implements
		IAttachmentForm {
	/*
	 * 排序号
	 */
	private String fdOrder = null;
	/*
	 * 姓名
	 */
	private String fdName = null;

	protected String fdSysId;

	protected String fdType;
	/*
	 * 所属车队
	 */
	private String fdMotorcadeId = null;

	private String fdMotorcadeName = null;
	/*
	 * 驾龄
	 */
	private String fdDriveYear = null;
	/*
	 * 驾照号
	 */
	private String fdDriverNumber = null;
	/*
	 * 年审时间
	 */
	private String fdAnnualAuditingTime = null;
	/*
	 * 证件类型
	 */
	private String fdCredentialsType = null;
	/*
	 * 初次领证时间
	 */
	private String fdCredentialsTime = null;
	/*
	 * 有效期限
	 */
	private String fdValidTime = null;
	/*
	 * 年审频率
	 */
	private String fdAnnualExamFrequency = null;
	/*
	 * 证件号码
	 */
	private String fdCredentialsNumber = null;
	/*
	 * 身份证号
	 */
	private String fdIdentificationNumber = null;
	/*
	 * 联系方式
	 */
	private String fdRelationInfo = null;
	/*
	 * 手机
	 */
	private String fdRelationPhone = null;
	/*
	 * 通知方式
	 */
	private String fdNotifyType = null;
	/*
	 * 通知人
	 */
	String fdNotifyPersonIds = null;

	String fdNotifyPersonNames = null;
	/*
	 * 备注
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

	private String fdIsValidation = null;

	public String getFdIsValidation() {
		return this.fdIsValidation;
	}

	public void setFdIsValidation(String fdIsValidation) {
		this.fdIsValidation = fdIsValidation;
	}

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
	 * @return 返回 所属车队
	 */
	public String getFdMotorcadeId() {
		return fdMotorcadeId;
	}

	/**
	 * @param fdMotorcadeId
	 *            要设置的 所属车队
	 */
	public void setFdMotorcadeId(String fdMotorcadeId) {
		this.fdMotorcadeId = fdMotorcadeId;
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
	public String getFdAnnualAuditingTime() {
		// if(StringUtil.isNotNull(fdAnnualAuditingTime)){
		// fdAnnualAuditingTime.substring(0, fdAnnualAuditingTime.indexOf(" "));
		// }
		return fdAnnualAuditingTime;
	}

	/**
	 * @param fdAnnualAuditingTime
	 *            要设置的 年审时间
	 */
	public void setFdAnnualAuditingTime(String fdAnnualAuditingTime) {
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
	public String getFdCredentialsTime() {
		// if(StringUtil.isNotNull(fdCredentialsTime)){
		// fdCredentialsTime.substring(0, fdCredentialsTime.indexOf(" "));
		// }
		return fdCredentialsTime;
	}

	/**
	 * @param fdCredentialsTime
	 *            要设置的 初次领证时间
	 */
	public void setFdCredentialsTime(String fdCredentialsTime) {
		this.fdCredentialsTime = fdCredentialsTime;
	}

	/**
	 * @return 返回 有效期限
	 */
	public String getFdValidTime() {
		// if(StringUtil.isNotNull(fdValidTime)){
		// fdValidTime.substring(0, fdValidTime.indexOf(" "));
		// }
		return fdValidTime;
	}

	/**
	 * @param fdValidTime
	 *            要设置的 有效期限
	 */
	public void setFdValidTime(String fdValidTime) {
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
		fdMotorcadeId = null;
		fdDriveYear = null;
		fdDriverNumber = null;
		fdAnnualAuditingTime = null;
		fdCredentialsType = null;
		fdCredentialsTime = null;
		fdValidTime = null;
		fdAnnualExamFrequency = null;
		fdCredentialsNumber = null;
		fdIdentificationNumber = null;
		fdRelationInfo = null;
		fdRelationPhone = null;
		fdNotifyType = null;
		fdNotifyPersonIds = null;
		fdNotifyPersonNames = null;
		fdRemark = null;
		docCreatorId = null;
		docCreatorName = null;
		docCreateTime = null;
		fdType = "2";
		super.reset(mapping, request);
	}

	@Override
    public Class getModelClass() {
		return KmCarmngDriversInfo.class;
	}

	private static FormToModelPropertyMap toModelPropertyMap = null;

	@Override
    public FormToModelPropertyMap getToModelPropertyMap() {
		if (toModelPropertyMap == null) {
			toModelPropertyMap = new FormToModelPropertyMap();
			toModelPropertyMap.put("docCreatorId", new FormConvertor_IDToModel(
					"docCreator", SysOrgElement.class));
			toModelPropertyMap.put("fdMotorcadeId",
					new FormConvertor_IDToModel("fdMotorcade",
							KmCarmngMotorcadeSet.class));
			toModelPropertyMap.put("fdNotifyPersonIds",
					new FormConvertor_IDsToModelList("fdNotifyPersons",
							KmCarmngDriversInfo.class));
		}
		return toModelPropertyMap;
	}

	public String getFdMotorcadeName() {
		return this.fdMotorcadeName;
	}

	public void setFdMotorcadeName(String fdMotorcadeName) {
		this.fdMotorcadeName = fdMotorcadeName;
	}

	public String getFdNotifyPersonIds() {
		return this.fdNotifyPersonIds;
	}

	public void setFdNotifyPersonIds(String fdNotifyPersonIds) {
		this.fdNotifyPersonIds = fdNotifyPersonIds;
	}

	public String getFdNotifyPersonNames() {
		return this.fdNotifyPersonNames;
	}

	public void setFdNotifyPersonNames(String fdNotifyPersonNames) {
		this.fdNotifyPersonNames = fdNotifyPersonNames;
	}

	public String getDocCreatorName() {
		return this.docCreatorName;
	}

	public void setDocCreatorName(String docCreatorName) {
		this.docCreatorName = docCreatorName;
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
