package org.uengine.garuda.web.organization;

import org.opencloudengine.garuda.client.model.OauthUser;
import org.uengine.garuda.model.Authority;
import org.uengine.garuda.model.Organization;
import org.uengine.garuda.model.OrganizationEmail;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface OrganizationService {

    Organization createOrganization(Organization organization, OauthUser oauthUser);

    Organization updateOrganization(Organization organization);

    int deleteOrganization(String id);

    Organization selectById(String id);

    Organization selectByName(String name);

    Organization selectByApiKeyAndSecret(String tenant_api_key, String tenant_api_secret);

    List<Organization> selectByUserId(String user_id);

    Authority selectAuthorityByUserIdAndOrganizationId(String user_id, String organization_id);

    Authority selectAuthorityById(String id);

    Authority createAuthority(Authority authority);

    int deleteAuthority(String id);

    List<Authority> selectAuthorityByOrganizationId(String organization_id);

    List<OrganizationEmail> selectOrganizationEmailByOrganizationId(String organization_id);

    OrganizationEmail selectOrganizationEmailById(String id);

    OrganizationEmail createOrganizationEmail(OrganizationEmail organizationEmail);

    OrganizationEmail updateOrganizationEmail(OrganizationEmail organizationEmail);

    int clearDefaultOrganizationEmail(String organization_id);

    int deleteOrganizationEmail(String id);

    OrganizationRole getOrganizationRole(HttpServletRequest request, String role);
}
