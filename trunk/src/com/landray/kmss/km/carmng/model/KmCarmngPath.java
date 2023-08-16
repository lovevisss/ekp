package com.landray.kmss.km.carmng.model;

import com.landray.kmss.common.convertor.ModelToFormPropertyMap;
import com.landray.kmss.common.model.BaseModel;
import com.landray.kmss.km.carmng.forms.KmCarmngPathForm;

public class KmCarmngPath extends BaseModel {

	protected KmCarmngApplication fdAppLication;

	/*
	 * 目的地
	 */
	protected String fdDestination;

	/*
	 * 目的地经纬度
	 */
	protected String fdDestinationCoordinate;
	/*
	 * 目的地详情
	 */
	protected String fdDestinationDetail;

	public KmCarmngApplication getFdAppLication() {
		return fdAppLication;
	}

	public void setFdAppLication(KmCarmngApplication fdAppLication) {
		this.fdAppLication = fdAppLication;
	}

	public String getFdDestination() {
		return fdDestination;
	}

	public void setFdDestination(String fdDestination) {
		this.fdDestination = fdDestination;
	}

	public String getFdDestinationCoordinate() {
		return fdDestinationCoordinate;
	}

	public void setFdDestinationCoordinate(String fdDestinationCoordinate) {
		this.fdDestinationCoordinate = fdDestinationCoordinate;
	}

	public String getFdDestinationDetail() {
		return fdDestinationDetail;
	}

	public void setFdDestinationDetail(String fdDestinationDetail) {
		this.fdDestinationDetail = fdDestinationDetail;
	}

	@Override
	public Class getFormClass() {
		return KmCarmngPathForm.class;
	}

	private static ModelToFormPropertyMap toFormPropertyMap;

	@Override
    public ModelToFormPropertyMap getToFormPropertyMap() {
		if (toFormPropertyMap == null) {
			toFormPropertyMap = new ModelToFormPropertyMap();
			toFormPropertyMap.putAll(super.getToFormPropertyMap());
			toFormPropertyMap.put("fdAppLication.fdId", "fdAppLicationId");
			toFormPropertyMap.put("fdAppLication.docSubject", "fdAppLicationName");
		}
		return toFormPropertyMap;
	}
}
