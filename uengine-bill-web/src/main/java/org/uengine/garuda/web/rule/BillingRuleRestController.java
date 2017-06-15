package org.uengine.garuda.web.rule;

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
import org.uengine.garuda.killbill.KBService;
import org.uengine.garuda.model.Authority;
import org.uengine.garuda.model.BillingRule;
import org.uengine.garuda.model.Organization;
import org.uengine.garuda.model.OrganizationEmail;
import org.uengine.garuda.util.ExceptionUtils;
import org.uengine.garuda.util.JsonUtils;
import org.uengine.garuda.web.organization.OrganizationRole;
import org.uengine.garuda.web.organization.OrganizationService;
import org.uengine.garuda.web.system.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;
import java.util.Properties;

/**
 * Created by uengine on 2017. 1. 11..
 */

@Controller
@RequestMapping("/rest/v1")
public class BillingRuleRestController {

    @Autowired
    @Qualifier("config")
    private Properties config;

    @Autowired
    private OrganizationService organizationService;

    @Autowired
    private BillingRuleRepository billingRuleRepository;

    @Autowired
    private KBService kbService;

    @Autowired
    AuthenticationService authenticationService;

    @RequestMapping(value = "/rule", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<Map> getRule(HttpServletRequest request,
                                       HttpServletResponse response) {
        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.MEMBER);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            BillingRule rule = billingRuleRepository.selectRuleByOrgId(role.getOrganization().getId());
            if (rule == null) {
                rule = new BillingRule();
                rule.setOrganization_id(role.getOrganization().getId());
                rule.setTenant_id(role.getOrganization().getTenant_id());
                rule.setRule(billingRuleRepository.getDefaultBillingRule());
                billingRuleRepository.insertRule(rule);
            }
            Map map = JsonUtils.marshal(rule.getRule());

            return new ResponseEntity<>(map, HttpStatus.OK);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }

    @RequestMapping(value = "/rule/default", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<Map> getDefaultRule(HttpServletRequest request,
                                              HttpServletResponse response) {
        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.MEMBER);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            Map map = JsonUtils.marshal(billingRuleRepository.getDefaultBillingRule());
            return new ResponseEntity<>(map, HttpStatus.OK);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }

    @RequestMapping(value = "/rule", method = RequestMethod.POST)
    public ResponseEntity<Void> uploadRule(HttpServletRequest request,
                                           HttpServletResponse response,
                                           @RequestBody Map map, UriComponentsBuilder ucBuilder) {

        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.ADMIN);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            BillingRule rule = billingRuleRepository.selectRuleByOrgId(role.getOrganization().getId());
            rule.setRule(JsonUtils.marshal(map));

            billingRuleRepository.updateRule(rule);

            HttpHeaders headers = new HttpHeaders();
            headers.setLocation(ucBuilder.path("/rest/v1/rule").buildAndExpand().toUri());
            return new ResponseEntity<>(headers, HttpStatus.CREATED);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }

    @RequestMapping(value = "/retry", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<Map> getRetry(HttpServletRequest request,
                                        HttpServletResponse response) {
        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.MEMBER);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            Map retry = kbService.getRetry(role.getOrganization().getTenant_api_key(),
                    role.getOrganization().getTenant_api_secret());

            return new ResponseEntity<>(retry, HttpStatus.OK);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }

    @RequestMapping(value = "/retry", method = RequestMethod.POST)
    public ResponseEntity<Void> uploadRetry(HttpServletRequest request,
                                            HttpServletResponse response,
                                            @RequestBody Map map, UriComponentsBuilder ucBuilder) {

        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.ADMIN);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            kbService.uploadRetry(role.getOrganization().getTenant_api_key(),
                    role.getOrganization().getTenant_api_secret(),
                    JsonUtils.marshal(map));

            HttpHeaders headers = new HttpHeaders();
            headers.setLocation(ucBuilder.path("/rest/v1/retry").buildAndExpand().toUri());
            return new ResponseEntity<>(headers, HttpStatus.CREATED);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }
}
