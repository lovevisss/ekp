package com.landray.kmss.km.carmng.forms;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.web.action.ActionMapping;

import com.landray.kmss.common.convertor.FormConvertor_IDToModel;
import com.landray.kmss.common.convertor.FormToModelPropertyMap;
import com.landray.kmss.common.forms.ExtendForm;
import com.landray.kmss.km.carmng.model.KmCarmngApplication;
import com.landray.kmss.km.carmng.model.KmCarmngEvaluation;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.UserUtil;

public class KmCarmngEvaluationForm extends ExtendForm {
	/*
	 * 所属申请单
	 */
	protected String fdApplicationId;
	protected String fdApplicationName;

	/*
	 * 评价人
	 */
	protected String fdEvaluatorId = null;
	protected String fdEvaluatorName = null;
	/*
	 * 评价时间
	 */
	protected String fdEvaluationTime = null;
	/*
	 * 分数
	 */
	protected String fdEvaluationScore;
	/*
	 * 评价内容
	 */
	protected java.lang.String fdEvaluationContent;

	public String getFdApplicationId() {
		return fdApplicationId;
	}

	public void setFdApplicationId(String fdApplicationId) {
		this.fdApplicationId = fdApplicationId;
	}

	public String getFdApplicationName() {
		return fdApplicationName;
	}

	public void setFdApplicationName(String fdApplicationName) {
		this.fdApplicationName = fdApplicationName;
	}

	public String getFdEvaluatorId() {
		return fdEvaluatorId;
	}

	public void setFdEvaluatorId(String fdEvaluatorId) {
		this.fdEvaluatorId = fdEvaluatorId;
	}

	public String getFdEvaluatorName() {
		return fdEvaluatorName;
	}

	public void setFdEvaluatorName(String fdEvaluatorName) {
		this.fdEvaluatorName = fdEvaluatorName;
	}

	public String getFdEvaluationTime() {
		return fdEvaluationTime;
	}

	public void setFdEvaluationTime(String fdEvaluationTime) {
		this.fdEvaluationTime = fdEvaluationTime;
	}

	public String getFdEvaluationScore() {
		return fdEvaluationScore;
	}

	public void setFdEvaluationScore(String fdEvaluationScore) {
		this.fdEvaluationScore = fdEvaluationScore;
	}

	public java.lang.String getFdEvaluationContent() {
		return fdEvaluationContent;
	}

	public void setFdEvaluationContent(java.lang.String fdEvaluationContent) {
		this.fdEvaluationContent = fdEvaluationContent;
	}

	@Override
    public Class getModelClass() {
		return KmCarmngEvaluation.class;
	}

	@Override
    public void reset(ActionMapping mapping, HttpServletRequest request) {
		fdEvaluationTime = null;
		fdEvaluationScore = null;
		fdEvaluationContent = null;
		fdEvaluatorName = null;
		setFdEvaluatorName(UserUtil.getUser().getFdName());
		setFdEvaluationTime(DateUtil.convertDateToString(new Date(), DateUtil.TYPE_DATETIME, request.getLocale()));
		super.reset(mapping, request);
	}

	private static FormToModelPropertyMap toModelPropertyMap = null;

	@Override
    public FormToModelPropertyMap getToModelPropertyMap() {
		if (toModelPropertyMap == null) {
			toModelPropertyMap = new FormToModelPropertyMap();
			toModelPropertyMap.put("fdApplicationId",
					new FormConvertor_IDToModel("fdApplication", KmCarmngApplication.class));
		}
		return toModelPropertyMap;
	}

}
