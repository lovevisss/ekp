package com.landray.kmss.km.carmng.forms;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.web.action.ActionMapping;

import com.landray.kmss.common.convertor.FormConvertor_IDToModel;
import com.landray.kmss.common.convertor.FormToModelPropertyMap;
import com.landray.kmss.common.forms.ExtendForm;
import com.landray.kmss.km.carmng.model.KmCarmngApplication;
import com.landray.kmss.km.carmng.model.KmCarmngPath;

public class KmCarmngPathForm extends ExtendForm {

	protected String fdAppLicationId;

	public String getFdAppLicationId() {
		return fdAppLicationId;
	}

	public void setFdAppLicationId(String fdAppLicationId) {
		this.fdAppLicationId = fdAppLicationId;
	}

	public String getFdAppLicationName() {
		return fdAppLicationName;
	}

	public void setFdAppLicationName(String fdAppLicationName) {
		this.fdAppLicationName = fdAppLicationName;
	}

	protected String fdAppLicationName;
	/*
	 * 目的地
	 */
	protected String fdDestination;

	protected String fdDestinationDetail;

	public String getFdDestination() {
		return fdDestination;
	}

	public void setFdDestination(String fdDestination) {
		this.fdDestination = fdDestination;
	}

	public String getFdDestinationDetail() {
		return fdDestinationDetail;
	}

	public void setFdDestinationDetail(String fdDestinationDetail) {
		this.fdDestinationDetail = fdDestinationDetail;
	}

	/*
	 * 目的地经纬度
	 */
	protected String fdDestinationCoordinate;

	public String getFdDestinationCoordinate() {
		return fdDestinationCoordinate;
	}

	public void setFdDestinationCoordinate(String fdDestinationCoordinate) {
		this.fdDestinationCoordinate = fdDestinationCoordinate;
	}

	@Override
    public void reset(ActionMapping mapping, HttpServletRequest request) {
		fdDestination = null;
		fdDestinationCoordinate = null;
		fdDestinationDetail = null;
		super.reset(mapping, request);
	}

	@Override
	public Class getModelClass() {
		return KmCarmngPath.class;
	}

	private static FormToModelPropertyMap toModelPropertyMap;

	@Override
    public FormToModelPropertyMap getToModelPropertyMap() {
		if (toModelPropertyMap == null) {
			toModelPropertyMap = new FormToModelPropertyMap();
			toModelPropertyMap.putAll(super.getToModelPropertyMap());
			toModelPropertyMap.put("fdAppLicationId",
					new FormConvertor_IDToModel("fdAppLication", KmCarmngApplication.class));
		}
		return toModelPropertyMap;
	}
}
