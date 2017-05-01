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

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.uengine.garuda.common.exception.ServiceException;
import org.uengine.garuda.common.repository.PersistentRepositoryImpl;
import org.uengine.garuda.model.*;
import org.uengine.garuda.util.JsonUtils;
import org.uengine.garuda.web.organization.OrganizationRepository;

import java.io.IOException;
import java.util.*;

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

    private ProductDao toDao(Product product) {
        try {
            Map map = JsonUtils.convertValue(product, Map.class);
            if (map.get("vendors") != null) {
                map.put("vendors", JsonUtils.marshal(product.getVendors()));
            }
            return JsonUtils.convertValue(map, ProductDao.class);
        } catch (IOException ex) {
            throw new ServiceException(ex);
        }
    }

    private Product toModel(ProductDao productDao) {
        try {
            Map map = JsonUtils.convertValue(productDao, Map.class);
            if (map.get("vendors") != null) {
                map.put("vendors", JsonUtils.unmarshalToList(map.get("vendors").toString()));
            }
            Product product = JsonUtils.convertValue(map, Product.class);
            return product;
        } catch (IOException ex) {
            throw new ServiceException(ex);
        }
    }

    @Override
    public Map selectProductByCondition(String organization_id, String is_active, String category, String searchKey, Long offset, Long limit) {
        Map map = new HashMap();
        map.put("searchKey", searchKey);
        map.put("category", category);
        map.put("offset", offset);
        map.put("limit", limit);
        map.put("organization_id", organization_id);
        map.put("is_active", is_active);
        ArrayList<Product> products = new ArrayList<>();
        List<ProductDao> list = this.getSqlSessionTemplate().selectList(this.getNamespace() + ".selectProductByCondition", map);
        for (ProductDao productDao : list) {
            products.add(this.toModel(productDao));
        }

        Long total = this.getSqlSessionTemplate().selectOne(this.getNamespace() + ".selectProductByConditionCount", map);
        Long max = this.getSqlSessionTemplate().selectOne(this.getNamespace() + ".selectProductCount", map);

        Map result = new HashMap();
        result.put("list", products);
        result.put("total", total + "");
        result.put("max", max + "");
        result.put("offset", offset + "");
        return result;
    }

    @Override
    public Product selectProductById(String organization_id, String id) {
        Map map = new HashMap();
        map.put("organization_id", organization_id);
        map.put("id", id);
        ProductDao dao = this.getSqlSessionTemplate().selectOne(this.getNamespace() + ".selectProductById", map);
        return toModel(dao);
    }

    @Override
    public Product insertProduct(Product product) {
        ProductDao productDao = toDao(product);
        this.getSqlSessionTemplate().insert(this.getNamespace() + ".insertProduct", productDao);
        Long record_id = productDao.getRecord_id();
        String id = "PRD_" + String.format("%010d", record_id);

        this.updateProductId(record_id, id);
        return this.selectProductById(product.getOrganization_id(), id);
    }

    @Override
    public Product updateProductById(Product product) {
        this.getSqlSessionTemplate().update(this.getNamespace() + ".updateProductById", toDao(product));
        return this.selectProductById(product.getOrganization_id(), product.getId());
    }

    @Override
    public int updateProductId(Long record_id, String id) {
        Map map = new HashMap();
        map.put("record_id", record_id);
        map.put("id", id);
        return this.getSqlSessionTemplate().update(this.getNamespace() + ".updateProductId", map);
    }

    @Override
    public Product updateProductActiveById(String organization_id, String id, String is_active) {
        Map map = new HashMap();
        map.put("organization_id", organization_id);
        map.put("id", id);
        map.put("is_active", is_active);
        this.getSqlSessionTemplate().update(this.getNamespace() + ".updateProductActiveById", map);
        return this.selectProductById(organization_id, id);
    }

    @Override
    public int updatePlanUsageSeq(String organization_id, String id, Long plan_seq, Long usage_seq) {
        Map map = new HashMap();
        map.put("organization_id", organization_id);
        map.put("id", id);
        map.put("plan_seq", plan_seq);
        map.put("usage_seq", usage_seq);
        return this.getSqlSessionTemplate().update(this.getNamespace() + ".updatePlanUsageSeq", map);
    }

    @Override
    public int deleteProductById(String organization_id, String id) {
        Map map = new HashMap();
        map.put("organization_id", organization_id);
        map.put("id", id);
        return this.getSqlSessionTemplate().delete(this.getNamespace() + ".deleteProductById", map);
    }
}