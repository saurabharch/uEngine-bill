package org.uengine.garuda.model.catalog;

import java.util.List;

/**
 * Created by uengine on 2017. 2. 3..
 */
public class Tier {
    private String unit;
    private Double size;
    private List<Price> prices;
    private Double max;

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public Double getSize() {
        return size;
    }

    public void setSize(Double size) {
        this.size = size;
    }

    public List<Price> getPrices() {
        return prices;
    }

    public void setPrices(List<Price> prices) {
        this.prices = prices;
    }

    public Double getMax() {
        return max;
    }

    public void setMax(Double max) {
        this.max = max;
    }
}
