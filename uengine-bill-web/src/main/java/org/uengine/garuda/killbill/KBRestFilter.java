package org.uengine.garuda.killbill;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.http.Header;
import org.apache.http.HttpResponse;
import org.apache.http.util.EntityUtils;
import org.springframework.context.ApplicationContext;
import org.uengine.garuda.model.Organization;
import org.uengine.garuda.model.Product;
import org.uengine.garuda.model.ProductVersion;
import org.uengine.garuda.model.SubscriptionEventsExt;
import org.uengine.garuda.model.catalog.Plan;
import org.uengine.garuda.proxy.ProxyRequest;
import org.uengine.garuda.proxy.ProxyService;
import org.uengine.garuda.util.ApplicationContextRegistry;
import org.uengine.garuda.util.HttpUtils;
import org.uengine.garuda.util.JsonUtils;
import org.uengine.garuda.util.StringUtils;
import org.uengine.garuda.web.configuration.ConfigurationHelper;
import org.uengine.garuda.web.organization.OrganizationRole;
import org.uengine.garuda.web.organization.OrganizationService;
import org.uengine.garuda.web.product.ProductService;
import org.uengine.garuda.web.product.event.SubscriptionEventRepository;
import org.uengine.garuda.web.product.version.ProductVersionService;
import sun.misc.BASE64Encoder;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.jstl.core.Config;
import java.io.IOException;
import java.util.*;

/**
 * Created by uengine on 2016. 4. 22..
 */
public class KBRestFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
        HttpServletResponse response = (HttpServletResponse) res;
        HttpServletRequest request = (HttpServletRequest) req;

        String[] proxyPaths = new String[]{
                "/rest/v1/accounts",
                "/rest/v1/bundles",
                "/rest/v1/credits",
                "/rest/v1/customFields",
                "/rest/v1/invoicePayments",
                "/rest/v1/invoices",
                "/rest/v1/overdue",
                "/rest/v1/paymentGateways",
                "/rest/v1/paymentMethods",
                "/rest/v1/payments",
                "/rest/v1/paymentTransactions",
                "/rest/v1/pluginsInfo",
                "/rest/v1/subscriptions",
                "/rest/v1/tenants",
                "/rest/v1/test",
                "/rest/v1/usages",
                "/rest/v1/tagDefinitions",
                "/rest/v1/tags",
                "/plugins"
        };

        boolean is_proxy = false;
        String requestURI = request.getRequestURI();
        int occurance = org.apache.commons.lang.StringUtils.countMatches(requestURI, "/");

        for (int i = 0; i < proxyPaths.length; i++) {
            if (requestURI.startsWith(proxyPaths[i])) {
                is_proxy = true;
            }
        }

        try {
            String accountId = null;
            ArrayList<String> plan_names = new ArrayList<>();
            String command = null;
            String body = null;
            String bundleId = null;

            //번들 이동
            if (requestURI.startsWith("/rest/v1/bundles/") && request.getMethod().toLowerCase().equals("put")) {
                String[] split = requestURI.split("/");
                if (split.length == 5) {
                    bundleId = split[4];
                    Map map = new ObjectMapper().readValue(request.getInputStream(), Map.class);
                    body = JsonUtils.marshal(map);
                    accountId = map.get("accountId").toString();
                    command = "transferBundle";
                }
            }

            //서브스크립션 추가
            if (requestURI.equals("/rest/v1/subscriptions") && request.getMethod().toLowerCase().equals("post")) {
                Map map = new ObjectMapper().readValue(request.getInputStream(), Map.class);
                body = JsonUtils.marshal(map);
                plan_names.add(map.get("planName").toString());
                accountId = map.get("accountId").toString();
                command = "createSubscription";
            }

            //서브스크립션 변경
            else if (requestURI.startsWith("/rest/v1/subscriptions/") && request.getMethod().toLowerCase().equals("put") && occurance == 4) {
                Map map = new ObjectMapper().readValue(request.getInputStream(), Map.class);
                body = JsonUtils.marshal(map);
                plan_names.add(map.get("planName").toString());
                accountId = map.get("accountId").toString();
                command = "updateSubscription";
            }

            //createEntitlementWithAddOns
            else if (requestURI.equals("/rest/v1/subscriptions/createEntitlementWithAddOns") && request.getMethod().toLowerCase().equals("post")) {
                List<Map> list = new ObjectMapper().readValue(request.getInputStream(), List.class);
                body = JsonUtils.marshal(list);
                for (Map map : list) {
                    accountId = map.get("accountId").toString();
                    plan_names.add(map.get("planName").toString());
                }
                command = "createEntitlementWithAddOns";
            }

            //createEntitlementsWithAddOns
            else if (requestURI.equals("/rest/v1/subscriptions/createEntitlementsWithAddOns") && request.getMethod().toLowerCase().equals("post")) {
                List<Map> list = new ObjectMapper().readValue(request.getInputStream(), List.class);
                body = JsonUtils.marshal(list);
                for (Map map : list) {
                    List<Map> baseEntitlementAndAddOns = (List<Map>) map.get("baseEntitlementAndAddOns");
                    for (Map entitlementAndAddOn : baseEntitlementAndAddOns) {
                        plan_names.add(entitlementAndAddOn.get("planName").toString());
                        accountId = entitlementAndAddOn.get("accountId").toString();
                    }
                }
                command = "createEntitlementsWithAddOns";
            }

            if (command != null) {
                doSubscriptionIntercept(request, response, body, command, plan_names, accountId, bundleId);
                return;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            response.setStatus(500);
            return;
        }

        //사용자 삭제
        if (requestURI.startsWith("/rest/v1/accounts") && request.getMethod().toLowerCase().equals("delete") && occurance == 4) {
            is_proxy = false;
        }
        //사용자 아이디 필터
        if (requestURI.startsWith("/rest/v1/accountsByIds") && request.getMethod().toLowerCase().equals("post")) {
            is_proxy = false;
        }


        //킬빌 rest uri 일 경우 프락시 통신을 한다.
        if (is_proxy) {
            try {
                doProxy(request, response);
                return;
            } catch (Exception ex) {
                ex.printStackTrace();
                response.setStatus(500);
                return;
            }
        } else {
            chain.doFilter(req, res);
        }
    }

    @Override
    public void destroy() {

    }

    /**
     * 서브스크립션 생성, 삭제, 번들 이동 요청을 인터셉트하여 이벤트 테이블에 추가,삭제한다.
     *
     * @param request
     * @param response
     * @param plan_names
     */
    private void doSubscriptionIntercept(HttpServletRequest request, HttpServletResponse response, String body,
                                         String command, ArrayList<String> plan_names, String accountId, String bundleId) {

        ApplicationContext context = ApplicationContextRegistry.getApplicationContext();
        OrganizationService organizationService = context.getBean(OrganizationService.class);
        KBRepository kbRepository = context.getBean(KBRepository.class);
        ProductVersionService productVersionService = context.getBean(ProductVersionService.class);
        ProductService productService = context.getBean(ProductService.class);
        SubscriptionEventRepository subscriptionEventRepository = context.getBean(SubscriptionEventRepository.class);

        OrganizationRole role = organizationService.getOrganizationRole(request, "MEMBER");
        if (!role.getAccept()) {
            response.setStatus(401);
            return;
        }

        Organization organization = role.getOrganization();

        //REQUEST 이벤트 레코드 아이디 리스트
        ArrayList<Long> eventIds = new ArrayList<>();

        //생성 또는 수정된 구독 아이디 리스트
        ArrayList<Map> createdSubscriptions = new ArrayList<>();

        //응답객체 요소
        String resultBody = null;
        Header[] headers = null;
        int statusCode = 0;

        try {
            //어카운드 얻기
            Map account = kbRepository.getAccountById(accountId);
            Long account_record_id = Long.parseLong(account.get("record_id") + "");

            //테넌트 얻기
            Map tenant = kbRepository.getTenantById(organization.getTenant_id());
            Long tenant_record_id = Long.parseLong(tenant.get("record_id") + "");

            if ("transferBundle".equals(command)) {
                //번들의 정보를 킬빌서버로부터 알아온다.
                String result = getSubscriptionsAfterIntercept(organization, "/1.0/kb/bundles/" + bundleId);
                Map bundleMap = JsonUtils.unmarshal(result);
                String ownerAccountId = bundleMap.get("accountId").toString();
                List<Map> subscriptions = (List<Map>) bundleMap.get("subscriptions");

                //번들에 포함된 서브스크립션의 히스토리를 이양할 구매자 계정으로 카피한다.
                for (Map subscription : subscriptions) {
                    String subscriptionId = subscription.get("subscriptionId").toString();
                    List<SubscriptionEventsExt> subscriptionEventsExts = subscriptionEventRepository.selectByAccountIdAndSubId(ownerAccountId, subscriptionId);
                    for (SubscriptionEventsExt eventsExt : subscriptionEventsExts) {
                        eventsExt.setSubscription_id(null);
                        eventsExt.setId(null);
                        eventsExt.setAccount_id(accountId);
                        eventsExt.setAccount_record_id(account_record_id);
                        eventsExt.setUser_type("REQUEST");
                        eventsExt.setReg_dt(null);
                        eventsExt = subscriptionEventRepository.insert(eventsExt);
                        eventIds.add(eventsExt.getId());
                    }
                }
            } else {
                //플랜 이름마다 서브스크립션 이벤트에 저장.
                for (String plan_name : plan_names) {
                    String product_id = plan_name.substring(0, 14);
                    //프로덕트 얻기
                    Product product = productService.selectProductById(organization.getId(), product_id);
                    if (!"Y".equals(product.getIs_active())) {
                        //액티브 프로덕트가 아닐경우
                        response.setStatus(400);
                        return;
                    }

                    //프로덕트 버젼 얻기
                    ProductVersion currentVersion = productVersionService.getCurrentVersion(organization.getId(), product_id);

                    //플랜 얻기
                    List<Plan> plans = currentVersion.getPlans();
                    Plan plan = null;
                    for (Plan p : plans) {
                        if (plan_name.equals(p.getName())) {
                            plan = p;
                        }
                    }
                    //플랜이 없거나 허용되지 않음
                    if (plan == null || !"Y".equals(plan.getIs_active())) {
                        response.setStatus(400);
                        return;
                    }

                    SubscriptionEventsExt eventsExt = new SubscriptionEventsExt();
                    eventsExt.setAccount_id(accountId);
                    eventsExt.setAccount_record_id(account_record_id);
                    eventsExt.setOrganization_id(organization.getId());
                    eventsExt.setTenant_id(organization.getTenant_id());
                    eventsExt.setTenant_record_id(tenant_record_id);
                    eventsExt.setUser_type("REQUEST");
                    eventsExt.setProduct_id(product_id);
                    eventsExt.setVersion(currentVersion.getVersion());
                    eventsExt.setPlan_name(plan_name);
                    eventsExt = subscriptionEventRepository.insert(eventsExt);
                    eventIds.add(eventsExt.getId());
                }
            }

            //킬빌 통신 시도
            HttpResponse httpResponse = sendKBRequest(request, organization, body);

            //통신 후 리스폰스를 위한 요소들을 가지고있는다.
            resultBody = EntityUtils.toString(httpResponse.getEntity());
            headers = httpResponse.getAllHeaders();
            statusCode = httpResponse.getStatusLine().getStatusCode();

            //프락시 통신 후 생성 또는 수정된 구독 아이디를 알아낸다.
            String result_user_type = null;
            String result = null;
            Map map;
            Header[] locations;
            Header location;
            String value;
            List<Map> subscriptions;
            switch (command) {
                case "transferBundle":
                    if (httpResponse.getStatusLine().getStatusCode() == 201) {
                        result_user_type = "CREATE";
                        locations = httpResponse.getHeaders("location");
                        location = locations[0];
                        value = location.getValue();
                        result = getSubscriptionsAfterIntercept(organization, value.substring(value.indexOf("/1.0/kb/")));
                        map = JsonUtils.unmarshal(result);

                        subscriptions = (List<Map>) map.get("subscriptions");
                        for (Map subscription : subscriptions) {
                            createdSubscriptions.add(subscription);
                        }
                    }
                    break;
                case "createSubscription":
                    if (httpResponse.getStatusLine().getStatusCode() == 201) {
                        result_user_type = "CREATE";
                        locations = httpResponse.getHeaders("location");
                        location = locations[0];
                        value = location.getValue();
                        result = getSubscriptionsAfterIntercept(organization, value.substring(value.indexOf("/1.0/kb/")));
                        map = JsonUtils.unmarshal(result);
                        createdSubscriptions.add(map);
                    }
                    break;
                case "updateSubscription":
                    if (httpResponse.getStatusLine().getStatusCode() == 200) {
                        result_user_type = "CHANGE";
                        result = resultBody;
                        map = JsonUtils.unmarshal(result);

                        //구독 변경일 경우에는, 변경 예약일 경우 변경전의 subscription plan_name 이 리턴된다.
                        //그러므로 원 요청의 plan_name 으로 교체하도록 한다.
                        map.put("planName", plan_names.get(0).toString());
                        createdSubscriptions.add(map);
                    } else {
                        throw new Exception("Failed to get subscription result AfterIntercept.");
                    }
                    break;
                case "createEntitlementWithAddOns":
                    if (httpResponse.getStatusLine().getStatusCode() == 201) {
                        result_user_type = "CREATE";
                        locations = httpResponse.getHeaders("location");
                        location = locations[0];
                        value = location.getValue();
                        result = getSubscriptionsAfterIntercept(organization, value.substring(value.indexOf("/1.0/kb/")));
                        map = JsonUtils.unmarshal(result);

                        subscriptions = (List<Map>) map.get("subscriptions");
                        for (Map subscription : subscriptions) {
                            createdSubscriptions.add(subscription);
                        }
                    }
                    break;
                case "createEntitlementsWithAddOns":
                    if (httpResponse.getStatusLine().getStatusCode() == 201) {
                        result_user_type = "CREATE";
                        locations = httpResponse.getHeaders("location");
                        location = locations[0];
                        value = location.getValue();
                        result = getSubscriptionsAfterIntercept(organization, value.substring(value.indexOf("/1.0/kb/")));
                        List<Map> bundles = JsonUtils.unmarshalToList(result);
                        for (Map bundle : bundles) {
                            subscriptions = (List<Map>) bundle.get("subscriptions");
                            for (Map subscription : subscriptions) {
                                createdSubscriptions.add(subscription);
                            }
                        }
                    }
                    break;
            }

            //subscriptionIds 마다, CREATE , CHANGE 이벤트를 생성한다.
            for (Map createdSubscription : createdSubscriptions) {
                String subscriptionId = createdSubscription.get("subscriptionId").toString();
                String plan_name = createdSubscription.get("planName").toString();
                String product_id = plan_name.substring(0, 14);

                //프로덕트 버젼 얻기
                ProductVersion currentVersion = productVersionService.getCurrentVersion(organization.getId(), product_id);

                SubscriptionEventsExt eventsExt = new SubscriptionEventsExt();
                eventsExt.setAccount_id(accountId);
                eventsExt.setAccount_record_id(account_record_id);
                eventsExt.setOrganization_id(organization.getId());
                eventsExt.setTenant_id(organization.getTenant_id());
                eventsExt.setTenant_record_id(tenant_record_id);
                eventsExt.setUser_type(result_user_type);
                eventsExt.setProduct_id(product_id);
                eventsExt.setVersion(currentVersion.getVersion());
                eventsExt.setPlan_name(plan_name);
                eventsExt.setSubscription_id(subscriptionId);

                subscriptionEventRepository.insert(eventsExt);
            }

        } catch (Exception ex) {
            ex.printStackTrace();

        } finally {
            //eventIds (REQUEST 이벤트 아이디들) 를 삭제한다.
            if (eventIds != null && !eventIds.isEmpty()) {
                for (Long eventId : eventIds) {
                    subscriptionEventRepository.delete(eventId);
                }
            }
            if (statusCode == 0) {
                statusCode = 400;
            }
            //transfer-encoding 을 제외한 헤더값을 카피한다.
            if (headers != null) {
                for (int i = 0; i < headers.length; i++) {
                    if (!"transfer-encoding".equals(headers[i].getName().toLowerCase())) {
                        response.setHeader(headers[i].getName(), headers[i].getValue());
                    }
                }
            }
            response.setStatus(statusCode);
            try {
                if (resultBody != null) {
                    response.getWriter().write(resultBody);
                }
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
    }

    /**
     * 서브스크립션 생성, 업데이트 후 변경 정보를 킬빌서버로부터 가져온다.
     *
     * @param organization
     * @param endPoint
     * @return
     * @throws Exception
     */
    private String getSubscriptionsAfterIntercept(Organization organization, String endPoint) throws Exception {
        ApplicationContext context = ApplicationContextRegistry.getApplicationContext();
        ConfigurationHelper configurationHelper = context.getBean(ConfigurationHelper.class);
        String tenant_api_key = organization.getTenant_api_key();
        String tenant_api_secret = organization.getTenant_api_secret();
        String kbusername = System.getProperty("killbill.user");
        String kbpassword = System.getProperty("killbill.password");
        String uri = System.getProperty("killbill.url") + endPoint;
        String method = "GET";

        String auth = kbusername + ":" + kbpassword;
        BASE64Encoder encoder = new BASE64Encoder();
        String encode = encoder.encode(auth.getBytes());

        Map headers = new HashMap();
        headers.put("Authorization", "Basic " + encode);
        headers.put("Content-Type", "application/json");
        headers.put("Accept", "application/json");
        headers.put("X-Killbill-CreatedBy", "uEngine");
        headers.put("X-Killbill-ApiKey", tenant_api_key);
        headers.put("X-Killbill-ApiSecret", tenant_api_secret);

        HttpResponse httpResponse = new HttpUtils().makeRequest(method, uri, null, headers);
        if (httpResponse.getStatusLine().getStatusCode() == 200) {
            return EntityUtils.toString(httpResponse.getEntity());
        } else {
            throw new Exception("Failed to get subscription result AfterIntercept.");
        }
    }

    /**
     * 킬빌 서버로 서브스크립션 생성 요청을 보낸다.
     *
     * @param request
     * @param organization
     * @param body
     * @return
     * @throws IOException
     */
    private HttpResponse sendKBRequest(HttpServletRequest request, Organization organization, String body) throws IOException {
        ApplicationContext context = ApplicationContextRegistry.getApplicationContext();
        ConfigurationHelper configurationHelper = context.getBean(ConfigurationHelper.class);
        String tenant_api_key = organization.getTenant_api_key();
        String tenant_api_secret = organization.getTenant_api_secret();
        String kbusername = System.getProperty("killbill.user");
        String kbpassword = System.getProperty("killbill.password");
        String uri = System.getProperty("killbill.url") + request.getRequestURI().replace("/rest/v1", "/1.0/kb");
        if (request.getQueryString() != null) {
            uri = uri + "?" + request.getQueryString();
        }
        String method = request.getMethod().toUpperCase();

        String auth = kbusername + ":" + kbpassword;
        BASE64Encoder encoder = new BASE64Encoder();
        String encode = encoder.encode(auth.getBytes());

        Map headers = new HashMap();
        headers.put("Authorization", "Basic " + encode);
        headers.put("Content-Type", "application/json");
        headers.put("Accept", "application/json");
        headers.put("X-Killbill-CreatedBy", "uEngine");
        headers.put("X-Killbill-ApiKey", tenant_api_key);
        headers.put("X-Killbill-ApiSecret", tenant_api_secret);

        return new HttpUtils().makeRequest(method, uri, body, headers);
    }

    private void doProxy(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ApplicationContext context = ApplicationContextRegistry.getApplicationContext();
        ProxyService proxyService = context.getBean(ProxyService.class);
        OrganizationService organizationService = context.getBean(OrganizationService.class);

        OrganizationRole role = organizationService.getOrganizationRole(request, "MEMBER");
        if (!role.getAccept()) {
            response.setStatus(401);
            return;
        }
        String tenant_api_key = role.getOrganization().getTenant_api_key();
        String tenant_api_secret = role.getOrganization().getTenant_api_secret();
        String kbusername = System.getProperty("killbill.user");
        String kbpassword = System.getProperty("killbill.password");

        String auth = kbusername + ":" + kbpassword;
        BASE64Encoder encoder = new BASE64Encoder();
        String encode = encoder.encode(auth.getBytes());

        Map requiredHeaders = new HashMap();
        requiredHeaders.put("Authorization", "Basic " + encode);
        requiredHeaders.put("X-Killbill-CreatedBy", "uEngine");
        requiredHeaders.put("X-Killbill-ApiKey", tenant_api_key);
        requiredHeaders.put("X-Killbill-ApiSecret", tenant_api_secret);

        String contentHeader = request.getHeader("Content-Type");
        if (!StringUtils.isEmpty(contentHeader)) {
            requiredHeaders.put("Content-Type", contentHeader);
        } else {
            requiredHeaders.put("Content-Type", "application/json");
        }

        String acceptHeader = request.getHeader("Accept");
        if (!StringUtils.isEmpty(acceptHeader)) {
            requiredHeaders.put("Accept", acceptHeader);
        } else {
            requiredHeaders.put("Accept", "application/json");
        }

        ProxyRequest proxyRequest = new ProxyRequest();
        proxyRequest.setRequest(request);
        proxyRequest.setResponse(response);

        proxyRequest.setHost(System.getProperty("killbill.url"));
        proxyRequest.setPath(request.getRequestURI().replace("/rest/v1", "/1.0/kb"));
        proxyRequest.setHeaders(requiredHeaders);

        proxyService.doProxy(proxyRequest);
    }

}
