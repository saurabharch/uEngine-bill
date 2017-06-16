package org.uengine.garuda.web.onetimebuy;

import com.google.common.io.CharStreams;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.UriComponentsBuilder;
import org.uengine.garuda.authentication.AuthenticationService;
import org.uengine.garuda.model.OneTimeBuy;
import org.uengine.garuda.model.Organization;
import org.uengine.garuda.model.Product;
import org.uengine.garuda.util.ExceptionUtils;
import org.uengine.garuda.web.organization.OrganizationRole;
import org.uengine.garuda.web.organization.OrganizationService;
import org.uengine.garuda.web.product.ProductService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Properties;

/**
 * Created by uengine on 2017. 1. 11..
 */

@Controller
@RequestMapping("/rest/v1")
public class OneTimeBuyRestController {

    @Autowired
    @Qualifier("config")
    private Properties config;

    @Autowired
    private OrganizationService organizationService;

    @Autowired
    private OneTimeBuyService oneTimeBuyService;

    @RequestMapping(value = "/onetimebuy", method = RequestMethod.POST)
    public ResponseEntity<List<OneTimeBuy>> createProduct(HttpServletRequest request,
                                                          HttpServletResponse response,
                                                          @RequestBody List<OneTimeBuyRequest> list,
                                                          @RequestParam(value = "accountId") String accountId,
                                                          @RequestParam(value = "requestedDate", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date requestedDate
    ) {

        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.ADMIN);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            List<OneTimeBuy> oneTimeBuyList = oneTimeBuyService.createOneTimeBuy(role.getOrganization(), list, accountId, requestedDate);
            return new ResponseEntity<>(oneTimeBuyList, HttpStatus.CREATED);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }

    @RequestMapping(value = "/onetimebuy/pagination", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<List<OneTimeBuy>> getProducts(HttpServletRequest request,
                                                        HttpServletResponse response,
                                                        @RequestParam(defaultValue = "0") Long offset,
                                                        @RequestParam(defaultValue = "100") Long limit) {
        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.MEMBER);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            Map map = oneTimeBuyService.selectByCondition(role.getOrganization().getId(), null, offset, limit);
            List<OneTimeBuy> oneTimeBuyList = (List<OneTimeBuy>) map.get("list");
            if (oneTimeBuyList == null) {
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
            }

            HttpHeaders headers = new HttpHeaders();
            headers.add("x-uengine-pagination-maxnbrecords", map.get("max").toString());
            headers.add("x-uengine-pagination-currentoffset", map.get("offset").toString());
            headers.add("x-uengine-pagination-totalnbrecords", map.get("total").toString());

            return new ResponseEntity<>(oneTimeBuyList, headers, HttpStatus.OK);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }

    @RequestMapping(value = "/onetimebuy/search/{searchKey}", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<List<OneTimeBuy>> getProductsSearch(HttpServletRequest request,
                                                              HttpServletResponse response,
                                                              @PathVariable("searchKey") String searchKey,
                                                              @RequestParam(defaultValue = "0") Long offset,
                                                              @RequestParam(defaultValue = "100") Long limit) {
        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.MEMBER);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            Map map = oneTimeBuyService.selectByCondition(role.getOrganization().getId(), searchKey, offset, limit);
            List<OneTimeBuy> oneTimeBuyList = (List<OneTimeBuy>) map.get("list");
            if (oneTimeBuyList == null) {
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
            }

            HttpHeaders headers = new HttpHeaders();
            headers.add("x-uengine-pagination-maxnbrecords", map.get("max").toString());
            headers.add("x-uengine-pagination-currentoffset", map.get("offset").toString());
            headers.add("x-uengine-pagination-totalnbrecords", map.get("total").toString());

            return new ResponseEntity<>(oneTimeBuyList, headers, HttpStatus.OK);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }

    @RequestMapping(value = "/onetimebuy/{record_id}", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<OneTimeBuy> getProduct(HttpServletRequest request,
                                                 HttpServletResponse response,
                                                 @PathVariable("record_id") Long record_id) {
        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.MEMBER);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            Organization organization = role.getOrganization();
            OneTimeBuy oneTimeBuy = oneTimeBuyService.selectById(organization.getId(), record_id);
            if (oneTimeBuy == null) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            return new ResponseEntity<>(oneTimeBuy, HttpStatus.OK);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }

    /**
     * 일회성 결제 이력을 CANCEL 한다.
     *
     * @param request
     * @param response
     * @param record_id
     * @return
     */
    @RequestMapping(value = "/onetimebuy/{record_id}", method = RequestMethod.DELETE)
    public ResponseEntity<OneTimeBuy> deleteProduct(HttpServletRequest request,
                                                    HttpServletResponse response,
                                                    @PathVariable("record_id") Long record_id) {

        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.ADMIN);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            Organization organization = role.getOrganization();
            OneTimeBuy oneTimeBuy = oneTimeBuyService.selectById(organization.getId(), record_id);
            if (oneTimeBuy == null) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            OneTimeBuy cancelOneTimeBuy = oneTimeBuyService.cancelOneTimeBuy(organization.getId(), record_id);
            return new ResponseEntity<>(cancelOneTimeBuy, HttpStatus.OK);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }
}
