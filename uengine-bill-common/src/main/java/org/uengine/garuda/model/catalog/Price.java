package org.uengine.garuda.model.catalog;

import java.math.BigDecimal;

/**
 * Created by uengine on 2017. 2. 3..
 */
public class Price {
    private String currency;
    private BigDecimal value;

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }

    public BigDecimal getValue() {
        return value;
    }

    public void setValue(BigDecimal value) {
        this.value = value;
    }
}
