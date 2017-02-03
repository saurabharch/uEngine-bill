package org.uengine.garuda.model.catalog;

import java.util.List;

/**
 * Created by uengine on 2017. 2. 2..
 */
public class Phase {
    private String type;
    private Duration duration;
    private Recurring recurring;
    private Fixed fixed;
    private List<Usage> usages;

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Duration getDuration() {
        return duration;
    }

    public void setDuration(Duration duration) {
        this.duration = duration;
    }

    public Recurring getRecurring() {
        return recurring;
    }

    public void setRecurring(Recurring recurring) {
        this.recurring = recurring;
    }

    public Fixed getFixed() {
        return fixed;
    }

    public void setFixed(Fixed fixed) {
        this.fixed = fixed;
    }

    public List<Usage> getUsages() {
        return usages;
    }

    public void setUsages(List<Usage> usages) {
        this.usages = usages;
    }
}
