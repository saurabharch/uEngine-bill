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
package org.uengine.garuda.web.organization;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.uengine.garuda.common.repository.PersistentRepositoryImpl;
import org.uengine.garuda.model.Authority;
import org.uengine.garuda.model.Organization;
import org.uengine.garuda.model.OrganizationEmail;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * @author Seungpil PARK
 */
@Repository
public class OrganizationRepositoryImpl extends PersistentRepositoryImpl<String, Object> implements OrganizationRepository {

    @Override
    public String getNamespace() {
        return this.NAMESPACE;
    }

    @Autowired
    public OrganizationRepositoryImpl(SqlSessionTemplate sqlSessionTemplate) {
        super.setSqlSessionTemplate(sqlSessionTemplate);
    }

    @Override
    public Organization selectById(String id) {
        return this.getSqlSessionTemplate().selectOne(this.getNamespace() + ".selectById", id);
    }

    @Override
    public Organization selectByName(String name) {
        return this.getSqlSessionTemplate().selectOne(this.getNamespace() + ".selectByName", name);
    }

    @Override
    public Organization selectByApiKeyAndSecret(String tenant_api_key, String tenant_api_secret) {
        Map map = new HashMap();
        map.put("tenant_api_key", tenant_api_key);
        map.put("tenant_api_secret", tenant_api_secret);
        return this.getSqlSessionTemplate().selectOne(this.getNamespace() + ".selectByApiKeyAndSecret", map);
    }

    @Override
    public List<Organization> selectByUserId(String user_id) {
        return this.getSqlSessionTemplate().selectList(this.getNamespace() + ".selectByUserId", user_id);
    }

    @Override
    public Organization insert(Organization organization) {
        organization.setId(UUID.randomUUID().toString());
        this.getSqlSessionTemplate().insert(this.getNamespace() + ".insert", organization);
        return this.selectById(organization.getId());
    }

    @Override
    public Organization update(Organization organization) {
        this.getSqlSessionTemplate().update(this.getNamespace() + ".update", organization);
        return this.selectById(organization.getId());
    }

    @Override
    public int delete(String id) {
        return this.getSqlSessionTemplate().delete(this.getNamespace() + ".delete", id);
    }

    @Override
    public Authority selectAuthorityByUserIdAndOrganizationId(String user_id, String organization_id) {
        Map map = new HashMap();
        map.put("user_id", user_id);
        map.put("organization_id", organization_id);
        return this.getSqlSessionTemplate().selectOne(this.getNamespace() + ".selectAuthorityByUserIdAndOrganizationId", organization_id);
    }

    @Override
    public Authority selectAuthorityById(String id) {
        return this.getSqlSessionTemplate().selectOne(this.getNamespace() + ".selectAuthorityById", id);
    }

    @Override
    public Authority insertAuthority(Authority authority) {
        authority.setId(UUID.randomUUID().toString());
        this.getSqlSessionTemplate().insert(this.getNamespace() + ".insertAuthority", authority);
        return this.selectAuthorityById(authority.getId());
    }

    @Override
    public int deleteAuthority(String id) {
        return this.getSqlSessionTemplate().delete(this.getNamespace() + ".deleteAuthority", id);
    }

    @Override
    public List<Authority> selectAuthorityByOrganizationId(String organization_id) {
        return this.getSqlSessionTemplate().selectList(this.getNamespace() + ".selectAuthorityByOrganizationId", organization_id);
    }

    @Override
    public List<OrganizationEmail> selectOrganizationEmailByOrganizationId(String organization_id) {
        return this.getSqlSessionTemplate().selectList(this.getNamespace() + ".selectOrganizationEmailByOrganizationId", organization_id);
    }

    @Override
    public OrganizationEmail selectOrganizationEmailById(String id) {
        return this.getSqlSessionTemplate().selectOne(this.getNamespace() + ".selectOrganizationEmailById", id);
    }

    @Override
    public OrganizationEmail insertOrganizationEmail(OrganizationEmail organizationEmail) {
        organizationEmail.setId(UUID.randomUUID().toString());
        this.getSqlSessionTemplate().insert(this.getNamespace() + ".insertOrganizationEmail", organizationEmail);
        return this.selectOrganizationEmailById(organizationEmail.getId());
    }

    @Override
    public OrganizationEmail updateOrganizationEmail(OrganizationEmail organizationEmail) {
        this.getSqlSessionTemplate().update(this.getNamespace() + ".updateOrganizationEmail", organizationEmail);
        return this.selectOrganizationEmailById(organizationEmail.getId());
    }

    @Override
    public int deleteOrganizationEmail(String id) {
        return this.getSqlSessionTemplate().delete(this.getNamespace() + ".deleteOrganizationEmail", id);
    }
}