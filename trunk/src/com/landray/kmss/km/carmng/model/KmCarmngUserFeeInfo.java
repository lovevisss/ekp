package com.landray.kmss.km.carmng.model;
import java.util.Date;

import com.landray.kmss.common.model.BaseModel;
import com.landray.kmss.km.carmng.forms.KmCarmngUserFeeInfoForm;
import com.landray.kmss.sys.organization.model.SysOrgElement;

/**
 * 创建日期 2010-三月-24
 * @author 叶中奇
 * 部门用车费用表
 */
public class KmCarmngUserFeeInfo  extends BaseModel {


	/*
	 * 用车人员
	 */
	protected SysOrgElement fdUser;
	
	/**
	 * 用车部门
	 */
	protected SysOrgElement fdApplicationDept;

	/*
	 * 费用
	 */
	protected Double fdFee;
	
	/*
	 * 车辆信息ID
	 */
	protected KmCarmngInfomation fdVehicles;
	
	/*
	 * 里程数
	 */
	protected Double fdMileageNumber;
	
	/*
	 * 停车费用
	 */
	protected Double fdStopFee;
	
	/*
	 * 路桥费用
	 */
	protected Double fdTurnpikeFee;
	
	/*
	 * 燃油费用
	 */
	protected Double fdFuelFee;
	
	/*
	 * 其他费用
	 */
	protected Double fdOtherFee;
	
	/*
	 * 洗车费用
	 */
	protected Double fdCarwashFee;
	
	/*
	 * 用车开始时间
	 */
	protected Date fdUseStartTime;
	
	/*
	 * 用车结束时间
	 */
	protected Date fdUseEndTime;
	
	
	protected KmCarmngDispatchersInfo kmDispatchersInfo;
	
	public KmCarmngDispatchersInfo getKmDispatchersInfo() {
		return this.kmDispatchersInfo;
	}




	public void setKmDispatchersInfo(KmCarmngDispatchersInfo kmDispatchersInfo) {
		this.kmDispatchersInfo = kmDispatchersInfo;
	}




	public KmCarmngUserFeeInfo() {
		super();
	}
	
	/**
	 * @return 返回 费用
	 */
	public Double getFdFee() {
		return fdFee;
	}
	
	/**
	 * @param fdFee 要设置的 费用
	 */
	public void setFdFee(Double fdFee) {
		this.fdFee = fdFee;
	}
	
	
	
	public SysOrgElement getFdUser() {
		return this.fdUser;
	}




	public void setFdUser(SysOrgElement fdUser) {
		this.fdUser = fdUser;
	}




	public KmCarmngInfomation getFdVehicles() {
		return this.fdVehicles;
	}




	public void setFdVehicles(KmCarmngInfomation fdVehicles) {
		this.fdVehicles = fdVehicles;
	}




	/**
	 * @return 返回 里程数
	 */
	public Double getFdMileageNumber() {
		return fdMileageNumber;
	}
	
	/**
	 * @param fdMileageNumber 要设置的 里程数
	 */
	public void setFdMileageNumber(Double fdMileageNumber) {
		this.fdMileageNumber = fdMileageNumber;
	}
	
	/**
	 * @return 返回 停车费用
	 */
	public Double getFdStopFee() {
		return fdStopFee;
	}
	
	/**
	 * @param fdStopFee 要设置的 停车费用
	 */
	public void setFdStopFee(Double fdStopFee) {
		this.fdStopFee = fdStopFee;
	}
	
	/**
	 * @return 返回 路桥费用
	 */
	public Double getFdTurnpikeFee() {
		return fdTurnpikeFee;
	}
	
	/**
	 * @param fdTurnpikeFee 要设置的 路桥费用
	 */
	public void setFdTurnpikeFee(Double fdTurnpikeFee) {
		this.fdTurnpikeFee = fdTurnpikeFee;
	}
	
	/**
	 * @return 返回 燃油费用
	 */
	public Double getFdFuelFee() {
		return fdFuelFee;
	}
	
	/**
	 * @param fdFuelFee 要设置的 燃油费用
	 */
	public void setFdFuelFee(Double fdFuelFee) {
		this.fdFuelFee = fdFuelFee;
	}
	
	/**
	 * @return 返回 其他费用
	 */
	public Double getFdOtherFee() {
		return fdOtherFee;
	}
	
	/**
	 * @param fdOtherFee 要设置的 其他费用
	 */
	public void setFdOtherFee(Double fdOtherFee) {
		this.fdOtherFee = fdOtherFee;
	}
	
	/**
	 * @return 返回 洗车费用
	 */
	public Double getFdCarwashFee() {
		return fdCarwashFee;
	}
	
	/**
	 * @param fdCarwashFee 要设置的 洗车费用
	 */
	public void setFdCarwashFee(Double fdCarwashFee) {
		this.fdCarwashFee = fdCarwashFee;
	}
	
	/**
	 * @return 返回 用车开始时间
	 */
	public Date getFdUseStartTime() {
		return fdUseStartTime;
	}
	
	/**
	 * @param fdUseStartTime 要设置的 用车开始时间
	 */
	public void setFdUseStartTime(Date fdUseStartTime) {
		this.fdUseStartTime = fdUseStartTime;
	}
	
	/**
	 * @return 返回 用车结束时间
	 */
	public Date getFdUseEndTime() {
		return fdUseEndTime;
	}
	
	/**
	 * @param fdUseEndTime 要设置的 用车结束时间
	 */
	public void setFdUseEndTime(Date fdUseEndTime) {
		this.fdUseEndTime = fdUseEndTime;
	}
	
	@Override
    public Class getFormClass() {
		return KmCarmngUserFeeInfoForm.class;
	}

	public SysOrgElement getFdApplicationDept() {
		return fdApplicationDept;
	}

	public void setFdApplicationDept(SysOrgElement fdApplicationDept) {
		this.fdApplicationDept = fdApplicationDept;
	}
}
