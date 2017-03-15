package org.uengine.garuda.model;

import java.sql.Date;

/**
 * Created by uengine on 2017. 1. 25..
 */
public class NotificationConfig {

    private Long record_id;
    private String id;
    private String organization_id;
    private String tenant_id;
    private Long tenant_record_id;
    private String configuration;
    private Date reg_dt;

    public Long getRecord_id() {
        return record_id;
    }

    public void setRecord_id(Long record_id) {
        this.record_id = record_id;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getOrganization_id() {
        return organization_id;
    }

    public void setOrganization_id(String organization_id) {
        this.organization_id = organization_id;
    }

    public String getTenant_id() {
        return tenant_id;
    }

    public void setTenant_id(String tenant_id) {
        this.tenant_id = tenant_id;
    }

    public Long getTenant_record_id() {
        return tenant_record_id;
    }

    public void setTenant_record_id(Long tenant_record_id) {
        this.tenant_record_id = tenant_record_id;
    }

    public String getConfiguration() {
        return configuration;
    }

    public void setConfiguration(String configuration) {
        this.configuration = configuration;
    }

    public Date getReg_dt() {
        return reg_dt;
    }

    public void setReg_dt(Date reg_dt) {
        this.reg_dt = reg_dt;
    }
}
