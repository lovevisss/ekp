package com.landray.kmss.km.carmng.model;

import java.util.Date;

import com.landray.kmss.common.convertor.ModelConvertor_Common;
import com.landray.kmss.common.convertor.ModelToFormPropertyMap;
import com.landray.kmss.common.model.BaseModel;
import com.landray.kmss.km.carmng.forms.KmCarmngDispatchersLogForm;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.util.DateUtil;

/**
  * 调度日志
  */
public class KmCarmngDispatchersLog extends BaseModel {

    private static ModelToFormPropertyMap toFormPropertyMap;

    private Boolean fdIsCar;

    private String fdCarIds;

    private String fdCarNames;

    private Date fdStartTime;

    private Date fdEndTime;

    private String fdRemark;

    private Date fdDispatchersTime;

    private String fdDispatchersId;

    private SysOrgPerson docCreator;

    @Override
    public Class<KmCarmngDispatchersLogForm> getFormClass() {
        return KmCarmngDispatchersLogForm.class;
    }

    @Override
    public ModelToFormPropertyMap getToFormPropertyMap() {
        if (toFormPropertyMap == null) {
            toFormPropertyMap = new ModelToFormPropertyMap();
            toFormPropertyMap.putAll(super.getToFormPropertyMap());
            toFormPropertyMap.put("fdStartTime", new ModelConvertor_Common("fdStartTime").setDateTimeType(DateUtil.TYPE_DATE));
            toFormPropertyMap.put("fdEndTime", new ModelConvertor_Common("fdEndTime").setDateTimeType(DateUtil.TYPE_DATE));
            toFormPropertyMap.put("fdDispatchersTime", new ModelConvertor_Common("fdDispatchersTime").setDateTimeType(DateUtil.TYPE_DATE));
            toFormPropertyMap.put("docCreator.fdName", "docCreatorName");
            toFormPropertyMap.put("docCreator.fdId", "docCreatorId");
        }
        return toFormPropertyMap;
    }

    @Override
    public void recalculateFields() {
        super.recalculateFields();
    }

    /**
     * 调度类型
     */
    public Boolean getFdIsCar() {
        return this.fdIsCar;
    }

    /**
     * 调度类型
     */
    public void setFdIsCar(Boolean fdIsCar) {
        this.fdIsCar = fdIsCar;
    }

    /**
     * 车辆id
     */
    public String getFdCarIds() {
        return this.fdCarIds;
    }

    /**
     * 车辆id
     */
    public void setFdCarIds(String fdCarIds) {
        this.fdCarIds = fdCarIds;
    }

    /**
     * 车牌号
     */
    public String getFdCarNames() {
        return this.fdCarNames;
    }

    /**
     * 车牌号
     */
    public void setFdCarNames(String fdCarNames) {
        this.fdCarNames = fdCarNames;
    }

    /**
     * 调度开始时间
     */
    public Date getFdStartTime() {
        return this.fdStartTime;
    }

    /**
     * 调度开始时间
     */
    public void setFdStartTime(Date fdStartTime) {
        this.fdStartTime = fdStartTime;
    }

    /**
     * 调度结束时间
     */
    public Date getFdEndTime() {
        return this.fdEndTime;
    }

    /**
     * 调度结束时间
     */
    public void setFdEndTime(Date fdEndTime) {
        this.fdEndTime = fdEndTime;
    }

    /**
     * 不派车原因
     */
    public String getFdRemark() {
        return this.fdRemark;
    }

    /**
     * 不派车原因
     */
    public void setFdRemark(String fdRemark) {
        this.fdRemark = fdRemark;
    }

    /**
     * 调度时间
     */
    public Date getFdDispatchersTime() {
        return this.fdDispatchersTime;
    }

    /**
     * 调度时间
     */
    public void setFdDispatchersTime(Date fdDispatchersTime) {
        this.fdDispatchersTime = fdDispatchersTime;
    }

    /**
     * 调度id
     */
    public String getFdDispatchersId() {
        return this.fdDispatchersId;
    }

    /**
     * 调度id
     */
    public void setFdDispatchersId(String fdDispatchersId) {
        this.fdDispatchersId = fdDispatchersId;
    }

    /**
     * 创建人
     */
    public SysOrgPerson getDocCreator() {
        return this.docCreator;
    }

    /**
     * 创建人
     */
    public void setDocCreator(SysOrgPerson docCreator) {
        this.docCreator = docCreator;
    }
}
