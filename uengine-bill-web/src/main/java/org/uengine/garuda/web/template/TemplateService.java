package org.uengine.garuda.web.template;

import org.uengine.garuda.model.NotificationType;
import org.uengine.garuda.model.Organization;
import org.uengine.garuda.model.Product;
import org.uengine.garuda.model.Template;

import java.util.List;
import java.util.Map;

public interface TemplateService {

    Map selectByOrgId(String organization_id);

    Map selectByOrgIdAndType(String organization_id, String notification_type);

    Template selectByOrgIdAndTypeAndLocale(String organization_id, String notification_type, String locale);

    Template insertTemplate(Organization organization, String notification_type, String locale, Template template);

    Template updateTemplate(Organization organization, String notification_type, String locale, Template template);

    Template setDefaultTemplate(String organization_id, String notification_type, String locale);

    int deleteByOrgIdAndType(String organization_id, String notification_type);

    int deleteByOrgIdAndTypeAndLocale(String organization_id, String notification_type, String locale);

    Template getDefaultTemplate(NotificationType notificationType);
}
