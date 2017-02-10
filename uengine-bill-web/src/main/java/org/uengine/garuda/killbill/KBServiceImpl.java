package org.uengine.garuda.killbill;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.uengine.garuda.authentication.AuthenticationService;
import org.uengine.garuda.common.exception.ServiceException;
import org.uengine.garuda.killbill.api.model.Clock;
import org.uengine.garuda.util.JsonUtils;
import org.uengine.garuda.web.organization.OrganizationRepository;

import java.io.IOException;
import java.util.*;

@Service
public class KBServiceImpl implements KBService {

    @Autowired
    @Qualifier("config")
    private Properties config;

    @Autowired
    private KBServiceFactory killbillServiceFactory;

    private Logger logger = LoggerFactory.getLogger(KBService.class);

    @Override
    public void uploadRetry(String apiKey, String apiSecret, String retryJson) {
        try {
            Map map = JsonUtils.unmarshal(retryJson);
            String retry = (String) map.get("retry");
            Map configMap = new HashMap();
            configMap.put("org.killbill.payment.retry.days", retry);
            killbillServiceFactory.apiClient(apiKey, apiSecret).tenantApi()
                    .uploadPerTenantConfig(JsonUtils.marshal(configMap));
        } catch (IOException ex) {
            throw new ServiceException(ex);
        }
    }

    @Override
    public Map getRetry(String apiKey, String apiSecret) {
        try {
            Map retryMap = new HashMap<>();
            List<Map> perTenantConfig = killbillServiceFactory.apiClient(apiKey, apiSecret).tenantApi()
                    .searchPerTenantConfig("PER_TENANT_CONFIG");
            for (Map config : perTenantConfig) {
                if ("PER_TENANT_CONFIG".equals(config.get("key"))) {
                    List<String> values = (List<String>) config.get("values");
                    for (String value : values) {
                        Map valueMap = JsonUtils.unmarshal(value);
                        if (valueMap.containsKey("org.killbill.payment.retry.days")) {
                            retryMap.put("retry", valueMap.get("org.killbill.payment.retry.days"));
                        }
                    }
                }
            }
            if (retryMap.isEmpty()) {
                throw new ServiceException("Not fount org.killbill.payment.retry.days in perTenentConfig");
            } else {
                return retryMap;
            }
        } catch (IOException ex) {
            throw new ServiceException(ex);
        }
    }

    @Override
    public Clock getTime(String apiKey, String apiSecret) {
        return killbillServiceFactory.apiClient(apiKey, apiSecret).testApi().getTime();
    }

    @Override
    public Clock updateTime(String apiKey, String apiSecret, String requestedDate) {
        return killbillServiceFactory.apiClient(apiKey, apiSecret).testApi().updateTime(requestedDate, null, null);
    }
}
