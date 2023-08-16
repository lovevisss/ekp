package com.landray.kmss.km.carmng.forms;

import com.landray.kmss.util.DateUtil;
import com.landray.kmss.common.convertor.FormToModelPropertyMap;
import javax.servlet.http.HttpServletRequest;
import com.landray.kmss.common.convertor.FormConvertor_Common;
import com.landray.kmss.web.action.ActionMapping;
import com.landray.kmss.common.forms.ExtendForm;
import com.landray.kmss.km.carmng.model.KmCarmngDispatchersLog;

/**
  * 调度日志
  */
public class KmCarmngDispatchersLogForm extends ExtendForm {

    private static FormToModelPropertyMap toModelPropertyMap;

    private String fdIsCar;

    private String fdCarIds;

    private String fdCarNames;

    private String fdStartTime;

    private String fdEndTime;

    private String fdRemark;

    private String fdDispatchersTime;

    private String fdDispatchersId;

    private String docCreatorId;

    private String docCreatorName;

    @Override
    public void reset(ActionMapping mapping, HttpServletRequest request) {
        fdIsCar = null;
        fdCarIds = null;
        fdCarNames = null;
        fdStartTime = null;
        fdEndTime = null;
        fdRemark = null;
        fdDispatchersTime = null;
        fdDispatchersId = null;
        docCreatorId = null;
        docCreatorName = null;
        super.reset(mapping, request);
    }

    @Override
    public Class<KmCarmngDispatchersLog> getModelClass() {
        return KmCarmngDispatchersLog.class;
    }

    @Override
    public FormToModelPropertyMap getToModelPropertyMap() {
        if (toModelPropertyMap == null) {
            toModelPropertyMap = new FormToModelPropertyMap();
            toModelPropertyMap.putAll(super.getToModelPropertyMap());
            toModelPropertyMap.put("fdStartTime", new FormConvertor_Common("fdStartTime").setDateTimeType(DateUtil.TYPE_DATE));
            toModelPropertyMap.put("fdEndTime", new FormConvertor_Common("fdEndTime").setDateTimeType(DateUtil.TYPE_DATE));
            toModelPropertyMap.put("fdDispatchersTime", new FormConvertor_Common("fdDispatchersTime").setDateTimeType(DateUtil.TYPE_DATE));
        }
        return toModelPropertyMap;
    }

    /**
     * 调度类型
     */
    public String getFdIsCar() {
        return this.fdIsCar;
    }

    /**
     * 调度类型
     */
    public void setFdIsCar(String fdIsCar) {
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
    public String getFdStartTime() {
        return this.fdStartTime;
    }

    /**
     * 调度开始时间
     */
    public void setFdStartTime(String fdStartTime) {
        this.fdStartTime = fdStartTime;
    }

    /**
     * 调度结束时间
     */
    public String getFdEndTime() {
        return this.fdEndTime;
    }

    /**
     * 调度结束时间
     */
    public void setFdEndTime(String fdEndTime) {
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
    public String getFdDispatchersTime() {
        return this.fdDispatchersTime;
    }

    /**
     * 调度时间
     */
    public void setFdDispatchersTime(String fdDispatchersTime) {
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
    public String getDocCreatorId() {
        return this.docCreatorId;
    }

    /**
     * 创建人
     */
    public void setDocCreatorId(String docCreatorId) {
        this.docCreatorId = docCreatorId;
    }

    /**
     * 创建人
     */
    public String getDocCreatorName() {
        return this.docCreatorName;
    }

    /**
     * 创建人
     */
    public void setDocCreatorName(String docCreatorName) {
        this.docCreatorName = docCreatorName;
    }
}
