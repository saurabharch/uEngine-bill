package org.uengine.garuda.model;

import java.sql.Date;

/**
 * Created by uengine on 2017. 1. 25..
 */
public class Plan {

    private String id;
    private String product_id;
    private Long version;
    private String name;
    private String is_onetime;
    private String is_active;
    private String phases;
    private String organization_id;
    private String tenant_id;
    private Date reg_dt;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getProduct_id() {
        return product_id;
    }

    public void setProduct_id(String product_id) {
        this.product_id = product_id;
    }

    public Long getVersion() {
        return version;
    }

    public void setVersion(Long version) {
        this.version = version;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getIs_onetime() {
        return is_onetime;
    }

    public void setIs_onetime(String is_onetime) {
        this.is_onetime = is_onetime;
    }

    public String getIs_active() {
        return is_active;
    }

    public void setIs_active(String is_active) {
        this.is_active = is_active;
    }

    public String getPhases() {
        return phases;
    }

    public void setPhases(String phases) {
        this.phases = phases;
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

    public Date getReg_dt() {
        return reg_dt;
    }

    public void setReg_dt(Date reg_dt) {
        this.reg_dt = reg_dt;
    }
}
