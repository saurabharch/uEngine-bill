package com.commerce.cloud.billing;

import com.commerce.cloud.model.UsageLog;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

@Service
public class UsageService {

    private ArrayList<UsageLog> usageLogs;

    @Autowired
    private BillingApi billingApi;

    @PostConstruct
    private void init() {
        usageLogs = new ArrayList<>();
    }

    public void addUsageLog(UsageLog log) {
        usageLogs.add(log);
    }

    @Scheduled(initialDelay = 1000, fixedDelay = 5000)
    public void saveUsageScheduler() {
        try {
            Map<String, Map<String, Object>> groupBySubscription = new HashMap<>();
            for (int i = 0; i < usageLogs.size(); i++) {
                UsageLog usageLog = usageLogs.get(i);
                String subscriptionId = usageLog.getSubscriptionId();

                if (!groupBySubscription.containsKey(subscriptionId)) {
                    groupBySubscription.put(subscriptionId, new HashMap<>());
                }
                Map<String, Object> map = groupBySubscription.get(subscriptionId);
                map.put("organizationId", usageLog.getOrganizationId());
                map.put("unit", usageLog.getUnit());
                if (map.containsKey("amount")) {
                    map.put("amount", (Integer) map.get("amount") + 1);
                } else {
                    map.put("amount", 1);
                }
            }
            if (!groupBySubscription.isEmpty()) {
                Set<Map.Entry<String, Map<String, Object>>> entries = groupBySubscription.entrySet();
                for (Map.Entry<String, Map<String, Object>> entry : entries) {
                    String subscriptionId = entry.getKey();
                    String organizationId = entry.getValue().get("organizationId").toString();
                    String unit = entry.getValue().get("unit").toString();
                    Integer amount = (Integer) entry.getValue().get("amount");
                    billingApi.saveUsage(organizationId, unit, amount, subscriptionId);
                }
            }
            usageLogs.clear();

        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
