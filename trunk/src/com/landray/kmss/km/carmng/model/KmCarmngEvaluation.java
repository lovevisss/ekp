package com.landray.kmss.km.carmng.model;

import java.util.Date;

import com.landray.kmss.common.convertor.ModelToFormPropertyMap;
import com.landray.kmss.common.model.BaseModel;
import com.landray.kmss.km.carmng.forms.KmCarmngEvaluationForm;
import com.landray.kmss.sys.organization.model.SysOrgElement;

public class KmCarmngEvaluation extends BaseModel {

	/*
	 * 所属申请单
	 */
	protected KmCarmngApplication fdApplication;

	/*
	 * 评价人
	 */
	protected SysOrgElement fdEvaluator = null;
	/*
	 * 评价时间
	 */
	protected java.util.Date fdEvaluationTime = new Date();
	/*
	 * 分数
	 */
	protected java.lang.Long fdEvaluationScore;
	/*
	 * 评价内容
	 */
	protected java.lang.String fdEvaluationContent;

	public KmCarmngApplication getFdApplication() {
		return fdApplication;
	}

	public void setFdApplication(KmCarmngApplication fdApplication) {
		this.fdApplication = fdApplication;
	}

	public SysOrgElement getFdEvaluator() {
		return fdEvaluator;
	}

	public void setFdEvaluator(SysOrgElement fdEvaluator) {
		this.fdEvaluator = fdEvaluator;
	}

	public java.util.Date getFdEvaluationTime() {
		return fdEvaluationTime;
	}

	public void setFdEvaluationTime(java.util.Date fdEvaluationTime) {
		this.fdEvaluationTime = fdEvaluationTime;
	}

	public java.lang.Long getFdEvaluationScore() {
		return fdEvaluationScore;
	}

	public void setFdEvaluationScore(java.lang.Long fdEvaluationScore) {
		this.fdEvaluationScore = fdEvaluationScore;
	}

	public java.lang.String getFdEvaluationContent() {
		return fdEvaluationContent;
	}

	public void setFdEvaluationContent(java.lang.String fdEvaluationContent) {
		this.fdEvaluationContent = fdEvaluationContent;
	}

	public KmCarmngEvaluation() {
		super();
	}

	@Override
    public Class getFormClass() {
		return KmCarmngEvaluationForm.class;
	}

	private static ModelToFormPropertyMap toFormPropertyMap;

	@Override
    public ModelToFormPropertyMap getToFormPropertyMap() {
		if (toFormPropertyMap == null) {
			toFormPropertyMap = new ModelToFormPropertyMap();
			toFormPropertyMap.putAll(super.getToFormPropertyMap());
			toFormPropertyMap.put("fdEvaluator.fdName", "fdEvaluatorName");
			toFormPropertyMap.put("fdApplication.docSubject", "fdApplicationName");
		}
		return toFormPropertyMap;
	}
}

