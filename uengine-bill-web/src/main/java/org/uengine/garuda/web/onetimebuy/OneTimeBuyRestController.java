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
}
