package org.uengine.garuda.killbill;

import org.opencloudengine.garuda.client.model.OauthUser;
import org.uengine.garuda.model.Authority;
import org.uengine.garuda.model.Organization;
import org.uengine.garuda.model.OrganizationEmail;
import org.uengine.garuda.web.organization.OrganizationRole;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

public interface KBService {

    void uploadRetry(String apiKey, String apiSecret, String retryJson);

    Map getRetry(String apiKey, String apiSecret);
}
