package org.uengine.garuda.killbill.api;

import org.apache.http.HttpResponse;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.uengine.garuda.common.exception.ServiceException;
import org.uengine.garuda.util.JsonUtils;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by uengine on 2016. 6. 16..
 */
public class SubscriptionApi extends KillbillApi {

    private Logger logger = LoggerFactory.getLogger(SubscriptionApi.class);

    public void updateBCD(String subscriptionId, int bcd) {
        String method = "PUT";
        String path = "/1.0/kb/subscriptions/" + subscriptionId + "/bcd";

        Map headers = new HashMap();
        try {
            Map params = new HashMap();
            params.put("billCycleDayLocal", bcd);

            HttpResponse httpResponse = this.apiRequest(method, path, JsonUtils.marshal(params), headers);
            if (httpResponse.getStatusLine().getStatusCode() != 200) {
                logger.error("Failed to update subscription BCD {}", subscriptionId);
                throw new ServiceException("Failed to update subscription, " + subscriptionId);
            }
        } catch (IOException ex) {
            throw new ServiceException("Failed to get update subscription, " + subscriptionId, ex);
        }
    }
}
