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
import sun.misc.BASE64Encoder;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by uengine on 2016. 6. 16..
 */
public class TenantApi extends KillbillApi {

    private Logger logger = LoggerFactory.getLogger(TenantApi.class);

    public Tenant createTenant(Tenant tenant) {
        String method = "POST";
        String path = "/1.0/kb/tenants?useGlobalDefault=false";

        try {
            Map params = JsonUtils.convertClassToMap(tenant);
            params.remove("tenantId");

            Map headers = new HashMap();
            HttpResponse httpResponse = this.apiRequest(method, path, JsonUtils.marshal(params), headers);
            if (httpResponse.getStatusLine().getStatusCode() == 201) {
                this.setApiKey(tenant.getApiKey());
                this.setApiSecret(tenant.getApiSecret());
                return this.getTenantByApiKey(tenant.getApiKey());
            } else {
                logger.error("Failed to create tenant {}", JsonUtils.marshal(params));
                throw new ServiceException("Failed to create tenant");
            }

        } catch (IOException ex) {
            throw new ServiceException("Failed to create tenant", ex);
        }
    }

    public Tenant getTenantByApiKey(String apiKey) {
        String method = "GET";
        String path = "/1.0/kb/tenants";

        Map params = new HashMap();
        params.put("apiKey", apiKey);
        String getQueryString = HttpUtils.createGETQueryString(params);

        Map headers = new HashMap();
        try {
            HttpResponse httpResponse = this.apiRequest(method, path + getQueryString, null, headers);
            if (httpResponse.getStatusLine().getStatusCode() == 200) {
                String s = EntityUtils.toString(httpResponse.getEntity());
                ObjectMapper objectMapper = new ObjectMapper();
                return objectMapper.convertValue(JsonUtils.marshal(s), Tenant.class);
            } else {
                logger.error("Failed to get tenant {}", JsonUtils.marshal(params));
                throw new ServiceException("Failed to get tenant");
            }
        } catch (IOException ex) {
            throw new ServiceException("Failed to get tenant", ex);
        }
    }

    public void uploadPerTenantConfig(String configJson) {
        String method = "POST";
        String path = "/1.0/kb/tenants/uploadPerTenantConfig";

        try {
            Map headers = new HashMap();
            headers.put("Content-Type", "text/plain");
            HttpResponse httpResponse = this.apiRequest(method, path, configJson, headers);
            if (httpResponse.getStatusLine().getStatusCode() != 201) {
                logger.error("Failed to upload uploadPerTenantConfig {}", configJson);
                throw new ServiceException("Failed to upload uploadPerTenantConfig");
            }

        } catch (IOException ex) {
            throw new ServiceException("Failed to upload uploadPerTenantConfig", ex);
        }
    }

    public List<Map> searchPerTenantConfig(String searchKey) {
        String method = "GET";
        String path = "/1.0/kb/tenants/uploadPerTenantConfig/" + searchKey + "/search";

        try {
            Map headers = new HashMap();
            HttpResponse httpResponse = this.apiRequest(method, path, null, headers);
            if (httpResponse.getStatusLine().getStatusCode() == 200) {
                String s = EntityUtils.toString(httpResponse.getEntity());
                return JsonUtils.unmarshalToList(s);
            } else {
                logger.error("Failed to get searchPerTenantConfig {}", searchKey);
                throw new ServiceException("Failed to get searchPerTenantConfig");
            }

        } catch (IOException ex) {
            throw new ServiceException("Failed to get searchPerTenantConfig", ex);
        }
    }
}
