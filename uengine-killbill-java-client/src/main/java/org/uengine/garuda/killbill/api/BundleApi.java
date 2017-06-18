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
public class BundleApi extends KillbillApi {

    private Logger logger = LoggerFactory.getLogger(BundleApi.class);

    public Map getBundle(String bundleId) {
        String method = "GET";
        String path = "/1.0/kb/bundles/" + bundleId;

        Map headers = new HashMap();
        try {
            HttpResponse httpResponse = this.apiRequest(method, path, null, headers);
            if (httpResponse.getStatusLine().getStatusCode() == 200) {
                String bundle = EntityUtils.toString(httpResponse.getEntity());
                return JsonUtils.unmarshal(bundle);
            } else {
                logger.error("Failed to get bundle {}", bundleId);
                throw new ServiceException("Failed to get bundle, " + bundleId);
            }
        } catch (IOException ex) {
            throw new ServiceException("Failed to get bundle, " + bundleId, ex);
        }
    }

    public List<Map> getAccountBundles(String accountId) {
        String method = "GET";
        String path = "/1.0/kb/accounts/" + accountId + "/bundles?audit=NONE";

        Map headers = new HashMap();
        try {
            HttpResponse httpResponse = this.apiRequest(method, path, null, headers);
            if (httpResponse.getStatusLine().getStatusCode() == 200) {
                String bundles = EntityUtils.toString(httpResponse.getEntity());
                return JsonUtils.unmarshalToList(bundles);
            } else {
                logger.error("Failed to get account bundle {}", accountId);
                throw new ServiceException("Failed to get account bundle, " + accountId);
            }
        } catch (IOException ex) {
            throw new ServiceException("Failed to get account bundle, " + accountId, ex);
        }
    }
}
