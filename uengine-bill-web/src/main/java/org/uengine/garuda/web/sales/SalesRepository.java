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
package org.uengine.garuda.web.sales;

import org.uengine.garuda.model.Authority;
import org.uengine.garuda.model.Organization;
import org.uengine.garuda.model.OrganizationEmail;
import org.uengine.garuda.model.ProductDistributionHistory;

import java.util.List;
import java.util.Map;

/**
 * 판매 이력 처리를 하는 SalesRepository
 *
 * @author Seungpil PARK
 */
public interface SalesRepository {

    String NAMESPACE = SalesRepository.class.getName();

    ProductDistributionHistory insertHistory(ProductDistributionHistory history);

    List<ProductDistributionHistory> selectAccountBalance(String organization_id, String vendor_id);

    List<ProductDistributionHistory> selectPerDateSummary(Map params);

    Map selectByCondition(String organization_id, String vendor_id, String product_id, String searchKey, Long offset, Long limit);

    ProductDistributionHistory selectById(String organization_id, Long record_id);

    int deleteById(String organization_id, Long record_id);
}
