package com.landray.kmss.km.carmng.model;

import java.util.Date;

import com.landray.kmss.common.convertor.ModelToFormPropertyMap;
import com.landray.kmss.common.model.BaseModel;
import com.landray.kmss.km.carmng.forms.KmCarmngRegisterInfoForm;
import com.landray.kmss.sys.organization.model.SysOrgElement;

/**
 * 创建日期 2010-三月-24
 * 
 * @author 叶中奇 回车登记单
 */
public class KmCarmngRegisterInfo extends BaseModel {

	/*
	 * 调度单
	 */
	protected KmCarmngDispatchersInfo fdDispatchers;
	
	public KmCarmngDispatchersInfo getFdDispatchers() {
		return fdDispatchers;
	}

	public void setFdDispatchers(KmCarmngDispatchersInfo fdDispatchers) {
		this.fdDispatchers = fdDispatchers;
	}

	/*
	 * 所属调度明细
	 */
	protected KmCarmngDispatchersInfoList fdDispatchInfoList;

	public KmCarmngDispatchersInfoList getFdDispatchInfoList() {
		return fdDispatchInfoList;
	}

	public void setFdDispatchInfoList(KmCarmngDispatchersInfoList fdDispatchInfoList) {
		this.fdDispatchInfoList = fdDispatchInfoList;
	}

	/*
	 * 回车时间
	 */
	protected Date fdStartTime;
	/*
	 * 回车时间
	 */
	protected Date fdEndTime;

	/*
	 * 出车里程表数
	 */
	protected Double fdMileageBeforeNumber;

	/*
	 * 回车里程表数
	 */
	protected Double fdMileageAfterNumber;
	
	/*
	 * 开始行驶里程
	 */
	protected Double fdMileageStartNumber;
	/*
	 * 结束行驶里程
	 */
	protected Double fdMileageEndNumber;
	/*
	 * 行驶里程数 新增字段by张文添
	 */
	protected Double fdMileageNumber;

	public Double getFdMileageNumber() {
		return fdMileageNumber;
	}

	public void setFdMileageNumber(Double fdMileageNumber) {
		this.fdMileageNumber = fdMileageNumber;
	}

	/*
	 * 实际行驶路线
	 */
	protected String fdRealPath;

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

	protected Double fdTotalFee;

	/*
	 * 洗车费用
	 */
	protected Double fdCarwashFee;

	/*
	 * 备注
	 */
	protected String fdRemark;

	/*
	 * 登记者
	 */
	protected SysOrgElement fdRegister;

	/*
	 * 登记时间
	 */
	protected Date fdRegisterTime;

	public Double getFdTotalFee() {
		return this.fdTotalFee;
	}

	public void setFdTotalFee(Double fdTotalFee) {
		this.fdTotalFee = fdTotalFee;
	}

	public KmCarmngRegisterInfo() {
		super();
	}

	public SysOrgElement getFdRegister() {
		return this.fdRegister;
	}

	public void setFdRegister(SysOrgElement fdRegister) {
		this.fdRegister = fdRegister;
	}

	/**
	 * @return 返回 回车时间
	 */
	public Date getFdEndTime() {
		return fdEndTime;
	}

	/**
	 * @param fdEndTime
	 *            要设置的 回车时间
	 */
	public void setFdEndTime(Date fdEndTime) {
		this.fdEndTime = fdEndTime;
	}

	/**
	 * @return 返回 出车里程表数
	 */
	public Double getFdMileageBeforeNumber() {
		return fdMileageBeforeNumber;
	}

	/**
	 * @param fdMileageBeforeNumber
	 *            要设置的 出车里程表数
	 */
	public void setFdMileageBeforeNumber(Double fdMileageBeforeNumber) {
		this.fdMileageBeforeNumber = fdMileageBeforeNumber;
	}

	/**
	 * @return 返回 回车里程表数
	 */
	public Double getFdMileageAfterNumber() {
		return fdMileageAfterNumber;
	}

	/**
	 * @param fdMileageAfterNumber
	 *            要设置的 回车里程表数
	 */
	public void setFdMileageAfterNumber(Double fdMileageAfterNumber) {
		this.fdMileageAfterNumber = fdMileageAfterNumber;
	}
	
	public Double getFdMileageStartNumber() {
		return fdMileageStartNumber;
	}

	public void setFdMileageStartNumber(Double fdMileageStartNumber) {
		this.fdMileageStartNumber = fdMileageStartNumber;
	}

	public Double getFdMileageEndNumber() {
		return fdMileageEndNumber;
	}

	public void setFdMileageEndNumber(Double fdMileageEndNumber) {
		this.fdMileageEndNumber = fdMileageEndNumber;
	}

	/**
	 * @return 返回 实际行驶路线
	 */
	public String getFdRealPath() {
		return fdRealPath;
	}

	/**
	 * @param fdRealPath
	 *            要设置的 实际行驶路线
	 */
	public void setFdRealPath(String fdRealPath) {
		this.fdRealPath = fdRealPath;
	}

	/**
	 * @return 返回 停车费用
	 */
	public Double getFdStopFee() {
		return fdStopFee;
	}

	/**
	 * @param fdStopFee
	 *            要设置的 停车费用
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
	 * @param fdTurnpikeFee
	 *            要设置的 路桥费用
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
	 * @param fdFuelFee
	 *            要设置的 燃油费用
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
	 * @param fdOtherFee
	 *            要设置的 其他费用
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
	 * @param fdCarwashFee
	 *            要设置的 洗车费用
	 */
	public void setFdCarwashFee(Double fdCarwashFee) {
		this.fdCarwashFee = fdCarwashFee;
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
	 * @return 返回 登记时间
	 */
	public Date getFdRegisterTime() {
		return fdRegisterTime;
	}

	/**
	 * @param fdRegisterTime
	 *            要设置的 登记时间
	 */
	public void setFdRegisterTime(Date fdRegisterTime) {
		this.fdRegisterTime = fdRegisterTime;
	}

	@Override
    public Class getFormClass() {
		return KmCarmngRegisterInfoForm.class;
	}

	public Date getFdStartTime() {
		return this.fdStartTime;
	}

	public void setFdStartTime(Date fdStartTime) {
		this.fdStartTime = fdStartTime;
	}

	private static ModelToFormPropertyMap toFormPropertyMap = null;

	@Override
    public ModelToFormPropertyMap getToFormPropertyMap() {
		if (toFormPropertyMap == null) {
			toFormPropertyMap = new ModelToFormPropertyMap();
			toFormPropertyMap.put("fdRegister.fdId", "fdRegisterId");
			toFormPropertyMap.put("fdRegister.fdName", "fdRegisterName");
			toFormPropertyMap.put("fdDispatchInfoList.fdId", "fdDispatchInfoListId");
			toFormPropertyMap.put("fdDispatchInfoList.fdCarInfoNo", "fdCarInfoNo");
			toFormPropertyMap.put("fdDispatchInfoList.fdMotorcadeName", "fdMotorcadeName");
			toFormPropertyMap.put("fdDispatchInfoList.fdMotorcadeId",
					"fdMotorcadeId");
			toFormPropertyMap.put("fdDispatchInfoList.fdDriverName", "fdDriversName");
			toFormPropertyMap.put("fdDispatchInfoList.fdDriverId", "fdDriverId");
			// toFormPropertyMap.put("fdDispatchers.fdTravelPath",
			// "fdTravelPath");
			// toFormPropertyMap.put("fdDispatchers.fdMileage",
			// "fdMileageBeforeNumber");
			// toFormPropertyMap.put("fdDispatchers.fdDestination",
			// "fdDestination");
		}
		return toFormPropertyMap;
	}

}
