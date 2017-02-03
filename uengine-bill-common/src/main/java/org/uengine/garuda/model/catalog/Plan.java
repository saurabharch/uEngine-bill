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
    private Long subscriptionCount;

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

    public Long getSubscriptionCount() {
        return subscriptionCount;
    }

    public void setSubscriptionCount(Long subscriptionCount) {
        this.subscriptionCount = subscriptionCount;
    }
}
