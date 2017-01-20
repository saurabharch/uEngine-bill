package org.uengine.garuda.killbill;

import org.springframework.context.ApplicationContext;
import org.uengine.garuda.proxy.ProxyRequest;
import org.uengine.garuda.proxy.ProxyService;
import org.uengine.garuda.util.ApplicationContextRegistry;
import org.uengine.garuda.util.StringUtils;
import org.uengine.garuda.web.configuration.ConfigurationHelper;
import org.uengine.garuda.web.organization.OrganizationRole;
import org.uengine.garuda.web.organization.OrganizationService;
import sun.misc.BASE64Encoder;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.jstl.core.Config;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

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
                "/rest/v1/usages"
        };

        boolean is_proxy = false;
        String requestURI = request.getRequestURI();
        for (int i = 0; i < proxyPaths.length; i++) {
            if (requestURI.startsWith(proxyPaths[i])) {
                is_proxy = true;
            }
        }

        //킬빌 rest uri 일 경우 프락시 통신을 한다.
        if (is_proxy) {
            ApplicationContext context = ApplicationContextRegistry.getApplicationContext();
            ProxyService proxyService = context.getBean(ProxyService.class);
            OrganizationService organizationService = context.getBean(OrganizationService.class);
            ConfigurationHelper configurationHelper = context.getBean(ConfigurationHelper.class);

            OrganizationRole role = organizationService.getOrganizationRole(request, "MEMBER");
            if (!role.getAccept()) {
                response.setStatus(401);
                return;
            }
            String tenant_api_key = role.getOrganization().getTenant_api_key();
            String tenant_api_secret = role.getOrganization().getTenant_api_secret();
            String kbusername = configurationHelper.get("killbill.user");
            String kbpassword = configurationHelper.get("killbill.password");

            String auth = kbusername + ":" + kbpassword;
            BASE64Encoder encoder = new BASE64Encoder();
            String encode = encoder.encode(auth.getBytes());

            Map requiredHeaders = new HashMap();
            requiredHeaders.put("Authorization", "Basic " + encode);
            requiredHeaders.put("Content-Type", "application/json");
            requiredHeaders.put("Accept", "application/json");
            requiredHeaders.put("X-Killbill-CreatedBy", "uEngine");
            requiredHeaders.put("X-Killbill-ApiKey", tenant_api_key);
            requiredHeaders.put("X-Killbill-ApiSecret", tenant_api_secret);

            ProxyRequest proxyRequest = new ProxyRequest();
            proxyRequest.setRequest(request);
            proxyRequest.setResponse(response);
            proxyRequest.setHost("http://" + configurationHelper.get("killbill.host") + ":" + configurationHelper.get("killbill.port"));
            proxyRequest.setPath(request.getRequestURI().replace("/rest/v1", "/1.0/kb"));
            proxyRequest.setHeaders(requiredHeaders);

            try{
                proxyService.doProxy(proxyRequest);
                return;
            }catch (Exception ex){
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
}
