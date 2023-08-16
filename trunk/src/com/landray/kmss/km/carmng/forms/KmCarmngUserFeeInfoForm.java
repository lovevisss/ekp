
package com.landray.kmss.km.carmng.forms;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.common.forms.ExtendForm;
import com.landray.kmss.km.carmng.model.KmCarmngUserFeeInfo;
import com.landray.kmss.web.action.ActionMapping;


/**
 * 创建日期 2010-三月-24
 * @author 叶中奇
 */
public class KmCarmngUserFeeInfoForm extends ExtendForm {
	/*
	 * 用车人员
	 */
    private String fdUserId = null;

	/*
	 * 用车部门
	 */
	private String fdApplicationDeptId = null;

	/*
	 * 费用
	 */
    private String fdFee = null;
	/*
	 * 车辆信息ID
	 */
    private String fdVehiclesId = null;
	/*
	 * 里程数
	 */
    private String fdMileageNumber = null;
	/*
	 * 停车费用
	 */
    private String fdStopFee = null;
	/*
	 * 路桥费用
	 */
    private String fdTurnpikeFee = null;
	/*
	 * 燃油费用
	 */
    private String fdFuelFee = null;
	/*
	 * 其他费用
	 */
    private String fdOtherFee = null;
	/*
	 * 洗车费用
	 */
    private String fdCarwashFee = null;
	/*
	 * 用车开始时间
	 */
    private String fdUseStartTime = null;
	/*
	 * 用车结束时间
	 */
    private String fdUseEndTime = null;

	/**
	 * @return 返回 用车人员
	 */
	public String getFdUserId() {
		return fdUserId;
	}
	
	/**
	 * @param fdUserId 要设置的 用车人员
	 */
	public void setFdUserId(String fdUserId) {
		this.fdUserId = fdUserId;
	}
	/**
	 * @return 返回 费用
	 */
	public String getFdFee() {
		return fdFee;
	}
	
	/**
	 * @param fdFee 要设置的 费用
	 */
	public void setFdFee(String fdFee) {
		this.fdFee = fdFee;
	}
	/**
	 * @return 返回 车辆信息ID
	 */
	public String getFdVehiclesId() {
		return fdVehiclesId;
	}
	
	/**
	 * @param fdVehiclesId 要设置的 车辆信息ID
	 */
	public void setFdVehiclesId(String fdVehiclesId) {
		this.fdVehiclesId = fdVehiclesId;
	}
	/**
	 * @return 返回 里程数
	 */
	public String getFdMileageNumber() {
		return fdMileageNumber;
	}
	
	/**
	 * @param fdMileageNumber 要设置的 里程数
	 */
	public void setFdMileageNumber(String fdMileageNumber) {
		this.fdMileageNumber = fdMileageNumber;
	}
	/**
	 * @return 返回 停车费用
	 */
	public String getFdStopFee() {
		return fdStopFee;
	}
	
	/**
	 * @param fdStopFee 要设置的 停车费用
	 */
	public void setFdStopFee(String fdStopFee) {
		this.fdStopFee = fdStopFee;
	}
	/**
	 * @return 返回 路桥费用
	 */
	public String getFdTurnpikeFee() {
		return fdTurnpikeFee;
	}
	
	/**
	 * @param fdTurnpikeFee 要设置的 路桥费用
	 */
	public void setFdTurnpikeFee(String fdTurnpikeFee) {
		this.fdTurnpikeFee = fdTurnpikeFee;
	}
	/**
	 * @return 返回 燃油费用
	 */
	public String getFdFuelFee() {
		return fdFuelFee;
	}
	
	/**
	 * @param fdFuelFee 要设置的 燃油费用
	 */
	public void setFdFuelFee(String fdFuelFee) {
		this.fdFuelFee = fdFuelFee;
	}
	/**
	 * @return 返回 其他费用
	 */
	public String getFdOtherFee() {
		return fdOtherFee;
	}
	
	/**
	 * @param fdOtherFee 要设置的 其他费用
	 */
	public void setFdOtherFee(String fdOtherFee) {
		this.fdOtherFee = fdOtherFee;
	}
	/**
	 * @return 返回 洗车费用
	 */
	public String getFdCarwashFee() {
		return fdCarwashFee;
	}
	
	/**
	 * @param fdCarwashFee 要设置的 洗车费用
	 */
	public void setFdCarwashFee(String fdCarwashFee) {
		this.fdCarwashFee = fdCarwashFee;
	}
	/**
	 * @return 返回 用车开始时间
	 */
	public String getFdUseStartTime() {
		return fdUseStartTime;
	}
	
	/**
	 * @param fdUseStartTime 要设置的 用车开始时间
	 */
	public void setFdUseStartTime(String fdUseStartTime) {
		this.fdUseStartTime = fdUseStartTime;
	}
	/**
	 * @return 返回 用车结束时间
	 */
	public String getFdUseEndTime() {
		return fdUseEndTime;
	}
	
	/**
	 * @param fdUseEndTime 要设置的 用车结束时间
	 */
	public void setFdUseEndTime(String fdUseEndTime) {
		this.fdUseEndTime = fdUseEndTime;
	}
    
	/*
	 *  （非 Javadoc）
	 * @see com.landray.kmss.web.action.ActionForm#reset(com.landray.kmss.web.action.ActionMapping, javax.servlet.http.HttpServletRequest)
	 */
    @Override
    public void reset(ActionMapping mapping, HttpServletRequest request) {
	    fdUserId = null;
	    fdFee = null;
	    fdVehiclesId = null;
	    fdMileageNumber = null;
	    fdStopFee = null;
	    fdTurnpikeFee = null;
	    fdFuelFee = null;
	    fdOtherFee = null;
	    fdCarwashFee = null;
	    fdUseStartTime = null;
	    fdUseEndTime = null;
			super.reset(mapping, request);
    }

	@Override
    public Class getModelClass() {
		return KmCarmngUserFeeInfo.class;
	}

	public String getFdApplicationDeptId() {
		return fdApplicationDeptId;
	}

	public void setFdApplicationDeptId(String fdApplicationDeptId) {
		this.fdApplicationDeptId = fdApplicationDeptId;
	}

}
