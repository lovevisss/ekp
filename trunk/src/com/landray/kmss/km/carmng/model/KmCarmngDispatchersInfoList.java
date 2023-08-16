package com.landray.kmss.km.carmng.model;

import com.landray.kmss.common.convertor.ModelConvertor_ModelToForm;
import com.landray.kmss.common.convertor.ModelToFormPropertyMap;
import com.landray.kmss.common.model.BaseModel;
import com.landray.kmss.km.carmng.forms.KmCarmngDispatchersInfoListForm;
import com.landray.kmss.sys.notify.interfaces.ISysNotifyModel;
import com.landray.kmss.sys.organization.model.SysOrgElement;

/**
 * 创建日期 2010-三月-24
 * 
 * @author 叶中奇 调度信息
 */
public class KmCarmngDispatchersInfoList extends BaseModel implements ISysNotifyModel {

	protected KmCarmngDispatchersInfo fdDispatchersInfo;

	protected KmCarmngRegisterInfo fdRegisterInfo;

	public KmCarmngRegisterInfo getFdRegisterInfo() {
		return fdRegisterInfo;
	}

	public void setFdRegisterInfo(KmCarmngRegisterInfo fdRegisterInfo) {
		this.fdRegisterInfo = fdRegisterInfo;
	}

	/*
	 * 车辆Id
	 */
	protected KmCarmngInfomation fdCarInfo;

	/*
	 * 车牌号码
	 */
	private String fdCarInfoNo = null;

	/*
	 * 车辆名称
	 */
	private String fdCarInfoName = null;

	/*
	 * 车辆类型
	 */
	private String fdVehichesTypeId = null;

	private String fdVehichesTypeName = null;

	public String getFdVehichesTypeId() {
		return fdVehichesTypeId;
	}

	public void setFdVehichesTypeId(String fdVehichesTypeId) {
		this.fdVehichesTypeId = fdVehichesTypeId;
	}

	public String getFdVehichesTypeName() {
		return fdVehichesTypeName;
	}

	public void setFdVehichesTypeName(String fdVehichesTypeName) {
		this.fdVehichesTypeName = fdVehichesTypeName;
	}

	/*
	 * 司机 这里指的是驾驶员信息的表的主键id 命名有误
	 */
	private String fdDriverId = null;
	/*
	 * 驾驶员姓名
	 */
	private String fdDriverName = null;

	/*
	 * 驾驶员电话
	 */
	private String fdRelationPhone = null;

	/*
	 * 座位数
	 */
	private String fdCarInfoSeatNumber = null;

	/*
	 * 车队Id
	 */
	private String fdMotorcadeId = null;
	/*
	 * 车队名称
	 */
	private String fdMotorcadeName = null;

	/*
	 * 驾驶员
	 */
	private SysOrgElement fdSysDriver;

	private String fdFlag;
	
	public String fdRegisterId;


	public String getFdFlag() {
		return this.fdFlag;
	}

	public void setFdFlag(String fdFlag) {
		this.fdFlag = fdFlag;
	}

	public String getFdRegisterId() {
		return fdRegisterId;
	}

	public void setFdRegisterId(String fdRegisterId) {
		this.fdRegisterId = fdRegisterId;
	}

	public KmCarmngDispatchersInfo getFdDispatchersInfo() {
		return fdDispatchersInfo;
	}

	public void setFdDispatchersInfo(KmCarmngDispatchersInfo fdDispatchersInfo) {
		this.fdDispatchersInfo = fdDispatchersInfo;
	}

	public KmCarmngInfomation getFdCarInfo() {
		return fdCarInfo;
	}

	public void setFdCarInfo(KmCarmngInfomation fdCarInfo) {
		this.fdCarInfo = fdCarInfo;
	}

	public String getFdCarInfoNo() {
		return fdCarInfoNo;
	}

	public void setFdCarInfoNo(String fdCarInfoNo) {
		this.fdCarInfoNo = fdCarInfoNo;
	}

	public String getFdCarInfoName() {
		return fdCarInfoName;
	}

	public void setFdCarInfoName(String fdCarInfoName) {
		this.fdCarInfoName = fdCarInfoName;
	}

	public String getFdDriverId() {
		return fdDriverId;
	}

	public void setFdDriverId(String fdDriverId) {
		this.fdDriverId = fdDriverId;
	}

	public String getFdDriverName() {
		return fdDriverName;
	}

	public void setFdDriverName(String fdDriverName) {
		this.fdDriverName = fdDriverName;
	}

	public String getFdRelationPhone() {
		return fdRelationPhone;
	}

	public void setFdRelationPhone(String fdRelationPhone) {
		this.fdRelationPhone = fdRelationPhone;
	}

	public String getFdCarInfoSeatNumber() {
		return fdCarInfoSeatNumber;
	}

	public void setFdCarInfoSeatNumber(String fdCarInfoSeatNumber) {
		this.fdCarInfoSeatNumber = fdCarInfoSeatNumber;
	}

	public String getFdMotorcadeId() {
		return fdMotorcadeId;
	}

	public void setFdMotorcadeId(String fdMotorcadeId) {
		this.fdMotorcadeId = fdMotorcadeId;
	}

	public String getFdMotorcadeName() {
		return fdMotorcadeName;
	}

	public void setFdMotorcadeName(String fdMotorcadeName) {
		this.fdMotorcadeName = fdMotorcadeName;
	}

	public SysOrgElement getFdSysDriver() {
		return fdSysDriver;
	}

	public void setFdSysDriver(SysOrgElement fdSysDriver) {
		this.fdSysDriver = fdSysDriver;
	}

	public KmCarmngDispatchersInfoList() {
		super();
	}

	@Override
    public Class getFormClass() {
		return KmCarmngDispatchersInfoListForm.class;
	}

	private static ModelToFormPropertyMap toFormPropertyMap = null;

	@Override
    public ModelToFormPropertyMap getToFormPropertyMap() {
		if (toFormPropertyMap == null) {
			toFormPropertyMap = new ModelToFormPropertyMap();
			toFormPropertyMap.putAll(super.getToFormPropertyMap());
			toFormPropertyMap.put("fdCarInfo.fdId", "fdCarInfoId");
			toFormPropertyMap.put("fdDispatchersInfo.fdId", "fdDispatchersInfoId");
			toFormPropertyMap.put("fdSysDriver.fdId", "fdSysDriverId");
			toFormPropertyMap.put("fdRegisterInfo", new ModelConvertor_ModelToForm("kmCarmngRegisterInfoForm"));
		}
		return toFormPropertyMap;
	}
}
