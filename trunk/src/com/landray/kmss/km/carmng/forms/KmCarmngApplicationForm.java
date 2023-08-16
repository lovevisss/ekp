package com.landray.kmss.km.carmng.forms;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.common.convertor.FormConvertor_FormListToModelList;
import com.landray.kmss.common.convertor.FormConvertor_IDToModel;
import com.landray.kmss.common.convertor.FormConvertor_IDsToModelList;
import com.landray.kmss.common.convertor.FormToModelPropertyMap;
import com.landray.kmss.km.carmng.model.KmCarmngApplication;
import com.landray.kmss.km.carmng.model.KmCarmngMotorcadeSet;
import com.landray.kmss.sys.attachment.forms.AttachmentDetailsForm;
import com.landray.kmss.sys.attachment.forms.IAttachmentForm;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.sys.right.interfaces.BaseAuthForm;
import com.landray.kmss.sys.workflow.interfaces.ISysWfMainForm;
import com.landray.kmss.sys.workflow.interfaces.SysWfBusinessForm;
import com.landray.kmss.util.AutoArrayList;
import com.landray.kmss.util.AutoHashMap;
import com.landray.kmss.web.action.ActionMapping;

/**
 * 创建日期 2010-三月-24
 * 
 * @author 黄郴
 */
public class KmCarmngApplicationForm extends BaseAuthForm implements IAttachmentForm,
		ISysWfMainForm {

	private String docSubject = null;
	/*
	 * 车队名称
	 */
	private String fdMotorcadeId = null;
	private String fdNo = null;

	private String fdMotorcadeName = null;

	private String fdMotorcadeRemark = null;

	/*
	 * 申请人
	 */
	private String fdApplicationPersonId = null;

	private String fdApplicationPersonName = null;

	public String getFdApplicationDeptId() {
		return fdApplicationDeptId;
	}

	public void setFdApplicationDeptId(String fdApplicationDeptId) {
		this.fdApplicationDeptId = fdApplicationDeptId;
	}

	public String getFdApplicationDeptName() {
		return fdApplicationDeptName;
	}

	public void setFdApplicationDeptName(String fdApplicationDeptName) {
		this.fdApplicationDeptName = fdApplicationDeptName;
	}

	/*
	 * 申请部门
	 */
	private String fdApplicationDeptId = null;

	private String fdApplicationDeptName = null;

	/*
	 * 用车人
	 */
	private String fdUserPersonIds = null;

	private String fdUserPersonNames = null;
	
	/*
	 * 外部用车人
	 */
	private String fdOtherUsers = null;

	/*
	 * 申请时间
	 */
	private String fdApplicationTime = null;
	/*
	 * 申请人电话
	 */
	private String fdApplicationPersonPhone = null;
	/*
	 * 随车人数
	 */
	private String fdUserNumber = null;
	/*
	 * 用车事由
	 */
	private String fdApplicationReason = null;
	/*
	 * 开始时间
	 */
	private String fdStartTime = null;
	/*
	 * 结束时间
	 */
	private String fdEndTime = null;
	/*
	 * 行驶路线
	 */
	private String fdApplicationPath;


	public String getFdApplicationPath() {
		return fdApplicationPath;
	}

	public void setFdApplicationPath(String fdApplicationPath) {
		this.fdApplicationPath = fdApplicationPath;
	}

	/*
	 * 出发地
	 */
	private String fdDeparture = null;

	/*
	 * 出发地经纬度
	 */
	private String fdDepartureCoordinate = null;

	/*
	 * 出发地详情
	 */
	private String fdDepartureDetail = null;
	/*
	 * 目的地
	 */
	private String fdDestination = null;

	/*
	 * 目的地经纬度
	 */
	private String fdDestinationCoordinate = null;
	/*
	 * 目的地详情
	 */
	private String fdDestinationDetail = null;

	public String getFdDeparture() {
		return fdDeparture;
	}

	public void setFdDeparture(String fdDeparture) {
		this.fdDeparture = fdDeparture;
	}

	public String getFdDestination() {
		return fdDestination;
	}

	public void setFdDestination(String fdDestination) {
		this.fdDestination = fdDestination;
	}

	public String getFdDepartureCoordinate() {
		return fdDepartureCoordinate;
	}

	public void setFdDepartureCoordinate(String fdDepartureCoordinate) {
		this.fdDepartureCoordinate = fdDepartureCoordinate;
	}

	public String getFdDestinationCoordinate() {
		return fdDestinationCoordinate;
	}

	public void setFdDestinationCoordinate(String fdDestinationCoordinate) {
		this.fdDestinationCoordinate = fdDestinationCoordinate;
	}

	public String getFdDepartureDetail() {
		return fdDepartureDetail;
	}

	public void setFdDepartureDetail(String fdDepartureDetail) {
		this.fdDepartureDetail = fdDepartureDetail;
	}

	public String getFdDestinationDetail() {
		return fdDestinationDetail;
	}

	public void setFdDestinationDetail(String fdDestinationDetail) {
		this.fdDestinationDetail = fdDestinationDetail;
	}

	/*
	 * 备注
	 */
	private String fdRemark = null;

	private String fdIsDispatcher = null;

	private KmCarmngDispatchersInfoForm kmCarmngDispatchersInfoForm = null;
	private KmCarmngEvaluationForm kmCarmngEvaluationForm = null;

	public KmCarmngEvaluationForm getKmCarmngEvaluationForm() {
		return kmCarmngEvaluationForm;
	}

	public void setKmCarmngEvaluationForm(KmCarmngEvaluationForm kmCarmngEvaluationForm) {
		this.kmCarmngEvaluationForm = kmCarmngEvaluationForm;
	}

	public String getFdIsDispatcher() {
		return this.fdIsDispatcher;
	}

	public KmCarmngDispatchersInfoForm getKmCarmngDispatchersInfoForm() {
		return this.kmCarmngDispatchersInfoForm;
	}

	public void setKmCarmngDispatchersInfoForm(
			KmCarmngDispatchersInfoForm kmCarmngDispatchersInfoForm) {
		this.kmCarmngDispatchersInfoForm = kmCarmngDispatchersInfoForm;
	}

	public void setFdIsDispatcher(String fdIsDispatcher) {
		this.fdIsDispatcher = fdIsDispatcher;
	}

	public String getFdOutStatus() {
		return this.fdOutStatus;
	}

	public void setFdOutStatus(String fdOutStatus) {
		this.fdOutStatus = fdOutStatus;
	}

	private String fdOutStatus = null;
	/*
	 * 创建者
	 */
	private String docCreatorId = null;

	private String docCreatorName = null;
	/*
	 * 创建时间
	 */
	private String docCreateTime = null;

	/**
	 * @return 返回 车队名称
	 */
	public String getFdMotorcadeId() {
		return fdMotorcadeId;
	}

	/**
	 * @return 返回 标题
	 */
	public String getDocSubject() {
		return this.docSubject;
	}

	public void setDocSubject(String docSubject) {
		this.docSubject = docSubject;
	}
	
	/**
	 * @return 返回 外部用车人
	 */
	public String getFdOtherUsers() {
		return this.fdOtherUsers;
	}

	public void setFdOtherUsers(String fdOtherUsers) {
		this.fdOtherUsers = fdOtherUsers;
	}

	public String getFdMotorcadeName() {
		return this.fdMotorcadeName;
	}

	public void setFdMotorcadeName(String fdMotorcadeName) {
		this.fdMotorcadeName = fdMotorcadeName;
	}

	public String getFdApplicationPersonId() {
		return this.fdApplicationPersonId;
	}

	public void setFdApplicationPersonId(String fdApplicationPersonId) {
		this.fdApplicationPersonId = fdApplicationPersonId;
	}

	public String getFdApplicationPersonName() {
		return this.fdApplicationPersonName;
	}

	public void setFdApplicationPersonName(String fdApplicationPersonName) {
		this.fdApplicationPersonName = fdApplicationPersonName;
	}

	public String getFdUserPersonIds() {
		return this.fdUserPersonIds;
	}

	public void setFdUserPersonIds(String fdUserPersonIds) {
		this.fdUserPersonIds = fdUserPersonIds;
	}

	public String getFdUserPersonNames() {
		return this.fdUserPersonNames;
	}

	public void setFdUserPersonNames(String fdUserPersonNames) {
		this.fdUserPersonNames = fdUserPersonNames;
	}

	public String getDocCreatorName() {
		return this.docCreatorName;
	}

	public void setDocCreatorName(String docCreatorName) {
		this.docCreatorName = docCreatorName;
	}

	/**
	 * @param fdMotorcadeId
	 *            要设置的 车队名称
	 */
	public void setFdMotorcadeId(String fdMotorcadeId) {
		this.fdMotorcadeId = fdMotorcadeId;
	}

	public String getFdNo() {
		return fdNo;
	}

	public void setFdNo(String fdNo) {
		this.fdNo = fdNo;
	}

	/**
	 * @return 返回 申请时间
	 */
	public String getFdApplicationTime() {
		return fdApplicationTime;
	}

	/**
	 * @param fdApplicationTime
	 *            要设置的 申请时间
	 */
	public void setFdApplicationTime(String fdApplicationTime) {
		this.fdApplicationTime = fdApplicationTime;
	}

	/**
	 * @return 返回 申请人电话
	 */
	public String getFdApplicationPersonPhone() {
		return fdApplicationPersonPhone;
	}

	/**
	 * @param fdApplicationPersonPhone
	 *            要设置的 申请人电话
	 */
	public void setFdApplicationPersonPhone(String fdApplicationPersonPhone) {
		this.fdApplicationPersonPhone = fdApplicationPersonPhone;
	}

	/**
	 * @return 返回 随车人数
	 */
	public String getFdUserNumber() {
		return fdUserNumber;
	}

	/**
	 * @param fdUserNumber
	 *            要设置的 随车人数
	 */
	public void setFdUserNumber(String fdUserNumber) {
		this.fdUserNumber = fdUserNumber;
	}

	/**
	 * @return 返回 用车事由
	 */
	public String getFdApplicationReason() {
		return fdApplicationReason;
	}

	/**
	 * @param fdApplicationReason
	 *            要设置的 用车事由
	 */
	public void setFdApplicationReason(String fdApplicationReason) {
		this.fdApplicationReason = fdApplicationReason;
	}

	protected List fdPathForms = new AutoArrayList(KmCarmngPathForm.class);

	public List getFdPathForms() {
		return fdPathForms;
	}

	public void setFdPathForms(List fdPathForms) {
		this.fdPathForms = fdPathForms;
	}

	/**
	 * @return 返回 开始时间
	 */
	public String getFdStartTime() {
		return fdStartTime;
	}

	/**
	 * @param fdStartTime
	 *            要设置的 开始时间
	 */
	public void setFdStartTime(String fdStartTime) {
		this.fdStartTime = fdStartTime;
	}

	/**
	 * @return 返回 结束时间
	 */
	public String getFdEndTime() {
		return fdEndTime;
	}

	/**
	 * @param fdEndTime
	 *            要设置的 结束时间
	 */
	public void setFdEndTime(String fdEndTime) {
		this.fdEndTime = fdEndTime;
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
	 * @return 返回 状态
	 */
	@Override
    public String getDocStatus() {
		return docStatus;
	}

	/**
	 * @param docStatus
	 *            要设置的 状态
	 */
	@Override
    public void setDocStatus(String docStatus) {
		this.docStatus = docStatus;
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

	@Override
    public void reset(ActionMapping mapping, HttpServletRequest request) {
		fdMotorcadeId = null;
		fdApplicationPersonId = null;
		fdApplicationPersonName = null;
		fdUserPersonIds = null;
		fdUserPersonNames = null;
		fdOtherUsers = null;
		fdApplicationDeptId = null;
		fdApplicationDeptName = null;
		fdApplicationTime = null;
		fdApplicationPersonPhone = null;
		fdUserNumber = null;
		fdApplicationReason = null;
		fdStartTime = null;
		fdEndTime = null;
		fdApplicationPath = null;
		fdDeparture = null;
		fdDepartureCoordinate = null;
		fdDepartureDetail = null;
		fdDestination = null;
		fdDestinationCoordinate = null;
		fdDestinationDetail = null;
		fdRemark = null;
		docStatus = null;
		docCreatorId = null;
		docCreatorName = null;
		docCreateTime = null;
		fdUserPersonIds = null;
		fdUserPersonNames = null;
		fdIsDispatcher = "1";
		sysWfBusinessForm = new SysWfBusinessForm();
		super.reset(mapping, request);
	}

	@Override
    public Class getModelClass() {
		return KmCarmngApplication.class;
	}

	private static FormToModelPropertyMap toModelPropertyMap = null;

	@Override
    public FormToModelPropertyMap getToModelPropertyMap() {
		if (toModelPropertyMap == null) {
			toModelPropertyMap = new FormToModelPropertyMap();
			toModelPropertyMap.putAll(super.getToModelPropertyMap());
			toModelPropertyMap.put("docCreatorId", new FormConvertor_IDToModel(
					"docCreator", SysOrgPerson.class));
			toModelPropertyMap.put("fdMotorcadeId",
					new FormConvertor_IDToModel("fdMotorcade",
							KmCarmngMotorcadeSet.class));
			toModelPropertyMap.put("fdApplicationPersonId",
					new FormConvertor_IDToModel("fdApplicationPerson",
							SysOrgPerson.class));
			toModelPropertyMap.put("fdApplicationDeptId",
					new FormConvertor_IDToModel("fdApplicationDept",
							SysOrgElement.class));
			toModelPropertyMap.put("fdUserPersonIds",
					new FormConvertor_IDsToModelList("fdUserPersons",
							SysOrgElement.class));
			toModelPropertyMap.put("fdPathForms", new FormConvertor_FormListToModelList("fdPaths",
					"fdAppLication"));
		}
		return toModelPropertyMap;
	}

	private SysWfBusinessForm sysWfBusinessForm = new SysWfBusinessForm();

	@Override
    public SysWfBusinessForm getSysWfBusinessForm() {
		return sysWfBusinessForm;
	}

	/**
	 * 附件实现
	 */
	AutoHashMap autoHashMap = new AutoHashMap(AttachmentDetailsForm.class);

	@Override
    public AutoHashMap getAttachmentForms() {
		return autoHashMap;
	}

	public String getFdMotorcadeRemark() {
		return this.fdMotorcadeRemark;
	}

	public void setFdMotorcadeRemark(String fdMotorcadeRemark) {
		this.fdMotorcadeRemark = fdMotorcadeRemark;
	}

	/**
	 * 通知用车人
	 */
	private String fdNotifyPerson;

	public String getFdNotifyPerson() {
		return fdNotifyPerson;
	}

	public void setFdNotifyPerson(String fdNotifyPerson) {
		this.fdNotifyPerson = fdNotifyPerson;
	}

}
