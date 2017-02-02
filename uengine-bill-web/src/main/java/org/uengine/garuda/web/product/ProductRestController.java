package org.uengine.garuda.web.product;

import org.opencloudengine.garuda.client.model.OauthUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.UriComponentsBuilder;
import org.uengine.garuda.authentication.AuthInformation;
import org.uengine.garuda.authentication.AuthenticationService;
import org.uengine.garuda.model.Authority;
import org.uengine.garuda.model.Organization;
import org.uengine.garuda.model.OrganizationEmail;
import org.uengine.garuda.model.Product;
import org.uengine.garuda.web.organization.OrganizationRole;
import org.uengine.garuda.web.organization.OrganizationService;
import org.uengine.garuda.web.system.UserService;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

/**
 * Created by uengine on 2017. 1. 11..
 */

@Controller
@RequestMapping("/rest/v1")
public class ProductRestController {

    @Autowired
    @Qualifier("config")
    private Properties config;

    @Autowired
    private OrganizationService organizationService;

    @Autowired
    private AuthenticationService authenticationService;

    @Autowired
    private ProductService productService;

    @RequestMapping(value = "/product/pagination", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<List<Product>> getProducts(HttpServletRequest request,
                                                     @RequestParam(defaultValue = "") String is_active,
                                                     @RequestParam(defaultValue = "0") Long offset,
                                                     @RequestParam(defaultValue = "100") Long limit) {
        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.MEMBER);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            Map map = productService.selectProductByCondition(role.getOrganization().getId(), is_active, null, offset, limit);
            List<Product> products = (List<Product>) map.get("list");
            if (products == null) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            HttpHeaders headers = new HttpHeaders();
            headers.add("x-uengine-pagination-maxnbrecords", map.get("max").toString());
            headers.add("x-uengine-pagination-currentoffset", map.get("offset").toString());
            headers.add("x-uengine-pagination-totalnbrecords", map.get("total").toString());

            return new ResponseEntity<>(products, headers, HttpStatus.OK);
        } catch (Exception ex) {
            ex.printStackTrace();
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value = "/product/search/{searchKey}", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<List<Product>> getProductsSearch(HttpServletRequest request,
                                                           @RequestParam(defaultValue = "") String is_active,
                                                           @PathVariable("searchKey") String searchKey,
                                                           @RequestParam(defaultValue = "0") Long offset,
                                                           @RequestParam(defaultValue = "100") Long limit) {
        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.MEMBER);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            Map map = productService.selectProductByCondition(role.getOrganization().getId(), is_active, searchKey, offset, limit);
            List<Product> products = (List<Product>) map.get("list");
            if (products == null) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            HttpHeaders headers = new HttpHeaders();
            headers.add("x-uengine-pagination-maxnbrecords", map.get("max").toString());
            headers.add("x-uengine-pagination-currentoffset", map.get("offset").toString());
            headers.add("x-uengine-pagination-totalnbrecords", map.get("total").toString());

            return new ResponseEntity<>(products, headers, HttpStatus.OK);
        } catch (Exception ex) {
            ex.printStackTrace();
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value = "/product", method = RequestMethod.POST)
    public ResponseEntity<Void> createProduct(HttpServletRequest request, @RequestBody Product product, UriComponentsBuilder ucBuilder) {

        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.ADMIN);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            Product createdProduct = productService.insertProduct(role.getOrganization(), product);

            HttpHeaders headers = new HttpHeaders();
            headers.setLocation(ucBuilder.path("/rest/v1/product/{id}").buildAndExpand(createdProduct.getId()).toUri());
            return new ResponseEntity<>(headers, HttpStatus.CREATED);
        } catch (Exception ex) {
            ex.printStackTrace();
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value = "/product/{id}", method = RequestMethod.PUT)
    public ResponseEntity<Product> updateProduct(HttpServletRequest request, @PathVariable("id") String id, @RequestBody Product product) {

        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.ADMIN);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }
            Organization organization = role.getOrganization();

            Product currentProduct = productService.selectProductById(organization.getId(), id);
            if (currentProduct == null) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            product.setId(id);
            currentProduct = productService.updateProductById(organization, product);
            return new ResponseEntity<>(currentProduct, HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value = "/product/{id}/active", method = RequestMethod.PUT)
    public ResponseEntity<Product> updateProduct(HttpServletRequest request, @PathVariable("id") String id, @RequestBody Map map) {

        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.ADMIN);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }
            Organization organization = role.getOrganization();

            Product currentProduct = productService.selectProductById(organization.getId(), id);
            if (currentProduct == null) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            if (!"Y".equals(map.get("is_active").toString()) && "!N".equals(map.get("is_active").toString())) {
                return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
            }

            currentProduct = productService.updateProductActiveById(currentProduct, map.get("is_active").toString());

            return new ResponseEntity<>(currentProduct, HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value = "/product/{id}", method = RequestMethod.DELETE)
    public ResponseEntity<Void> deleteProduct(HttpServletRequest request, @PathVariable("id") String id) {

        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.ADMIN);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            Organization organization = role.getOrganization();
            Product currentProduct = productService.selectProductById(organization.getId(), id);
            if (currentProduct == null) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            productService.deleteProductById(organization.getId(), id);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception ex) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }
}
