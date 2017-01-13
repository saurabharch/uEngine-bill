package org.uengine.garuda.killbill;

import org.opencloudengine.garuda.util.ApplicationContextRegistry;
import org.springframework.context.ApplicationContext;
import org.uengine.garuda.proxy.ProxyRequest;
import org.uengine.garuda.proxy.ProxyService;
import org.uengine.garuda.web.configuration.ConfigurationHelper;
import org.uengine.garuda.web.organization.OrganizationRole;
import org.uengine.garuda.web.organization.OrganizationService;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.jstl.core.Config;
import java.io.IOException;

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

        ApplicationContext context = ApplicationContextRegistry.getApplicationContext();
        ProxyService proxyService = context.getBean(ProxyService.class);
        OrganizationService organizationService = context.getBean(OrganizationService.class);
        ConfigurationHelper configurationHelper = context.getBean(ConfigurationHelper.class);

        OrganizationRole role = organizationService.getOrganizationRole(request, "MEMBER");
        if(!role.getAccept()){
            response.sendError(401);
            return;
        }

        ProxyRequest proxyRequest = new ProxyRequest();
        proxyRequest.setRequest(request);
        proxyRequest.setResponse(response);
        proxyRequest.setHost("http://" + configurationHelper.get("killbill.host") + ":" + configurationHelper.get("killbill.port"));
        proxyRequest.setPath(request.getPathInfo().replace("/rest/v1", "/1.0/kb"));

        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "POST, GET, DELETE, PUT");
        response.setHeader("Access-Control-Max-Age", "3600");
        response.setHeader("Access-Control-Allow-Headers", "x-requested-with, origin, content-type, accept, " +
                "management-key, management-secret, client-key, client-secret");
        chain.doFilter(req, res);
    }

    @Override
    public void destroy() {

    }
}
