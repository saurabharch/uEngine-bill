package org.uengine.garuda.killbill.api;

import org.apache.http.HttpResponse;
import org.apache.http.util.EntityUtils;
import org.uengine.garuda.util.HttpUtils;
import org.uengine.garuda.util.JsonUtils;
import org.uengine.garuda.util.StringUtils;
import sun.misc.BASE64Encoder;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by uengine on 2016. 6. 16..
 */
public class KillbillApi {

    private HttpUtils httpUtils;
    private String url;
    private String user;
    private String password;
    private String apiKey;
    private String apiSecret;

    public HttpUtils getHttpUtils() {
        return httpUtils;
    }

    public void setHttpUtils(HttpUtils httpUtils) {
        this.httpUtils = httpUtils;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getApiKey() {
        return apiKey;
    }

    public void setApiKey(String apiKey) {
        this.apiKey = apiKey;
    }

    public String getApiSecret() {
        return apiSecret;
    }

    public void setApiSecret(String apiSecret) {
        this.apiSecret = apiSecret;
    }

    public KillbillApi() {

    }

    public TenantApi tenantApi() {
        return (TenantApi) this.copyOptions(new TenantApi());
    }

    public OverdueApi overdueApi() {
        return (OverdueApi) this.copyOptions(new OverdueApi());
    }

    public TestApi testApi() {
        return (TestApi) this.copyOptions(new TestApi());
    }

    public BundleApi bundleApi() {
        return (BundleApi) this.copyOptions(new BundleApi());
    }

    public InvoiceApi invoiceApi() {
        return (InvoiceApi) this.copyOptions(new InvoiceApi());
    }

    public CreditsApi creditsApi() {
        return (CreditsApi) this.copyOptions(new CreditsApi());
    }

    public SubscriptionApi subscriptionApi()

    {
        return (SubscriptionApi) this.copyOptions(new SubscriptionApi());
    }

    public AccountApi accountApi() {
        return (AccountApi) this.copyOptions(new AccountApi());
    }

    private KillbillApi copyOptions(KillbillApi killbillApi) {
        killbillApi.setUrl(url);
        killbillApi.setUser(user);
        killbillApi.setPassword(password);
        killbillApi.setApiKey(apiKey);
        killbillApi.setApiSecret(apiSecret);
        killbillApi.setHttpUtils(httpUtils);
        return killbillApi;
    }

    public KillbillApi(String url, String user, String password, String apiKey, String apiSecret) {
        this.url = url;
        this.user = user;
        this.password = password;
        this.apiKey = apiKey;
        this.apiSecret = apiSecret;

        this.httpUtils = new HttpUtils();
    }


    public HttpResponse apiRequest(String method, String path, String data, Map headers) throws IOException {

        String auth = this.user + ":" + this.password;
        BASE64Encoder encoder = new BASE64Encoder();
        String encode = encoder.encode(auth.getBytes());

        Map requiredHeaders = new HashMap();
        requiredHeaders.put("Authorization", "Basic " + encode);
        requiredHeaders.put("Content-Type", "application/json");
        requiredHeaders.put("Accept", "application/json");
        requiredHeaders.put("X-Killbill-CreatedBy", "uEngine");

        if (!StringUtils.isEmpty(this.apiKey)) {
            requiredHeaders.put("X-Killbill-ApiKey", this.apiKey);
        }
        if (!StringUtils.isEmpty(this.apiSecret)) {
            requiredHeaders.put("X-Killbill-ApiSecret", this.apiSecret);
        }

        requiredHeaders.putAll(headers);

        String url = this.url + path;
        HttpResponse httpResponse = httpUtils.makeRequest(method, url, data, requiredHeaders);
        return httpResponse;
    }
}
