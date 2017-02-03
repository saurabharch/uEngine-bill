package org.uengine.garuda.model;

import net.minidev.json.JSONUtil;
import org.killbill.billing.catalog.DefaultPlan;
import org.killbill.billing.catalog.DefaultPlanPhase;
import org.killbill.billing.catalog.DefaultPrice;
import org.killbill.billing.catalog.StandaloneCatalog;
import org.killbill.billing.catalog.api.Plan;
import org.killbill.billing.catalog.rules.DefaultCaseBillingAlignment;
import org.killbill.billing.catalog.rules.DefaultPlanRules;
import org.uengine.garuda.util.JsonUtils;
import org.uengine.garuda.util.SystemUtils;

import java.util.Map;

/**
 * Created by uengine on 2017. 1. 26..
 */
public class StandAloneProduct {
    public static void main(String[] args) throws Exception {
        StandaloneCatalog catalog = new StandaloneCatalog();

        DefaultPlanRules planRules = new DefaultPlanRules();
        //Map<String, Object> map = JsonUtils.convertClassToMap(planRules);
        String marshal = JsonUtils.marshal(planRules);
        System.out.println(marshal);


        DefaultPlan plan = new DefaultPlan();

        DefaultPlanPhase planPhase = new DefaultPlanPhase();
        //new DefaultPrice()
    }
}
