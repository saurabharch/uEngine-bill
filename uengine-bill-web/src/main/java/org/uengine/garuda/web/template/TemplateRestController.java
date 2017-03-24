package org.uengine.garuda.web.template;

import com.google.common.io.CharStreams;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.UriComponentsBuilder;
import org.uengine.garuda.authentication.AuthenticationService;
import org.uengine.garuda.model.Organization;
import org.uengine.garuda.model.Product;
import org.uengine.garuda.model.Template;
import org.uengine.garuda.util.ExceptionUtils;
import org.uengine.garuda.web.organization.OrganizationRole;
import org.uengine.garuda.web.organization.OrganizationService;
import org.uengine.garuda.web.product.ProductService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

/**
 * Created by uengine on 2017. 1. 11..
 */

@Controller
@RequestMapping("/rest/v1")
public class TemplateRestController {

    @Autowired
    @Qualifier("config")
    private Properties config;

    @Autowired
    private OrganizationService organizationService;

    @Autowired
    private TemplateService templateService;

    @RequestMapping(value = "/template", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<Map> getAllTemplate(HttpServletRequest request,
                                              HttpServletResponse response) {
        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.MEMBER);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            Organization organization = role.getOrganization();
            Map map = templateService.selectByOrgId(organization.getId());
            return new ResponseEntity<>(map, HttpStatus.OK);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }

    @RequestMapping(value = "/template/{notification_type}", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<Map> getTemplateByType(HttpServletRequest request,
                                                 HttpServletResponse response,
                                                 @PathVariable("notification_type") String notification_type) {
        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.MEMBER);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            Organization organization = role.getOrganization();
            Map map = templateService.selectByOrgIdAndType(organization.getId(), notification_type);
            return new ResponseEntity<>(map, HttpStatus.OK);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }

    @RequestMapping(value = "/template/{notification_type}", method = RequestMethod.DELETE)
    public ResponseEntity<Void> deleteTemplateByType(HttpServletRequest request,
                                                     HttpServletResponse response,
                                                     @PathVariable("notification_type") String notification_type) {

        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.ADMIN);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            Organization organization = role.getOrganization();
            templateService.deleteByOrgIdAndType(organization.getId(), notification_type);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }

    @RequestMapping(value = "/template/{notification_type}/{locale}", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<Template> getTemplateByTypeAndLocale(HttpServletRequest request,
                                                               HttpServletResponse response,
                                                               @PathVariable("notification_type") String notification_type,
                                                               @PathVariable("locale") String locale) {
        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.MEMBER);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            Organization organization = role.getOrganization();
            Template template = templateService.selectByOrgIdAndTypeAndLocale(organization.getId(), notification_type, locale);
            if(template == null){
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }
            return new ResponseEntity<>(template, HttpStatus.OK);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }

    @RequestMapping(value = "/template/{notification_type}/{locale}", method = RequestMethod.DELETE)
    public ResponseEntity<Void> deleteTemplateByTypeAndLocale(HttpServletRequest request,
                                                              HttpServletResponse response,
                                                              @PathVariable("notification_type") String notification_type,
                                                              @PathVariable("locale") String locale) {

        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.ADMIN);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            Organization organization = role.getOrganization();

            Template template = templateService.selectByOrgIdAndTypeAndLocale(organization.getId(), notification_type, locale);
            if(template == null){
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            templateService.deleteByOrgIdAndTypeAndLocale(organization.getId(), notification_type, locale);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }

    @RequestMapping(value = "/template/{notification_type}/{locale}", method = RequestMethod.POST)
    public ResponseEntity<Void> createTemplate(HttpServletRequest request,
                                               HttpServletResponse response,
                                               @PathVariable("notification_type") String notification_type,
                                               @PathVariable("locale") String locale,
                                               @RequestBody Template template, UriComponentsBuilder ucBuilder) {

        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.ADMIN);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }
            templateService.insertTemplate(role.getOrganization(), notification_type, locale, template);

            HttpHeaders headers = new HttpHeaders();
            headers.setLocation(ucBuilder.path("/rest/v1/template/{notification_type}/{locale}")
                    .buildAndExpand(notification_type, locale).toUri());
            return new ResponseEntity<>(headers, HttpStatus.CREATED);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }

    @RequestMapping(value = "/template/{notification_type}/{locale}", method = RequestMethod.PUT)
    public ResponseEntity<Template> setDefaultTemplate(HttpServletRequest request,
                                                       HttpServletResponse response,
                                                       @PathVariable("notification_type") String notification_type,
                                                       @PathVariable("locale") String locale) {

        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.ADMIN);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }
            Organization organization = role.getOrganization();
            Template template = templateService.selectByOrgIdAndTypeAndLocale(organization.getId(), notification_type, locale);
            if(template == null){
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            template = templateService.setDefaultTemplate(organization.getId(), notification_type, locale);

            return new ResponseEntity<>(template, HttpStatus.OK);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }
}
