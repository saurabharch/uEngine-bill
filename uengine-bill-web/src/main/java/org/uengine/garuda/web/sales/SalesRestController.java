package org.uengine.garuda.web.sales;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.uengine.garuda.killbill.KBRepository;
import org.uengine.garuda.model.DistributionTransactionType;
import org.uengine.garuda.model.ProductDistributionHistory;
import org.uengine.garuda.util.ExceptionUtils;
import org.uengine.garuda.web.organization.OrganizationRole;
import org.uengine.garuda.web.organization.OrganizationService;

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
public class SalesRestController {

    @Autowired
    @Qualifier("config")
    private Properties config;

    @Autowired
    private OrganizationService organizationService;

    @Autowired
    private SalesService salesService;

    @Autowired
    private KBRepository kbRepository;

    @RequestMapping(value = "/accounts/{id}/sales/balance", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<Map> getAccountBalance(HttpServletRequest request,
                                                 HttpServletResponse response,
                                                 @PathVariable("id") String id) {
        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.MEMBER);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            Map perDateSummary = salesService.getAccountSalesBalance(role.getOrganization(), id);
            if (perDateSummary == null) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            return new ResponseEntity<>(perDateSummary, HttpStatus.OK);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }

    @RequestMapping(value = "/accounts/{id}/sales/summary", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<Map> getAccountSummary(HttpServletRequest request,
                                                 HttpServletResponse response,
                                                 @PathVariable("id") String id,
                                                 @RequestParam(value = "start_date", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date start_date,
                                                 @RequestParam(value = "end_date", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date end_date,
                                                 @RequestParam(value = "product_id", required = false) String product_id,
                                                 @RequestParam(value = "plan_name", required = false) String plan_name,
                                                 @RequestParam(value = "usage_name", required = false) String usage_name) {
        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.MEMBER);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            SalesSummaryFilter filter = new SalesSummaryFilter();
            filter.setSummaryType(SalesSummaryType.VENDOR);
            filter.setStart_date(start_date);
            filter.setEnd_date(end_date);
            filter.setVendor_id(id);
            filter.setProduct_id(product_id);
            filter.setPlan_name(plan_name);
            filter.setUsage_name(usage_name);

            Map perDateSummary = salesService.getPerDateSummary(role.getOrganization(), filter);
            if (perDateSummary == null) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            return new ResponseEntity<>(perDateSummary, HttpStatus.OK);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }

    @RequestMapping(value = "/accounts/{id}/sales/pagination", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<List<ProductDistributionHistory>> getAccountSales(HttpServletRequest request,
                                                                            HttpServletResponse response,
                                                                            @PathVariable("id") String id,
                                                                            @RequestParam(defaultValue = "0") Long offset,
                                                                            @RequestParam(defaultValue = "100") Long limit) {
        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.MEMBER);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            Map map = salesService.getAccountSalesByCondition(role.getOrganization(), id, null, offset, limit);
            List<ProductDistributionHistory> historyList = (List<ProductDistributionHistory>) map.get("list");
            if (historyList == null) {
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
            }

            HttpHeaders headers = new HttpHeaders();
            headers.add("x-uengine-pagination-maxnbrecords", map.get("max").toString());
            headers.add("x-uengine-pagination-currentoffset", map.get("offset").toString());
            headers.add("x-uengine-pagination-totalnbrecords", map.get("total").toString());

            return new ResponseEntity<>(historyList, headers, HttpStatus.OK);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }

    @RequestMapping(value = "/accounts/{id}/sales/search/{searchKey}", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<List<ProductDistributionHistory>> getAccountSalesSearch(HttpServletRequest request,
                                                                                  HttpServletResponse response,
                                                                                  @PathVariable("id") String id,
                                                                                  @PathVariable("searchKey") String searchKey,
                                                                                  @RequestParam(defaultValue = "0") Long offset,
                                                                                  @RequestParam(defaultValue = "100") Long limit) {
        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.MEMBER);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            Map map = salesService.getAccountSalesByCondition(role.getOrganization(), id, searchKey, offset, limit);
            List<ProductDistributionHistory> historyList = (List<ProductDistributionHistory>) map.get("list");
            if (historyList == null) {
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
            }

            HttpHeaders headers = new HttpHeaders();
            headers.add("x-uengine-pagination-maxnbrecords", map.get("max").toString());
            headers.add("x-uengine-pagination-currentoffset", map.get("offset").toString());
            headers.add("x-uengine-pagination-totalnbrecords", map.get("total").toString());

            return new ResponseEntity<>(historyList, headers, HttpStatus.OK);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }

    @RequestMapping(value = "/accounts/{id}/sales/withdraw", method = RequestMethod.POST)
    public ResponseEntity<ProductDistributionHistory> withdraw(HttpServletRequest request,
                                                               HttpServletResponse response,
                                                               @PathVariable("id") String id,
                                                               @RequestBody SalesWithdrawRequest withdrawRequest) {

        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.ADMIN);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            Map account = kbRepository.getAccountById(id);
            if(account == null){
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            withdrawRequest.setTransactionType(DistributionTransactionType.WITHDRAW);
            ProductDistributionHistory history = salesService.withdrawAccountBalance(role.getOrganization(), id, withdrawRequest);
            return new ResponseEntity<>(history, HttpStatus.CREATED);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }

    @RequestMapping(value = "/accounts/{id}/sales/credit", method = RequestMethod.POST)
    public ResponseEntity<ProductDistributionHistory> credit(HttpServletRequest request,
                                                             HttpServletResponse response,
                                                             @PathVariable("id") String id,
                                                             @RequestBody SalesWithdrawRequest withdrawRequest) {

        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.ADMIN);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            Map account = kbRepository.getAccountById(id);
            if(account == null){
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            withdrawRequest.setTransactionType(DistributionTransactionType.CREDIT);
            ProductDistributionHistory history = salesService.withdrawAccountBalance(role.getOrganization(), id, withdrawRequest);
            return new ResponseEntity<>(history, HttpStatus.CREATED);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }

    @RequestMapping(value = "/accounts/{id}/sales/cancelwithdraw/{sales_record_id}", method = RequestMethod.DELETE)
    public ResponseEntity<Void> cancelWithdraw(HttpServletRequest request,
                                               HttpServletResponse response,
                                               @PathVariable("id") String id,
                                               @PathVariable("sales_record_id") Long sales_record_id) {

        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.ADMIN);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }


            ProductDistributionHistory history = salesService.selectById(role.getOrganization(), sales_record_id);
            if (history == null || !id.equals(history.getVendor_id()) ||
                    !DistributionTransactionType.WITHDRAW.toString().equals(history.getTransaction_type())) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            salesService.cancelWithdraw(role.getOrganization(), sales_record_id);
            return new ResponseEntity<>(HttpStatus.OK);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }

    @RequestMapping(value = "/accounts/{id}/sales/notes/{sales_record_id}", method = RequestMethod.PUT)
    public ResponseEntity<ProductDistributionHistory> updateNotes(HttpServletRequest request,
                                                                  HttpServletResponse response,
                                                                  @RequestBody Map params,
                                                                  @RequestParam(value = "id") String id,
                                                                  @PathVariable("sales_record_id") Long sales_record_id) {

        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.MEMBER);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            ProductDistributionHistory history = salesService.selectById(role.getOrganization(), sales_record_id);
            if (history == null || !id.equals(history.getVendor_id()) ||
                    !DistributionTransactionType.WITHDRAW.toString().equals(history.getTransaction_type())) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            ProductDistributionHistory updated = salesService.updateNote(role.getOrganization(), sales_record_id, history.getVendor_id(), params.get("notes").toString());
            if(updated == null){
                return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
            }
            return new ResponseEntity<>(updated, HttpStatus.OK);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }


    @RequestMapping(value = "/product/{id}/sales/summary", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<Map> getProductSummary(HttpServletRequest request,
                                                 HttpServletResponse response,
                                                 @PathVariable("id") String id,
                                                 @RequestParam(value = "start_date", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date start_date,
                                                 @RequestParam(value = "end_date", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date end_date,
                                                 @RequestParam(value = "vendor_id", required = false) String vendor_id,
                                                 @RequestParam(value = "plan_name", required = false) String plan_name,
                                                 @RequestParam(value = "usage_name", required = false) String usage_name) {
        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.MEMBER);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            SalesSummaryFilter filter = new SalesSummaryFilter();
            filter.setSummaryType(SalesSummaryType.PRODUCT);
            filter.setStart_date(start_date);
            filter.setEnd_date(end_date);
            filter.setVendor_id(vendor_id);
            filter.setProduct_id(id);
            filter.setPlan_name(plan_name);
            filter.setUsage_name(usage_name);

            Map perDateSummary = salesService.getPerDateSummary(role.getOrganization(), filter);
            if (perDateSummary == null) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            return new ResponseEntity<>(perDateSummary, HttpStatus.OK);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }

    @RequestMapping(value = "/product/{id}/sales/pagination", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<List<ProductDistributionHistory>> getProductSales(HttpServletRequest request,
                                                                            HttpServletResponse response,
                                                                            @PathVariable("id") String id,
                                                                            @RequestParam(defaultValue = "0") Long offset,
                                                                            @RequestParam(defaultValue = "100") Long limit) {
        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.MEMBER);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            Map map = salesService.getProductSalesByCondition(role.getOrganization(), id, null, offset, limit);
            List<ProductDistributionHistory> historyList = (List<ProductDistributionHistory>) map.get("list");
            if (historyList == null) {
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
            }

            HttpHeaders headers = new HttpHeaders();
            headers.add("x-uengine-pagination-maxnbrecords", map.get("max").toString());
            headers.add("x-uengine-pagination-currentoffset", map.get("offset").toString());
            headers.add("x-uengine-pagination-totalnbrecords", map.get("total").toString());

            return new ResponseEntity<>(historyList, headers, HttpStatus.OK);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }

    @RequestMapping(value = "/product/{id}/sales/search/{searchKey}", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<List<ProductDistributionHistory>> getProductSalesSearch(HttpServletRequest request,
                                                                                  HttpServletResponse response,
                                                                                  @PathVariable("id") String id,
                                                                                  @PathVariable("searchKey") String searchKey,
                                                                                  @RequestParam(defaultValue = "0") Long offset,
                                                                                  @RequestParam(defaultValue = "100") Long limit) {
        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.MEMBER);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            Map map = salesService.getProductSalesByCondition(role.getOrganization(), id, searchKey, offset, limit);
            List<ProductDistributionHistory> historyList = (List<ProductDistributionHistory>) map.get("list");
            if (historyList == null) {
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
            }

            HttpHeaders headers = new HttpHeaders();
            headers.add("x-uengine-pagination-maxnbrecords", map.get("max").toString());
            headers.add("x-uengine-pagination-currentoffset", map.get("offset").toString());
            headers.add("x-uengine-pagination-totalnbrecords", map.get("total").toString());

            return new ResponseEntity<>(historyList, headers, HttpStatus.OK);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }


    @RequestMapping(value = "/organization/sales/summary", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<Map> getOrganizationSummary(HttpServletRequest request,
                                                      HttpServletResponse response,
                                                      @RequestParam(value = "start_date", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date start_date,
                                                      @RequestParam(value = "end_date", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date end_date,
                                                      @RequestParam(value = "vendor_id", required = false) String vendor_id,
                                                      @RequestParam(value = "product_id", required = false) String product_id,
                                                      @RequestParam(value = "plan_name", required = false) String plan_name,
                                                      @RequestParam(value = "usage_name", required = false) String usage_name) {
        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.MEMBER);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            SalesSummaryFilter filter = new SalesSummaryFilter();
            filter.setSummaryType(SalesSummaryType.ORGANIZATION);
            filter.setStart_date(start_date);
            filter.setEnd_date(end_date);
            filter.setVendor_id(vendor_id);
            filter.setProduct_id(product_id);
            filter.setPlan_name(plan_name);
            filter.setUsage_name(usage_name);

            Map perDateSummary = salesService.getPerDateSummary(role.getOrganization(), filter);
            if (perDateSummary == null) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            return new ResponseEntity<>(perDateSummary, HttpStatus.OK);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }

    @RequestMapping(value = "/organization/sales/pagination", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<List<ProductDistributionHistory>> getOrganizationSales(HttpServletRequest request,
                                                                                 HttpServletResponse response,
                                                                                 @RequestParam(defaultValue = "0") Long offset,
                                                                                 @RequestParam(defaultValue = "100") Long limit) {
        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.MEMBER);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            Map map = salesService.getOrgSalesByCondition(role.getOrganization(), null, offset, limit);
            List<ProductDistributionHistory> historyList = (List<ProductDistributionHistory>) map.get("list");
            if (historyList == null) {
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
            }

            HttpHeaders headers = new HttpHeaders();
            headers.add("x-uengine-pagination-maxnbrecords", map.get("max").toString());
            headers.add("x-uengine-pagination-currentoffset", map.get("offset").toString());
            headers.add("x-uengine-pagination-totalnbrecords", map.get("total").toString());

            return new ResponseEntity<>(historyList, headers, HttpStatus.OK);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }

    @RequestMapping(value = "/organization/sales/search/{searchKey}", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<List<ProductDistributionHistory>> getOrganizationSalesSearch(HttpServletRequest request,
                                                                                       HttpServletResponse response,
                                                                                       @PathVariable("searchKey") String searchKey,
                                                                                       @RequestParam(defaultValue = "0") Long offset,
                                                                                       @RequestParam(defaultValue = "100") Long limit) {
        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.MEMBER);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            Map map = salesService.getOrgSalesByCondition(role.getOrganization(), searchKey, offset, limit);
            List<ProductDistributionHistory> historyList = (List<ProductDistributionHistory>) map.get("list");
            if (historyList == null) {
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
            }

            HttpHeaders headers = new HttpHeaders();
            headers.add("x-uengine-pagination-maxnbrecords", map.get("max").toString());
            headers.add("x-uengine-pagination-currentoffset", map.get("offset").toString());
            headers.add("x-uengine-pagination-totalnbrecords", map.get("total").toString());

            return new ResponseEntity<>(historyList, headers, HttpStatus.OK);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }
}
