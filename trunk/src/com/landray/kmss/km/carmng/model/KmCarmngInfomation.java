package com.landray.kmss.km.carmng.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.landray.kmss.common.convertor.ModelConvertor_ModelListToString;
import com.landray.kmss.common.convertor.ModelToFormPropertyMap;
import com.landray.kmss.common.model.BaseModel;
import com.landray.kmss.km.carmng.forms.KmCarmngInfomationForm;
import com.landray.kmss.sys.attachment.forms.AttachmentDetailsForm;
import com.landray.kmss.sys.attachment.model.IAttachment;
import com.landray.kmss.sys.ftsearch.interfaces.INeedIndex;
import com.landray.kmss.sys.notify.interfaces.ISysNotifyModel;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.sys.recycle.model.ISysRecycleModel;
import com.landray.kmss.sys.recycle.model.SysRecycleConstant;
import com.landray.kmss.util.AutoHashMap;

/**
 * 创建日期 2010-三月-24
 * 
 * @author 叶中奇 车辆信息
 */
public class KmCarmngInfomation extends BaseModel implements IAttachment,
		ISysNotifyModel, INeedIndex, ISysRecycleModel {

	/*
	 * 车牌号码
	 */
	protected String fdNo;

	/*
	 * 车辆名称
	 */
	protected String docSubject;

	/*
	 * 车辆类型
	 */
	protected KmCarmngCategory fdVehichesType;
	
	/*
	 * 车架号
	 */
	protected String fdVin;
	
	public String getFdVin() {
		return fdVin;
	}

	public void setFdVin(String fdVin) {
		this.fdVin = fdVin;
	}

	/*
	 * 发动机号
	 */
	protected String fdEngineNumber;
	
	public String getFdEngineNumber() {
		return fdEngineNumber;
	}

	public void setFdEngineNumber(String fdEngineNumber) {
		this.fdEngineNumber = fdEngineNumber;
	}

	/*
	 * 座位数
	 */
	protected Integer fdSeatNumber;

	/*
	 * 所属车队
	 */
	protected KmCarmngMotorcadeSet fdMotorcade;

	/*
	 * 载客/载货量
	 */
	protected String fdCardParameter;

	/*
	 * 驾驶员
	 */
	protected String fdDriverId;

	/*
	 * 驾驶员姓名
	 */
	protected String fdDriverName;


	/*
	 * 定额燃油标准
	 */
	protected Double fdFuelStandard;

	/*
	 * 购买时间
	 */
	protected Date fdBuyTime;

	/*
	 * 年检日期
	 */
	protected Date fdAnnuaCheckTime;

	/*
	 * 年检频率
	 */
	protected String fdAnnuaCheckFrequency;
	/*
	 * 年检单位
	 */
	protected String fdUnit;

	/*
	 * 
	 * 
	 * /* 保险日期
	 */
	protected Date fdInsutanceTime;

	/*
	 * 保险公司
	 */
	protected String fdInsutanceComputer;

	/*
	 * 车船费用
	 */
	protected String fdPassageMoney;

	/*
	 * 年票
	 */
	protected String fdYearlongTicket;

	/*
	 * 联系电话
	 */
	protected String fdRelationPhone;

	/*
	 * 状态
	 */
	protected String docStatus;

	/*
	 * 备注
	 */
	protected String fdRemark;

	public String getFdUnit() {
		return fdUnit;
	}

	public void setFdUnit(String fdUnit) {
		this.fdUnit = fdUnit;
	}

	/*
	 * 保险到期前通知人 多对多关联
	 */
	protected List fdNotifyPersons = new ArrayList();

	public List getFdNotifyPersons() {
		return fdNotifyPersons;
	}

	public void setFdNotifyPersons(List fdNotifyPersons) {
		this.fdNotifyPersons = fdNotifyPersons;
	}

	/**
	 * 最后修改时间
	 */
	protected Date fdLastModifiedTime = new Date();

	public Date getFdLastModifiedTime() {
		return fdLastModifiedTime;
	}

	public void setFdLastModifiedTime(Date fdLastModifiedTime) {
		this.fdLastModifiedTime = fdLastModifiedTime;
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

	/*
	 * 创建时间
	 */

	/*
	 * 驾驶员
	 */
	protected SysOrgElement fdSysDriver;

	public SysOrgElement getFdSysDriver() {
		return fdSysDriver;
	}

	public void setFdSysDriver(SysOrgElement fdSysDriver) {
		this.fdSysDriver = fdSysDriver;
	}

	protected Date docCreateTime;

	protected String fdNotifyType;

	public String getFdNotifyType() {
		return this.fdNotifyType;
	}

	public void setFdNotifyType(String fdNotifyType) {
		this.fdNotifyType = fdNotifyType;
	}

	public KmCarmngInfomation() {
		super();
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
	public Integer getFdSeatNumber() {
		return fdSeatNumber;
	}

	/**
	 * @param fdSeatNumber
	 *            要设置的 座位数
	 */
	public void setFdSeatNumber(Integer fdSeatNumber) {
		this.fdSeatNumber = fdSeatNumber;
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
	public Double getFdFuelStandard() {
		return fdFuelStandard;
	}

	/**
	 * @param fdFuelStandard
	 *            要设置的 定额燃油标准
	 */
	public void setFdFuelStandard(Double fdFuelStandard) {
		this.fdFuelStandard = fdFuelStandard;
	}

	/**
	 * @return 返回 购买时间
	 */
	public Date getFdBuyTime() {
		return fdBuyTime;
	}

	/**
	 * @param fdBuyTime
	 *            要设置的 购买时间
	 */
	public void setFdBuyTime(Date fdBuyTime) {
		this.fdBuyTime = fdBuyTime;
	}

	/**
	 * @return 返回 年检日期
	 */
	public Date getFdAnnuaCheckTime() {
		return fdAnnuaCheckTime;
	}

	/**
	 * @param fdAnnuaCheckTime
	 *            要设置的 年检日期
	 */
	public void setFdAnnuaCheckTime(Date fdAnnuaCheckTime) {
		this.fdAnnuaCheckTime = fdAnnuaCheckTime;
	}

	public String getFdAnnuaCheckFrequency() {
		return this.fdAnnuaCheckFrequency;
	}

	public void setFdAnnuaCheckFrequency(String fdAnnuaCheckFrequency) {
		this.fdAnnuaCheckFrequency = fdAnnuaCheckFrequency;
	}

	/**
	 * @return 返回 保险日期
	 */
	public Date getFdInsutanceTime() {
		return fdInsutanceTime;
	}

	/**
	 * @param fdInsutanceTime
	 *            要设置的 保险日期
	 */
	public void setFdInsutanceTime(Date fdInsutanceTime) {
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
		return KmCarmngInfomationForm.class;
	}

	public KmCarmngCategory getFdVehichesType() {
		return this.fdVehichesType;
	}

	public void setFdVehichesType(KmCarmngCategory fdVehichesType) {
		this.fdVehichesType = fdVehichesType;
	}

	public KmCarmngMotorcadeSet getFdMotorcade() {
		return this.fdMotorcade;
	}

	public void setFdMotorcade(KmCarmngMotorcadeSet fdMotorcade) {
		this.fdMotorcade = fdMotorcade;
	}

	public SysOrgElement getDocCreator() {
		return this.docCreator;
	}

	public void setDocCreator(SysOrgElement docCreator) {
		this.docCreator = docCreator;
	}

	private static ModelToFormPropertyMap toFormPropertyMap = null;

	@Override
    public ModelToFormPropertyMap getToFormPropertyMap() {
		if (toFormPropertyMap == null) {
			toFormPropertyMap = new ModelToFormPropertyMap();
			toFormPropertyMap.put("docCreator.fdId", "docCreatorId");
			toFormPropertyMap.put("docCreator.fdName", "docCreatorName");
			toFormPropertyMap.put("fdVehichesType.fdId", "fdVehichesTypeId");
			toFormPropertyMap
					.put("fdVehichesType.fdName", "fdVehichesTypeName");
			toFormPropertyMap.put("fdMotorcade.fdId", "fdMotorcadeId");
			toFormPropertyMap.put("fdMotorcade.fdName", "fdMotorcadeName");
			toFormPropertyMap.put("fdNotifyPersons",
					new ModelConvertor_ModelListToString(
							"fdNotifyPersonIds:fdNotifyPersonNames",
							"fdId:fdName"));
		}
		return toFormPropertyMap;
	}

	AutoHashMap autoHashMap = new AutoHashMap(AttachmentDetailsForm.class);

	@Override
    public AutoHashMap getAttachmentForms() {
		return autoHashMap;
	}

	private Integer docDeleteFlag;

	@Override
	public boolean isNeedIndex() {
		return docDeleteFlag == null
				|| docDeleteFlag == SysRecycleConstant.OPT_TYPE_RECOVER;
	}

	@Override
	public Integer getDocDeleteFlag() {
		return docDeleteFlag;
	}

	@Override
	public void setDocDeleteFlag(Integer docDeleteFlag) {
		this.docDeleteFlag = docDeleteFlag;
	}

	private Date docDeleteTime;

	@Override
	public Date getDocDeleteTime() {
		return docDeleteTime;
	}

	@Override
	public void setDocDeleteTime(Date docDeleteTime) {
		this.docDeleteTime = docDeleteTime;
	}

	private SysOrgPerson docDeleteBy;

	@Override
	public SysOrgPerson getDocDeleteBy() {
		return docDeleteBy;
	}

	@Override
	public void setDocDeleteBy(SysOrgPerson docDeleteBy) {
		this.docDeleteBy = docDeleteBy;
	}

	@Override
	public void recalculateFields() {
		super.recalculateFields();
		this.setFdLastModifiedTime(new Date());
	}
}
