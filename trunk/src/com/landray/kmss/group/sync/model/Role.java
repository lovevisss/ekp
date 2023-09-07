package com.landray.kmss.group.sync.model;

public class Role {
    private String id;
    private String name;

    public Role() {
        this.id="";
        this.name="";
    }

    public Role(String id , String name) {
        this.id = id;
        this.name = name;
    }

    public String getId() {
        return this.id;
    }

    public String getName() {
        return this.name;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }
}
