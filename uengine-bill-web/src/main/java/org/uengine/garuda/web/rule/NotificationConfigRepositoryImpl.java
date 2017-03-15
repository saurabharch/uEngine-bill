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
package org.uengine.garuda.web.rule;

import org.mybatis.spring.SqlSessionTemplate;
import org.opencloudengine.garuda.common.exception.ServiceException;
import org.opencloudengine.garuda.util.ResourceUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.uengine.garuda.common.repository.PersistentRepositoryImpl;
import org.uengine.garuda.model.BillingRule;
import org.uengine.garuda.model.NotificationConfig;

import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.nio.file.Files;

/**
 * @author Seungpil PARK
 */
@Repository
public class NotificationConfigRepositoryImpl extends PersistentRepositoryImpl<String, Object> implements NotificationConfigRepository {

    @Override
    public String getNamespace() {
        return this.NAMESPACE;
    }

    @Autowired
    public NotificationConfigRepositoryImpl(SqlSessionTemplate sqlSessionTemplate) {
        super.setSqlSessionTemplate(sqlSessionTemplate);
    }

    @Override
    public NotificationConfig selectConfigByOrgId(String organization_id) {
        return this.getSqlSessionTemplate().selectOne(this.getNamespace() + ".selectConfigByOrgId", organization_id);
    }

    @Override
    public NotificationConfig insertConfig(NotificationConfig notificationConfig) {
        this.getSqlSessionTemplate().insert(this.getNamespace() + ".insertConfig", notificationConfig);
        return this.selectConfigByOrgId(notificationConfig.getOrganization_id());
    }

    @Override
    public NotificationConfig updateConfig(NotificationConfig notificationConfig) {
        this.getSqlSessionTemplate().update(this.getNamespace() + ".updateConfig", notificationConfig);
        return this.selectConfigByOrgId(notificationConfig.getOrganization_id());
    }

    @Override
    public int deleteConfigByOrgId(String organization_id) {
        return this.getSqlSessionTemplate().delete(this.getNamespace() + ".deleteConfigByOrgId", organization_id);
    }

    @Override
    public String getDefaultConfig() {
        try {
            URL url = getClass().getResource("/rule/default-notification-config.json");
            File ruleFile = ResourceUtils.getFile(url);
            String json = new String(Files.readAllBytes(ruleFile.toPath()));
            return json;
        } catch (IOException e) {
            throw new ServiceException("Failed to read default notification configuration");
        }
    }
}