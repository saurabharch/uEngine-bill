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
package org.uengine.garuda.killbill;

import org.uengine.garuda.model.Authority;
import org.uengine.garuda.model.Organization;
import org.uengine.garuda.model.OrganizationEmail;

import java.util.List;
import java.util.Map;

/**
 * 킬빌의 데이터베이스 레파지토리
 *
 * @author Seungpil PARK
 */
public interface KBRepository {

    String NAMESPACE = KBRepository.class.getName();

    Long subscriptionCountByTenantId(String id);

    Map getAccountById(String id);

    Map getTenantById(String id);

    int deleteAccountById(String id);

    Long getBundleCountByAccountId(String id);

    Long getPaymentCountByAccountId(String id);
}
