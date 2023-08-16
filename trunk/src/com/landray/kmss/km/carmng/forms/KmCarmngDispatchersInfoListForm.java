package com.landray.kmss.km.carmng.forms;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.web.action.ActionMapping;

import com.landray.kmss.common.convertor.FormConvertor_IDToModel;
import com.landray.kmss.common.convertor.FormToModelPropertyMap;
import com.landray.kmss.common.forms.ExtendForm;
import com.landray.kmss.km.carmng.model.KmCarmngDispatchersInfo;
import com.landray.kmss.km.carmng.model.KmCarmngDispatchersInfoList;
import com.landray.kmss.km.carmng.model.KmCarmngInfomation;
import com.landray.kmss.sys.organization.model.SysOrgElement;


public class KmCarmngDispatchersInfoListForm extends ExtendForm {

	private String fdDispatchersInfoId = null;

	public String getFdDispatchersInfoId() {
		return fdDispatchersInfoId;
	}

	public void setFdDispatchersInfoId(String fdDispatchersInfoId) {
		this.fdDispatchersInfoId = fdDispatchersInfoId;
	}

	private KmCarmngRegisterInfoForm kmCarmngRegisterInfoForm = null;

	public KmCarmngRegisterInfoForm getKmCarmngRegisterInfoForm() {
		return this.kmCarmngRegisterInfoForm;
	}

	public void setKmCarmngRegisterInfoForm(KmCarmngRegisterInfoForm kmCarmngRegisterInfoForm) {
		this.kmCarmngRegisterInfoForm = kmCarmngRegisterInfoForm;
	}
	private String fdRegisterId;

	public String getFdRegisterId() {
		return fdRegisterId;
	}

	public void setFdRegisterId(String fdRegisterId) {
		this.fdRegisterId = fdRegisterId;
	}
	/*
	 * 车辆Id
	 */
	private String fdCarInfoId = null;

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
	 * 这个才是驾驶员的组织架构id 组织架构外的为null或者"" by张文添
	 */
	private String fdSysDriverId = null;
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

	private String fdFlag = null;

	public String getFdFlag() {
		return fdFlag;
	}

	public void setFdFlag(String fdFlag) {
		this.fdFlag = fdFlag;
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

	public String getFdSysDriverId() {
		return fdSysDriverId;
	}

	public void setFdSysDriverId(String fdSysDriverId) {
		this.fdSysDriverId = fdSysDriverId;
	}

	public String getFdRelationPhone() {
		return fdRelationPhone;
	}

	public void setFdRelationPhone(String fdRelationPhone) {
		this.fdRelationPhone = fdRelationPhone;
	}

	public String getFdCarInfoId() {
		return fdCarInfoId;
	}

	public void setFdCarInfoId(String fdCarInfoId) {
		this.fdCarInfoId = fdCarInfoId;
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

	public String getFdCarInfoSeatNumber() {
		return fdCarInfoSeatNumber;
	}

	public void setFdCarInfoSeatNumber(String fdCarInfoSeatNumber) {
		this.fdCarInfoSeatNumber = fdCarInfoSeatNumber;
	}

	public String getFdMotorcadeId() {
		return this.fdMotorcadeId;
	}

	public void setFdMotorcadeId(String fdMotorcadeId) {
		this.fdMotorcadeId = fdMotorcadeId;
	}

	public String getFdMotorcadeName() {
		return this.fdMotorcadeName;
	}

	public void setFdMotorcadeName(String fdMotorcadeName) {
		this.fdMotorcadeName = fdMotorcadeName;
	}

	/*
	 * （非 Javadoc）
	 * 
	 * @seecom.landray.kmss.web.action.ActionForm#reset(org.apache.struts.action.
	 * ActionMapping, javax.servlet.http.HttpServletRequest)
	 */
	@Override
    public void reset(ActionMapping mapping, HttpServletRequest request) {
		fdCarInfoId = null;
		fdCarInfoNo = null;
		fdCarInfoName = null;
		fdVehichesTypeId = null;
		fdVehichesTypeName = null;
		fdCarInfoSeatNumber = null;
		fdDriverName = null;
		fdDriverId = null;
		fdRelationPhone = null;
		fdSysDriverId = null;
		fdFlag = "0";
		super.reset(mapping, request);
	}

	@Override
    public Class getModelClass() {
		return KmCarmngDispatchersInfoList.class;
	}



	private static FormToModelPropertyMap toModelPropertyMap = null;

	@Override
    public FormToModelPropertyMap getToModelPropertyMap() {
		if (toModelPropertyMap == null) {
			toModelPropertyMap = new FormToModelPropertyMap();
			toModelPropertyMap.put("fdSysDriverId", new FormConvertor_IDToModel("fdSysDriver", SysOrgElement.class));
			toModelPropertyMap.put("fdDispatchersInfoId",
					new FormConvertor_IDToModel("fdDispatchersInfo", KmCarmngDispatchersInfo.class));
			toModelPropertyMap.put("fdCarInfoId",
					new FormConvertor_IDToModel("fdCarInfo", KmCarmngInfomation.class));
		}
		return toModelPropertyMap;
	}
}
