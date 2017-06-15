/**
 * Copyright (C) 2011 uEngine Project (http://www.uengine.io).
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

import org.uengine.garuda.model.Authority;
import org.uengine.garuda.model.Organization;
import org.uengine.garuda.model.OrganizationEmail;

import java.util.List;

/**
 * 조직 정보에 대한 CRUD 기능을 처리하는 OrganizationRepository
 *
 * @author Seungpil PARK
 */
public interface OrganizationRepository {

    String NAMESPACE = OrganizationRepository.class.getName();

    Organization selectById(String id);

    Organization selectByName(String name);

    Organization selectByApiKeyAndSecret(String tenant_api_key, String tenant_api_secret);

    List<Organization> selectByUserId(String user_id);

    Organization insert(Organization organization);

    Organization update(Organization organization);

    int delete(String id);

    Authority selectAuthorityByUserIdAndOrganizationId(String user_id, String organization_id);

    Authority selectAuthorityById(String id);

    Authority insertAuthority(Authority authority);

    int deleteAuthority(String id);

    List<Authority> selectAuthorityByOrganizationId(String organization_id);

    List<OrganizationEmail> selectOrganizationEmailByOrganizationId(String organization_id);

    OrganizationEmail selectOrganizationEmailById(String id);

    OrganizationEmail insertOrganizationEmail(OrganizationEmail organizationEmail);

    OrganizationEmail updateOrganizationEmail(OrganizationEmail organizationEmail);

    int deleteOrganizationEmail(String id);

    int clearDefaultOrganizationEmail(String organization_id);

    Organization selectOneForTest();
}
