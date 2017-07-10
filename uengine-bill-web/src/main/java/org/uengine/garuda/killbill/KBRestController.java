package org.uengine.garuda.killbill;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.uengine.garuda.killbill.api.KillbillApi;
import org.uengine.garuda.model.OneTimeBuy;
import org.uengine.garuda.model.Organization;
import org.uengine.garuda.model.OrganizationEmail;
import org.uengine.garuda.util.DateUtils;
import org.uengine.garuda.util.ExceptionUtils;
import org.uengine.garuda.web.onetimebuy.OneTimeBuyRepository;
import org.uengine.garuda.web.onetimebuy.OneTimeBuyService;
import org.uengine.garuda.web.organization.OrganizationRole;
import org.uengine.garuda.web.organization.OrganizationService;
import org.uengine.garuda.web.system.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by uengine on 2017. 1. 11..
 */

@Controller
@RequestMapping("/rest/v1")
public class KBRestController {

    @Autowired
    @Qualifier("config")
    private Properties config;

    @Autowired
    private OrganizationService organizationService;

    @Autowired
    private KBRepository kbRepository;

    @Autowired
    private KBServiceFactory kbServiceFactory;

    @Autowired
    private OneTimeBuyRepository oneTimeBuyRepository;

    @Autowired
    private OneTimeBuyService oneTimeBuyService;

    //여기서 bcd 업데이트 만들기
    @RequestMapping(value = "/accounts/{id}/bcd", method = RequestMethod.PUT)
    public ResponseEntity<Map> updateAccountBcd(HttpServletRequest request,
                                                HttpServletResponse response,
                                                @PathVariable("id") String id, @RequestBody Map params) {

        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.ADMIN);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }
            Organization organization = role.getOrganization();

            int billCycleDayLocal = (int) params.get("billCycleDayLocal");
            if (billCycleDayLocal < 1 || billCycleDayLocal > 31) {
                throw new SecurityException("billCycleDayLocal should be between 1 and 31");
            }

            Map account = kbRepository.getAccountById(id);
            if (account == null) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            //모든 번들을 구하고, subscription bcd 를 조정한다.
            List<Map> accountBundles = kbServiceFactory.apiClient(organization.getTenant_api_key(), organization.getTenant_api_secret())
                    .bundleApi().getAccountBundles(id);

            for (Map accountBundle : accountBundles) {
                List<Map> subscriptions = (List<Map>) accountBundle.get("subscriptions");
                for (Map subscription : subscriptions) {
                    String subscriptionId = subscription.get("subscriptionId").toString();
                    kbServiceFactory.apiClient(organization.getTenant_api_key(), organization.getTenant_api_secret())
                            .subscriptionApi().updateBCD(subscriptionId, billCycleDayLocal);
                }
            }

            //Account 의 레코드를 조정한다.
            account.put("billing_cycle_day_local", billCycleDayLocal);
            kbRepository.updateAccountBcd(account.get("id").toString(), billCycleDayLocal);


            //구매 기록중 번들 아이디가 없고, PENDING_INVOICE 것들의 리스트를 불러와, 새로운 bcd 로 billing_date 를 결정한다.
            List<OneTimeBuy> oneTimeBuyList = oneTimeBuyRepository.selectAccountPendingBuys(account.get("id").toString());
            for (OneTimeBuy oneTimeBuy : oneTimeBuyList) {
                String effective_date = oneTimeBuy.getEffective_date();
                Date effectiveDate = DateUtils.parseDate(effective_date, new String[]{"yyyy-MM-dd"});
                Date actualBcdDate = oneTimeBuyService.getActualBcdDate(effectiveDate, billCycleDayLocal);

                oneTimeBuy.setBilling_date(DateUtils.parseDate(actualBcdDate, "yyyy-MM-dd"));
                oneTimeBuyService.update(oneTimeBuy);
            }


            return new ResponseEntity<>(account, HttpStatus.OK);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }

    @RequestMapping(value = "/accounts/{id}", method = RequestMethod.DELETE)
    public ResponseEntity<Void> deleteAccount(HttpServletRequest request, HttpServletResponse response,
                                              @PathVariable("id") String id) {

        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.ADMIN);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            Map account = kbRepository.getAccountById(id);
            if (account == null) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            //번들이나 페이먼트가 있다면 삭제할 수 없다.
            Long bundleCount = kbRepository.getBundleCountByAccountId(id);
            Long paymentCount = kbRepository.getPaymentCountByAccountId(id);

            if (bundleCount > 0 || paymentCount > 0) {
                return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
            }

            kbRepository.deleteAccountById(id);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }

    @RequestMapping(value = "/accountsByIds", method = RequestMethod.POST)
    public ResponseEntity<List> createProduct(HttpServletRequest request,
                                              HttpServletResponse response,
                                              @RequestBody List<String> ids) {

        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.ADMIN);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            List accountByIds = new ArrayList();
            if (ids != null && !ids.isEmpty()) {
                accountByIds = kbRepository.getAccountByIds(ids);
            }

            return new ResponseEntity<>(accountByIds, HttpStatus.OK);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }

    //아카운트 unblock
    @RequestMapping(value = "/accounts/{id}/unblock", method = RequestMethod.PUT)
    public ResponseEntity<Void> unblockAccount(HttpServletRequest request,
                                              HttpServletResponse response,
                                              @PathVariable("id") String id,
                                              @RequestParam(value = "resumeInvoice", defaultValue = "false") boolean resumeInvoice) {

        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.ADMIN);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }
            Organization organization = role.getOrganization();

            KillbillApi killbillApi = kbServiceFactory.apiClient(organization.getTenant_api_key(), organization.getTenant_api_secret());

            //1.어카운트의 블락 스테이트 업데이트.
            Map blockParams = new HashMap();
            blockParams.put("stateName", "__KILLBILL__CLEAR__OVERDUE_STATE__");
            blockParams.put("service", "overdue-service");
            blockParams.put("type", "ACCOUNT");
            killbillApi.accountApi().blockAccount(id, blockParams);

            //resumeInvoice 가 있다면
            if (resumeInvoice) {
                //2. 어카운트 태그 조회
                boolean hasInvoiceOffTag = false;
                List<Map> accountTags = killbillApi.accountApi().getAccountTags(id);
                for (Map accountTag : accountTags) {
                    if (accountTag.get("tagDefinitionId").equals("00000000-0000-0000-0000-000000000002")) {
                        hasInvoiceOffTag = true;
                    }
                }

                //3. resumeInvoice 수행
                if (hasInvoiceOffTag) {
                    ArrayList<String> tags = new ArrayList<>();
                    tags.add("00000000-0000-0000-0000-000000000002");
                    killbillApi.accountApi().deleteAccountTags(id, tags);
                }
            }

            return new ResponseEntity<>(HttpStatus.OK);
        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }
}
