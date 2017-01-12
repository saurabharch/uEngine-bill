package org.uengine.garuda.killbill.api.model;

/**
 * Created by uengine on 2017. 1. 12..
 */
public class Tenant {
    private String tenantId;
    private String externalKey;
    private String apiKey;
    private String apiSecret;
    private Object auditLogs;

    public String getTenantId() {
        return tenantId;
    }

    public void setTenantId(String tenantId) {
        this.tenantId = tenantId;
    }

    public String getExternalKey() {
        return externalKey;
    }

    public void setExternalKey(String externalKey) {
        this.externalKey = externalKey;
    }

    public String getApiKey() {
        return apiKey;
    }

    public void setApiKey(String apiKey) {
        this.apiKey = apiKey;
    }

    public String getApiSecret() {
        return apiSecret;
    }

    public void setApiSecret(String apiSecret) {
        this.apiSecret = apiSecret;
    }

    public Object getAuditLogs() {
        return auditLogs;
    }

    public void setAuditLogs(Object auditLogs) {
        this.auditLogs = auditLogs;
    }
}
