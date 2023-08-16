package com.landray.kmss.km.carmng.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.landray.kmss.common.convertor.ModelConvertor_Common;
import com.landray.kmss.common.convertor.ModelConvertor_ModelListToString;
import com.landray.kmss.common.convertor.ModelToFormPropertyMap;
import com.landray.kmss.common.model.BaseModel;
import com.landray.kmss.km.carmng.forms.KmCarmngInsuranceInfoForm;
import com.landray.kmss.sys.attachment.forms.AttachmentDetailsForm;
import com.landray.kmss.sys.attachment.model.IAttachment;
import com.landray.kmss.sys.notify.interfaces.ISysNotifyModel;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.util.AutoHashMap;
import com.landray.kmss.util.DateUtil;

/**
 * 创建日期 2010-三月-24
 * 
 * @author 叶中奇 车辆保险
 */
public class KmCarmngInsuranceInfo extends BaseModel implements IAttachment,
		ISysNotifyModel {

	/*
	 * 厂牌号码
	 */
	protected String fdProductBrand;

	/*
	 * 车牌号码
	 */
	protected KmCarmngInfomation fdVehiclesInfo;

	/*
	 * 初次登记日期
	 */
	protected Date fdRegisterTime;

	/*
	 * 保险开始日期
	 */
	protected Date fdInsuranceStartTime;

	/*
	 * 保险结束日期
	 */
	protected Date fdInsuranceEndTime;

	/*
	 * 保险价值
	 */
	protected Double fdInsurancePrice;

	/*
	 * 车损
	 */
	protected Integer fdIsDamag;

	/*
	 * 第三者险
	 */
	protected Integer fdIsThirdInsurance;

	/*
	 * 抢险
	 */
	protected Integer fdIsRobInsurance;

	/*
	 * 玻璃险
	 */
	protected Integer fdIsGlassInsurance;

	/*
	 * 不记免赔
	 */
	protected Integer fdIsAbatement;

	/*
	 * 强制险
	 */
	protected Integer fdIsHeadline;

	/*
	 * 责任险
	 */
	protected Integer fdIsLiability;

	/*
	 * 保险金额
	 */
	protected Double fdInsuranceFee;

	/*
	 * 保险单号
	 */
	protected String fdInsuranceNo;

	/*
	 * 备注
	 */
	protected String fdRemark;

	/*
	 * 创建时间
	 */
	protected Date docCreateTime;
	/*
	 * 保险到期前通知人 多对多关联
	 */
	protected List fdNotifyPersons = new ArrayList();
	
	
	/*
	 * 修改时间
	 */
	protected Date docModifyTime;

	/*
	 * 修改者
	 */
	protected SysOrgElement docModifier;

	public SysOrgElement getDocModifier() {
		return docModifier;
	}

	public void setDocModifier(SysOrgElement docModifier) {
		this.docModifier = docModifier;
	}

	public Date getDocModifyTime() {
		return docModifyTime;
	}

	public void setDocModifyTime(Date docModifyTime) {
		this.docModifyTime = docModifyTime;
	}

	public List getFdNotifyPersons() {
		return fdNotifyPersons;
	}

	public void setFdNotifyPersons(List fdNotifyPersons) {
		this.fdNotifyPersons = fdNotifyPersons;
	}

	/**
	 * 提前通知天数
	 */
	protected Integer fdNotifyBeforeDay;

	public Integer getFdNotifyBeforeDay() {
		return fdNotifyBeforeDay;
	}

	public void setFdNotifyBeforeDay(Integer fdNotifyBeforeDay) {
		this.fdNotifyBeforeDay = fdNotifyBeforeDay;
	}

	/**
	 * 是否在保险日期结束前进行通知
	 */
	protected Boolean fdIsNotify;

	public Boolean getFdIsNotify() {
		return fdIsNotify;
	}

	public void setFdIsNotify(Boolean fdIsNotify) {
		this.fdIsNotify = fdIsNotify;
	}

	/*
	 * 创建者
	 */
	protected SysOrgElement docCreator;

	public KmCarmngInsuranceInfo() {
		super();
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

	public KmCarmngInfomation getFdVehiclesInfo() {
		return this.fdVehiclesInfo;
	}

	public void setFdVehiclesInfo(KmCarmngInfomation fdVehiclesInfo) {
		this.fdVehiclesInfo = fdVehiclesInfo;
	}

	public SysOrgElement getDocCreator() {
		return this.docCreator;
	}

	public void setDocCreator(SysOrgElement docCreator) {
		this.docCreator = docCreator;
	}

	/**
	 * @return 返回 初次登记日期
	 */
	public Date getFdRegisterTime() {
		return fdRegisterTime;
	}

	/**
	 * @param fdRegisterTime
	 *            要设置的 初次登记日期
	 */
	public void setFdRegisterTime(Date fdRegisterTime) {
		this.fdRegisterTime = fdRegisterTime;
	}

	/**
	 * @return 返回 保险开始日期
	 */
	public Date getFdInsuranceStartTime() {
		return fdInsuranceStartTime;
	}

	/**
	 * @param fdInsuranceStartTime
	 *            要设置的 保险开始日期
	 */
	public void setFdInsuranceStartTime(Date fdInsuranceStartTime) {
		this.fdInsuranceStartTime = fdInsuranceStartTime;
	}

	/**
	 * @return 返回 保险结束日期
	 */
	public Date getFdInsuranceEndTime() {
		return fdInsuranceEndTime;
	}

	/**
	 * @param fdInsuranceEndTime
	 *            要设置的 保险结束日期
	 */
	public void setFdInsuranceEndTime(Date fdInsuranceEndTime) {
		this.fdInsuranceEndTime = fdInsuranceEndTime;
	}

	/**
	 * @return 返回 保险价值
	 */
	public Double getFdInsurancePrice() {
		return fdInsurancePrice;
	}

	/**
	 * @param fdInsurancePrice
	 *            要设置的 保险价值
	 */
	public void setFdInsurancePrice(Double fdInsurancePrice) {
		this.fdInsurancePrice = fdInsurancePrice;
	}

	public Integer getFdIsDamag() {
		return this.fdIsDamag;
	}

	public void setFdIsDamag(Integer fdIsDamag) {
		this.fdIsDamag = fdIsDamag;
	}

	public Integer getFdIsThirdInsurance() {
		return this.fdIsThirdInsurance;
	}

	public void setFdIsThirdInsurance(Integer fdIsThirdInsurance) {
		this.fdIsThirdInsurance = fdIsThirdInsurance;
	}

	public Integer getFdIsRobInsurance() {
		return this.fdIsRobInsurance;
	}

	public void setFdIsRobInsurance(Integer fdIsRobInsurance) {
		this.fdIsRobInsurance = fdIsRobInsurance;
	}

	public Integer getFdIsGlassInsurance() {
		return this.fdIsGlassInsurance;
	}

	public void setFdIsGlassInsurance(Integer fdIsGlassInsurance) {
		this.fdIsGlassInsurance = fdIsGlassInsurance;
	}

	public Integer getFdIsAbatement() {
		return this.fdIsAbatement;
	}

	public void setFdIsAbatement(Integer fdIsAbatement) {
		this.fdIsAbatement = fdIsAbatement;
	}

	public Integer getFdIsHeadline() {
		return this.fdIsHeadline;
	}

	public void setFdIsHeadline(Integer fdIsHeadline) {
		this.fdIsHeadline = fdIsHeadline;
	}

	public Integer getFdIsLiability() {
		return this.fdIsLiability;
	}

	public void setFdIsLiability(Integer fdIsLiability) {
		this.fdIsLiability = fdIsLiability;
	}

	public Double getFdInsuranceFee() {
		return this.fdInsuranceFee;
	}

	public void setFdInsuranceFee(Double fdInsuranceFee) {
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
		return KmCarmngInsuranceInfoForm.class;
	}

	private static ModelToFormPropertyMap toFormPropertyMap = null;

	@Override
    public ModelToFormPropertyMap getToFormPropertyMap() {
		if (toFormPropertyMap == null) {
			toFormPropertyMap = new ModelToFormPropertyMap();
			toFormPropertyMap.put("docCreator.fdId", "docCreatorId");
			toFormPropertyMap.put("docCreator.fdName", "docCreatorName");
			toFormPropertyMap.put("docModifier.fdName", "docModifierName");
			toFormPropertyMap.put("fdVehiclesInfo.fdId", "fdVehiclesInfoId");
			toFormPropertyMap.put("fdVehiclesInfo.docSubject",
					"fdVehiclesInfoName");
			toFormPropertyMap.put("fdVehiclesInfo.fdNo", "fdVehiclesInfoNo");
			toFormPropertyMap.put("fdVehiclesInfo.fdVehichesType.fdName",
					"fdVehiclesCategoryName");
			toFormPropertyMap.put("fdNotifyPersons",
					new ModelConvertor_ModelListToString(
							"fdNotifyPersonIds:fdNotifyPersonNames",
							"fdId:fdName"));
			toFormPropertyMap.put("fdRegisterTime", new ModelConvertor_Common(
					"fdRegisterTime").setDateTimeType(DateUtil.TYPE_DATE));
			toFormPropertyMap.put("fdInsuranceStartTime",
					new ModelConvertor_Common("fdInsuranceStartTime")
							.setDateTimeType(DateUtil.TYPE_DATE));
			toFormPropertyMap.put("fdInsuranceEndTime",
					new ModelConvertor_Common("fdInsuranceEndTime")
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
