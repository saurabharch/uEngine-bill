package org.uengine.garuda.web.sales;

import java.util.Date;

/**
 * Created by uengine on 2017. 6. 21..
 */
public class SalesSummaryFilter {
    private SalesSummaryType requesterType;
    private Date start_date;
    private Date end_date;
    private String vendor_id;
    private String product_id;
    private String plan_name;
    private String usage_name;

    public SalesSummaryType getRequesterType() {
        return requesterType;
    }

    public void setRequesterType(SalesSummaryType requesterType) {
        this.requesterType = requesterType;
    }

    public Date getStart_date() {
        return start_date;
    }

    public void setStart_date(Date start_date) {
        this.start_date = start_date;
    }

    public Date getEnd_date() {
        return end_date;
    }

    public void setEnd_date(Date end_date) {
        this.end_date = end_date;
    }

    public String getVendor_id() {
        return vendor_id;
    }

    public void setVendor_id(String vendor_id) {
        this.vendor_id = vendor_id;
    }

    public String getProduct_id() {
        return product_id;
    }

    public void setProduct_id(String product_id) {
        this.product_id = product_id;
    }

    public String getPlan_name() {
        return plan_name;
    }

    public void setPlan_name(String plan_name) {
        this.plan_name = plan_name;
    }

    public String getUsage_name() {
        return usage_name;
    }

    public void setUsage_name(String usage_name) {
        this.usage_name = usage_name;
    }
}
