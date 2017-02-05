package org.uengine.garuda.web.product.version;

import com.google.common.base.Enums;
import org.apache.commons.lang.enums.EnumUtils;
import org.killbill.billing.catalog.api.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.uengine.garuda.common.exception.ServiceException;
import org.uengine.garuda.killbill.KBRepository;
import org.uengine.garuda.killbill.KBService;
import org.uengine.garuda.killbill.KBServiceFactory;
import org.uengine.garuda.model.*;
import org.uengine.garuda.model.Product;
import org.uengine.garuda.model.catalog.*;
import org.uengine.garuda.model.catalog.Fixed;
import org.uengine.garuda.model.catalog.Plan;
import org.uengine.garuda.model.catalog.Price;
import org.uengine.garuda.model.catalog.Recurring;
import org.uengine.garuda.model.catalog.Tier;
import org.uengine.garuda.model.catalog.Usage;
import org.uengine.garuda.util.JsonUtils;
import org.uengine.garuda.util.StringUtils;
import org.uengine.garuda.web.organization.OrganizationRepository;
import org.uengine.garuda.web.product.ProductRepository;
import org.uengine.garuda.web.product.event.SubscriptionEventRepository;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.sql.*;
import java.sql.Date;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
public class ProductVersionServiceImpl implements ProductVersionService {

    @Autowired
    @Qualifier("config")
    private Properties config;

    @Autowired
    private ProductVersionRepository productVersionRepository;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private SubscriptionEventRepository subscriptionEventRepository;

    @Autowired
    private OrganizationRepository organizationRepository;

    private Logger logger = LoggerFactory.getLogger(ProductVersionService.class);

    /**
     * 플랜을 제외한 버젼 리스트를 반환한다.
     *
     * @param organization_id
     * @param product_id
     * @return
     * @throws IOException
     */
    @Override
    public List<Map> listVersionExcludePlans(String organization_id, String product_id) throws IOException {
        List<ProductVersion> productVersions = this.listVersion(organization_id, product_id);
        List<Map> mapList = new ArrayList<>();
        for (ProductVersion productVersion : productVersions) {
            Map<String, Object> map = JsonUtils.convertClassToMap(productVersion);
            map.remove("plans");
            mapList.add(map);
        }
        return mapList;
    }

    /**
     * 버젼 리스트를 반환한다.
     *
     * @param organization_id
     * @param product_id
     * @return
     */
    @Override
    public List<ProductVersion> listVersion(String organization_id, String product_id) {
        return productVersionRepository.selectByProductId(organization_id, product_id);
    }

    /**
     * 주어진 버젼을 반환한다.
     *
     * @param organization_id
     * @param product_id
     * @param version
     * @return
     */
    @Override
    public ProductVersion getVersion(String organization_id, String product_id, Long version) {
        ProductVersion productVersion = productVersionRepository.selectByVersion(organization_id, product_id, version);
        return versionWithPlanCount(productVersion);
    }

    /**
     * 현재 버젼을 반환한다.
     *
     * @param organization_id
     * @param product_id
     * @return
     */
    @Override
    public ProductVersion getCurrentVersion(String organization_id, String product_id) {
        ProductVersion productVersion = productVersionRepository.selectByCurrentVersion(organization_id, product_id);
        return versionWithPlanCount(productVersion);
    }

    /**
     * 신규 버젼을 생성한다.
     *
     * @param organization_id
     * @param product_id
     * @param productVersion
     * @return
     */
    @Override
    public ProductVersion createVersion(String organization_id, String product_id, ProductVersion productVersion) {
        //기본 정보 설정
        Organization organization = organizationRepository.selectById(organization_id);
        productVersion.setOrganization_id(organization_id);
        productVersion.setProduct_id(product_id);
        productVersion.setTenant_id(organization.getTenant_id());

        //effective date 가 최신버젼보다 이전이면 등록불가.
        ProductVersion maxVersion = productVersionRepository.selectMaxVersion(organization_id, product_id);
        if (maxVersion != null) {
            java.sql.Date effective_max_date = maxVersion.getEffective_date();

            Date effective_date = productVersion.getEffective_date();
            if (effective_date.getTime() <= effective_max_date.getTime()) {
                throw new ServiceException("The effective date can not be earlier than the date of the previous version.");
            }
        }

        //플랜 벨리데이션
        validatePlans(productVersion.getPlans());

        //플랜 아이디와 유서지 신규 생성 및 밸리데이션
        productVersion = createAndValidatePlanAndUsageId(organization_id, product_id, productVersion);

        //버젼 저장
        ProductVersion createdVersion = productVersionRepository.insertVersion(productVersion);

        //is_current 가 Y 일경우 current 업데이트
        if ("Y".equals(productVersion.getIs_current())) {
            productVersionRepository.updateVersionAsCurrent(organization_id, product_id, createdVersion.getVersion());
        }

        return versionWithPlanCount(createdVersion);
    }

    /**
     * 버젼을 업데이트 한다.
     *
     * @param organization_id
     * @param product_id
     * @param version
     * @param productVersion
     * @return
     */
    @Override
    public ProductVersion updateVersion(String organization_id, String product_id, Long version, ProductVersion productVersion) {
        //기본 정보 설정
        Organization organization = organizationRepository.selectById(organization_id);
        productVersion.setOrganization_id(organization_id);
        productVersion.setProduct_id(product_id);
        productVersion.setTenant_id(organization.getTenant_id());

        ProductVersion existVersion = this.getVersion(organization_id, product_id, version);
        if (existVersion == null) {
            throw new ServiceException("Not found version : " + product_id + " , " + version);
        }
        productVersion.setVersion(version);

        //effective date 이전버젼과 이후버젼 사이여야 한다.
        Date effective_date = productVersion.getEffective_date();
        ProductVersion nextVersion = this.getVersion(organization_id, product_id, version + 1);
        ProductVersion prevVersion = this.getVersion(organization_id, product_id, version - 1);

        if (nextVersion != null) {
            java.sql.Date effective_next_date = nextVersion.getEffective_date();
            if (effective_date.getTime() >= effective_next_date.getTime()) {
                throw new ServiceException("The effective date can not be later than next version.");
            }
        }

        if (prevVersion != null) {
            java.sql.Date effective_prev_date = prevVersion.getEffective_date();
            if (effective_date.getTime() <= effective_prev_date.getTime()) {
                throw new ServiceException("The effective date can not be earlier than the date of the previous version.");
            }
        }

        //플랜 벨리데이션
        validatePlans(productVersion.getPlans());

        //플랜 아이디와 유서지 신규 생성
        productVersion = createAndValidatePlanAndUsageId(organization_id, product_id, productVersion);

        //버젼 업데이트
        ProductVersion updatedVersion = productVersionRepository.updateVersion(productVersion);

        //is_current 가 Y 일경우 current 업데이트
        if ("Y".equals(productVersion.getIs_current())) {
            productVersionRepository.updateVersionAsCurrent(organization_id, product_id, updatedVersion.getVersion());
        }

        return versionWithPlanCount(updatedVersion);
    }


    /**
     * 주어진 버젼을 current version 으로 변경한다.
     *
     * @param organization_id
     * @param product_id
     * @param version
     * @return
     */
    @Override
    public int updateVersionAsCurrent(String organization_id, String product_id, Long version) {
        return productVersionRepository.updateVersionAsCurrent(organization_id, product_id, version);
    }


    /**
     * 주어진 버젼을 삭제한다.
     *
     * @param organization_id
     * @param product_id
     * @param version
     * @return
     */
    @Override
    public int deleteVersion(String organization_id, String product_id, Long version) {
        ProductVersion existVersion = this.getVersion(organization_id, product_id, version);
        if (existVersion == null) {
            throw new ServiceException("Not found version : " + product_id + " , " + version);
        }
        Long total_number = new Long(0);
        for (Plan plan : existVersion.getPlans()) {
            Long number = plan.getNumber_of_subscriptions_referenced_by_version();
            number = number == null ? 0 : number;
            total_number = total_number + number;
        }
        if (total_number > 0) {
            throw new ServiceException("Failed to delete cause by number_of_subscriptions_referenced_by_version is not zero.");
        }
        return productVersionRepository.deleteVersion(organization_id, product_id, version);
    }

    /**
     * 프로덕트 버젼의 플랜마다 현재 버젼을 쓰고있는 서브스크립션 수와 플랜을 쓰고있는 서브스크립션 수를 덧대어 반환한다.
     *
     * @param productVersion
     * @return
     */
    private ProductVersion versionWithPlanCount(ProductVersion productVersion) {
        if (productVersion != null) {
            List<Map> planCounts = subscriptionEventRepository.selectSubscriptionCountByProductVersion(
                    productVersion.getOrganization_id(),
                    productVersion.getProduct_id(),
                    productVersion.getVersion());

            for (Plan plan : productVersion.getPlans()) {
                for (Map planCount : planCounts) {
                    Long number_of_subscriptions_referenced_by_version = (Long) planCount.get("number_of_subscriptions_referenced_by_version");
                    Long number_of_subscriptions = (Long) planCount.get("number_of_subscriptions");
                    String plan_name = (String) planCount.get("plan_name");

                    if (!StringUtils.isEmpty(plan.getName())) {
                        if (plan.getName().equals(plan_name)) {
                            plan.setNumber_of_subscriptions_referenced_by_version(number_of_subscriptions_referenced_by_version);
                            plan.setNumber_of_subscriptions(number_of_subscriptions);
                        }
                    }
                }
            }
        }
        return productVersion;
    }

    /**
     * 생성 또는 업데이트 할 프로덕트 버젼의 플랜들 중 플랜아이디와 유서지아이디를 생성해준다.
     *
     * @param organization_id
     * @param product_id
     * @param productVersion
     * @return
     */
    private ProductVersion createAndValidatePlanAndUsageId(String organization_id, String product_id, ProductVersion productVersion) {

        Product product = productRepository.selectProductById(organization_id, product_id);
        if (product == null) {
            throw new ServiceException("Not found product : " + product_id);
        }
        Long plan_seq = product.getPlan_seq();
        Long usage_seq = product.getUsage_seq();
        Long plan_org_seq = product.getPlan_seq();
        Long usage_org_seq = product.getUsage_seq();
        List<Plan> plans = productVersion.getPlans();

        List<String> planNameList = new ArrayList<>();
        List<String> usageNameList = new ArrayList<>();

        for (Plan plan : plans) {
            //plan 아이디들과 usage 아이디들이 없다면 아이디를 신규로 생성
            if (StringUtils.isEmpty(plan.getName())) {
                plan_seq++;
                plan.setName(createPlanUsageName(product_id, plan_seq, "PL"));
            }
            //있다면 Id 체크
            else {
                validPlanUsageName(plan.getName(), product_id, plan_org_seq, "PL");
            }
            planNameList.add(plan.getName());

            List<Phase> initialPhases = plan.getInitialPhases();
            if (initialPhases != null && !initialPhases.isEmpty()) {
                for (Phase initialPhase : initialPhases) {
                    List<Usage> usages = initialPhase.getUsages();
                    for (Usage usage : usages) {
                        if (StringUtils.isEmpty(usage.getName())) {
                            usage_seq++;
                            usage.setName(createPlanUsageName(product_id, usage_seq, "USG"));
                        } else {
                            validPlanUsageName(usage.getName(), product_id, usage_org_seq, "USG");
                        }
                        usageNameList.add(usage.getName());
                    }
                }
            }

            Phase finalPhase = plan.getFinalPhase();
            List<Usage> usages = finalPhase.getUsages();
            for (Usage usage : usages) {
                if (StringUtils.isEmpty(usage.getName())) {
                    usage_seq++;
                    usage.setName(createPlanUsageName(product_id, usage_seq, "USG"));
                } else {
                    validPlanUsageName(usage.getName(), product_id, usage_org_seq, "USG");
                }
                usageNameList.add(usage.getName());
            }
        }

        //중복된 플랜 아이디가 있는지 체크
        if (hsaDuplicate(planNameList)) {
            throw new ServiceException("Duplicated plan id founded in : " + product_id);
        }

        //중복 유서지 아이디 체크
        if (hsaDuplicate(usageNameList)) {
            throw new ServiceException("Duplicated usage id founded in : " + product_id);
        }

        //변경된 plan_seq 와 usage_seq 를 업데이트
        productRepository.updatePlanUsageSeq(organization_id, product_id, plan_seq, usage_seq);
        return productVersion;
    }

    private boolean hsaDuplicate(List<String> list) {
        List<String> temp = new ArrayList<>();
        boolean duplicate = false;
        for (String s : list) {
            if (temp.contains(s)) {
                duplicate = true;
                break;
            } else {
                temp.add(s);
            }
        }
        return duplicate;
    }

    /**
     * 플랜 또는 유서지 아이디를 생성해 리턴한다.
     *
     * @param product_id
     * @param seq
     * @param prefix
     * @return
     */
    private String createPlanUsageName(String product_id, Long seq, String prefix) {
        String id = prefix + "-" + String.format("%06d", seq);
        return product_id + "-" + id;
    }

    private void validPlanUsageName(String plan_name, String product_id, Long currentSeq, String prefix) {
        //TODO 플랜 아이디 밸리데이션
        //앞 형식이 프로덕트 아이디인지 체크.
        //뒤 형식이 플랜 아이디인지 체크.
        //버젼안에 두가지 이상 중복 아이디가 있는지 체크
        //프로덕트의 seq 보다 큰 값이 있는지 체크

        try {
            boolean isValid = true;
            if (plan_name == null || plan_name.length() != (22 + prefix.length())) {
                isValid = false;
            }
            String subProductId = plan_name.substring(0, 14);
            String subPlanId = plan_name.substring(14);
            if (!subProductId.equals(product_id)) {
                isValid = false;
            }
            if (!subPlanId.startsWith("-" + prefix + "-")) {
                isValid = false;
            }
            String subPlanId2 = subPlanId.substring(2 + prefix.length());
            Long seq = Long.parseLong(subPlanId2);
            if (seq == null || currentSeq < seq || seq == 0) {
                isValid = false;
            }
            if (!isValid) {
                throw new ServiceException("Invalid " + prefix + " : " + plan_name);
            }
        } catch (Exception ex) {
            throw new ServiceException("Invalid " + prefix + " : " + plan_name);
        }
    }

    /**
     * 플랜의 스트럭쳐를 밸리데이팅 한다.
     *
     * @param plans
     */
    private void validatePlans(List<Plan> plans) {
        for (Plan plan : plans) {
            if (StringUtils.isEmpty(plan.getDisplay_name())) {
                throw new ServiceException("Field display_name is required for plan.");
            }

            if (StringUtils.isEmpty(plan.getIs_active()) ||
                    (!"Y".equals(plan.getIs_active()) && !"N".equals(plan.getIs_active()))) {
                throw new ServiceException("Field  is_active name is required for plan. (Y or N)");
            }

            if (plan.getFinalPhase() == null) {
                throw new ServiceException("Final phase is required in plan : " + plan.getDisplay_name());
            }
            validatePhase(plan.getFinalPhase(), plan);

            if (plan.getInitialPhases() != null && !plan.getInitialPhases().isEmpty()) {
                for (Phase phase : plan.getInitialPhases()) {
                    validatePhase(phase, plan);
                }
            }
        }
    }

    /**
     * Phase 를 체크한다.
     *
     * @param phase
     * @param plan
     */
    private void validatePhase(Phase phase, Plan plan) {

        //phase type check
        if (!Enums.getIfPresent(PhaseType.class, phase.getType()).isPresent()) {
            throw new ServiceException(phase.getType() + " is invalid phase type : " + plan.getDisplay_name());
        }

        //duration check
        if (phase.getDuration() == null) {
            throw new ServiceException("There is no phase duration : " + plan.getDisplay_name());
        }

        //TimeUnit
        if (!Enums.getIfPresent(TimeUnit.class, phase.getDuration().getUnit()).isPresent()) {
            throw new ServiceException(phase.getDuration().getUnit() + " is invalid duration time unit : " + plan.getDisplay_name());
        }

        //duration number
        if (!TimeUnit.UNLIMITED.toString().equals(phase.getDuration().getUnit()) && phase.getDuration().getNumber() == null) {
            throw new ServiceException(phase.getDuration().getUnit() + " need duration number  : " + plan.getDisplay_name());
        }

        if (phase.getFixed() == null && phase.getRecurring() == null && phase.getUsages() == null) {
            throw new ServiceException("Some phase has no fixed,recurring,usages in : " + plan.getDisplay_name());
        } else if (phase.getUsages().size() == 0) {
            throw new ServiceException("Some phase has no fixed,recurring,usages in : " + plan.getDisplay_name());
        }

        Fixed fixed = phase.getFixed();
        Recurring recurring = phase.getRecurring();
        List<Usage> usages = phase.getUsages();

        //fixed
        if (fixed != null) {
            validatePriceList(fixed.getFixedPrice(), plan);
        }


        //recurring
        if (recurring != null) {
            if (!Enums.getIfPresent(BillingPeriod.class, recurring.getBillingPeriod()).isPresent()) {
                throw new ServiceException(recurring.getBillingPeriod() + " is invalid billing period : " + plan.getDisplay_name());
            }
            validatePriceList(recurring.getRecurringPrice(), plan);
        }

        //usage
        for (Usage usage : usages) {
            if (StringUtils.isEmpty(usage.getDisplay_name())) {
                throw new ServiceException("Usage display name is required : " + plan.getDisplay_name());
            }

            if (!Enums.getIfPresent(BillingMode.class, usage.getBillingMode()).isPresent()) {
                throw new ServiceException(usage.getBillingMode() + " is invalid usage billing mode : " + plan.getDisplay_name());
            }

            if (!Enums.getIfPresent(UsageType.class, usage.getUsageType()).isPresent()) {
                throw new ServiceException(usage.getUsageType() + " is invalid usage type : " + plan.getDisplay_name());
            }

            if (!Enums.getIfPresent(BillingPeriod.class, usage.getBillingPeriod()).isPresent()) {
                throw new ServiceException(usage.getBillingPeriod() + " is invalid usage billing period : " + plan.getDisplay_name());
            }

            if (usage.getTiers() == null || usage.getTiers().isEmpty()) {
                throw new ServiceException("Tiers are required : " + plan.getDisplay_name());
            }

            //Tier check
            for (Tier tier : usage.getTiers()) {
                if (StringUtils.isEmpty(tier.getUnit())) {
                    throw new ServiceException("Some usage has empty unit name : " + plan.getDisplay_name());
                }

                Pattern pattern = Pattern.compile("\\s");
                Matcher matcher = pattern.matcher(tier.getUnit());
                boolean found = matcher.find();
                if (found) {
                    throw new ServiceException("Some usage has white space unit name : " + plan.getDisplay_name());
                }

                if (tier.getSize() == null || tier.getSize() < 0) {
                    throw new ServiceException("There is invalid tier size value : " + plan.getDisplay_name());
                }

                if (tier.getMax() == null || tier.getMax() < 0) {
                    throw new ServiceException("There is invalid tier max value : " + plan.getDisplay_name());
                }

                validatePriceList(tier.getPrices(), plan);
            }
        }
    }

    /**
     * 프라이스 리스트를 체크한다.
     *
     * @param priceList
     * @param plan
     */
    private void validatePriceList(List<Price> priceList, Plan plan) {
        if (priceList.isEmpty()) {
            throw new ServiceException("There is a phase using no price entry : " + plan.getDisplay_name());
        }
        for (Price price : priceList) {
            if (StringUtils.isEmpty(price.getCurrency())) {
                throw new ServiceException("There is empty currency in price entry : " + plan.getDisplay_name());
            }
            if (price.getValue() == null || price.getValue().compareTo(BigDecimal.ZERO) == -1) {
                throw new ServiceException("There is invalid currency value in price entry : " + plan.getDisplay_name());
            }
        }
    }
}
