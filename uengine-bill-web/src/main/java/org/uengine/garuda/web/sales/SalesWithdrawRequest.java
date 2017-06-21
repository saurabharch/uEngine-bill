package org.uengine.garuda.web.sales;

import org.uengine.garuda.model.DistributionTransactionType;

import java.math.BigDecimal;

/**
 * Created by uengine on 2017. 6. 21..
 */
public class SalesWithdrawRequest {
    private DistributionTransactionType transactionType;
    private BigDecimal amount;
    private String currency;
    private String notes;

    public DistributionTransactionType getTransactionType() {
        return transactionType;
    }

    public void setTransactionType(DistributionTransactionType transactionType) {
        this.transactionType = transactionType;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }
}
