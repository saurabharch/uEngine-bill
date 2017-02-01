package org.uengine.garuda.model;

import java.math.BigDecimal;
import java.sql.Date;

/**
 * Created by uengine on 2017. 1. 25..
 */
public class ProductDistributionHistory {
    private String id;
    private String plan_id;
    private String product_id;
    private Long version;
    private String usage_id;
    private String account_id;
    private String organization_id;
    private String tenant_id;
    private Long account_record_id;
    private Long tenant_record_id;
    private BigDecimal distribution;
    private BigDecimal amount;
    private BigDecimal original_amount;
    private String currency;
    private String invoice_id;
    private String payment_id;
    private String transaction_type;
    private Date reg_dt;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPlan_id() {
        return plan_id;
    }

    public void setPlan_id(String plan_id) {
        this.plan_id = plan_id;
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

    public String getUsage_id() {
        return usage_id;
    }

    public void setUsage_id(String usage_id) {
        this.usage_id = usage_id;
    }

    public String getAccount_id() {
        return account_id;
    }

    public void setAccount_id(String account_id) {
        this.account_id = account_id;
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

    public Long getAccount_record_id() {
        return account_record_id;
    }

    public void setAccount_record_id(Long account_record_id) {
        this.account_record_id = account_record_id;
    }

    public Long getTenant_record_id() {
        return tenant_record_id;
    }

    public void setTenant_record_id(Long tenant_record_id) {
        this.tenant_record_id = tenant_record_id;
    }

    public BigDecimal getDistribution() {
        return distribution;
    }

    public void setDistribution(BigDecimal distribution) {
        this.distribution = distribution;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public BigDecimal getOriginal_amount() {
        return original_amount;
    }

    public void setOriginal_amount(BigDecimal original_amount) {
        this.original_amount = original_amount;
    }

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }

    public String getInvoice_id() {
        return invoice_id;
    }

    public void setInvoice_id(String invoice_id) {
        this.invoice_id = invoice_id;
    }

    public String getPayment_id() {
        return payment_id;
    }

    public void setPayment_id(String payment_id) {
        this.payment_id = payment_id;
    }

    public String getTransaction_type() {
        return transaction_type;
    }

    public void setTransaction_type(String transaction_type) {
        this.transaction_type = transaction_type;
    }

    public Date getReg_dt() {
        return reg_dt;
    }

    public void setReg_dt(Date reg_dt) {
        this.reg_dt = reg_dt;
    }
}
