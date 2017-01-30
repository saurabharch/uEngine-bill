package org.uengine.garuda.killbill.api;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.http.HttpResponse;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.uengine.garuda.common.exception.ServiceException;
import org.uengine.garuda.killbill.api.model.Tenant;
import org.uengine.garuda.util.HttpUtils;
import org.uengine.garuda.util.JsonUtils;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by uengine on 2016. 6. 16..
 */
public class OverdueApi extends KillbillApi {

    private Logger logger = LoggerFactory.getLogger(OverdueApi.class);

    public void createOverdue(String overdueJson) {
        String method = "POST";
        String path = "/1.0/kb/overdue";

        try {
            Map headers = new HashMap();
            HttpResponse httpResponse = this.apiRequest(method, path, overdueJson, headers);
            if (httpResponse.getStatusLine().getStatusCode() != 201) {
                logger.error("Failed to create overdue {}", overdueJson);
                throw new ServiceException("Failed to create overdue");
            }

        } catch (IOException ex) {
            throw new ServiceException("Failed to create overdue", ex);
        }
    }

    public String getOverdue() {
        String method = "GET";
        String path = "/1.0/kb/overdue";

        Map headers = new HashMap();
        try {
            HttpResponse httpResponse = this.apiRequest(method, path, null, headers);
            if (httpResponse.getStatusLine().getStatusCode() == 200) {
                return EntityUtils.toString(httpResponse.getEntity());
            } else {
                logger.error("Failed to get overdue");
                throw new ServiceException("Failed to get overdue");
            }
        } catch (IOException ex) {
            throw new ServiceException("Failed to get overdue", ex);
        }
    }
}
