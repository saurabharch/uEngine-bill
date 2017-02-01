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

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.uengine.garuda.common.repository.PersistentRepositoryImpl;
import org.uengine.garuda.model.Authority;
import org.uengine.garuda.model.Organization;
import org.uengine.garuda.model.OrganizationEmail;
import org.uengine.garuda.model.Product;
import org.uengine.garuda.web.organization.OrganizationRepository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * @author Seungpil PARK
 */
@Repository
public class ProductRepositoryImpl extends PersistentRepositoryImpl<String, Object> implements ProductRepository {

    @Override
    public String getNamespace() {
        return this.NAMESPACE;
    }

    @Autowired
    public ProductRepositoryImpl(SqlSessionTemplate sqlSessionTemplate) {
        super.setSqlSessionTemplate(sqlSessionTemplate);
    }

    @Override
    public List<Product> selectProductByCondition(String searchKey, Long offset, Long limit) {
        Map map = new HashMap();
        map.put("searchKey", searchKey);
        map.put("offset", offset);
        map.put("limit", limit);
        return this.getSqlSessionTemplate().selectList(this.getNamespace() + ".selectProductByCondition", map);
    }

    @Override
    public Product selectProductById(String id) {
        return this.getSqlSessionTemplate().selectOne(this.getNamespace() + ".selectProductById", id);
    }

    @Override
    public Product insertProduct(Product product) {
        int record_id = this.getSqlSessionTemplate().insert(this.getNamespace() + ".insertProduct", product);
        String id = String.format("%010d", record_id);
        this.updateProductId(Long.parseLong("" + record_id), id);

        return this.selectProductById(id);
    }

    @Override
    public Product updateProductById(Product product) {
        this.getSqlSessionTemplate().update(this.getNamespace() + ".updateProductById", product);
        return this.selectProductById(product.getId());
    }

    @Override
    public int updateProductId(Long record_id, String id) {
        Map map = new HashMap();
        map.put("record_id", record_id);
        map.put("id", id);
        return this.getSqlSessionTemplate().update(this.getNamespace() + ".updateProductId", map);
    }

    @Override
    public int deleteProductById(String id) {
        return this.getSqlSessionTemplate().delete(this.getNamespace() + ".deleteProductById", id);
    }
}