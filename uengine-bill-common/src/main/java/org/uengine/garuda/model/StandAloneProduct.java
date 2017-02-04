package org.uengine.garuda.model;

import com.fasterxml.jackson.databind.ObjectMapper;
import net.minidev.json.JSONUtil;
import org.killbill.billing.catalog.*;
import org.killbill.billing.catalog.api.Plan;
import org.killbill.billing.catalog.rules.DefaultCaseBillingAlignment;
import org.killbill.billing.catalog.rules.DefaultPlanRules;
import org.uengine.garuda.util.JsonUtils;
import org.uengine.garuda.util.SystemUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by uengine on 2017. 1. 26..
 */
public class StandAloneProduct {
    public static void main(String[] args) throws Exception {
        StandaloneCatalog catalog = new StandaloneCatalog();

        DefaultPlanRules planRules = new DefaultPlanRules();
        //Map<String, Object> map = JsonUtils.convertClassToMap(planRules);
        //String marshal = JsonUtils.marshal(planRules);
        //System.out.println(marshal);


        DefaultPlan plan = new DefaultPlan();

        DefaultPlanPhase planPhase = new DefaultPlanPhase();
        //new DefaultPrice()
        //new DefaultDuration().getUnit()


        List<org.uengine.garuda.model.catalog.Plan> plans = new ArrayList<>();
        plans.add(new org.uengine.garuda.model.catalog.Plan());
        ProductVersion productVersion = new ProductVersion();
        productVersion.setPlans(plans);

        String plans2 = JsonUtils.marshal(productVersion.getPlans());
        Map<String, Object> map = JsonUtils.convertClassToMap(productVersion);
        map.put("plans", plans2);
        ProductDaoVersion daoVersion = new ObjectMapper().convertValue(map, ProductDaoVersion.class);

        List<org.uengine.garuda.model.catalog.Plan> plans3 = JsonUtils.unmarshalToList(daoVersion.getPlans());
        Map<String, Object> map2 = JsonUtils.convertClassToMap(daoVersion);
        map2.put("plans", plans3);
        ProductVersion version = new ObjectMapper().convertValue(map2, ProductVersion.class);

        System.out.println(JsonUtils.marshal(version));
    }
}
