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

import com.cloudant.client.api.Database;
import com.cloudant.client.api.views.AllDocsResponse;
import org.mybatis.spring.SqlSessionTemplate;
import org.opencloudengine.garuda.common.exception.ServiceException;
import org.opencloudengine.garuda.util.JsonUtils;
import org.opencloudengine.garuda.util.ResourceUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.uengine.garuda.common.repository.PersistentRepositoryImpl;
import org.uengine.garuda.model.*;
import org.uengine.garuda.web.organization.OrganizationRepository;

import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.nio.file.Files;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * @author Seungpil PARK
 */
@Repository
public class BillingRuleRepositoryImpl extends PersistentRepositoryImpl<String, Object> implements BillingRuleRepository {

    @Override
    public String getNamespace() {
        return this.NAMESPACE;
    }

    @Autowired
    public BillingRuleRepositoryImpl(SqlSessionTemplate sqlSessionTemplate) {
        super.setSqlSessionTemplate(sqlSessionTemplate);
    }

    @Override
    public BillingRule selectRuleByOrgId(String organization_id) {
        return this.getSqlSessionTemplate().selectOne(this.getNamespace() + ".selectRuleByOrgId", organization_id);
    }

    @Override
    public BillingRule insertRule(BillingRule rule) {
        this.getSqlSessionTemplate().insert(this.getNamespace() + ".insertRule", rule);
        return this.selectRuleByOrgId(rule.getOrganization_id());
    }

    @Override
    public BillingRule updateRule(BillingRule rule) {
        this.getSqlSessionTemplate().update(this.getNamespace() + ".updateRule", rule);
        return this.selectRuleByOrgId(rule.getOrganization_id());
    }

    @Override
    public int deleteRuleByOrgId(String organization_id) {
        return this.getSqlSessionTemplate().delete(this.getNamespace() + ".deleteRuleByOrgId", organization_id);
    }

    @Override
    public String getDefaultBillingRule() {
        try {
            URL url = getClass().getResource("/rule/default-billing-rule.json");
            File ruleFile = ResourceUtils.getFile(url);
            String json = new String(Files.readAllBytes(ruleFile.toPath()));
            return json;
        } catch (IOException e) {
            throw new ServiceException("Failed to read default billing rule");
        }
    }

    @Override
    public String getDefaultOverdueRule() {
        try {
            URL url = getClass().getResource("/rule/default-overdue-rule.json");
            File ruleFile = ResourceUtils.getFile(url);
            String json = new String(Files.readAllBytes(ruleFile.toPath()));
            return json;
        } catch (IOException e) {
            throw new ServiceException("Failed to read default billing rule");
        }
    }

    @Override
    public String getDefaultRetryRule() {
        try {
            URL url = getClass().getResource("/rule/default-retry-rule.json");
            File ruleFile = ResourceUtils.getFile(url);
            String json = new String(Files.readAllBytes(ruleFile.toPath()));
            return json;
        } catch (IOException e) {
            throw new ServiceException("Failed to read default retry rule");
        }
    }
}