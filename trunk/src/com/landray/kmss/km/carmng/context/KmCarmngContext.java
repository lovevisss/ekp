package com.landray.kmss.km.carmng.context;

import java.util.Date;

public class KmCarmngContext {

	private String fdCarId;

	private String fdCarNo;

	private String fdCarName;

	private String fdCarCategoryName;

	private String fdCarCategoryId;

	private Double fdInsuranceInfoFee;

	private Double fdRepairFee;

	private Double fdMaintenanceFee;

	private Double fdOtherFee;

	private Double fdFee;

	private Double fdMileageNumber;

	// 违章时间
	private Date fdInfringeTime;

	public Date getFdInfringeTime() {
		return fdInfringeTime;
	}

	public void setFdInfringeTime(Date fdInfringeTime) {
		this.fdInfringeTime = fdInfringeTime;
	}

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
	 * 洗车费用
	 */
	protected Double fdCarwashFee;

	protected Double fdTotalFee;

	/*
	 * 违章费用
	 */
	protected Double fdInfringeFee;

	public Double getFdInfringeFee() {
		return this.fdInfringeFee;
	}

	public void setFdInfringeFee(Double fdInfringeFee) {
		this.fdInfringeFee = fdInfringeFee;
	}

	public String getFdCarId() {
		return this.fdCarId;
	}

	public void setFdCarId(String fdCarId) {
		this.fdCarId = fdCarId;
	}

	public String getFdCarNo() {
		return this.fdCarNo;
	}

	public void setFdCarNo(String fdCarNo) {
		this.fdCarNo = fdCarNo;
	}

	public String getFdCarName() {
		return this.fdCarName;
	}

	public void setFdCarName(String fdCarName) {
		this.fdCarName = fdCarName;
	}

	public String getFdCarCategoryName() {
		return this.fdCarCategoryName;
	}

	public void setFdCarCategoryName(String fdCarCategoryName) {
		this.fdCarCategoryName = fdCarCategoryName;
	}

	public String getFdCarCategoryId() {
		return this.fdCarCategoryId;
	}

	public void setFdCarCategoryId(String fdCarCategoryId) {
		this.fdCarCategoryId = fdCarCategoryId;
	}

	public Double getFdRepairFee() {
		return this.fdRepairFee;
	}

	public void setFdRepairFee(Double fdRepairFee) {
		this.fdRepairFee = fdRepairFee;
	}

	public Double getFdMaintenanceFee() {
		return this.fdMaintenanceFee;
	}

	public void setFdMaintenanceFee(Double fdMaintenanceFee) {
		this.fdMaintenanceFee = fdMaintenanceFee;
	}

	public Double getFdOtherFee() {
		return this.fdOtherFee;
	}

	public void setFdOtherFee(Double fdOtherFee) {
		this.fdOtherFee = fdOtherFee;
	}

	public Double getFdStopFee() {
		return this.fdStopFee;
	}

	public void setFdStopFee(Double fdStopFee) {
		this.fdStopFee = fdStopFee;
	}

	public Double getFdTurnpikeFee() {
		return this.fdTurnpikeFee;
	}

	public void setFdTurnpikeFee(Double fdTurnpikeFee) {
		this.fdTurnpikeFee = fdTurnpikeFee;
	}

	public Double getFdFuelFee() {
		return this.fdFuelFee;
	}

	public void setFdFuelFee(Double fdFuelFee) {
		this.fdFuelFee = fdFuelFee;
	}

	public Double getFdCarwashFee() {
		return this.fdCarwashFee;
	}

	public void setFdCarwashFee(Double fdCarwashFee) {
		this.fdCarwashFee = fdCarwashFee;
	}

	public Double getFdTotalFee() {
		return this.fdTotalFee;
	}

	public void setFdTotalFee(Double fdTotalFee) {
		this.fdTotalFee = fdTotalFee;
	}

	public Double getFdInsuranceInfoFee() {
		return this.fdInsuranceInfoFee;
	}

	public void setFdInsuranceInfoFee(Double fdInsuranceInfoFee) {
		this.fdInsuranceInfoFee = fdInsuranceInfoFee;
	}

	public Double getFdFee() {
		return this.fdFee;
	}

	public void setFdFee(Double fdFee) {
		this.fdFee = fdFee;
	}

	public Double getFdMileageNumber() {
		return this.fdMileageNumber;
	}

	public void setFdMileageNumber(Double fdMileageNumber) {
		this.fdMileageNumber = fdMileageNumber;
	}

}
