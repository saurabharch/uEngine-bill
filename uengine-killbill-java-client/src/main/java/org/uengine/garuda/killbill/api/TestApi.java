package org.uengine.garuda.killbill.api;

import org.apache.http.HttpResponse;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.uengine.garuda.common.exception.ServiceException;
import org.uengine.garuda.killbill.api.model.Clock;
import org.uengine.garuda.util.HttpUtils;
import org.uengine.garuda.util.JsonUtils;
import org.uengine.garuda.util.StringUtils;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by uengine on 2016. 6. 16..
 */
public class TestApi extends KillbillApi {

    private Logger logger = LoggerFactory.getLogger(TestApi.class);

    public Clock updateTime(String requestedDate, String timeZone, Long timeoutSec) {
        String method = "POST";
        String path = "/1.0/kb/test/clock";

        try {
            Map params = new HashMap();
            if (timeoutSec == null) {
                timeoutSec = new Long(5);
            }
            params.put("requestedDate", requestedDate);
            params.put("timeoutSec", timeoutSec);

            if(!StringUtils.isEmpty(timeZone)){
                params.put("timeZone", timeZone);
            }

            String getQueryString = HttpUtils.createGETQueryString(params);

            Map headers = new HashMap();
            HttpResponse httpResponse = this.apiRequest(method, path + getQueryString, null, headers);
            if (httpResponse.getStatusLine().getStatusCode() != 200) {
                logger.error("Failed to updateTime {}", params);
                throw new ServiceException("Failed to updateTime");
            } else {
                return new Clock(JsonUtils.unmarshal(EntityUtils.toString(httpResponse.getEntity())));
            }

        } catch (IOException ex) {
            throw new ServiceException("Failed to updateTime", ex);
        }
    }

    public Clock getTime() {
        String method = "GET";
        String path = "/1.0/kb/test/clock";

        Map headers = new HashMap();
        try {
            HttpResponse httpResponse = this.apiRequest(method, path, null, headers);
            if (httpResponse.getStatusLine().getStatusCode() == 200) {
                String result = EntityUtils.toString(httpResponse.getEntity());
                return new Clock(JsonUtils.unmarshal(result));

            } else {
                logger.error("Failed to get clock");
                throw new ServiceException("Failed to get clock");
            }
        } catch (Exception ex) {
            throw new ServiceException("Failed to get clock", ex);
        }
    }
}
