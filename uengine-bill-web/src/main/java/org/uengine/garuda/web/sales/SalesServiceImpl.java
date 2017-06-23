package org.uengine.garuda.web.sales;

import org.apache.commons.collections.map.HashedMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.uengine.garuda.common.exception.ServiceException;
import org.uengine.garuda.killbill.KBRepository;
import org.uengine.garuda.killbill.KBService;
import org.uengine.garuda.killbill.KBServiceFactory;
import org.uengine.garuda.killbill.api.model.Clock;
import org.uengine.garuda.model.*;
import org.uengine.garuda.model.catalog.Plan;
import org.uengine.garuda.model.catalog.Price;
import org.uengine.garuda.model.catalog.ProductCategory;
import org.uengine.garuda.util.DateUtils;
import org.uengine.garuda.util.JsonUtils;
import org.uengine.garuda.util.StringUtils;
import org.uengine.garuda.util.UUIDUtils;
import org.uengine.garuda.web.onetimebuy.OneTimeBuyRepository;
import org.uengine.garuda.web.onetimebuy.OneTimeBuyRequest;
import org.uengine.garuda.web.onetimebuy.OneTimeBuyService;
import org.uengine.garuda.web.onetimebuy.OneTimeBuyState;
import org.uengine.garuda.web.product.ProductRepository;
import org.uengine.garuda.web.product.ProductService;
import org.uengine.garuda.web.product.version.ProductVersionService;
import org.uengine.garuda.web.rule.BillingRuleRepository;

import java.math.BigDecimal;
import java.util.*;

@Service
public class SalesServiceImpl implements SalesService {

    @Autowired
    @Qualifier("config")
    private Properties config;

    @Autowired
    private SalesRepository salesRepository;

    @Autowired
    private KBRepository kbRepository;

    @Autowired
    private KBService kbService;

    @Autowired
    private KBServiceFactory kbServiceFactory;


    private Logger logger = LoggerFactory.getLogger(ProductRepository.class);

    @Override
    public ProductDistributionHistory selectById(Organization organization, Long record_id) {
        return salesRepository.selectById(organization.getId(), record_id);
    }

    /**
     * 벤더 계정의 판매 대금 잔액을 조회한다.
     *
     * @param organization
     * @param vendor_id
     * @return
     */
    @Override
    public Map getAccountSalesBalance(Organization organization, String vendor_id) {
        List<ProductDistributionHistory> historyList = salesRepository.selectAccountBalance(organization.getId(), vendor_id);
        if (historyList == null) {
            historyList = new ArrayList<>();
        }

        Map result = new HashMap();
        Map balance = new HashMap();
        Map sales = new HashMap();
        Map refund = new HashMap();
        Map withdraw = new HashMap();
        Map credit = new HashMap();
        for (ProductDistributionHistory history : historyList) {
            String transactionType = history.getTransaction_type();
            switch (transactionType) {
                case "BALANCE":
                    balance.put(history.getCurrency(), history.getAmount());
                    break;
                case "CREATION":
                    sales.put(history.getCurrency(), history.getAmount());
                    break;
                case "ADJUSTMENT":
                    refund.put(history.getCurrency(), history.getAmount());
                    break;
                case "WITHDRAW":
                    withdraw.put(history.getCurrency(), history.getAmount());
                    break;
                case "CREDIT":
                    credit.put(history.getCurrency(), history.getAmount());
                    break;
                default:
                    break;
            }
        }
        result.put("balance", balance);
        result.put("sales", sales);
        result.put("refund", refund);
        result.put("withdraw", withdraw);
        result.put("credit", credit);
        return result;
    }

    @Override
    public Map getPerDateSummaryForOrganization(Organization organization, SalesSummaryFilter summaryFilter) throws Exception {

        //총 매출 합산은 벤더 필터를 삭제한다.
        summaryFilter.setVendor_id(null);
        Map total_revenue = this.getPerDateSummary(organization, summaryFilter);

        //순 매출,환불 합산은 벤더 필터를 organization 설정
        summaryFilter.setVendor_id("organization");
        Map net_summary = this.getPerDateSummary(organization, summaryFilter);

        //credit, widthdraw 항목은 순 매출,환불 집계 대상이 아니기때문에 총 합산식과 공유하도록 한다.
        net_summary.put("credit", total_revenue.get("credit"));
        net_summary.put("withdraw", total_revenue.get("withdraw"));

        Map map = new HashedMap();
        map.put("total_revenue", total_revenue);
        map.put("net_summary", net_summary);

        if (summaryFilter.getStart_date() != null) {
            map.put("start_date", DateUtils.parseDate(summaryFilter.getStart_date(), "yyyy-MM-dd"));
        }
        if (summaryFilter.getEnd_date() != null) {
            map.put("end_date", DateUtils.parseDate(summaryFilter.getStart_date(), "yyyy-MM-dd"));
        }
        return map;
    }


    /**
     * 판매 이력 합계를 날짜별로 계산하여 리턴한다.
     *
     * @param organization  Organization
     * @param summaryFilter SalesSummaryFilter
     * @return
     */
    @Override
    public Map getPerDateSummary(Organization organization, SalesSummaryFilter summaryFilter) throws Exception {

        Map result = new HashedMap();

        Map<String, Object> filter = JsonUtils.convertClassToMap(summaryFilter);
        //filter.put("summaryType", summaryFilter.getSummaryType().toString());
        filter.put("organization_id", organization.getId());
        if (summaryFilter.getStart_date() != null) {
            filter.put("start_date", DateUtils.parseDate(summaryFilter.getStart_date(), "yyyy-MM-dd"));
            result.put("start_date", filter.get("start_date").toString());
        }
        if (summaryFilter.getEnd_date() != null) {
            filter.put("end_date", DateUtils.parseDate(summaryFilter.getStart_date(), "yyyy-MM-dd"));
            result.put("end_date", filter.get("end_date").toString());
        }

        Map<String, List<Map<String, Object>>> sales_per_date = new HashMap<>();
        Map<String, List<Map<String, Object>>> refund_per_date = new HashMap<>();
        Map<String, List<Map<String, Object>>> withdraw_per_date = new HashMap<>();
        Map<String, List<Map<String, Object>>> credit_per_date = new HashMap<>();

        Map<String, Map<String, Object>> sales_summary = new HashMap<>();
        Map<String, Map<String, Object>> refund_summary = new HashMap<>();
        Map<String, Map<String, Object>> withdraw_summary = new HashMap<>();
        Map<String, Map<String, Object>> credit_summary = new HashMap<>();

        List<ProductDistributionHistory> historyList = salesRepository.selectPerDateSummary(filter);
        for (ProductDistributionHistory history : historyList) {
            String transactionType = history.getTransaction_type();

            if (summaryFilter.getSummaryType().equals(SalesSummaryType.ORGANIZATION)) {
                switch (transactionType) {
                    case "CREATION":
                        this.mergePerDateForOrganization(sales_per_date, sales_summary, history);
                        break;
                    case "ADJUSTMENT":
                        this.mergePerDateForOrganization(refund_per_date, refund_summary, history);
                        break;
                    case "WITHDRAW":
                        this.mergePerDateForOrganization(withdraw_per_date, withdraw_summary, history);
                        break;
                    case "CREDIT":
                        this.mergePerDateForOrganization(credit_per_date, credit_summary, history);
                        break;
                    default:
                        break;
                }
            } else {
                switch (transactionType) {
                    case "CREATION":
                        this.mergePerDate(sales_per_date, sales_summary, history);
                        break;
                    case "ADJUSTMENT":
                        this.mergePerDate(refund_per_date, refund_summary, history);
                        break;
                    case "WITHDRAW":
                        this.mergePerDate(withdraw_per_date, withdraw_summary, history);
                        break;
                    case "CREDIT":
                        this.mergePerDate(credit_per_date, credit_summary, history);
                        break;
                    default:
                        break;
                }
            }
        }

        Map sales = new HashMap();
        sales.put("per_date", sales_per_date);
        sales.put("summary", sales_summary);

        Map refund = new HashMap();
        refund.put("per_date", refund_per_date);
        refund.put("summary", refund_summary);

        Map withdraw = new HashMap();
        withdraw.put("per_date", withdraw_per_date);
        withdraw.put("summary", withdraw_summary);

        Map credit = new HashMap();
        credit.put("per_date", credit_per_date);
        credit.put("summary", credit_summary);

        result.put("sales", sales);
        result.put("refund", refund);
        result.put("withdraw", withdraw);
        result.put("credit", credit);
        return result;
    }

    private void mergePerDateForOrganization(Map<String, List<Map<String, Object>>> per_date, Map<String, Map<String, Object>> summary, ProductDistributionHistory history) {
        String format_date = history.getFormat_date();
        if (StringUtils.isEmpty(format_date)) {
            return;
        }

        String price_type = history.getPrice_type() != null ? history.getPrice_type() : "";

        //total 인서트 수행
        if (!summary.containsKey("total")) {
            summary.put("total", new HashedMap());
        }
        Map<String, Object> total = summary.get("total");
        if (total.containsKey(history.getCurrency())) {
            BigDecimal decimal = (BigDecimal) total.get(history.getCurrency());
            BigDecimal add = decimal.add(history.getAmount());
            total.put(history.getCurrency(), add);
        } else {
            total.put(history.getCurrency(), history.getAmount());
        }

        //per_price_type
        this.mergeSummary(summary, "per_price_type", price_type, history);

        //per_date 에 인서트한다.
        if (!per_date.containsKey(format_date)) {
            per_date.put(format_date, new ArrayList<Map<String, Object>>());
        }
        List<Map<String, Object>> date_map = per_date.get(format_date);


        //날짜에 속한 map 들이 동일한 필드를 가지고 있다면,includeMap 에 저장한다.
        Map<String, Object> includeMap = null;
        for (Map<String, Object> map : date_map) {
            boolean isSame = true;
            if (!map.get("price_type").equals(price_type)) {
                isSame = false;
            }
            if (isSame) {
                includeMap = map;
            }
        }

        //includeMap 이 있다면 amount 에 currency 를 추가한다.
        if (includeMap != null) {
            Map<String, BigDecimal> amount = (Map<String, BigDecimal>) includeMap.get("amount");
            amount.put(history.getCurrency(), history.getAmount());
        }
        //그 외의 경우 새로운 map 을 만들어서 date_map 에 입력한다.
        else {
            includeMap = new HashedMap();
            includeMap.put("price_type", price_type);

            Map<String, BigDecimal> amount = new HashedMap();
            amount.put(history.getCurrency(), history.getAmount());
            includeMap.put("amount", amount);
            date_map.add(includeMap);
        }
    }

    private void mergePerDate(Map<String, List<Map<String, Object>>> per_date, Map<String, Map<String, Object>> summary, ProductDistributionHistory history) {
        String format_date = history.getFormat_date();
        if (StringUtils.isEmpty(format_date)) {
            return;
        }

        String vendor_id = history.getVendor_id() != null ? history.getVendor_id() : "";
        String product_id = history.getProduct_id() != null ? history.getProduct_id() : "";
        String plan_name = history.getPlan_name() != null ? history.getPlan_name() : "";
        String price_type = history.getPrice_type() != null ? history.getPrice_type() : "";
        String usage_name = history.getUsage_name() != null ? history.getUsage_name() : "";

        //summary 에 인서트한다.

        //total 인서트 수행
        if (!summary.containsKey("total")) {
            summary.put("total", new HashedMap());
        }
        Map<String, Object> total = summary.get("total");
        if (total.containsKey(history.getCurrency())) {
            BigDecimal decimal = (BigDecimal) total.get(history.getCurrency());
            BigDecimal add = decimal.add(history.getAmount());
            total.put(history.getCurrency(), add);
        } else {
            total.put(history.getCurrency(), history.getAmount());
        }

        //per_product_id
        this.mergeSummary(summary, "per_product_id", product_id, history);
        //per_vendor_id
        this.mergeSummary(summary, "per_vendor_id", vendor_id, history);
        //per_plan_name
        this.mergeSummary(summary, "per_plan_name", plan_name, history);
        //per_price_type
        this.mergeSummary(summary, "per_price_type", price_type, history);
        //per_usage_name
        this.mergeSummary(summary, "per_usage_name", usage_name, history);

        //per_date 에 인서트한다.
        if (!per_date.containsKey(format_date)) {
            per_date.put(format_date, new ArrayList<Map<String, Object>>());
        }
        List<Map<String, Object>> date_map = per_date.get(format_date);


        //날짜에 속한 map 들이 동일한 필드를 가지고 있다면,includeMap 에 저장한다.
        Map<String, Object> includeMap = null;
        for (Map<String, Object> map : date_map) {
            boolean isSame = true;
            if (!map.get("vendor_id").equals(vendor_id)) {
                isSame = false;
            }
            if (!map.get("product_id").equals(product_id)) {
                isSame = false;
            }
            if (!map.get("plan_name").equals(plan_name)) {
                isSame = false;
            }
            if (!map.get("price_type").equals(price_type)) {
                isSame = false;
            }
            if (!map.get("usage_name").equals(usage_name)) {
                isSame = false;
            }
            if (isSame) {
                includeMap = map;
            }
        }

        //includeMap 이 있다면 amount 에 currency 를 추가한다.
        if (includeMap != null) {
            Map<String, BigDecimal> amount = (Map<String, BigDecimal>) includeMap.get("amount");
            amount.put(history.getCurrency(), history.getAmount());
        }
        //그 외의 경우 새로운 map 을 만들어서 date_map 에 입력한다.
        else {
            includeMap = new HashedMap();
            includeMap.put("vendor_id", vendor_id);
            includeMap.put("product_id", product_id);
            includeMap.put("plan_name", plan_name);
            includeMap.put("price_type", price_type);
            includeMap.put("usage_name", usage_name);

            Map<String, BigDecimal> amount = new HashedMap();
            amount.put(history.getCurrency(), history.getAmount());
            includeMap.put("amount", amount);
            date_map.add(includeMap);
        }
    }

    private void mergeSummary(Map<String, Map<String, Object>> summary, String summaryPerType, String perValue, ProductDistributionHistory history) {
        if (!summary.containsKey(summaryPerType)) {
            summary.put(summaryPerType, new HashedMap());
        }
        Map<String, Object> perSummary = summary.get(summaryPerType);
        if (!StringUtils.isEmpty(perValue)) {

            if (!perSummary.containsKey(perValue)) {
                perSummary.put(perValue, new HashedMap());
            }
            Map<String, Object> per_product_item = (Map<String, Object>) perSummary.get(perValue);
            if (per_product_item.containsKey(history.getCurrency())) {
                BigDecimal decimal = (BigDecimal) per_product_item.get(history.getCurrency());
                BigDecimal add = decimal.add(history.getAmount());
                per_product_item.put(history.getCurrency(), add);
            } else {
                per_product_item.put(history.getCurrency(), history.getAmount());
            }
        }
    }

    /**
     * 벤더의 판매기록을 조회한다.
     *
     * @param organization
     * @param vendor_id
     * @param searchKey
     * @param offset
     * @param limit
     * @return
     */
    @Override
    public Map getAccountSalesByCondition(Organization organization, String vendor_id, String searchKey, Long offset, Long limit) {
        return salesRepository.selectByCondition(organization.getId(), vendor_id, null, searchKey, offset, limit);
    }

    /**
     * 프로덕트의 판매기록을 조회한다.
     *
     * @param organization
     * @param product_id
     * @param searchKey
     * @param offset
     * @param limit
     * @return
     */
    @Override
    public Map getProductSalesByCondition(Organization organization, String product_id, String searchKey, Long offset, Long limit) {
        return salesRepository.selectByCondition(organization.getId(), null, product_id, searchKey, offset, limit);
    }

    /**
     * 조직 전체의 판매기록을 조회한다.
     *
     * @param organization
     * @param searchKey
     * @param offset
     * @param limit
     * @return
     */
    @Override
    public Map getOrgSalesByCondition(Organization organization, String searchKey, Long offset, Long limit) {
        return salesRepository.selectByCondition(organization.getId(), null, null, searchKey, offset, limit);
    }

    /**
     * 사용자의 판매대금에서 출금 또는 크레딧 전환한다.
     *
     * @param organization
     * @param vendor_id
     * @param withdrawRequest
     * @return
     */
    @Override
    public ProductDistributionHistory withdrawAccountBalance(Organization organization, String vendor_id, SalesWithdrawRequest withdrawRequest) {

        //현재 시각 구하기.
        Clock clock = kbService.getTime(organization.getTenant_api_key(), organization.getTenant_api_secret());

        //출금 요청 타입 구하기
        DistributionTransactionType transactionType = withdrawRequest.getTransactionType();

        //출금 요청 currency
        String currency = withdrawRequest.getCurrency();

        //출금 요청 금액
        BigDecimal amount = withdrawRequest.getAmount();

        //사용자 잔액
        Map salesBalance = this.getAccountSalesBalance(organization, vendor_id);
        Map balance = (Map) salesBalance.get("balance");

        //사용자 currency 구하기
        Map account = kbRepository.getAccountById(vendor_id);
        String accountCurrency = account.get("currency").toString();

        //출금 요청 currency 의 잔액을 구한다. 없다면 잔액은 0 이다.
        BigDecimal balanceAmount = new BigDecimal(0);
        if (balance.containsKey(currency)) {
            balanceAmount = (BigDecimal) balance.get(currency);
        }

        //출금 요청 금액이 잔액보다 클 경우 요청을 거절한다.
        if (amount.compareTo(balanceAmount) == 1) {
            throw new ServiceException("Requested withdrawal amount is more than account balance");
        }

        //계좌 인출인 경우 히스토리를 저장한다.
        if (transactionType.equals(DistributionTransactionType.WITHDRAW)) {
            ProductDistributionHistory history = new ProductDistributionHistory();

            history.setTenant_id(organization.getTenant_id());
            history.setOrganization_id(organization.getId());
            history.setVendor_id(vendor_id);
            history.setAmount(amount);
            history.setCurrency(currency);
            history.setTransaction_type(DistributionTransactionType.WITHDRAW.toString());
            history.setFormat_date(clock.getLocalDate());
            history.setCreated_date(clock.getCurrentUtcTime());
            history.setNotes(withdrawRequest.getNotes());

            return salesRepository.insertHistory(history);
        }
        //크레딧 전환 요청인 경우 크레딧을 전환하고 히스토리를 저장한다.
        else if (transactionType.equals(DistributionTransactionType.CREDIT)) {
            Map credit = kbServiceFactory.apiClient(organization.getTenant_api_key(), organization.getTenant_api_secret())
                    .creditsApi().createCredit(amount, currency, vendor_id, null, null);

            String invoiceId = credit.get("invoiceId").toString();
            ProductDistributionHistory history = new ProductDistributionHistory();

            history.setTenant_id(organization.getTenant_id());
            history.setOrganization_id(organization.getId());
            history.setVendor_id(vendor_id);
            history.setAmount(amount);
            history.setCurrency(currency);
            history.setInvoice_id(invoiceId);
            history.setTransaction_type(DistributionTransactionType.WITHDRAW.toString());
            history.setFormat_date(clock.getLocalDate());
            history.setCreated_date(clock.getCurrentUtcTime());
            history.setNotes(withdrawRequest.getNotes());

            return salesRepository.insertHistory(history);
        } else {
            throw new ServiceException("Invalid request parameter to make credit.");
        }
    }

    /**
     * 출금 기록을 취소(삭제) 한다.
     *
     * @param organization
     * @param record_id
     * @return
     */
    @Override
    public int cancelWithdraw(Organization organization, Long record_id) {
        return salesRepository.deleteById(organization.getId(), record_id);
    }

    /**
     * 판매 기록의 notes 를 업데이트 한다.
     *
     * @param organization
     * @param record_id
     * @param vendor_id
     * @param notes
     * @return
     */
    @Override
    public ProductDistributionHistory updateNote(Organization organization, Long record_id, String vendor_id, String notes) {
        return salesRepository.updateNotes(organization.getId(), record_id, vendor_id, notes);
    }
}
