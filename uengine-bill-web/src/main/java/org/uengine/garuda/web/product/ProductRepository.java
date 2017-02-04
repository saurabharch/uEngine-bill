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
package org.uengine.garuda.web.product;

import org.uengine.garuda.model.Authority;
import org.uengine.garuda.model.Organization;
import org.uengine.garuda.model.OrganizationEmail;
import org.uengine.garuda.model.Product;

import java.util.List;
import java.util.Map;

/**
 * @author Seungpil PARK
 */
public interface ProductRepository {

    String NAMESPACE = ProductRepository.class.getName();

    Map selectProductByCondition(String organization_id, String is_active, String searchKey, Long offset, Long limit);

    Product selectProductById(String organization_id, String id);

    Product insertProduct(Product product);

    Product updateProductById(Product product);

    Product updateProductActiveById(String organization_id, String id, String is_active);

    int updateProductId(Long record_id, String id);

    int updatePlanUsageSeq(String organization_id, String id, Long plan_seq, Long usage_seq);

    int deleteProductById(String organization_id, String id);
}
