package com.landray.kmss.group.sync.model;

import java.util.Date;

public class Creator extends Role{
    private Date createTime;

    public Creator() {
        super();
    }

    public Creator(String id, String name, Date createTime) {
        super(id, name);
        this.createTime = createTime;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}
