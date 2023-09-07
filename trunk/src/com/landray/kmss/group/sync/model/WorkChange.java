package com.landray.kmss.group.sync.model;

public class WorkChange {

    private String name;
    private String workCode;
    private Integer typeCode;

    public WorkChange() {
    }

    public WorkChange(String name, String workCode, Integer typeCode) {
        this.name = name;
        this.workCode = workCode;
        this.typeCode = typeCode;
    }

    public String getName() {
        return name;
    }

    public String getWorkCode() {
        return workCode;
    }

    public Integer getTypeCode() {
        return typeCode;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setWorkCode(String workCode) {
        this.workCode = workCode;
    }

    public void setTypeCode(Integer typeCode) {
        this.typeCode = typeCode;
    }


}
