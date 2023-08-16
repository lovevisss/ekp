package com.landray.kmss.km.carmng.forms;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.web.action.ActionMapping;

import com.landray.kmss.common.convertor.FormConvertor_IDToModel;
import com.landray.kmss.common.convertor.FormConvertor_IDsToModelList;
import com.landray.kmss.common.convertor.FormToModelPropertyMap;
import com.landray.kmss.common.forms.ExtendForm;
import com.landray.kmss.km.carmng.model.KmCarmngInfomation;
import com.landray.kmss.km.carmng.model.KmCarmngInsuranceInfo;
import com.landray.kmss.sys.attachment.forms.AttachmentDetailsForm;
import com.landray.kmss.sys.attachment.forms.IAttachmentForm;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.util.AutoHashMap;

/**
 * 创建日期 2010-三月-24
 * 
 * @author 叶中奇
 */
public class KmCarmngInsuranceInfoForm extends ExtendForm implements
		IAttachmentForm {
	/*
	 * 厂牌号码
	 */
	private String fdProductBrand = null;
	/*
	 * 车牌号码
	 */
	private String fdVehiclesInfoId = null;

	private String fdVehiclesInfoName = null;

	private String fdVehiclesInfoNo = null;

	private String fdVehiclesCategoryName = null;

	/*
	 * 初次登记日期
	 */
	private String fdRegisterTime = null;
	/*
	 * 保险开始日期
	 */
	private String fdInsuranceStartTime = null;
	/*
	 * 保险结束日期
	 */
	private String fdInsuranceEndTime = null;
	/*
	 * 保险价值
	 */
	private String fdInsurancePrice = null;
	/*
	 * 车损
	 */
	private String fdIsDamag = null;
	/*
	 * 第三者险
	 */
	private String fdIsThirdInsurance = null;
	/*
	 * 抢险
	 */
	private String fdIsRobInsurance = null;
	/*
	 * 玻璃险
	 */
	private String fdIsGlassInsurance = null;
	/*
	 * 不记免赔
	 */
	private String fdIsAbatement = null;
	/*
	 * 强制险
	 */
	private String fdIsHeadline = null;
	/*
	 * 责任险
	 */
	private String fdIsLiability = null;
	/*
	 * 保险金额
	 */
	private String fdInsuranceFee = null;
	/*
	 * 保险单号
	 */
	private String fdInsuranceNo = null;
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

	/*
	 * 保险到期前通知人
	 */
	private String fdNotifyPersonIds = null;
	private String fdNotifyPersonNames = null;

	/*
	 * 修改时间
	 */
	private String docModifyTime = null;

	/*
	 * 修改者
	 */

	private String docModifierName = null;

	public String getDocModifyTime() {
		return docModifyTime;
	}

	public void setDocModifyTime(String docModifyTime) {
		this.docModifyTime = docModifyTime;
	}

	public String getDocModifierName() {
		return docModifierName;
	}

	public void setDocModifierName(String docModifierName) {
		this.docModifierName = docModifierName;
	}

	public String getFdNotifyPersonIds() {
		return fdNotifyPersonIds;
	}

	public void setFdNotifyPersonIds(String fdNotifyPersonIds) {
		this.fdNotifyPersonIds = fdNotifyPersonIds;
	}

	public String getFdNotifyPersonNames() {
		return fdNotifyPersonNames;
	}

	public void setFdNotifyPersonNames(String fdNotifyPersonNames) {
		this.fdNotifyPersonNames = fdNotifyPersonNames;
	}

	/**
	 * 提前通知天数
	 */
	private String fdNotifyBeforeDay = null;

	public String getFdNotifyBeforeDay() {
		return fdNotifyBeforeDay;
	}

	public void setFdNotifyBeforeDay(String fdNotifyBeforeDay) {
		this.fdNotifyBeforeDay = fdNotifyBeforeDay;
	}

	/**
	 * 是否在保险日期结束前进行通知
	 */

	private String fdIsNotify = null;

	public String getFdIsNotify() {
		return fdIsNotify;
	}

	public void setFdIsNotify(String fdIsNotify) {
		this.fdIsNotify = fdIsNotify;
	}

	/**
	 * @return 返回 厂牌号码
	 */
	public String getFdProductBrand() {
		return fdProductBrand;
	}

	/**
	 * @param fdProductBrand
	 *            要设置的 厂牌号码
	 */
	public void setFdProductBrand(String fdProductBrand) {
		this.fdProductBrand = fdProductBrand;
	}

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
	 * @return 返回 初次登记日期
	 */
	public String getFdRegisterTime() {
		return fdRegisterTime;
	}

	/**
	 * @param fdRegisterTime
	 *            要设置的 初次登记日期
	 */
	public void setFdRegisterTime(String fdRegisterTime) {
		this.fdRegisterTime = fdRegisterTime;
	}

	/**
	 * @return 返回 保险开始日期
	 */
	public String getFdInsuranceStartTime() {
		return fdInsuranceStartTime;
	}

	/**
	 * @param fdInsuranceStartTime
	 *            要设置的 保险开始日期
	 */
	public void setFdInsuranceStartTime(String fdInsuranceStartTime) {
		this.fdInsuranceStartTime = fdInsuranceStartTime;
	}

	/**
	 * @return 返回 保险结束日期
	 */
	public String getFdInsuranceEndTime() {
		return fdInsuranceEndTime;
	}

	/**
	 * @param fdInsuranceEndTime
	 *            要设置的 保险结束日期
	 */
	public void setFdInsuranceEndTime(String fdInsuranceEndTime) {
		this.fdInsuranceEndTime = fdInsuranceEndTime;
	}

	/**
	 * @return 返回 保险价值
	 */
	public String getFdInsurancePrice() {
		return fdInsurancePrice;
	}

	/**
	 * @param fdInsurancePrice
	 *            要设置的 保险价值
	 */
	public void setFdInsurancePrice(String fdInsurancePrice) {
		this.fdInsurancePrice = fdInsurancePrice;
	}

	/**
	 * @return 返回 车损
	 */
	public String getFdIsDamag() {
		return fdIsDamag;
	}

	/**
	 * @param fdIsDamag
	 *            要设置的 车损
	 */
	public void setFdIsDamag(String fdIsDamag) {
		this.fdIsDamag = fdIsDamag;
	}

	/**
	 * @return 返回 第三者险
	 */
	public String getFdIsThirdInsurance() {
		return fdIsThirdInsurance;
	}

	/**
	 * @param fdIsThirdInsurance
	 *            要设置的 第三者险
	 */
	public void setFdIsThirdInsurance(String fdIsThirdInsurance) {
		this.fdIsThirdInsurance = fdIsThirdInsurance;
	}

	/**
	 * @return 返回 抢险
	 */
	public String getFdIsRobInsurance() {
		return fdIsRobInsurance;
	}

	/**
	 * @param fdIsRobInsurance
	 *            要设置的 抢险
	 */
	public void setFdIsRobInsurance(String fdIsRobInsurance) {
		this.fdIsRobInsurance = fdIsRobInsurance;
	}

	/**
	 * @return 返回 玻璃险
	 */
	public String getFdIsGlassInsurance() {
		return fdIsGlassInsurance;
	}

	/**
	 * @param fdIsGlassInsurance
	 *            要设置的 玻璃险
	 */
	public void setFdIsGlassInsurance(String fdIsGlassInsurance) {
		this.fdIsGlassInsurance = fdIsGlassInsurance;
	}

	/**
	 * @return 返回 不记免赔
	 */
	public String getFdIsAbatement() {
		return fdIsAbatement;
	}

	/**
	 * @param fdIsAbatement
	 *            要设置的 不记免赔
	 */
	public void setFdIsAbatement(String fdIsAbatement) {
		this.fdIsAbatement = fdIsAbatement;
	}

	/**
	 * @return 返回 强制险
	 */
	public String getFdIsHeadline() {
		return fdIsHeadline;
	}

	/**
	 * @param fdIsHeadline
	 *            要设置的 强制险
	 */
	public void setFdIsHeadline(String fdIsHeadline) {
		this.fdIsHeadline = fdIsHeadline;
	}

	/**
	 * @return 返回 责任险
	 */
	public String getFdIsLiability() {
		return fdIsLiability;
	}

	/**
	 * @param fdIsLiability
	 *            要设置的 责任险
	 */
	public void setFdIsLiability(String fdIsLiability) {
		this.fdIsLiability = fdIsLiability;
	}

	/**
	 * @return 返回 保险金额
	 */
	public String getFdInsuranceFee() {
		return fdInsuranceFee;
	}

	/**
	 * @param fdInsuranceFee
	 *            要设置的 保险金额
	 */
	public void setFdInsuranceFee(String fdInsuranceFee) {
		this.fdInsuranceFee = fdInsuranceFee;
	}

	/**
	 * @return 返回 保险单号
	 */
	public String getFdInsuranceNo() {
		return fdInsuranceNo;
	}

	/**
	 * @param fdInsuranceNo
	 *            要设置的 保险单号
	 */
	public void setFdInsuranceNo(String fdInsuranceNo) {
		this.fdInsuranceNo = fdInsuranceNo;
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
		fdProductBrand = null;
		fdVehiclesInfoId = null;
		fdVehiclesInfoName = null;
		fdVehiclesInfoNo = null;
		fdRegisterTime = null;
		fdInsuranceStartTime = null;
		fdInsuranceEndTime = null;
		fdInsurancePrice = null;
		fdIsDamag = "1";
		fdIsThirdInsurance = "1";
		fdIsRobInsurance = "1";
		fdIsGlassInsurance = "1";
		fdIsAbatement = "1";
		fdIsHeadline = "1";
		fdIsLiability = "1";
		fdInsuranceFee = null;
		fdInsuranceNo = null;
		fdRemark = null;
		docCreateTime = null;
		docCreatorId = null;
		docCreatorName = null;
		fdNotifyPersonIds = null;
		fdNotifyPersonNames = null;
		fdNotifyBeforeDay = "30";
		fdIsNotify = "true";
		docModifyTime = null;
		docModifierName = null;
		super.reset(mapping, request);
	}

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

	public String getDocCreatorName() {
		return this.docCreatorName;
	}

	public void setDocCreatorName(String docCreatorName) {
		this.docCreatorName = docCreatorName;
	}

	public String getFdVehiclesCategoryName() {
		return this.fdVehiclesCategoryName;
	}

	public void setFdVehiclesCategoryName(String fdVehiclesCategoryName) {
		this.fdVehiclesCategoryName = fdVehiclesCategoryName;
	}

	@Override
    public Class getModelClass() {
		return KmCarmngInsuranceInfo.class;
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
			toModelPropertyMap.put("fdNotifyPersonIds",
					new FormConvertor_IDsToModelList("fdNotifyPersons",
							SysOrgElement.class));
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
