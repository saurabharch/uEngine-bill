package org.uengine.garuda.web.organization;

import org.opencloudengine.garuda.client.model.OauthUser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.uengine.garuda.authentication.AuthInformation;
import org.uengine.garuda.authentication.AuthenticationService;
import org.uengine.garuda.common.exception.ServiceException;
import org.uengine.garuda.killbill.KBRepository;
import org.uengine.garuda.killbill.KBServiceFactory;
import org.uengine.garuda.killbill.api.model.Tenant;
import org.uengine.garuda.model.Authority;
import org.uengine.garuda.model.Organization;
import org.uengine.garuda.model.OrganizationEmail;
import org.uengine.garuda.util.StringUtils;
import org.uengine.garuda.web.system.UserService;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Service
public class OrganizationServiceImpl implements OrganizationService {

    @Autowired
    @Qualifier("config")
    private Properties config;

    @Autowired
    private OrganizationRepository organizationRepository;

    @Autowired
    private KBRepository kbRepository;

    @Autowired
    private AuthenticationService authenticationService;

    @Autowired
    private KBServiceFactory killbillServiceFactory;

    private Logger logger = LoggerFactory.getLogger(OrganizationService.class);

    /**
     * 조직을 생성한다.
     *
     * @param organization Organization
     * @return
     */
    @Override
    public Organization createOrganization(Organization organization, OauthUser oauthUser) {

        logger.info("Start to create organization {}", organization.getName());

        String name = organization.getName();
        if (StringUtils.isEmpty(name)) {
            throw new ServiceException("organization name is required");
        }

        //킬빌 테넌트를 생성한다.
        Tenant tenant = new Tenant();
        String key = UUID.randomUUID().toString();
        tenant.setApiSecret(key);
        tenant.setApiKey(key);
        tenant.setExternalKey(key);
        Tenant createdTenant = killbillServiceFactory.apiClient().tenantApi().createTenant(tenant);

        //조직을 생성한다.
        organization.setTenant_id(createdTenant.getTenantId());
        organization.setTenant_api_key(tenant.getApiKey());
        organization.setTenant_api_secret(tenant.getApiSecret());
        organization.setTenant_external_key(tenant.getExternalKey());
        organization.setIs_active("Y");
        Organization createdOrganization = organizationRepository.insert(organization);

        //요청자를 ADMIN 으로 Authority 를 생성한다.
        Authority authority = new Authority();
        authority.setOrganization_id(createdOrganization.getId());
        authority.setUser_id(oauthUser.get_id());
        authority.setUser_name(oauthUser.getUserName());
        authority.setRole(OrganizationRole.ADMIN);
        organizationRepository.insertAuthority(authority);

        //요청자의 이메일로 OrganizationEmail 을 생성한다.
        if (oauthUser.containsKey("email")) {
            OrganizationEmail organizationEmail = new OrganizationEmail();
            organizationEmail.setOrganization_id(createdOrganization.getId());
            organizationEmail.setEmail(oauthUser.get("email").toString());
            organizationEmail.setIs_active("Y");
            organizationEmail.setIs_default("Y");
            organizationRepository.insertOrganizationEmail(organizationEmail);
        }

        logger.info("Success to create organization {}", organization.getName());

        return createdOrganization;
    }

    @Override
    public Organization updateOrganization(Organization organization) {
        return organizationRepository.update(organization);
    }

    @Override
    public int deleteOrganization(String id) {
        Organization organization = this.selectById(id);

        //구독건이 남아있다면 삭제 불가능
        Long count = kbRepository.subscriptionCountByTenantId(organization.getTenant_id());
        if (count != null && count > 0) {
            logger.error("Failed to delete organization {}", id);
            throw new ServiceException("One or more subscriptions are exist. : " + count);
        }
        return organizationRepository.delete(id);
    }

    @Override
    public Organization selectById(String id) {
        return organizationRepository.selectById(id);
    }

    @Override
    public Organization selectByName(String name) {
        return organizationRepository.selectByName(name);
    }

    @Override
    public Organization selectByApiKeyAndSecret(String tenant_api_key, String tenant_api_secret) {
        return organizationRepository.selectByApiKeyAndSecret(tenant_api_key, tenant_api_secret);
    }

    @Override
    public List<Organization> selectByUserId(String user_id) {
        return organizationRepository.selectByUserId(user_id);
    }

    @Override
    public Authority selectAuthorityByUserIdAndOrganizationId(String user_id, String organization_id) {
        return organizationRepository.selectAuthorityByUserIdAndOrganizationId(user_id, organization_id);
    }

    @Override
    public Authority selectAuthorityById(String id) {
        return organizationRepository.selectAuthorityById(id);
    }

    @Override
    public Authority createAuthority(Authority authority) {
        return organizationRepository.insertAuthority(authority);
    }

    @Override
    public int deleteAuthority(String id) {
        return organizationRepository.deleteAuthority(id);
    }

    @Override
    public List<Authority> selectAuthorityByOrganizationId(String organization_id) {
        return organizationRepository.selectAuthorityByOrganizationId(organization_id);
    }

    @Override
    public List<OrganizationEmail> selectOrganizationEmailByOrganizationId(String organization_id) {
        return organizationRepository.selectOrganizationEmailByOrganizationId(organization_id);
    }

    @Override
    public OrganizationEmail selectOrganizationEmailById(String id) {
        return organizationRepository.selectOrganizationEmailById(id);
    }

    /**
     * 조직 이메일을 생성한다.
     *
     * @param organizationEmail
     * @return
     */
    @Override
    public OrganizationEmail createOrganizationEmail(OrganizationEmail organizationEmail) {
        if ("Y".equals(organizationEmail.getIs_default())) {
            this.clearDefaultOrganizationEmail(organizationEmail.getOrganization_id());
        } else {
            organizationEmail.setIs_default("N");
        }

        //TODO 조직 이메일 등록 이전에, 고의적 타인의 이메일 등록방지를 위해 이메일 컨펌 절차를 수행할 것.
        if (StringUtils.isEmpty(organizationEmail.getIs_active())) {
            organizationEmail.setIs_active("Y");
        }
        return organizationRepository.insertOrganizationEmail(organizationEmail);
    }

    /**
     * 조직 이메일을 업데이트 한다.
     *
     * @param organizationEmail
     * @return
     */
    @Override
    public OrganizationEmail updateOrganizationEmail(OrganizationEmail organizationEmail) {
        if ("Y".equals(organizationEmail.getIs_default())) {
            this.clearDefaultOrganizationEmail(organizationEmail.getOrganization_id());
        } else {
            organizationEmail.setIs_default("N");
        }
        return organizationRepository.updateOrganizationEmail(organizationEmail);
    }

    /**
     * 디폴트 조직 이메일을 초기화한다.
     *
     * @param organization_id
     * @return
     */
    @Override
    public int clearDefaultOrganizationEmail(String organization_id) {
        return organizationRepository.clearDefaultOrganizationEmail(organization_id);
    }

    @Override
    public int deleteOrganizationEmail(String id) {
        return organizationRepository.deleteOrganizationEmail(id);
    }

    private Map<String, String> getHeaders(HttpServletRequest request) {
        Enumeration<String> headerNames = request.getHeaderNames();
        List<String> list = Collections.list(headerNames);
        Map<String, String> map = new HashMap();
        for (int i = 0; i < list.size(); i++) {
            String name = list.get(i);
            map.put(name.toLowerCase(), request.getHeader(name));
        }
        return map;
    }

    /**
     * http 헤더의 토큰값과 organization id 로 접근 가능 롤을 판별한다.
     *
     * @param request
     * @return
     */
    @Override
    public OrganizationRole getOrganizationRole(HttpServletRequest request, String role) {
        OrganizationRole orgRole = new OrganizationRole();

        Map<String, String> headers = this.getHeaders(request);
        String organization_id = headers.get(config.getProperty("header.organization"));

        AuthInformation authInformation = authenticationService.validateRequest(
                request,
                config.getProperty("header.authorization"),
                AuthInformation.LOCATION_HEADER,
                AuthInformation.TOKEN_TYPE_JWT);

        orgRole.setRole(role);

        try {
            //oauthUser 가 없으면 fail
            if (authInformation.getOauthUser() == null) {
                orgRole.setAccept(false);
                return orgRole;
            } else {
                orgRole.setToken(authInformation.getToken());
            }


            //organization_id 가 없고 ANY 일 경우 success 리턴
            //organization_id 가 없고 그 외의 경우 fail
            if (StringUtils.isEmpty(organization_id)) {
                if (OrganizationRole.ANY.equals(role)) {
                    orgRole.setAccept(true);
                    return orgRole;
                } else {
                    orgRole.setAccept(false);
                    return orgRole;
                }
            }

            //조직이 없을 경우 리턴
            Organization organization = organizationRepository.selectById(organization_id);
            if (organization == null) {
                orgRole.setAccept(false);
                return orgRole;
            } else {
                orgRole.setOrganization(organization);
            }

            Authority authority = organizationRepository.selectAuthorityByUserIdAndOrganizationId(authInformation.getOauthUser().get_id(), organization_id);
            //authority 가 없을 경우 fail
            if (authority == null) {
                orgRole.setAccept(false);
                return orgRole;
            }

            //authority 와 role 규칙이 틀리면 fail
            if (OrganizationRole.ADMIN.equals(role)) {
                if (OrganizationRole.ADMIN.equals(authority.getRole())) {
                    orgRole.setAccept(true);
                    return orgRole;
                }
            }
            if (OrganizationRole.MEMBER.equals(role)) {
                if (OrganizationRole.ADMIN.equals(authority.getRole()) || OrganizationRole.MEMBER.equals(authority.getRole())) {
                    orgRole.setAccept(true);
                    return orgRole;
                }
            }
            if (OrganizationRole.ANY.equals(role)) {
                orgRole.setAccept(true);
                return orgRole;
            }

            orgRole.setAccept(false);
            return orgRole;
        } catch (Exception ex) {
            ex.printStackTrace();
            orgRole.setAccept(false);
            return orgRole;
        }
    }
}
