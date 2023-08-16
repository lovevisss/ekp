package com.landray.kmss.km.carmng.forms;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.web.action.ActionMapping;

import com.landray.kmss.common.convertor.FormConvertor_IDToModel;
import com.landray.kmss.common.convertor.FormToModelPropertyMap;
import com.landray.kmss.common.forms.ExtendForm;
import com.landray.kmss.km.carmng.model.KmCarmngDispatchersInfoList;
import com.landray.kmss.km.carmng.model.KmCarmngRegisterInfo;
import com.landray.kmss.sys.organization.model.SysOrgElement;

/**
 * 创建日期 2010-三月-24
 * 
 * @author 叶中奇
 */
public class KmCarmngRegisterInfoForm extends ExtendForm {

	/*
	 * 调度单
	 */
	private String fdDispatchInfoListId = null;
	/*
	 * 回车时间
	 */
	private String fdStartTime = null;
	/*
	 * 回车时间
	 */
	private String fdEndTime = null;
	/*
	 * 出车里程表数
	 */
	private String fdMileageBeforeNumber = null;
	/*
	 * 回车里程表数
	 */
	private String fdMileageAfterNumber = null;
	/*
	 * 行驶里程数by张文添
	 */
	private String fdMileageNumber = null;
	
	/*
	 * 开始行驶里程
	 */
	protected String fdMileageStartNumber = null;
	/*
	 * 结束行驶里程
	 */
	protected String fdMileageEndNumber = null;

	public String getFdMileageNumber() {
		return fdMileageNumber;
	}

	public void setFdMileageNumber(String fdMileageNumber) {
		this.fdMileageNumber = fdMileageNumber;
	}

	/*
	 * 实际行驶路线
	 */
	private String fdRealPath = null;

	private String fdCarInfoNo = null;

	private String fdMotorcadeId = null;

	public String getFdMotorcadeId() {
		return fdMotorcadeId;
	}

	public void setFdMotorcadeId(String fdMotorcadeId) {
		this.fdMotorcadeId = fdMotorcadeId;
	}

	private String fdMotorcadeName = null;

	private String fdDriversName = null;
	private String fdDriverId = null;

	public String getFdDriverId() {
		return fdDriverId;
	}

	public void setFdDriverId(String fdDriverId) {
		this.fdDriverId = fdDriverId;
	}

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

	private String fdTotalFee = null;
	/*
	 * 洗车费用
	 */
	private String fdCarwashFee = null;
	/*
	 * 备注
	 */
	private String fdRemark = null;
	/*
	 * 登记者
	 */
	private String fdRegisterId = null;

	private String fdRegisterName = null;

	public String getFdTotalFee() {
		return this.fdTotalFee;
	}

	public void setFdTotalFee(String fdTotalFee) {
		this.fdTotalFee = fdTotalFee;
	}

	/*
	 * 登记时间
	 */
	private String fdRegisterTime = null;

	public String getFdRegisterName() {
		return this.fdRegisterName;
	}

	public void setFdRegisterName(String fdRegisterName) {
		this.fdRegisterName = fdRegisterName;
	}

	public String getFdDispatchInfoListId() {
		return fdDispatchInfoListId;
	}

	public void setFdDispatchInfoListId(String fdDispatchInfoListId) {
		this.fdDispatchInfoListId = fdDispatchInfoListId;
	}

	/**
	 * @return 返回 回车时间
	 */
	public String getFdEndTime() {
		return fdEndTime;
	}

	/**
	 * @param fdEndTime
	 *            要设置的 回车时间
	 */
	public void setFdEndTime(String fdEndTime) {
		this.fdEndTime = fdEndTime;
	}

	/**
	 * @return 返回 出车里程表数
	 */
	public String getFdMileageBeforeNumber() {
		return fdMileageBeforeNumber;
	}

	/**
	 * @param fdMileageBeforeNumber
	 *            要设置的 出车里程表数
	 */
	public void setFdMileageBeforeNumber(String fdMileageBeforeNumber) {
		this.fdMileageBeforeNumber = fdMileageBeforeNumber;
	}

	/**
	 * @return 返回 回车里程表数
	 */
	public String getFdMileageAfterNumber() {
		return fdMileageAfterNumber;
	}

	/**
	 * @param fdMileageAfterNumber
	 *            要设置的 回车里程表数
	 */
	public void setFdMileageAfterNumber(String fdMileageAfterNumber) {
		this.fdMileageAfterNumber = fdMileageAfterNumber;
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
	public String getFdStopFee() {
		return fdStopFee;
	}

	/**
	 * @param fdStopFee
	 *            要设置的 停车费用
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
	 * @param fdTurnpikeFee
	 *            要设置的 路桥费用
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
	 * @param fdFuelFee
	 *            要设置的 燃油费用
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
	 * @param fdOtherFee
	 *            要设置的 其他费用
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
	 * @param fdCarwashFee
	 *            要设置的 洗车费用
	 */
	public void setFdCarwashFee(String fdCarwashFee) {
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
	 * @return 返回 登记者
	 */
	public String getFdRegisterId() {
		return fdRegisterId;
	}

	/**
	 * @param fdRegisterId
	 *            要设置的 登记者
	 */
	public void setFdRegisterId(String fdRegisterId) {
		this.fdRegisterId = fdRegisterId;
	}

	/**
	 * @return 返回 登记时间
	 */
	public String getFdRegisterTime() {
		return fdRegisterTime;
	}

	/**
	 * @param fdRegisterTime
	 *            要设置的 登记时间
	 */
	public void setFdRegisterTime(String fdRegisterTime) {
		this.fdRegisterTime = fdRegisterTime;
	}

	public String getFdCarInfoNo() {
		return this.fdCarInfoNo;
	}

	public void setFdCarInfoNo(String fdCarInfoNo) {
		this.fdCarInfoNo = fdCarInfoNo;
	}

	public String getFdMotorcadeName() {
		return this.fdMotorcadeName;
	}

	public void setFdMotorcadeName(String fdMotorcadeName) {
		this.fdMotorcadeName = fdMotorcadeName;
	}

	public String getFdDriversName() {
		return this.fdDriversName;
	}

	public void setFdDriversName(String fdDriversName) {
		this.fdDriversName = fdDriversName;
	}

	public String getFdMileageStartNumber() {
		return fdMileageStartNumber;
	}

	public void setFdMileageStartNumber(String fdMileageStartNumber) {
		this.fdMileageStartNumber = fdMileageStartNumber;
	}

	public String getFdMileageEndNumber() {
		return fdMileageEndNumber;
	}

	public void setFdMileageEndNumber(String fdMileageEndNumber) {
		this.fdMileageEndNumber = fdMileageEndNumber;
	}

	/*
	 * （非 Javadoc）
	 * 
	 * @seecom.landray.kmss.web.action.ActionForm#reset(org.apache.struts.action.
	 * ActionMapping, javax.servlet.http.HttpServletRequest)
	 */
	@Override
    public void reset(ActionMapping mapping, HttpServletRequest request) {
		fdDispatchInfoListId = null;
		fdEndTime = null;
		fdMileageBeforeNumber = null;
		fdMileageAfterNumber = null;
		fdRealPath = null;
		fdStopFee = null;
		fdTurnpikeFee = null;
		fdFuelFee = null;
		fdOtherFee = null;
		fdCarwashFee = null;
		fdRemark = null;
		fdRegisterId = null;
		fdRegisterName = null;
		fdRegisterTime = null;
		fdMileageNumber = null;
		fdMileageStartNumber = null;
		fdMileageEndNumber = null;
		super.reset(mapping, request);
	}

	@Override
    public Class getModelClass() {
		return KmCarmngRegisterInfo.class;
	}

	private static FormToModelPropertyMap toModelPropertyMap = null;

	@Override
    public FormToModelPropertyMap getToModelPropertyMap() {
		if (toModelPropertyMap == null) {
			toModelPropertyMap = new FormToModelPropertyMap();
			toModelPropertyMap.put("fdRegisterId", new FormConvertor_IDToModel(
					"fdRegister", SysOrgElement.class));
			toModelPropertyMap.put("fdDispatchInfoListId",
					new FormConvertor_IDToModel("fdDispatchInfoList",
							KmCarmngDispatchersInfoList.class));
		}
		return toModelPropertyMap;
	}

	public String getFdStartTime() {
		return this.fdStartTime;
	}

	public void setFdStartTime(String fdStartTime) {
		this.fdStartTime = fdStartTime;
	}

}
