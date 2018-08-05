package org.uengine.garuda.web.organization;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.util.UriComponentsBuilder;
import org.uengine.garuda.authentication.AuthInformation;
import org.uengine.garuda.authentication.AuthenticationService;
import org.uengine.garuda.model.Authority;
import org.uengine.garuda.model.Organization;
import org.uengine.garuda.model.OrganizationEmail;
import org.uengine.garuda.util.ExceptionUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Properties;

/**
 * Created by uengine on 2017. 1. 11..
 */

@Controller
@RequestMapping("/rest/v1")
public class OrganizationRestController {

    @Autowired
    @Qualifier("config")
    private Properties config;

    @Autowired
    private OrganizationService organizationService;

    @Autowired
    AuthenticationService authenticationService;

    @RequestMapping(value = "/organization", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<List<Organization>> listOrganization(HttpServletRequest request, HttpServletResponse response) {

        try {
            AuthInformation authInformation = authenticationService.validateRequest(
                    request,
                    config.getProperty("header.authorization"),
                    AuthInformation.LOCATION_HEADER,
                    AuthInformation.TOKEN_TYPE_JWT);

            if (authInformation.getOauthUser() == null) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }
            List<Organization> organizations = organizationService.selectByUserId(authInformation.getOauthUser().getUserName());
            if (organizations.isEmpty()) {
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
            }
            return new ResponseEntity<>(organizations, HttpStatus.OK);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }

    @RequestMapping(value = "/organization/{id}", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<Organization> getOrganization(HttpServletRequest request,
                                                        HttpServletResponse response,
                                                        @PathVariable("id") String id) {
        try {
            AuthInformation authInformation = authenticationService.validateRequest(
                    request,
                    config.getProperty("header.authorization"),
                    AuthInformation.LOCATION_HEADER,
                    AuthInformation.TOKEN_TYPE_JWT);
            if (authInformation.getOauthUser() == null) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }
            Authority authority = organizationService.selectAuthorityByUserIdAndOrganizationId(authInformation.getOauthUser().getUserName(), id);
            if (authority == null) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            Organization organization = organizationService.selectById(id);
            if (organization == null) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }
            return new ResponseEntity<>(organization, HttpStatus.OK);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }

    @RequestMapping(value = "/organization", method = RequestMethod.POST)
    public ResponseEntity<Void> createOrganization(HttpServletRequest request,
                                                   HttpServletResponse response,
                                                   @RequestBody Organization organization, UriComponentsBuilder ucBuilder) {

        try {
            AuthInformation authInformation = authenticationService.validateRequest(
                    request,
                    config.getProperty("header.authorization"),
                    AuthInformation.LOCATION_HEADER,
                    AuthInformation.TOKEN_TYPE_JWT);
            if (authInformation.getOauthUser() == null) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }
            //TODO 사용자가 ADMIN 권한이 있는 조직 중 같은 이름을 사용불가.
            Organization existOrganization = organizationService.selectByName(organization.getName());
            if (existOrganization != null) {
                return new ResponseEntity<>(HttpStatus.CONFLICT);
            }

            Organization createdOrganization = organizationService.createOrganization(organization, authInformation.getOauthUser());

            HttpHeaders headers = new HttpHeaders();
            headers.setLocation(ucBuilder.path("/rest/v1/organization/{_id}").buildAndExpand(createdOrganization.getId()).toUri());
            return new ResponseEntity<>(headers, HttpStatus.CREATED);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }

    @RequestMapping(value = "/organization/{id}", method = RequestMethod.PUT)
    public ResponseEntity<Organization> updateOrganization(HttpServletRequest request,
                                                           HttpServletResponse response,
                                                           @PathVariable("id") String id, @RequestBody Organization organization) {

        try {
            AuthInformation authInformation = authenticationService.validateRequest(
                    request,
                    config.getProperty("header.authorization"),
                    AuthInformation.LOCATION_HEADER,
                    AuthInformation.TOKEN_TYPE_JWT);
            if (authInformation.getOauthUser() == null) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }
            Authority authority = organizationService.selectAuthorityByUserIdAndOrganizationId(authInformation.getOauthUser().getUserName(), id);
            if (authority == null || !OrganizationRole.ADMIN.equals(authority.getRole())) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            Organization currentOrganization = organizationService.selectById(id);
            if (currentOrganization == null) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            Organization existOrganization = organizationService.selectByName(organization.getName());
            if (existOrganization != null && !existOrganization.getId().equals(id)) {
                return new ResponseEntity<>(HttpStatus.CONFLICT);
            }

            organization.setId(currentOrganization.getId());
            currentOrganization = organizationService.updateOrganization(organization);

            return new ResponseEntity<>(currentOrganization, HttpStatus.OK);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }

    @RequestMapping(value = "/organization/{id}", method = RequestMethod.DELETE)
    public ResponseEntity<Void> deleteOrganization(HttpServletRequest request,
                                                   HttpServletResponse response,
                                                   @PathVariable("id") String id) {

        try {
            AuthInformation authInformation = authenticationService.validateRequest(
                    request,
                    config.getProperty("header.authorization"),
                    AuthInformation.LOCATION_HEADER,
                    AuthInformation.TOKEN_TYPE_JWT);
            if (authInformation.getOauthUser() == null) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }
            Authority authority = organizationService.selectAuthorityByUserIdAndOrganizationId(authInformation.getOauthUser().getUserName(), id);
            if (authority == null || !OrganizationRole.ADMIN.equals(authority.getRole())) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            Organization currentOrganization = organizationService.selectById(id);
            if (currentOrganization == null) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            organizationService.deleteOrganization(id);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }

    @RequestMapping(value = "/organizationEmail", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<List<OrganizationEmail>> getOrganizationEmails(HttpServletRequest request,
                                                                         HttpServletResponse response) {
        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.MEMBER);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            List<OrganizationEmail> emails = organizationService.selectOrganizationEmailByOrganizationId(role.getOrganization().getId());
            if (emails == null) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }
            return new ResponseEntity<>(emails, HttpStatus.OK);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }

    @RequestMapping(value = "/organizationEmail", method = RequestMethod.POST)
    public ResponseEntity<Void> createOrganizationEmails(HttpServletRequest request,
                                                         HttpServletResponse response,
                                                         @RequestBody OrganizationEmail email, UriComponentsBuilder ucBuilder) {

        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.ADMIN);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }
            Organization organization = role.getOrganization();
            //조직 이메일중 같은 주소는 사용 불가.
            boolean isConflict = false;
            List<OrganizationEmail> emails = organizationService.selectOrganizationEmailByOrganizationId(organization.getId());
            for (OrganizationEmail organizationEmail : emails) {
                if (organizationEmail.getEmail().equals(email.getEmail())) {
                    isConflict = true;
                }
            }
            if (isConflict) {
                return new ResponseEntity<>(HttpStatus.CONFLICT);
            }

            email.setOrganization_id(organization.getId());
            OrganizationEmail createdEmail = organizationService.createOrganizationEmail(email);

            HttpHeaders headers = new HttpHeaders();
            headers.setLocation(ucBuilder.path("/rest/v1/organizationEmail/{id}").buildAndExpand(createdEmail.getId()).toUri());
            return new ResponseEntity<>(headers, HttpStatus.CREATED);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }

    @RequestMapping(value = "/organizationEmail/{id}", method = RequestMethod.PUT)
    public ResponseEntity<OrganizationEmail> updateOrganizationEmail(HttpServletRequest request,
                                                                HttpServletResponse response,
                                                                @PathVariable("id") String id, @RequestBody OrganizationEmail email) {

        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.ADMIN);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }
            Organization organization = role.getOrganization();

            OrganizationEmail currentEmail = organizationService.selectOrganizationEmailById(id);
            if (currentEmail == null) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            //조직 이메일중 같은 주소는 사용 불가.
            boolean isConflict = false;
            List<OrganizationEmail> emails = organizationService.selectOrganizationEmailByOrganizationId(organization.getId());
            for (OrganizationEmail organizationEmail : emails) {
                if (organizationEmail.getEmail().equals(email.getEmail()) && !organizationEmail.getId().equals(id)) {
                    isConflict = true;
                }
            }
            if (isConflict) {
                return new ResponseEntity<>(HttpStatus.CONFLICT);
            }

            //아이디와 조직 아이디를 부여하고 업데이트.
            email.setId(currentEmail.getId());
            email.setOrganization_id(organization.getId());
            currentEmail = organizationService.updateOrganizationEmail(email);

            return new ResponseEntity<>(currentEmail, HttpStatus.OK);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }

    @RequestMapping(value = "/organizationEmail/{id}", method = RequestMethod.DELETE)
    public ResponseEntity<Void> deleteOrganizationEmail(HttpServletRequest request,
                                                        HttpServletResponse response,
                                                        @PathVariable("id") String id) {

        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.ADMIN);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            OrganizationEmail currentEmail = organizationService.selectOrganizationEmailById(id);
            if (currentEmail == null) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            //디폴트 이메일은 삭제할 수 없다.
            if ("Y".equals(currentEmail.getIs_default())) {
                return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
            }

            organizationService.deleteOrganizationEmail(id);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }
}
