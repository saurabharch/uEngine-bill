package com.commerce.cloud.billing;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.lang.time.DateUtils;
import org.apache.http.Header;
import org.apache.http.HttpResponse;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class BillingApi {

    private Logger logger = LoggerFactory.getLogger(BillingApi.class);

    @Autowired
    private BillingConfig billingConfig;

    public void saveUsage(String organization, String unit, int amount, String subscriptionId) {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String format = formatter.format(new Date());

        String method = "POST";
        String path = "/rest/v1/usages";

        Usage usage = new Usage();
        usage.setSubscriptionId(subscriptionId);
        usage.setUnitUsageRecords(new ArrayList<>());

        Usage.UnitUsageRecord unitUsageRecord = new Usage.UnitUsageRecord();
        unitUsageRecord.setUnitType(unit);
        unitUsageRecord.setUsageRecords(new ArrayList<>());

        Usage.UnitUsageRecord.UsageRecord record = new Usage.UnitUsageRecord.UsageRecord();
        record.setAmount(amount);
        record.setRecordDate(format);
        unitUsageRecord.getUsageRecords().add(record);

        usage.getUnitUsageRecords().add(unitUsageRecord);

        try {
            Map headers = new HashMap();
            String asString = new ObjectMapper().writeValueAsString(usage);

            HttpResponse httpResponse = this.apiRequest(method, path, asString, headers, organization);
            if (httpResponse.getStatusLine().getStatusCode() != 201) {
                logger.error("Failed to save usage {}", asString);
            }

        } catch (IOException ex) {
            logger.error("Failed to save usage");
        }
    }

    public HttpResponse apiRequest(String method, String path, String data, Map headers, String organization) throws IOException {
        Map requiredHeaders = new HashMap();
        requiredHeaders.put("Authorization", "Basic " + billingConfig.getAuthentication());
        requiredHeaders.put("Content-Type", "application/json");
        requiredHeaders.put("Accept", "application/json");
        requiredHeaders.put("X-organization-id", organization);
        requiredHeaders.putAll(headers);

        String url = billingConfig.getUrl() + path;
        HttpUtils httpUtils = new HttpUtils();
        HttpResponse httpResponse = httpUtils.makeRequest(method, url, data, requiredHeaders);
        return httpResponse;
    }
}
