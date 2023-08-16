package com.landray.kmss.km.carmng.forms;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.common.convertor.FormConvertor_IDToModel;
import com.landray.kmss.common.convertor.FormConvertor_IDsToModelList;
import com.landray.kmss.common.convertor.FormToModelPropertyMap;
import com.landray.kmss.common.forms.ExtendForm;
import com.landray.kmss.km.carmng.model.KmCarmngCategory;
import com.landray.kmss.km.carmng.model.KmCarmngInfomation;
import com.landray.kmss.km.carmng.model.KmCarmngMotorcadeSet;
import com.landray.kmss.sys.attachment.forms.AttachmentDetailsForm;
import com.landray.kmss.sys.attachment.forms.IAttachmentForm;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.util.AutoHashMap;
import com.landray.kmss.web.action.ActionMapping;

/**
 * 创建日期 2010-三月-24
 * 
 * @author 叶中奇
 */
public class KmCarmngInfomationForm extends ExtendForm implements
		IAttachmentForm {
	/*
	 * 车牌号码
	 */
	private String fdNo = null;
	/*
	 * 车辆名称
	 */
	private String docSubject = null;
	/*
	 * 车辆类型
	 */
	private String fdVehichesTypeId = null;

	private String fdVehichesTypeName = null;
	/*
	 * 座位数
	 */
	private String fdSeatNumber = null;
	/*
	 * 所属车队
	 */
	private String fdMotorcadeId = null;

	private String fdMotorcadeName = null;
	/*
	 * 载客/载货量
	 */
	private String fdCardParameter = null;
	/*
	 * 驾驶员
	 */
	private String fdDriverId = null;
	/*
	 * 驾驶员姓名
	 */
	private String fdDriverName = null;
	/*
	 * 定额燃油标准
	 */
	private String fdFuelStandard = null;
	/*
	 * 购买时间
	 */
	private String fdBuyTime = null;
	/*
	 * 年检日期
	 */
	private String fdAnnuaCheckTime = null;
	/*
	 * 年检频率
	 */
	private String fdAnnuaCheckFrequency = null;

	/*
	 * 年检单位
	 */
	private String fdUnit = null;

	/*
	 * 保险日期
	 */
	private String fdInsutanceTime = null;
	/*
	 * 保险公司
	 */
	private String fdInsutanceComputer = null;
	/*
	 * 车船费用
	 */
	private String fdPassageMoney = null;
	/*
	 * 年票
	 */
	private String fdYearlongTicket = null;
	/*
	 * 联系电话
	 */
	private String fdRelationPhone = null;
	/*
	 * 状态
	 */
	private String docStatus = null;
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
	
	
	/*
	 * 车架号
	 */
	private String fdVin = null;
	
	/*
	 * 发动机号
	 */
	private String fdEngineNumber = null;
	

	public String getFdVin() {
		return fdVin;
	}

	public void setFdVin(String fdVin) {
		this.fdVin = fdVin;
	}

	public String getFdEngineNumber() {
		return fdEngineNumber;
	}

	public void setFdEngineNumber(String fdEngineNumber) {
		this.fdEngineNumber = fdEngineNumber;
	}
	
	/*
	 * 年检到期前通知人
	 */
	private String fdNotifyPersonIds = null;
	private String fdNotifyPersonNames = null;

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
	 * 是否在年检日期前进行通知
	 */

	private String fdIsNotify = null;

	public String getFdIsNotify() {
		return fdIsNotify;
	}

	public void setFdIsNotify(String fdIsNotify) {
		this.fdIsNotify = fdIsNotify;
	}

	/*
	 * 这个才是驾驶员的组织架构id 组织架构外的为null或者"" by张文添
	 */
	private String fdSysDriverId = null;

	public String getFdSysDriverId() {
		return fdSysDriverId;
	}

	public void setFdSysDriverId(String fdSysDriverId) {
		this.fdSysDriverId = fdSysDriverId;
	}

	/**
	 * @return 返回 车牌号码
	 */
	public String getFdNo() {
		return fdNo;
	}

	/**
	 * @param fdNo
	 *            要设置的 车牌号码
	 */
	public void setFdNo(String fdNo) {
		this.fdNo = fdNo;
	}

	/**
	 * @return 返回 车辆名称
	 */
	public String getDocSubject() {
		return docSubject;
	}

	/**
	 * @param docSubject
	 *            要设置的 车辆名称
	 */
	public void setDocSubject(String docSubject) {
		this.docSubject = docSubject;
	}

	/**
	 * @return 返回 座位数
	 */
	public String getFdSeatNumber() {
		return fdSeatNumber;
	}

	/**
	 * @param fdSeatNumber
	 *            要设置的 座位数
	 */
	public void setFdSeatNumber(String fdSeatNumber) {
		this.fdSeatNumber = fdSeatNumber;
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
	 * @return 返回 载客/载货量
	 */
	public String getFdCardParameter() {
		return fdCardParameter;
	}

	/**
	 * @param fdCardParameter
	 *            要设置的 载客/载货量
	 */
	public void setFdCardParameter(String fdCardParameter) {
		this.fdCardParameter = fdCardParameter;
	}

	/**
	 * @return 返回 驾驶员
	 */
	public String getFdDriverId() {
		return fdDriverId;
	}

	/**
	 * @param fdDriverId
	 *            要设置的 驾驶员
	 */
	public void setFdDriverId(String fdDriverId) {
		this.fdDriverId = fdDriverId;
	}

	/**
	 * @return 返回 驾驶员姓名
	 */
	public String getFdDriverName() {
		return fdDriverName;
	}

	/**
	 * @param fdDriverName
	 *            要设置的 驾驶员姓名
	 */
	public void setFdDriverName(String fdDriverName) {
		this.fdDriverName = fdDriverName;
	}


	/**
	 * @return 返回 定额燃油标准
	 */
	public String getFdFuelStandard() {
		return fdFuelStandard;
	}

	/**
	 * @param fdFuelStandard
	 *            要设置的 定额燃油标准
	 */
	public void setFdFuelStandard(String fdFuelStandard) {
		this.fdFuelStandard = fdFuelStandard;
	}

	/**
	 * @param fdUnit
	 *            要设置的 年检单位
	 */

	public String getFdUnit() {
		return fdUnit;
	}

	public void setFdUnit(String fdUnit) {
		this.fdUnit = fdUnit;
	}

	/**
	 * @return 返回 购买时间
	 */
	public String getFdBuyTime() {
		return fdBuyTime;
	}


	/**
	 * @param fdBuyTime
	 *            要设置的 购买时间
	 */
	public void setFdBuyTime(String fdBuyTime) {
		this.fdBuyTime = fdBuyTime;
	}

	/**
	 * @return 返回 年检日期
	 */
	public String getFdAnnuaCheckTime() {
		return fdAnnuaCheckTime;
	}

	/**
	 * @param fdAnnuaCheckTime
	 *            要设置的 年检日期
	 */
	public void setFdAnnuaCheckTime(String fdAnnuaCheckTime) {
		this.fdAnnuaCheckTime = fdAnnuaCheckTime;
	}

	/**
	 * @return 返回 年检频率
	 */
	public String getFdAnnuaCheckFrequency() {
		return fdAnnuaCheckFrequency;
	}

	/**
	 * @param fdAnnuaCheckFrequency
	 *            要设置的 年检频率
	 */
	public void setFdAnnuaCheckFrequency(String fdAnnuaCheckFrequency) {
		this.fdAnnuaCheckFrequency = fdAnnuaCheckFrequency;
	}

	/**
	 * @return 返回 保险日期
	 */
	public String getFdInsutanceTime() {
		return fdInsutanceTime;
	}

	/**
	 * @param fdInsutanceTime
	 *            要设置的 保险日期
	 */
	public void setFdInsutanceTime(String fdInsutanceTime) {
		this.fdInsutanceTime = fdInsutanceTime;
	}

	/**
	 * @return 返回 保险公司
	 */
	public String getFdInsutanceComputer() {
		return fdInsutanceComputer;
	}

	/**
	 * @param fdInsutanceComputer
	 *            要设置的 保险公司
	 */
	public void setFdInsutanceComputer(String fdInsutanceComputer) {
		this.fdInsutanceComputer = fdInsutanceComputer;
	}

	/**
	 * @return 返回 车船费用
	 */
	public String getFdPassageMoney() {
		return fdPassageMoney;
	}

	/**
	 * @param fdPassageMoney
	 *            要设置的 车船费用
	 */
	public void setFdPassageMoney(String fdPassageMoney) {
		this.fdPassageMoney = fdPassageMoney;
	}

	/**
	 * @return 返回 年票
	 */
	public String getFdYearlongTicket() {
		return fdYearlongTicket;
	}

	/**
	 * @param fdYearlongTicket
	 *            要设置的 年票
	 */
	public void setFdYearlongTicket(String fdYearlongTicket) {
		this.fdYearlongTicket = fdYearlongTicket;
	}

	/**
	 * @return 返回 联系电话
	 */
	public String getFdRelationPhone() {
		return fdRelationPhone;
	}

	/**
	 * @param fdRelationPhone
	 *            要设置的 联系电话
	 */
	public void setFdRelationPhone(String fdRelationPhone) {
		this.fdRelationPhone = fdRelationPhone;
	}

	/**
	 * @return 返回 状态
	 */
	public String getDocStatus() {
		return docStatus;
	}

	/**
	 * @param docStatus
	 *            要设置的 状态
	 */
	public void setDocStatus(String docStatus) {
		this.docStatus = docStatus;
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
		fdNo = null;
		docSubject = null;
		fdVehichesTypeId = null;
		fdVehichesTypeName = null;
		fdSeatNumber = null;
		fdMotorcadeId = null;
		fdMotorcadeName = null;
		fdCardParameter = null;
		fdDriverId = null;
		fdDriverName = null;
		fdFuelStandard = null;
		fdBuyTime = null;
		fdAnnuaCheckTime = null;
		fdAnnuaCheckFrequency = null;
		fdUnit = null;
		fdInsutanceTime = null;
		fdInsutanceComputer = null;
		fdPassageMoney = null;
		fdYearlongTicket = null;
		fdRelationPhone = null;
		docStatus = null;
		fdRemark = null;
		docCreatorId = null;
		docCreatorName = null;
		docCreateTime = null;
		fdSysDriverId = null;
		fdNotifyPersonIds = null;
		fdNotifyPersonNames = null;
		fdNotifyBeforeDay = "30";
		fdIsNotify = "true";
		autoHashMap.clear();
		super.reset(mapping, request);
	}

	@Override
    public Class getModelClass() {
		return KmCarmngInfomation.class;
	}

	public String getFdVehichesTypeId() {
		return this.fdVehichesTypeId;
	}

	public void setFdVehichesTypeId(String fdVehichesTypeId) {
		this.fdVehichesTypeId = fdVehichesTypeId;
	}

	public String getFdVehichesTypeName() {
		return this.fdVehichesTypeName;
	}

	public void setFdVehichesTypeName(String fdVehichesTypeName) {
		this.fdVehichesTypeName = fdVehichesTypeName;
	}

	public String getFdMotorcadeName() {
		return this.fdMotorcadeName;
	}

	public void setFdMotorcadeName(String fdMotorcadeName) {
		this.fdMotorcadeName = fdMotorcadeName;
	}

	public String getDocCreatorName() {
		return this.docCreatorName;
	}

	public void setDocCreatorName(String docCreatorName) {
		this.docCreatorName = docCreatorName;
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
			toModelPropertyMap.put("fdVehichesTypeId",
					new FormConvertor_IDToModel("fdVehichesType",
							KmCarmngCategory.class));
			toModelPropertyMap.put("fdSysDriverId",
					new FormConvertor_IDToModel("fdSysDriver",
							SysOrgElement.class));
			toModelPropertyMap.put("fdNotifyPersonIds",
					new FormConvertor_IDsToModelList("fdNotifyPersons",
							SysOrgElement.class));
		}
		return toModelPropertyMap;
	}

	AutoHashMap autoHashMap = new AutoHashMap(AttachmentDetailsForm.class);

	@Override
    public AutoHashMap getAttachmentForms() {
		return autoHashMap;
	}

}
