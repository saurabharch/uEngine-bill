package org.uengine.garuda.web.onetimebuy;

/**
 * Created by uengine on 2017. 6. 11..
 */
public class OneTimeBuyRequest {
    private String bundleId;
    private String productCategory;
    private String planName;

    public String getBundleId() {
        return bundleId;
    }

    public void setBundleId(String bundleId) {
        this.bundleId = bundleId;
    }

    public String getProductCategory() {
        return productCategory;
    }

    public void setProductCategory(String productCategory) {
        this.productCategory = productCategory;
    }

    public String getPlanName() {
        return planName;
    }

    public void setPlanName(String planName) {
        this.planName = planName;
    }
}
