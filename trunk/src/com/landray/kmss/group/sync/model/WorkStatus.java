package com.landray.kmss.group.sync.model;

public class WorkStatus {
    private String name;
    private String workCode;

    private Integer TypeCode;


    public WorkStatus() {
    }

    public WorkStatus(String name, String workCode, Integer typeCode) {
        this.name = name;
        this.workCode = workCode;
        TypeCode = typeCode;
    }

    public String getName() {
        return name;
    }

    public String getWorkCode() {
        return workCode;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setWorkCode(String workCode) {
        this.workCode = workCode;
    }

    public Integer getTypeCode() {
        return TypeCode;
    }

    public void setTypeCode(Integer typeCode) {
        TypeCode = typeCode;
    }


}
