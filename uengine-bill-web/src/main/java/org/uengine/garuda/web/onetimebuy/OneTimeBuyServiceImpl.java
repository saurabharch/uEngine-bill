package org.uengine.garuda.web.onetimebuy;

import org.uengine.garuda.common.exception.ServiceException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
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
import org.uengine.garuda.web.product.ProductRepository;
import org.uengine.garuda.web.product.ProductService;
import org.uengine.garuda.web.product.event.SubscriptionEventRepository;
import org.uengine.garuda.web.product.version.ProductVersionService;
import org.uengine.garuda.web.rule.BillingRuleRepository;
import sun.misc.resources.Messages_pt_BR;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class OneTimeBuyServiceImpl implements OneTimeBuyService {

    @Autowired
    @Qualifier("config")
    private Properties config;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private OneTimeBuyRepository oneTimeBuyRepository;

    @Autowired
    private KBServiceFactory killbillServiceFactory;

    @Autowired
    private KBService kbService;

    @Autowired
    private KBRepository kbRepository;

    @Autowired
    private ProductVersionService productVersionService;

    @Autowired
    private ProductService productService;

    @Autowired
    private BillingRuleRepository billingRuleRepository;


    private Logger logger = LoggerFactory.getLogger(ProductRepository.class);

    @Override
    public List<OneTimeBuy> createOneTimeBuy(Organization organization, List<OneTimeBuyRequest> list, String accountId, Date requestedDate) throws Exception {
        //여기서 부터 작성할것. 위키 설계대로.

        //리턴할 oneTimeBuy 리스트
        List<OneTimeBuy> oneTimeBuyList = new ArrayList<OneTimeBuy>();

        //처리 후 즉시 발급이 필요한 대상
        List<OneTimeBuy> immediatelyItems = new ArrayList<OneTimeBuy>();

        //account 를 구한다.
        Map account = kbRepository.getAccountById(accountId);
        if (account == null) {
            throw new ServiceException("Not found account.");
        }

        //requestedDate 가 없을시는 effective_date 를 오늘날짜로 지정
        //requestedDate 가 있을시는 effective_date 를 그대로 쓴다.
        Date effectiveDate = null;
        Clock clock = kbService.getTime(organization.getTenant_api_key(), organization.getTenant_api_secret());
        if (requestedDate == null) {
            effectiveDate = clock.getCurrentUtcTime();
        } else {
            Calendar cal = Calendar.getInstance();
            cal.setTime(clock.getCurrentUtcTime());

            Calendar requestedCal = Calendar.getInstance();
            requestedCal.setTime(requestedDate);
            int year = requestedCal.get(Calendar.YEAR);
            int month = requestedCal.get(Calendar.MONTH);
            int day = requestedCal.get(Calendar.DAY_OF_MONTH);

            cal.set(Calendar.YEAR, year);
            cal.set(Calendar.MONTH, month);
            cal.set(Calendar.DAY_OF_MONTH, day);
            effectiveDate = cal.getTime();
        }

        //결제 규칙을 가져온다.
        BillingRule rule = billingRuleRepository.selectRuleByOrgId(organization.getId());
        Map ruleJson = JsonUtils.marshal(rule.getRule());
        if (!ruleJson.containsKey("oneTimeBillingAlignment")) {
            ruleJson = JsonUtils.marshal(billingRuleRepository.getDefaultBillingRule());
        }
        String alignment = ((Map) ((List) ruleJson.get("oneTimeBillingAlignment")).get(0)).get("oneTimeBillingAlignment").toString();


        //스테이트는 펜딩 인보이스
        String state = OneTimeBuyState.PENDING_INVOICE.toString();


        for (OneTimeBuyRequest oneTimeBuyRequest : list) {

            //프로덕트 카데고리 요청이 ONE_TIME 이여야 한다.
            if (!ProductCategory.ONE_TIME.toString().equals(oneTimeBuyRequest.getProductCategory())) {
                throw new ServiceException("Request Parameter productCategory must be ONE_TIME");
            }

            String planName = oneTimeBuyRequest.getPlanName();
            String product_id = planName.substring(0, 14);


            //프로덕트의 카테고리가 ONE_TIME 이여야 한다.
            Product product = productService.selectProductById(organization.getId(), product_id);
            if (product == null || !ProductCategory.ONE_TIME.toString().equals(product.getCategory())) {
                throw new ServiceException("Plan " + planName + " is not an ONE_TIME product");
            }

            //요청일에 해당하는 프로덕트 버젼을 가져온다.
            ProductVersion versionByEffectiveDate = productVersionService.getVersionByEffectiveDate(organization.getId(), product_id, effectiveDate);
            if (versionByEffectiveDate == null) {
                throw new ServiceException("Not Found Product Version for effective date " + DateUtils.parseDate(effectiveDate, "yyyy-MM-dd HH:mm:ss"));
            }

            //프로덕트 버젼에서 플랜을 찾는다.
            Plan plan = productVersionService.getPlanFromVersionByPlanName(versionByEffectiveDate, planName);
            if (plan == null || plan.getOnetimePrice() == null) {
                throw new ServiceException("Plan " + planName + " need OnetimePrice model.");
            }

            //프로덕트와 플랜이 액티브 인지 확인한다.
            if (!"Y".equals(product.getIs_active())) {
                throw new ServiceException("Product " + product.getName() + " is not active");
            }
            if (!"Y".equals(plan.getIs_active())) {
                throw new ServiceException("Plan " + planName + " is not active");
            }

            //account 의 currency 에 해당하는 가격을 가져온다.
            List<Price> onetimePrice = plan.getOnetimePrice();
            String currency = null;
            BigDecimal amount = null;
            for (Price price : onetimePrice) {
                if (price.getCurrency().equals(account.get("currency"))) {
                    currency = price.getCurrency();
                    amount = price.getValue();
                }
            }
            if (StringUtils.isEmpty(currency)) {
                throw new ServiceException("Plan " + planName + " need " + account.get("currency") + " price.");
            }

            /**
             * BUNDLE 지정시
             * BUNDLE 의 BASE 서브스크립션의 chargedThroughDate 로 billing_date 를 지정함.
             * 만일 chargedThroughDate 가 없다면 등록처리 하지 않는다.
             */
            if (!StringUtils.isEmpty(oneTimeBuyRequest.getBundleId())) {
                String bundleId = oneTimeBuyRequest.getBundleId();
                Map bundle = killbillServiceFactory
                        .apiClient(organization.getTenant_api_key(), organization.getTenant_api_secret())
                        .bundleApi().getBundle(bundleId);

                //번들의 어카운트 아이디가 요청자의 아이디와 다르면 신청 불가능이다.
                if (!accountId.equals(bundle.get("accountId").toString())) {
//                    //여기서부터.
                    throw new ServiceException("There is no base subscription which has chargedThroughDate in bundle " + bundleId);
                }

                //BASE 이면서 chargedThroughDate 가 있는 서브스크립션 선정.
                List<Map> subscriptions = (List<Map>) bundle.get("subscriptions");
                Map baseSubscription = null;
                for (Map subscription : subscriptions) {
                    String productCategory = subscription.get("productCategory").toString();
                    if (ProductCategory.BASE.toString().equals(productCategory)) {
                        if (subscription.get("chargedThroughDate") != null) {
                            baseSubscription = subscription;
                        }
                    }
                }
                if (baseSubscription == null) {
                    throw new ServiceException("There is no base subscription which has chargedThroughDate in bundle " + bundleId);
                }

                //빌링 데이트는 베이스 서브스크립션의 chargedThroughDate 이다.
                String billing_date = baseSubscription.get("chargedThroughDate").toString();


                //OneTimeBuy 를 저장한다.
                OneTimeBuy oneTimeBuy = new OneTimeBuy();
                oneTimeBuy.setBundle_id(bundleId);
                oneTimeBuy.setState(state);
                oneTimeBuy.setTenant_id(organization.getTenant_id());
                oneTimeBuy.setOrganization_id(organization.getId());
                oneTimeBuy.setAccount_id(accountId);
                oneTimeBuy.setProduct_id(product_id);
                oneTimeBuy.setVersion(versionByEffectiveDate.getVersion());
                oneTimeBuy.setPlan_name(planName);
                oneTimeBuy.setPlan_display_name(plan.getDisplay_name());
                oneTimeBuy.setAmount(amount);
                oneTimeBuy.setCurrency(currency);
                oneTimeBuy.setEffective_date(DateUtils.parseDate(effectiveDate, "yyyy-MM-dd"));
                oneTimeBuy.setBilling_date(billing_date);
                oneTimeBuy.setCreated_date(clock.getCurrentUtcTime());

                OneTimeBuy inserted = oneTimeBuyRepository.insert(oneTimeBuy);
                oneTimeBuyList.add(inserted);
            }

            /**
             * BUNDLE 미지정시
             case1) 결제 규칙이 ACCOUNT 에 정렬인 경우,
             Account 의 bcd 를 effective_date 에 대입하여 실제 billing_date 를 결정한다.
             billing_date 가 오늘날짜와 같거나 이전인 경우 즉시 원타임 플랜 단독 구매 로직 실행.

             case2) 결제 규칙이 REQUESTED_DATE 일 경우 effective_date 를 billing_date 로 결정함.
             billing_date 가 오늘날짜와 같거나 이전인 경우 즉시 원타임 플랜 단독 구매 로직 실행.
             */
            else {
                Date actualBcdDate = null;
                if (alignment.equals("ACCOUNT")) {
                    int bcd = (int) account.get("billing_cycle_day_local");
                    actualBcdDate = this.getActualBcdDate(effectiveDate, bcd);
                } else {
                    actualBcdDate = effectiveDate;
                }

                //OneTimeBuy 를 저장한다.
                OneTimeBuy oneTimeBuy = new OneTimeBuy();
                oneTimeBuy.setBundle_id(null);
                oneTimeBuy.setState(state);
                oneTimeBuy.setTenant_id(organization.getTenant_id());
                oneTimeBuy.setOrganization_id(organization.getId());
                oneTimeBuy.setAccount_id(accountId);
                oneTimeBuy.setProduct_id(product_id);
                oneTimeBuy.setVersion(versionByEffectiveDate.getVersion());
                oneTimeBuy.setPlan_name(planName);
                oneTimeBuy.setPlan_display_name(plan.getDisplay_name());
                oneTimeBuy.setAmount(amount);
                oneTimeBuy.setCurrency(currency);
                oneTimeBuy.setEffective_date(DateUtils.parseDate(effectiveDate, "yyyy-MM-dd"));
                oneTimeBuy.setBilling_date(DateUtils.parseDate(actualBcdDate, "yyyy-MM-dd"));
                oneTimeBuy.setCreated_date(clock.getCurrentUtcTime());

                OneTimeBuy inserted = oneTimeBuyRepository.insert(oneTimeBuy);
                oneTimeBuyList.add(inserted);

                //billing_date 가 오늘날짜와 같거나 이전인 경우 immediatelyItems 에 추가한다.
                Date billingDate = DateUtils.parseDate(oneTimeBuy.getBilling_date(), new String[]{"yyyy-MM-dd"});
                Date currentUtcTime = clock.getCurrentUtcTime();
                if (billingDate.getTime() <= currentUtcTime.getTime()) {
                    immediatelyItems.add(inserted);
                }
            }
        }

        //immediatelyItems 항목들을 즉시 발송 하도록 한다.
        List<OneTimeBuy> immediately = sendOneTimeBuyImmediately(organization, clock, immediatelyItems);

        //oneTimeBuyList 에 immediately 의 업데이트사항이 이미 적용되었으므로 그대로 리턴한다.
        return oneTimeBuyList;
    }

    /**
     * 주어진 일회성 구매 인보이스 대기 항목들을 인보이스 발급하고, 송장 번호를 업데이트한다.
     *
     * @param organization   조직
     * @param clock          킬빌 현재 시각
     * @param oneTimeBuyList 일회성 구매 인보이스 대기 항목들
     * @return
     */
    @Override
    public List<OneTimeBuy> sendOneTimeBuyImmediately(Organization organization, Clock clock, List<OneTimeBuy> oneTimeBuyList) {
        //어카운트 별로 항목을 정리하도록 한다.
        Map<String, List<OneTimeBuy>> oneTimeBuyAccountMap = new HashMap<String, List<OneTimeBuy>>();
        for (OneTimeBuy oneTimeBuy : oneTimeBuyList) {
            String account_id = oneTimeBuy.getAccount_id();
            if (!oneTimeBuyAccountMap.containsKey(account_id)) {
                oneTimeBuyAccountMap.put(account_id, new ArrayList<OneTimeBuy>());
            }
            oneTimeBuyAccountMap.get(account_id).add(oneTimeBuy);
        }

        //어카운트 별로 charge invoice 를 실행한다.
        for (Map.Entry<String, List<OneTimeBuy>> entry : oneTimeBuyAccountMap.entrySet()) {
            String account_id = entry.getKey();
            List<OneTimeBuy> oneTimeBuys = entry.getValue();

            //인보이스 차지 요청의 바디를 생성한다.
            List<Map> invoiceCharges = new ArrayList<>();
            for (OneTimeBuy oneTimeBuy : oneTimeBuys) {
                //인보이스 아이템 아이디를 생성한다.
                oneTimeBuy.setInvoice_item_id(UUIDUtils.generateUUID());

                Map invoiceCharge = new HashMap();
                invoiceCharge.put("description", oneTimeBuy.getPlan_display_name());
                invoiceCharge.put("amount", oneTimeBuy.getAmount());
                invoiceCharge.put("currency", oneTimeBuy.getCurrency());
                invoiceCharge.put("planName", oneTimeBuy.getPlan_name());
                invoiceCharge.put("invoiceItemId", oneTimeBuy.getInvoice_item_id());
                invoiceCharge.put("startDate", oneTimeBuy.getEffective_date());

                invoiceCharges.add(invoiceCharge);
            }

            //인보이스 생성이 성공했을 경우 각 인보이스의 아이템에 해당하는 내용의
            //일회성 구매 항목의 아이템 아이디, 인보이스 아이디, 스테이터스, 빌링 데이트를 업데이트 한다.
            try {
                List<Map> result = killbillServiceFactory
                        .apiClient(organization.getTenant_api_key(), organization.getTenant_api_secret())
                        .invoiceApi().createInvoiceCharges(account_id, invoiceCharges);

                for (Map invoiceItem : result) {
                    String invoiceItemId = invoiceItem.get("invoiceItemId").toString();
                    for (OneTimeBuy oneTimeBuy : oneTimeBuys) {
                        if (oneTimeBuy.getInvoice_item_id().equals(invoiceItemId)) {
                            oneTimeBuy.setInvoice_id(invoiceItem.get("invoiceId").toString());
                            oneTimeBuy.setState(OneTimeBuyState.INVOICED.toString());
                            oneTimeBuy.setBilling_date(clock.getLocalDate());
                            oneTimeBuyRepository.update(oneTimeBuy);
                        }
                    }
                }
            }
            //실패한 경우, 각 일회성 구매 항목의 아이템 아이디를 초기화하고, 스테이터스를 업데이트 하도록 한다.
            catch (Exception ex) {
                for (OneTimeBuy oneTimeBuy : oneTimeBuys) {
                    oneTimeBuy.setInvoice_item_id(null);
                    oneTimeBuy.setState(OneTimeBuyState.CANCELED.toString());
                    oneTimeBuy.setBilling_date(clock.getLocalDate());
                    oneTimeBuyRepository.update(oneTimeBuy);
                }
            }
        }

        return oneTimeBuyList;
    }

    @Override
    public OneTimeBuy selectById(String organization_id, Long record_id) {
        return oneTimeBuyRepository.selectById(organization_id, record_id);
    }

    @Override
    public OneTimeBuy update(OneTimeBuy oneTimeBuy) {
        return oneTimeBuyRepository.update(oneTimeBuy);
    }

    @Override
    public OneTimeBuy cancelOneTimeBuy(String organization_id, Long record_id) {
        OneTimeBuy oneTimeBuy = this.selectById(organization_id, record_id);
        if (OneTimeBuyState.INVOICED.toString().equals(oneTimeBuy.getState())) {
            throw new ServiceException("INVOICED One Time Buy record can not ne canceled.");
        }
        oneTimeBuy.setState(OneTimeBuyState.CANCELED.toString());
        return oneTimeBuyRepository.update(oneTimeBuy);
    }

    @Override
    public Map selectByCondition(String organization_id, String searchKey, Long offset, Long limit) {
        return oneTimeBuyRepository.selectByCondition(organization_id, searchKey, offset, limit);
    }

    @Override
    public List<OneTimeBuy> selectByAccountId(String organization_id, String account_id) {
        return oneTimeBuyRepository.selectByAccountId(organization_id, account_id);
    }

    @Override
    public List<OneTimeBuy> selectBcdPendingBuys(Date billingDate) {
        return oneTimeBuyRepository.selectBcdPendingBuys(billingDate);
    }

    /**
     * 주어진 날짜에 해당하는 달의 bcd 날짜를 구한다.
     * ACCOUNT bdc 가 0 인 경우 effective_date 를 billing_date 로 결정함.
     * ACCOUNT bcd 를 effective_date 달에 대입하여 effective_date 달의 bcd 날짜를 구한다. => bcdDate
     * <p>
     * bcdDate 의 dd 가 effective_date dd 보다 같거나 클 경우, billing_date 는 bcdDate 이다.
     * bcdDate 의 dd 가 effective_date dd 보다 작을 경우, billing_date 는 bcdDate 의 MM + 1 을 한 달의 ACCOUNT bcd 대입 날짜이다.
     *
     * @param effectiveDate
     * @param bcd
     * @return
     */
    private Date getActualBcdDate(Date effectiveDate, int bcd) {

        //리턴할 billingDate
        Date billingDate = null;

        //bcd 가 0 인 경우 effectiveDate 를 billingDate 로 결정한다.
        if (bcd == 0) {
            billingDate = effectiveDate;
            return billingDate;
        }

        //actualBcd 는 해당 달의 마지막 day 를 수렴해 재조정한 bcd 이다.
        int actualBcd = bcd;

        Calendar cal = Calendar.getInstance();
        cal.setTime(effectiveDate);

        int year = cal.get(Calendar.YEAR);
        int month = cal.get(Calendar.MONTH);
        int day = cal.get(Calendar.DAY_OF_MONTH);

        //effectiveDate 달의 마지막 day 를 구한다.
        cal.set(Calendar.DAY_OF_MONTH, 1);
        cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
        int actualLastBcdDay = cal.get(Calendar.DAY_OF_MONTH);

        //actualBcd 가 actualLastBcdDay 보다 클 경우 actualBcd 를 재조정한다.
        if (actualBcd > actualLastBcdDay) {
            actualBcd = actualLastBcdDay;
        }

        //actualBcd 가 effective_date dd 보다 같거나 클 경우, billing_date 해당 달의 actualBcd 이다.
        if (actualBcd >= day) {
            cal.set(Calendar.DAY_OF_MONTH, actualBcd);
            return cal.getTime();
        }
        //actualBcd 가 effective_date dd 보다 작을 경우, billing_date 는 해당 달++ 달의 ACCOUNT bcd 대입 날짜이다.
        else {
            //다음달의 마지막 day 를 구한다.
            month++;
            cal.set(Calendar.DAY_OF_MONTH, 1);
            cal.set(Calendar.MONTH, month);
            cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
            actualLastBcdDay = cal.get(Calendar.DAY_OF_MONTH);

            //다음달의 actualBcd 를 구한다.
            actualBcd = bcd;
            if (actualBcd > actualLastBcdDay) {
                actualBcd = actualLastBcdDay;
            }
            //다음달의 최종 bcd 결제일을 구한다.
            cal.set(Calendar.DAY_OF_MONTH, actualBcd);

            return cal.getTime();
        }
    }
}
