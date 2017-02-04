package org.uengine.garuda.model.catalog;

import java.util.List;

/**
 * Created by uengine on 2017. 2. 2..
 */
public class Plan {

    private String id;
    private String name;
    private List<Phase> initialPhases;
    private Phase finalPhase;
    private Long subscription_count_for_version;
    private Long subscription_count_total;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public Long getSubscription_count_for_version() {
        return subscription_count_for_version;
    }

    public void setSubscription_count_for_version(Long subscription_count_for_version) {
        this.subscription_count_for_version = subscription_count_for_version;
    }

    public Long getSubscription_count_total() {
        return subscription_count_total;
    }

    public void setSubscription_count_total(Long subscription_count_total) {
        this.subscription_count_total = subscription_count_total;
    }
}
