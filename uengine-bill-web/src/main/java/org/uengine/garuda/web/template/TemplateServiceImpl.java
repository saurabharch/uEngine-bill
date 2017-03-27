package org.uengine.garuda.web.template;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.uengine.garuda.killbill.KBRepository;
import org.uengine.garuda.model.NotificationType;
import org.uengine.garuda.model.Organization;
import org.uengine.garuda.model.Product;
import org.uengine.garuda.model.Template;
import org.uengine.garuda.web.organization.OrganizationRepository;
import org.uengine.garuda.web.product.ProductRepository;
import org.uengine.garuda.web.product.ProductService;
import org.uengine.garuda.web.product.event.SubscriptionEventRepository;

import java.util.*;

@Service
public class TemplateServiceImpl implements TemplateService {

    @Autowired
    @Qualifier("config")
    private Properties config;

    @Autowired
    private TemplateRepository templateRepository;

    @Autowired
    private KBRepository kbRepository;

    @Autowired
    private OrganizationRepository organizationRepository;

    private Logger logger = LoggerFactory.getLogger(TemplateService.class);


    /**
     * 주어진 조직의 모든 템플릿을 불러온다.
     *
     * @param organization_id
     * @return
     */
    @Override
    public Map selectByOrgId(String organization_id) {
        List<Template> templates = templateRepository.selectByOrgId(organization_id);
        if (templates == null) {
            templates = new ArrayList<Template>();
        }

        //타입별로 정렬
        Map<String, ArrayList<Template>> map = new HashMap();
        for (Template template : templates) {
            String notification_type = template.getNotification_type();
            if (!map.containsKey(notification_type)) {
                map.put(notification_type, new ArrayList<Template>());
            }
            map.get(notification_type).add(template);
        }

        //타입별로 누락된 템플릿 인서트
        for (int i = 0; i < NotificationType.values().length; i++) {
            String requiredType = NotificationType.values()[i].toString();
            if (isEmptyTemplate(requiredType, map)) {
                map.get(requiredType).add(this.insertDefaultTemplate(organization_id, requiredType));
            }
        }
        return map;
    }

    /**
     * 주어진 조직의 알림타입에 디폴트 템플릿을 생성한다.
     *
     * @param organization_id
     * @param notification_type
     * @return
     */
    private Template insertDefaultTemplate(String organization_id, String notification_type) {

        Organization organization = organizationRepository.selectById(organization_id);
        if (organization == null) {
            return null;
        }
        Template template = this.getDefaultTemplate(NotificationType.valueOf(notification_type));
        template.setIs_default("Y");
        return this.insertTemplate(organization, notification_type, template.getLocale(), template);
    }

    /**
     * 주어진 조직의 알림 타입의 모든 템플릿을 가져온다.
     *
     * @param organization_id
     * @param notification_type
     * @return
     */
    @Override
    public Map selectByOrgIdAndType(String organization_id, String notification_type) {
        List<Template> templates = templateRepository.selectByOrgIdAndType(organization_id, notification_type);
        if (templates == null || templates.isEmpty()) {
            Template template = this.insertDefaultTemplate(organization_id, notification_type);
            templates = new ArrayList<>();
            templates.add(template);
        }
        Map map = new HashMap();
        map.put(notification_type, templates);
        return map;
    }

    @Override
    public Template selectByOrgIdAndTypeAndLocale(String organization_id, String notification_type, String locale) {
        return templateRepository.selectByOrgIdAndTypeAndLocale(organization_id, notification_type, locale);
    }

    @Override
    public Template insertTemplate(Organization organization, String notification_type, String locale, Template template) {
        Template existTemplate = this.selectByOrgIdAndTypeAndLocale(organization.getId(), notification_type, locale);

        //기존에 템플릿이 있다면 업데이트 한다.
        if (existTemplate != null) {
            existTemplate = this.updateTemplate(organization, notification_type, locale, template);
        }
        //기존에 템플릿이 없다면 신규 저장
        else {
            template.setOrganization_id(organization.getId());
            template.setTenant_id(organization.getTenant_id());
            template.setTenant_record_id(this.getTenantRecordId(organization));
            template.setNotification_type(notification_type);
            template.setLocale(locale);
            existTemplate = templateRepository.insertTemplate(template);
        }
        if ("Y".equals(template.getIs_default())) {
            this.setDefaultTemplate(organization.getId(), notification_type, locale);
        }
        return existTemplate;
    }

    @Override
    public Template updateTemplate(Organization organization, String notification_type, String locale, Template template) {
        template.setOrganization_id(organization.getId());
        template.setNotification_type(notification_type);
        template.setLocale(locale);
        return templateRepository.updateTemplate(template);
    }

    @Override
    public Template setDefaultTemplate(String organization_id, String notification_type, String locale) {
        return templateRepository.setDefaultTemplate(organization_id, notification_type, locale);
    }

    @Override
    public int deleteByOrgIdAndType(String organization_id, String notification_type) {
        return templateRepository.deleteByOrgIdAndType(organization_id, notification_type);
    }

    @Override
    public int deleteByOrgIdAndTypeAndLocale(String organization_id, String notification_type, String locale) {
        return templateRepository.deleteByOrgIdAndTypeAndLocale(organization_id, notification_type, locale);
    }

    @Override
    public Template getDefaultTemplate(NotificationType notificationType) {
        return templateRepository.getDefaultTemplate(notificationType);
    }

    /**
     * 조직의 테넌트 레코드 아이디를 얻어온다.
     *
     * @param organization
     * @return
     */
    private Long getTenantRecordId(Organization organization) {
        Map tenantMap = kbRepository.getTenantById(organization.getTenant_id());
        if (tenantMap == null) {
            return null;
        }
        return Long.parseLong(tenantMap.get("record_id") + "");
    }

    /**
     * 템플릿 타입별 해쉬맵에서 주어진 타입이 비었는지 확인하고 비었을 경우 템플릿 어레이를 추가한다.
     *
     * @param requiredType
     * @param map
     * @return
     */
    private boolean isEmptyTemplate(String requiredType, Map<String, ArrayList<Template>> map) {
        if (map.get(requiredType) == null) {
            map.put(requiredType, new ArrayList<Template>());
            return true;
        }
        if (map.get(requiredType).size() < 1) {
            map.put(requiredType, new ArrayList<Template>());
            return true;
        }
        return false;
    }
}
