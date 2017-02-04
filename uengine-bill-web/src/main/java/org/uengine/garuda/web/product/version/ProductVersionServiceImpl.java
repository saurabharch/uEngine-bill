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

    @Autowired
    private KBRepository kbRepository;

    @Autowired
    private KBServiceFactory killbillServiceFactory;

    @Autowired
    private KBService kbService;

    private Logger logger = LoggerFactory.getLogger(ProductVersionService.class);


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

    @Override
    public List<ProductVersion> listVersion(String organization_id, String product_id) {
        return productVersionRepository.selectByProductId(organization_id, product_id);
    }

    @Override
    public ProductVersion getVersion(String organization_id, String product_id, Long version) {
        ProductVersion productVersion = productVersionRepository.selectByVersion(organization_id, product_id, version);
        return versionWithPlanCount(productVersion);
    }

    @Override
    public ProductVersion getCurrentVersion(String organization_id, String product_id) {
        ProductVersion productVersion = productVersionRepository.selectByCurrentVersion(organization_id, product_id);
        return versionWithPlanCount(productVersion);
    }

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

        //플랜 아이디와 유서지 아이디가 없다면 신규 생성
        productVersion = createPlanAndUsageId(organization_id, product_id, productVersion);

        //버젼 저장
        ProductVersion createdVersion = productVersionRepository.insertVersion(productVersion);

        //is_current 가 Y 일경우 current 업데이트
        if ("Y".equals(productVersion.getIs_current())) {
            productVersionRepository.updateVersionAsCurrent(organization_id, product_id, createdVersion.getVersion());
        }

        return versionWithPlanCount(createdVersion);
    }

    @Override
    public ProductVersion updateVersion(String organization_id, String product_id, Long version, ProductVersion productVersion) {
        return null;
    }

    @Override
    public int updateVersionAsCurrent(String organization_id, String product_id, Long version) {
        return 0;
    }

    @Override
    public int deleteVersion(String organization_id, String product_id, Long version) {
        return 0;
    }

    /**
     * 프로덕트 버젼의 플랜마다 현재 버젼을 쓰고있는 서브스크립션 수와 플랜을 쓰고있는 서브스크립션 수를 덧대어 반환한다.
     *
     * @param productVersion
     * @return
     */
    private ProductVersion versionWithPlanCount(ProductVersion productVersion) {
        List<Map> planCounts = subscriptionEventRepository.selectSubscriptionCountByProductVersion(
                productVersion.getOrganization_id(),
                productVersion.getProduct_id(),
                productVersion.getVersion());

        for (Plan plan : productVersion.getPlans()) {
            for (Map planCount : planCounts) {
                Long count_by_version = (Long) planCount.get("count_by_version");
                Long count_total = (Long) planCount.get("count_total");
                String plan_id = (String) planCount.get("plan_id");

                if (!StringUtils.isEmpty(plan.getId())) {
                    if (plan.getId().equals(plan_id)) {
                        plan.setSubscription_count_for_version(count_by_version);
                        plan.setSubscription_count_total(count_total);
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
    private ProductVersion createPlanAndUsageId(String organization_id, String product_id, ProductVersion productVersion) {
        //plan 아이디들과 usage 아이디들이 없다면 아이디를 신규로 생성
        Product product = productRepository.selectProductById(organization_id, product_id);
        if (product == null) {
            throw new ServiceException("Not found product : " + product_id);
        }
        Long plan_seq = product.getPlan_seq();
        Long usage_seq = product.getUsage_seq();
        List<Plan> plans = productVersion.getPlans();
        for (Plan plan : plans) {
            if (StringUtils.isEmpty(plan.getId())) {
                plan_seq++;
                plan.setId(createPlanUsageId(product_id, plan_seq, "PL"));
            }

            List<Phase> initialPhases = plan.getInitialPhases();
            for (Phase initialPhase : initialPhases) {
                List<Usage> usages = initialPhase.getUsages();
                for (Usage usage : usages) {
                    if (StringUtils.isEmpty(usage.getId())) {
                        usage_seq++;
                        usage.setId(createPlanUsageId(product_id, usage_seq, "USG"));
                    }
                }
            }

            Phase finalPhase = plan.getFinalPhase();
            List<Usage> usages = finalPhase.getUsages();
            for (Usage usage : usages) {
                if (StringUtils.isEmpty(usage.getId())) {
                    usage_seq++;
                    usage.setId(createPlanUsageId(product_id, usage_seq, "USG"));
                }
            }
        }
        //변경된 plan_seq 와 usage_seq 를 업데이트
        productRepository.updatePlanUsageSeq(organization_id, product_id, plan_seq, usage_seq);
        return productVersion;
    }

    private String createPlanUsageId(String product_id, Long seq, String prefix) {
        String id = prefix + "-" + String.format("%06d", seq);
        return product_id + "-" + id;
    }

    /**
     * 플랜의 스트럭쳐를 밸리데이팅 한다.
     *
     * @param plans
     */
    private void validatePlans(List<Plan> plans) {
        for (Plan plan : plans) {
            if (StringUtils.isEmpty(plan.getName())) {
                throw new ServiceException("There is no named plan.");
            }

            if (plan.getFinalPhase() == null) {
                throw new ServiceException("Final phase is required in plan name : " + plan.getName());
            }
            validatePhase(plan.getFinalPhase(), plan);

            for (Phase phase : plan.getInitialPhases()) {
                validatePhase(phase, plan);
            }
        }
    }

    private void validatePhase(Phase phase, Plan plan) {

        //name check
        if (!Enums.getIfPresent(PhaseType.class, phase.getType()).isPresent()) {
            throw new ServiceException(phase.getType() + " is invalid phase type : " + plan.getName());
        }

        //duration check
        if (phase.getDuration() == null) {
            throw new ServiceException("There is no phase duration : " + plan.getName());
        }

        //TimeUnit
        if (!Enums.getIfPresent(TimeUnit.class, phase.getDuration().getUnit()).isPresent()) {
            throw new ServiceException(phase.getDuration().getUnit() + " is invalid duration time unit : " + plan.getName());
        }

        //duration number
        if (!TimeUnit.UNLIMITED.equals(phase.getDuration().getUnit()) && phase.getDuration().getNumber() == null) {
            throw new ServiceException(phase.getDuration().getUnit() + " need duration number  : " + plan.getName());
        }

        if (phase.getFixed() == null && phase.getRecurring() == null && phase.getUsages() == null) {
            throw new ServiceException("Some phase has no fixed,recurring,usages in : " + plan.getName());
        } else if (phase.getUsages().size() == 0) {
            throw new ServiceException("Some phase has no fixed,recurring,usages in : " + plan.getName());
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
                throw new ServiceException(recurring.getBillingPeriod() + " is invalid billing period : " + plan.getName());
            }
            validatePriceList(recurring.getRecurringPrice(), plan);
        }

        //usage
        for (Usage usage : usages) {
            if (StringUtils.isEmpty(usage.getName())) {
                throw new ServiceException("Usage name is required : " + plan.getName());
            }

            if (!Enums.getIfPresent(BillingMode.class, usage.getBillingMode()).isPresent()) {
                throw new ServiceException(usage.getBillingMode() + " is invalid usage billing mode : " + plan.getName());
            }

            if (!Enums.getIfPresent(UsageType.class, usage.getUsageType()).isPresent()) {
                throw new ServiceException(usage.getUsageType() + " is invalid usage type : " + plan.getName());
            }

            if (!Enums.getIfPresent(BillingPeriod.class, usage.getBillingPeriod()).isPresent()) {
                throw new ServiceException(usage.getBillingPeriod() + " is invalid usage billing period : " + plan.getName());
            }

            if (usage.getTiers() == null || usage.getTiers().isEmpty()) {
                throw new ServiceException("Tiers are required : " + plan.getName());
            }

            //Tier check
            for (Tier tier : usage.getTiers()) {
                if (StringUtils.isEmpty(tier.getUnit())) {
                    throw new ServiceException("Some usage has empty unit name : " + plan.getName());
                }

                Pattern pattern = Pattern.compile("\\s");
                Matcher matcher = pattern.matcher(tier.getUnit());
                boolean found = matcher.find();
                if (found) {
                    throw new ServiceException("Some usage has white space unit name : " + plan.getName());
                }

                if (tier.getSize() == null || tier.getSize() < 0) {
                    throw new ServiceException("There is invalid tier size value : " + plan.getName());
                }

                if (tier.getMax() == null || tier.getMax() < 0) {
                    throw new ServiceException("There is invalid tier max value : " + plan.getName());
                }

                validatePriceList(tier.getPrices(), plan);
            }
        }
    }

    private void validatePriceList(List<Price> priceList, Plan plan) {
        if (priceList.isEmpty()) {
            throw new ServiceException("There is a phase using no price entry : " + plan.getName());
        }
        for (Price price : priceList) {
            if (StringUtils.isEmpty(price.getCurrency())) {
                throw new ServiceException("There is empty currency in price entry : " + plan.getName());
            }
            if (price.getValue() == null || price.getValue().compareTo(BigDecimal.ZERO) == -1) {
                throw new ServiceException("There is invalid currency value in price entry : " + plan.getName());
            }
        }
    }
}
