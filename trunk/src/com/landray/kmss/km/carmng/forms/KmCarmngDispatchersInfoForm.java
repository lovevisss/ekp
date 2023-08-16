package com.landray.kmss.km.carmng.forms;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.common.convertor.FormConvertor_FormListToModelList;
import com.landray.kmss.common.convertor.FormConvertor_IDToModel;
import com.landray.kmss.common.convertor.FormToModelPropertyMap;
import com.landray.kmss.common.forms.ExtendForm;
import com.landray.kmss.km.carmng.model.KmCarmngDispatchersInfo;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.util.AutoArrayList;
import com.landray.kmss.web.action.ActionMapping;

/**
 * 创建日期 2010-三月-24
 * 
 * @author 叶中奇
 */
public class KmCarmngDispatchersInfoForm extends ExtendForm {
	/*
	 * 申请单
	 */
	private String fdApplicationIds = null;

	private String fdApplicationNames = null;

	/*
	 * 路线安排
	 */
	protected List fdPathForms = new ArrayList();


	public List getFdPathForms() {
		return fdPathForms;
	}

	public void setFdPathForms(List fdPathForms) {
		this.fdPathForms = fdPathForms;
	}

	/*
	 * 开始时间
	 */
	private String fdStartTime = null;
	/*
	 * 结束时间
	 */
	private String fdEndTime = null;
	/*
	 * 回车登记员
	 */
	private String fdRegisterId = null;

	private String fdRegisterName = null;
	/*
	 * 调度者
	 */
	private String docCreatorId = null;

	private String docCreatorName = null;
	/*
	 * 调度时间
	 */
	private String docCreateTime = null;

	private String fdFlag = null;


	protected List fdDispatchersInfoListForm = new AutoArrayList(KmCarmngDispatchersInfoListForm.class);

	public List getFdDispatchersInfoListForm() {
		return fdDispatchersInfoListForm;
	}

	public void setFdDispatchersInfoListForm(List fdDispatchersInfoListForm) {
		this.fdDispatchersInfoListForm = fdDispatchersInfoListForm;
	}


	public String getFdFlag() {
		return this.fdFlag;
	}

	public void setFdFlag(String fdFlag) {
		this.fdFlag = fdFlag;
	}


	public String getFdApplicationNames() {
		return this.fdApplicationNames;
	}

	public void setFdApplicationNames(String fdApplicationNames) {
		this.fdApplicationNames = fdApplicationNames;
	}

	public String getFdRegisterName() {
		return this.fdRegisterName;
	}

	public void setFdRegisterName(String fdRegisterName) {
		this.fdRegisterName = fdRegisterName;
	}

	public String getDocCreatorId() {
		return this.docCreatorId;
	}

	public void setDocCreatorId(String docCreatorId) {
		this.docCreatorId = docCreatorId;
	}

	public String getDocCreatorName() {
		return this.docCreatorName;
	}

	public void setDocCreatorName(String docCreatorName) {
		this.docCreatorName = docCreatorName;
	}


	/**
	 * @return 返回 申请单
	 */
	public String getFdApplicationIds() {
		return fdApplicationIds;
	}

	/**
	 * @param fdApplicationIds
	 *            要设置的 申请单
	 */
	public void setFdApplicationIds(String fdApplicationIds) {
		this.fdApplicationIds = fdApplicationIds;
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
	 * @return 返回 回车登记员
	 */
	public String getFdRegisterId() {
		return fdRegisterId;
	}

	/**
	 * @param fdRegisterId
	 *            要设置的 回车登记员
	 */
	public void setFdRegisterId(String fdRegisterId) {
		this.fdRegisterId = fdRegisterId;
	}

	/**
	 * @return 返回 调度时间
	 */
	public String getDocCreateTime() {
		return docCreateTime;
	}

	/**
	 * @param docCreateTime
	 *            要设置的 调度时间
	 */
	public void setDocCreateTime(String docCreateTime) {
		this.docCreateTime = docCreateTime;
	}

	/*
	 * （非 Javadoc）
	 * 
	 * @seecom.landray.kmss.web.action.ActionForm#reset(org.apache.struts.action.
	 * ActionMapping, javax.servlet.http.HttpServletRequest)
	 */
	@Override
    public void reset(ActionMapping mapping, HttpServletRequest request) {
		fdApplicationIds = null;
		fdStartTime = null;
		fdEndTime = null;
		fdRegisterId = null;
		fdRegisterName = null;
		docCreatorId = null;
		docCreatorName = null;
		docCreateTime = null;
		this.fdFlag = "0";
		super.reset(mapping, request);
	}

	@Override
    public Class getModelClass() {
		return KmCarmngDispatchersInfo.class;
	}


	private static FormToModelPropertyMap toModelPropertyMap = null;

	@Override
    public FormToModelPropertyMap getToModelPropertyMap() {
		if (toModelPropertyMap == null) {
			toModelPropertyMap = new FormToModelPropertyMap();
			toModelPropertyMap.put("docCreatorId", new FormConvertor_IDToModel("docCreator", SysOrgElement.class));
			toModelPropertyMap.put("fdRegisterId", new FormConvertor_IDToModel(
					"fdRegister", SysOrgElement.class));
			toModelPropertyMap.put("fdDispatchersInfoListForm",
					new FormConvertor_FormListToModelList("fdDispatchersInfoList", "fdDispatchersInfo"));
		}
		return toModelPropertyMap;
	}
	/*
	 * 通知机制
	 */
	private String fdNotifyType = null;

	public String getFdNotifyType() {
		return fdNotifyType;
	}

	public void setFdNotifyType(String fdNotifyType) {
		this.fdNotifyType = fdNotifyType;
	}

	/**
	 * 调度类型
	 */
	private String fdDispatchersType;

	/**
	 * 不派车原因
	 */
	private String fdRemark;

	public String getFdDispatchersType() {
		return fdDispatchersType;
	}

	public void setFdDispatchersType(String fdDispatchersType) {
		this.fdDispatchersType = fdDispatchersType;
	}

	public String getFdRemark() {
		return fdRemark;
	}

	public void setFdRemark(String fdRemark) {
		this.fdRemark = fdRemark;
	}

	/**
	 * 通知人
	 */
	private String fdNotifyPerson;

	public String getFdNotifyPerson() {
		return fdNotifyPerson;
	}

	public void setFdNotifyPerson(String fdNotifyPerson) {
		this.fdNotifyPerson = fdNotifyPerson;
	}

}
