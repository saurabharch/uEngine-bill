package org.uengine.garuda.killbill.api;

import com.google.common.base.Joiner;
import org.apache.http.HttpResponse;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.uengine.garuda.common.exception.ServiceException;
import org.uengine.garuda.util.HttpUtils;
import org.uengine.garuda.util.JsonUtils;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by uengine on 2016. 6. 16..
 */
public class AccountApi extends KillbillApi {

    private Logger logger = LoggerFactory.getLogger(AccountApi.class);

    public void blockAccount(String accountId, Map params) {
        String method = "PUT";
        String path = "/1.0/kb/accounts/" + accountId + "/block";

        try {
            String blockJson = JsonUtils.marshal(params);
            Map headers = new HashMap();
            HttpResponse httpResponse = this.apiRequest(method, path, blockJson, headers);
            if (httpResponse.getStatusLine().getStatusCode() != 200) {
                logger.error("Failed to block account {} {}", accountId, blockJson);
                throw new ServiceException("Failed to block account");
            }

        } catch (IOException ex) {
            throw new ServiceException("Failed to block account", ex);
        }
    }

    public List<Map> getAccountTags(String accountId) {
        String method = "GET";
        String path = "/1.0/kb/accounts/" + accountId + "/tags";

        Map headers = new HashMap();
        try {
            HttpResponse httpResponse = this.apiRequest(method, path, null, headers);
            if (httpResponse.getStatusLine().getStatusCode() == 200) {
                String result = EntityUtils.toString(httpResponse.getEntity());
                return JsonUtils.unmarshalToList(result);
            } else {
                logger.error("Failed to get AccountTags");
                throw new ServiceException("Failed to get AccountTags");
            }
        } catch (IOException ex) {
            throw new ServiceException("Failed to get AccountTags", ex);
        }
    }

    public void deleteAccountTags(String accountId, List<String> tags) {
        String method = "DELETE";
        String path = "/1.0/kb/accounts/" + accountId + "/tags";

        Map headers = new HashMap();
        try {
            String tagList = Joiner.on(",").join(tags);
            Map params = new HashMap();
            params.put("tagList", tagList);
            String getQueryString = HttpUtils.createGETQueryString(params);

            HttpResponse httpResponse = this.apiRequest(method, path + getQueryString, null, headers);
            if (httpResponse.getStatusLine().getStatusCode() != 200) {
                logger.error("Failed to delete account tag {} {}", accountId, tagList);
                throw new ServiceException("Failed to delete account tag");
            }
        } catch (IOException ex) {
            throw new ServiceException("Failed to delete account tag", ex);
        }
    }
}
