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

import org.mybatis.spring.SqlSessionTemplate;
import org.opencloudengine.garuda.common.exception.ServiceException;
import org.opencloudengine.garuda.util.ResourceUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.uengine.garuda.common.repository.PersistentRepositoryImpl;
import org.uengine.garuda.model.NotificationType;
import org.uengine.garuda.model.Template;

import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.nio.file.Files;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author Seungpil PARK
 */
@Repository
public class TemplateRepositoryImpl extends PersistentRepositoryImpl<String, Object> implements TemplateRepository {

    @Override
    public String getNamespace() {
        return this.NAMESPACE;
    }

    @Autowired
    public TemplateRepositoryImpl(SqlSessionTemplate sqlSessionTemplate) {
        super.setSqlSessionTemplate(sqlSessionTemplate);
    }

    @Override
    public List<Template> selectByOrgId(String organization_id) {
        return this.getSqlSessionTemplate().selectList(this.getNamespace() + ".selectByOrgId", organization_id);
    }

    @Override
    public List<Template> selectByOrgIdAndType(String organization_id, String notification_type) {
        Map map = new HashMap();
        map.put("organization_id", organization_id);
        map.put("notification_type", notification_type);
        return this.getSqlSessionTemplate().selectList(this.getNamespace() + ".selectByOrgIdAndType", map);
    }

    @Override
    public Template selectByOrgIdAndTypeAndLocale(String organization_id, String notification_type, String locale) {
        Map map = new HashMap();
        map.put("organization_id", organization_id);
        map.put("notification_type", notification_type);
        map.put("locale", locale);
        return this.getSqlSessionTemplate().selectOne(this.getNamespace() + ".selectByOrgIdAndTypeAndLocale", map);
    }

    @Override
    public Template insertTemplate(Template template) {
        this.getSqlSessionTemplate().insert(this.getNamespace() + ".insertTemplate", template);
        return this.selectByOrgIdAndTypeAndLocale(
                template.getOrganization_id(),
                template.getNotification_type(),
                template.getLocale());
    }

    @Override
    public Template updateTemplate(Template template) {
        this.getSqlSessionTemplate().update(this.getNamespace() + ".updateTemplate", template);
        return this.selectByOrgIdAndTypeAndLocale(
                template.getOrganization_id(),
                template.getNotification_type(),
                template.getLocale());
    }

    @Override
    public Template setDefaultTemplate(String organization_id, String notification_type, String locale) {
        Map map = new HashMap();
        map.put("organization_id", organization_id);
        map.put("notification_type", notification_type);
        map.put("locale", locale);
        this.getSqlSessionTemplate().update(this.getNamespace() + ".unsetDefaultTemplate", map);
        this.getSqlSessionTemplate().update(this.getNamespace() + ".setDefaultTemplate", map);
        return this.selectByOrgIdAndTypeAndLocale(
                organization_id,
                notification_type,
                locale);
    }

    @Override
    public int deleteByOrgIdAndType(String organization_id, String notification_type) {
        Map map = new HashMap();
        map.put("organization_id", organization_id);
        map.put("notification_type", notification_type);
        return this.getSqlSessionTemplate().delete(this.getNamespace() + ".deleteByOrgIdAndType", map);
    }

    @Override
    public int deleteByOrgIdAndTypeAndLocale(String organization_id, String notification_type, String locale) {
        Map map = new HashMap();
        map.put("organization_id", organization_id);
        map.put("notification_type", notification_type);
        map.put("locale", locale);
        return this.getSqlSessionTemplate().delete(this.getNamespace() + ".deleteByOrgIdAndTypeAndLocale", map);
    }

    @Override
    public Template getDefaultTemplate(NotificationType notificationType) {
        try {
            String defaultLocale = "en_US";

            URL subjectUrl = getClass().getResource("/template/"+notificationType.toString()+"-default-subject.txt");
            File subjectFile = ResourceUtils.getFile(subjectUrl);
            String subject = new String(Files.readAllBytes(subjectFile.toPath()));

            URL bodyUrl = getClass().getResource("/template/"+ notificationType.toString()+"-default-body.html");
            File bodyFile = ResourceUtils.getFile(bodyUrl);
            String body = new String(Files.readAllBytes(bodyFile.toPath()));


            Template template = new Template();
            template.setSubject(subject);
            template.setBody(body);
            template.setLocale(defaultLocale);
            template.setNotification_type(notificationType.toString());
            return template;
        } catch (IOException e) {
            throw new ServiceException("Failed to read default template");
        }
    }
}