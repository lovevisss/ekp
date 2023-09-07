package com.landray.kmss.group.sync.model;

import java.util.Date;

public class Contract {
    private Date agreementBeginDate;
    private Date agreementEndDate;
    private String agreementType;

    private boolean isLongTerm;

    public Contract() {
        }

    public Contract(Date agreementBeginDate, Date agreementEndDate, String agreementType, Boolean isLongTerm) {
        this.agreementBeginDate = agreementBeginDate;
        this.agreementEndDate = agreementEndDate;
        this.agreementType = agreementType;
        this.isLongTerm = isLongTerm;

    }

    public Date getAgreementBeginDate() {
        return agreementBeginDate;
    }

    public Date getAgreementEndDate() {
        return agreementEndDate;
    }

    public String getAgreementType() {
        return agreementType;
    }

    public boolean getIsLongTerm() {
        return isLongTerm;
    }

    public void setAgreementBeginDate(Date agreementBeginDate) {
        this.agreementBeginDate = agreementBeginDate;
    }

    public void setAgreementEndDate(Date agreementEndDate) {
        this.agreementEndDate = agreementEndDate;
    }

    public void setAgreementType(String agreementType) {
        this.agreementType = agreementType;
    }

    public void setIsLongTerm(boolean isLongTerm) {
        this.isLongTerm = isLongTerm;
    }


}
