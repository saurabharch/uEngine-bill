package org.uengine.garuda.model.catalog;

import org.joda.time.Period;

/**
 * Created by uengine on 2017. 3. 27..
 */
public enum BillingPeriod {

    DAILY(Period.days(1)),
    WEEKLY(Period.weeks(1)),
    BIWEEKLY(Period.weeks(2)),
    THIRTY_DAYS(Period.days(30)),
    MONTHLY(Period.months(1)),
    QUARTERLY(Period.months(3)),
    BIANNUAL(Period.months(6)),
    ANNUAL(Period.years(1)),
    BIENNIAL(Period.years(2)),
    NO_BILLING_PERIOD(Period.ZERO);

    private final Period period;

    BillingPeriod(final Period period) {
        this.period = period;
    }

    public Period getPeriod() {
        return period;
    }
}
