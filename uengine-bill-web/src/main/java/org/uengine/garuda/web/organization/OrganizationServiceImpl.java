package org.uengine.garuda.web.organization;

import org.opencloudengine.garuda.client.model.OauthUser;
import org.opencloudengine.garuda.util.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.uengine.garuda.common.exception.ServiceException;
import org.uengine.garuda.killbill.KBServiceFactory;
import org.uengine.garuda.killbill.api.model.Tenant;
import org.uengine.garuda.model.Authority;
import org.uengine.garuda.model.Organization;
import org.uengine.garuda.model.OrganizationEmail;
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
    private UserService userService;

    @Autowired
    private KBServiceFactory killbillServiceFactory;

    /**
     * 조직을 생성한다.
     * @param organization Organization
     * @return
     */
    @Override
    public Organization createOrganization(Organization organization) {
        String name = organization.getName();
        if(StringUtils.isEmpty(name)){
            throw new ServiceException("organization name is required");
        }
        Tenant tenant = new Tenant();
        String key = UUID.randomUUID().toString();
        tenant.setApiSecret(key);
        tenant.setApiKey(key);
        tenant.setExternalKey(key);

        Tenant created = killbillServiceFactory.apiClient().tenantApi().createTenant(tenant);

        organization.setTenant_id(created.getTenantId());
        organization.setTenant_api_key(created.getApiKey());
        organization.setTenant_api_secret(created.getApiSecret());
        organization.setTenant_external_key(created.getExternalKey());

        return organizationRepository.insert(organization);
    }

    @Override
    public Organization updateOrganization(Organization organization) {
        return organizationRepository.update(organization);
    }

    @Override
    public int deleteOrganization(String id) {
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

    @Override
    public OrganizationEmail insertOrganizationEmail(OrganizationEmail organizationEmail) {
        return organizationRepository.insertOrganizationEmail(organizationEmail);
    }

    @Override
    public OrganizationEmail updateOrganizationEmail(OrganizationEmail organizationEmail) {
        return organizationRepository.updateOrganizationEmail(organizationEmail);
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
     * @param request
     * @return
     */
    @Override
    public OrganizationRole getOrganizationRole(HttpServletRequest request, String role) {
        OrganizationRole orgRole = new OrganizationRole();

        Map<String, String> headers = this.getHeaders(request);
        String token = headers.get("authorization");
        String organization_id = headers.get("x-organization-id");

        orgRole.setRole(role);

        try{
            //토큰값이 없다면 fail
            if(StringUtils.isEmpty(token)){
                orgRole.setAccept(false);
                return orgRole;
            }else{
                orgRole.setToken(token);
            }

            //토큰 정보가 없다면 fail
            Map tokenInfo = userService.tokenInfo(token);
            if(tokenInfo == null){
                orgRole.setAccept(false);
                return orgRole;
            }else{
                orgRole.setToken(token);
            }

            //유저 정보를 얻어오지 못하면 fail
            String user_id = ((Map)tokenInfo.get("context")).get("userId").toString();
            OauthUser user = userService.selectByUserId(user_id);
            if(user == null){
                orgRole.setAccept(false);
                return orgRole;
            }else{
                orgRole.setOauthUser(user);
            }

            //organization_id 가 없고 ANY 일 경우 success 리턴
            //organization_id 가 없고 그 외의 경우 fail
            if(StringUtils.isEmpty(organization_id)){
                if(OrganizationRole.ANY.equals(role)){
                    orgRole.setAccept(true);
                    return orgRole;
                }else{
                    orgRole.setAccept(false);
                    return orgRole;
                }
            }

            //조직이 없을 경우 리턴
            Organization organization = organizationRepository.selectById(organization_id);
            if(organization == null){
                orgRole.setAccept(false);
                return orgRole;
            }else{
                orgRole.setOrganization(organization);
            }

            Authority authority = organizationRepository.selectAuthorityByUserIdAndOrganizationId(user_id, organization_id);
            //authority 가 없을 경우 fail
            if (authority == null){
                orgRole.setAccept(false);
                return orgRole;
            }

            //authority 와 role 규칙이 틀리면 fail
            if(OrganizationRole.ADMIN.equals(role)){
                if(OrganizationRole.ADMIN.equals(authority.getRole())){
                    orgRole.setAccept(true);
                    return orgRole;
                }
            }
            if(OrganizationRole.MEMBER.equals(role)){
                if(OrganizationRole.ADMIN.equals(authority.getRole()) || OrganizationRole.MEMBER.equals(authority.getRole())){
                    orgRole.setAccept(true);
                    return orgRole;
                }
            }
            if(OrganizationRole.ANY.equals(role)){
                orgRole.setAccept(true);
                return orgRole;
            }

            orgRole.setAccept(false);
            return orgRole;
        }catch (Exception ex){
            ex.printStackTrace();
            orgRole.setAccept(false);
            return orgRole;
        }
    }
}
