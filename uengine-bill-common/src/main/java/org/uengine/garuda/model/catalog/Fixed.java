package org.uengine.garuda.model.catalog;

import org.uengine.garuda.model.Vendor;

import java.util.List;

/**
 * Created by uengine on 2017. 2. 3..
 */
public class Fixed {
    private List<Price> fixedPrice;

    public List<Price> getFixedPrice() {
        return fixedPrice;
    }

    public void setFixedPrice(List<Price> fixedPrice) {
        this.fixedPrice = fixedPrice;
    }
}
