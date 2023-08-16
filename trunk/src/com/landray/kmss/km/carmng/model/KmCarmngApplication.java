package com.landray.kmss.km.carmng.model;

import java.util.Date;
import java.util.List;

import com.landray.kmss.common.convertor.ModelConvertor_ModelListToFormList;
import com.landray.kmss.common.convertor.ModelConvertor_ModelListToString;
import com.landray.kmss.common.convertor.ModelConvertor_ModelToForm;
import com.landray.kmss.common.convertor.ModelToFormPropertyMap;
import com.landray.kmss.constant.SysDocConstant;
import com.landray.kmss.km.carmng.forms.KmCarmngApplicationForm;
import com.landray.kmss.sys.attachment.forms.AttachmentDetailsForm;
import com.landray.kmss.sys.attachment.model.IAttachment;
import com.landray.kmss.sys.ftsearch.interfaces.INeedIndex;
import com.landray.kmss.sys.notify.interfaces.ISysNotifyModel;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.sys.recycle.model.ISysRecycleModel;
import com.landray.kmss.sys.recycle.model.SysRecycleConstant;
import com.landray.kmss.sys.right.interfaces.BaseAuthModel;
import com.landray.kmss.sys.workflow.interfaces.ISysWfMainModel;
import com.landray.kmss.sys.workflow.interfaces.SysWfBusinessModel;
import com.landray.kmss.util.AutoHashMap;
import com.landray.kmss.util.StringUtil;

/**
 * 创建日期 2010-三月-24
 * 
 * @author 黄郴 用车申请
 */
public class KmCarmngApplication extends BaseAuthModel implements IAttachment,
		ISysWfMainModel, ISysNotifyModel, INeedIndex, ISysRecycleModel {

	protected String docSubject;

	/*
	 * 车队名称
	 */
	protected KmCarmngMotorcadeSet fdMotorcade;
	protected String fdNo;

	/*
	 * 申请人
	 */
	protected SysOrgPerson fdApplicationPerson;

	/*
	 * 申请部门
	 */

	//display="none"
	protected SysOrgElement fdApplicationDept;

	public SysOrgElement getFdApplicationDept() {
		return fdApplicationDept;
	}

	public void setFdApplicationDept(SysOrgElement fdApplicationDept) {
		this.fdApplicationDept = fdApplicationDept;
	}

	/*
	 * 用车人
	 */
	protected List fdUserPersons;
	
	/*
	 * 外部用车人
	 */
	protected String fdOtherUsers;

	/*
	 * 申请时间
	 */
	protected Date fdApplicationTime;

	/*
	 * 申请人电话
	 */
	protected String fdApplicationPersonPhone;

	/*
	 * 随车人数
	 */
	protected String fdUserNumber;

	/*
	 * 用车事由
	 */
	protected String fdApplicationReason;
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

	public String getFdNo() {
		return fdNo;
	}

	public void setFdNo(String fdNo) {
		this.fdNo = fdNo;
	}

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
	 * 目的地
	 */
	protected List<KmCarmngPath> fdPaths;


	/*
	 * 开始时间
	 */
	protected Date fdStartTime;

	/*
	 * 结束时间
	 */
	protected Date fdEndTime;

	/*
	 * 行驶路线
	 */
	protected String fdApplicationPath;

	public String getFdApplicationPath() {
		if (StringUtil.isNotNull(fdApplicationPath)) {
			return fdApplicationPath.replace(";", "-");
		}
		return fdApplicationPath;
	}

	public void setFdApplicationPath(String fdApplicationPath) {
		this.fdApplicationPath = fdApplicationPath;
	}

	/*
	 * 备注
	 */
	protected String fdRemark;

	protected Integer fdIsDispatcher;

	protected KmCarmngDispatchersInfo kmCarmngDispatchersInfo;
	protected KmCarmngEvaluation kmCarmngEvaluation;

	public KmCarmngEvaluation getKmCarmngEvaluation() {
		return kmCarmngEvaluation;
	}

	public void setKmCarmngEvaluation(KmCarmngEvaluation kmCarmngEvaluation) {
		this.kmCarmngEvaluation = kmCarmngEvaluation;
	}

	public Integer getFdIsDispatcher() {
		return this.fdIsDispatcher;
	}

	public void setFdIsDispatcher(Integer fdIsDispatcher) {
		this.fdIsDispatcher = fdIsDispatcher;
	}

	public KmCarmngApplication() {
		super();
	}

	public KmCarmngMotorcadeSet getFdMotorcade() {
		return this.fdMotorcade;
	}

	public void setFdMotorcade(KmCarmngMotorcadeSet fdMotorcade) {
		this.fdMotorcade = fdMotorcade;
	}

	public SysOrgPerson getFdApplicationPerson() {
		return fdApplicationPerson;
	}

	public void setFdApplicationPerson(SysOrgPerson fdApplicationPerson) {
		this.fdApplicationPerson = fdApplicationPerson;
	}

	public List getFdUserPersons() {
		return this.fdUserPersons;
	}

	public void setFdUserPersons(List fdUserPersons) {
		this.fdUserPersons = fdUserPersons;
	}

	/**
	 * @return 返回 申请时间
	 */
	public Date getFdApplicationTime() {
		return fdApplicationTime;
	}

	/**
	 * @param fdApplicationTime
	 *            要设置的 申请时间
	 */
	public void setFdApplicationTime(Date fdApplicationTime) {
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


	public List<KmCarmngPath> getFdPaths() {
		return fdPaths;
	}

	public void setFdPaths(List<KmCarmngPath> fdPaths) {
		this.fdPaths = fdPaths;
	}

	/**
	 * @return 返回 开始时间
	 */
	public Date getFdStartTime() {
		return fdStartTime;
	}

	/**
	 * @param fdStartTime
	 *            要设置的 开始时间
	 */
	public void setFdStartTime(Date fdStartTime) {
		this.fdStartTime = fdStartTime;
	}

	/**
	 * @return 返回 结束时间
	 */
	public Date getFdEndTime() {
		return fdEndTime;
	}

	/**
	 * @param fdEndTime
	 *            要设置的 结束时间
	 */
	public void setFdEndTime(Date fdEndTime) {
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

	@Override
    public Class getFormClass() {
		return KmCarmngApplicationForm.class;
	}

	private SysWfBusinessModel sysWfBusinessModel = new SysWfBusinessModel();

	@Override
    public SysWfBusinessModel getSysWfBusinessModel() {
		return sysWfBusinessModel;
	}

	@Override
    public String getDocSubject() {
		return this.docSubject;
	}

	public void setDocSubject(String docSubject) {
		this.docSubject = docSubject;
	}
	
	public String getFdOtherUsers() {
		return this.fdOtherUsers;
	}

	public void setFdOtherUsers(String fdOtherUsers) {
		this.fdOtherUsers = fdOtherUsers;
	}
	
	/**
	 * @return 返回 所有人可阅读标记
	 */
	@Override
    public java.lang.Boolean getAuthReaderFlag() {
		if (authReaderFlag == null) {
			return new Boolean(false);
		}
		return authReaderFlag;
	}
	
	/**
	 * @param authReaderFlag
	 *            要设置的 所有人可阅读标记
	 */
	@Override
    public void setAuthReaderFlag(java.lang.Boolean authReaderFlag) {
		this.authReaderFlag = authReaderFlag;
	}
	
	/*
	 * 附件机制
	 */
	private AutoHashMap autoHashMap = new AutoHashMap(AttachmentDetailsForm.class);

	@Override
    public AutoHashMap getAttachmentForms() {
		return autoHashMap;
	}
	
	@Override
	protected void recalculateReaderField() {
		super.recalculateReaderField();
		if (getDocStatus().equals(SysDocConstant.DOC_STATUS_PUBLISH)) {
			authAllReaders.addAll(getFdUserPersons());
		}
		//添加申请人（联系人）阅读权限
		if(getFdApplicationPerson() != null && !authAllReaders.contains(getFdApplicationPerson())){
			authAllReaders.add(getFdApplicationPerson());
		}
	}
	
	private static ModelToFormPropertyMap toFormPropertyMap = null;

	@Override
    public ModelToFormPropertyMap getToFormPropertyMap() {
		if (toFormPropertyMap == null) {
			toFormPropertyMap = new ModelToFormPropertyMap();
			toFormPropertyMap.putAll(super.getToFormPropertyMap());
			toFormPropertyMap.put("docCreator.fdId", "docCreatorId");
			toFormPropertyMap.put("docCreator.fdName", "docCreatorName");
			toFormPropertyMap.put("fdMotorcade.fdId", "fdMotorcadeId");
			toFormPropertyMap.put("fdMotorcade.fdName", "fdMotorcadeName");
			toFormPropertyMap.put("fdMotorcade.fdRemark", "fdMotorcadeRemark");
			toFormPropertyMap.put("fdApplicationPerson.fdId",
					"fdApplicationPersonId");
			toFormPropertyMap.put("fdApplicationPerson.fdName",
					"fdApplicationPersonName");
			toFormPropertyMap.put("fdApplicationDept.fdId",
					"fdApplicationDeptId");
			toFormPropertyMap.put("fdApplicationDept.deptLevelNames",
					"fdApplicationDeptName");
			toFormPropertyMap
					.put("fdUserPersons", new ModelConvertor_ModelListToString(
							"fdUserPersonIds:fdUserPersonNames", "fdId:fdName"));
			toFormPropertyMap.put("kmCarmngDispatchersInfo",
					new ModelConvertor_ModelToForm(
							"kmCarmngDispatchersInfoForm"));
			toFormPropertyMap.put("kmCarmngEvaluation", new ModelConvertor_ModelToForm("kmCarmngEvaluationForm"));

			toFormPropertyMap.put("fdPaths", new ModelConvertor_ModelListToFormList("fdPathForms"));
		}
		return toFormPropertyMap;
	}

	public KmCarmngDispatchersInfo getKmCarmngDispatchersInfo() {
		return this.kmCarmngDispatchersInfo;
	}

	public void setKmCarmngDispatchersInfo(
			KmCarmngDispatchersInfo kmCarmngDispatchersInfo) {
		this.kmCarmngDispatchersInfo = kmCarmngDispatchersInfo;
	}

	private java.lang.String fdNotifyType;

	public java.lang.String getFdNotifyType() {
		return fdNotifyType;
	}

	public void setFdNotifyType(java.lang.String fdNotifyType) {
		this.fdNotifyType = fdNotifyType;
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
}
