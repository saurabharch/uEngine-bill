package org.uengine.garuda.model.catalog;

import org.uengine.garuda.model.Vendor;

import java.util.List;

/**
 * Created by uengine on 2017. 2. 2..
 */
public class Plan {

    private String name;
    private String display_name;
    private String is_active;
    private List<Phase> initialPhases;
    private Phase finalPhase;
    private List<Price> onetimePrice;
    private Long number_of_subscriptions_referenced_by_version;
    private Long number_of_subscriptions;
    private Long number_of_oneTimeBuys_referenced_by_version;
    private Long number_of_oneTimeBuys;
    private List<Vendor> overwriteVendors;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDisplay_name() {
        return display_name;
    }

    public void setDisplay_name(String display_name) {
        this.display_name = display_name;
    }

    public String getIs_active() {
        return is_active;
    }

    public void setIs_active(String is_active) {
        this.is_active = is_active;
    }

    public List<Phase> getInitialPhases() {
        return initialPhases;
    }

    public void setInitialPhases(List<Phase> initialPhases) {
        this.initialPhases = initialPhases;
    }

    public Phase getFinalPhase() {
        return finalPhase;
    }

    public void setFinalPhase(Phase finalPhase) {
        this.finalPhase = finalPhase;
    }

    public List<Price> getOnetimePrice() {
        return onetimePrice;
    }

    public void setOnetimePrice(List<Price> onetimePrice) {
        this.onetimePrice = onetimePrice;
    }

    public Long getNumber_of_subscriptions_referenced_by_version() {
        return number_of_subscriptions_referenced_by_version;
    }

    public void setNumber_of_subscriptions_referenced_by_version(Long number_of_subscriptions_referenced_by_version) {
        this.number_of_subscriptions_referenced_by_version = number_of_subscriptions_referenced_by_version;
    }

    public Long getNumber_of_subscriptions() {
        return number_of_subscriptions;
    }

    public void setNumber_of_subscriptions(Long number_of_subscriptions) {
        this.number_of_subscriptions = number_of_subscriptions;
    }

    public Long getNumber_of_oneTimeBuys_referenced_by_version() {
        return number_of_oneTimeBuys_referenced_by_version;
    }

    public void setNumber_of_oneTimeBuys_referenced_by_version(Long number_of_oneTimeBuys_referenced_by_version) {
        this.number_of_oneTimeBuys_referenced_by_version = number_of_oneTimeBuys_referenced_by_version;
    }

    public Long getNumber_of_oneTimeBuys() {
        return number_of_oneTimeBuys;
    }

    public void setNumber_of_oneTimeBuys(Long number_of_oneTimeBuys) {
        this.number_of_oneTimeBuys = number_of_oneTimeBuys;
    }

    public List<Vendor> getOverwriteVendors() {
        return overwriteVendors;
    }

    public void setOverwriteVendors(List<Vendor> overwriteVendors) {
        this.overwriteVendors = overwriteVendors;
    }
}
