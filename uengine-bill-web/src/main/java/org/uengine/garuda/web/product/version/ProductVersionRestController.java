package org.uengine.garuda.web.product.version;

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
import org.uengine.garuda.model.ProductVersion;
import org.uengine.garuda.util.ExceptionUtils;
import org.uengine.garuda.web.organization.OrganizationRole;
import org.uengine.garuda.web.organization.OrganizationService;
import org.uengine.garuda.web.product.ProductService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * Created by uengine on 2017. 1. 11..
 */

@Controller
@RequestMapping("/rest/v1")
public class ProductVersionRestController {

    @Autowired
    @Qualifier("config")
    private Properties config;

    @Autowired
    private OrganizationService organizationService;

    @Autowired
    private ProductVersionService productVersionService;

    @Autowired
    private ProductService productService;

    @RequestMapping(value = "/product/{id}/version", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<List<Map>> getProductVersions(HttpServletRequest request,
                                                        HttpServletResponse response,
                                                        @PathVariable("id") String id) {
        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.MEMBER);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            Organization organization = role.getOrganization();
            Product product = productService.selectProductById(organization.getId(), id);
            if (product == null) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }
            List<Map> list = productVersionService.listVersionExcludePlans(organization.getId(), id);
            return new ResponseEntity<>(list, HttpStatus.OK);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }

    @RequestMapping(value = "/product/{id}/version/{version}", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<ProductVersion> getProductVersion(HttpServletRequest request,
                                                            HttpServletResponse response,
                                                            @PathVariable("id") String id,
                                                            @PathVariable("version") Long version) {
        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.MEMBER);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            Organization organization = role.getOrganization();
            ProductVersion productVersion = productVersionService.getVersion(organization.getId(), id, version);
            if (productVersion == null) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            return new ResponseEntity<>(productVersion, HttpStatus.OK);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }

    @RequestMapping(value = "/product/{id}/version/current", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<ProductVersion> getCurrentProductVersion(HttpServletRequest request,
                                                                   HttpServletResponse response,
                                                                   @PathVariable("id") String id) {
        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.MEMBER);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            Organization organization = role.getOrganization();
            ProductVersion productVersion = productVersionService.getCurrentVersion(organization.getId(), id);
            if (productVersion == null) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            return new ResponseEntity<>(productVersion, HttpStatus.OK);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }


    @RequestMapping(value = "/product/{id}/version", method = RequestMethod.POST)
    public ResponseEntity<Void> createProductVersion(HttpServletRequest request,
                                                     HttpServletResponse response,
                                                     @RequestBody ProductVersion productVersion,
                                                     @PathVariable("id") String id,
                                                     UriComponentsBuilder ucBuilder) {

        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.ADMIN);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            Organization organization = role.getOrganization();
            Product product = productService.selectProductById(organization.getId(), id);
            if (product == null) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            ProductVersion createdVersion = productVersionService.createVersion(organization.getId(), id, productVersion);

            HttpHeaders headers = new HttpHeaders();
            headers.setLocation(ucBuilder.path("/rest/v1/product/{id}/version/{version}").buildAndExpand(id, createdVersion.getVersion()).toUri());
            return new ResponseEntity<>(headers, HttpStatus.CREATED);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }

    @RequestMapping(value = "/product/{id}/version/{version}", method = RequestMethod.PUT)
    public ResponseEntity<ProductVersion> updateProductVersion(HttpServletRequest request,
                                                               HttpServletResponse response,
                                                               @PathVariable("id") String id,
                                                               @PathVariable("version") Long version,
                                                               @RequestBody ProductVersion productVersion) {

        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.ADMIN);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }
            Organization organization = role.getOrganization();
            ProductVersion currentVersion = productVersionService.getVersion(organization.getId(), id, version);
            if (currentVersion == null) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            currentVersion = productVersionService.updateVersion(organization.getId(), id, version, productVersion);
            return new ResponseEntity<>(currentVersion, HttpStatus.OK);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }

    @RequestMapping(value = "/product/{id}/version/{version}", method = RequestMethod.DELETE)
    public ResponseEntity<Void> deleteProductVersion(HttpServletRequest request,
                                                     HttpServletResponse response,
                                              @PathVariable("id") String id,
                                              @PathVariable("version") Long version) {

        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.ADMIN);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            Organization organization = role.getOrganization();
            ProductVersion currentVersion = productVersionService.getVersion(organization.getId(), id, version);
            if (currentVersion == null) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            productVersionService.deleteVersion(organization.getId(), id, version);

            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }

}
