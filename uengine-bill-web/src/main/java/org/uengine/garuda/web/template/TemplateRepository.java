/**
 * Copyright (C) 2011 Flamingo Project (http://www.opencloudengine.org).
 * <p/>
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * <p/>
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * <p/>
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package org.uengine.garuda.web.template;

import org.uengine.garuda.model.NotificationType;
import org.uengine.garuda.model.Product;
import org.uengine.garuda.model.Template;

import java.util.List;
import java.util.Map;

/**
 * @author Seungpil PARK
 */
public interface TemplateRepository {

    String NAMESPACE = TemplateRepository.class.getName();

    List<Template> selectByOrgId(String organization_id);

    List<Template> selectByOrgIdAndType(String organization_id, String notification_type);

    Template selectByOrgIdAndTypeAndLocale(String organization_id, String notification_type, String locale);

    Template insertTemplate(Template template);

    Template updateTemplate(Template template);

    Template setDefaultTemplate(String organization_id, String notification_type, String locale);

    int deleteByOrgIdAndType(String organization_id, String notification_type);

    int deleteByOrgIdAndTypeAndLocale(String organization_id, String notification_type, String locale);

    Template getDefaultTemplate(NotificationType notificationType);
}
