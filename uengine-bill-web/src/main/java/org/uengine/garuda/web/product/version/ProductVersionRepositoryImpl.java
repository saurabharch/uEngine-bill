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
package org.uengine.garuda.web.product.version;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.uengine.garuda.common.exception.ServiceException;
import org.uengine.garuda.common.repository.PersistentRepositoryImpl;
import org.uengine.garuda.model.ProductDaoVersion;
import org.uengine.garuda.model.ProductVersion;
import org.uengine.garuda.model.SubscriptionEventsExt;
import org.uengine.garuda.model.catalog.Plan;
import org.uengine.garuda.util.JsonUtils;
import org.uengine.garuda.web.product.event.SubscriptionEventRepository;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author Seungpil PARK
 */
@Repository
public class ProductVersionRepositoryImpl extends PersistentRepositoryImpl<String, Object> implements ProductVersionRepository {

    @Override
    public String getNamespace() {
        return this.NAMESPACE;
    }

    @Autowired
    public ProductVersionRepositoryImpl(SqlSessionTemplate sqlSessionTemplate) {
        super.setSqlSessionTemplate(sqlSessionTemplate);
    }

    private ProductDaoVersion convertToDao(ProductVersion productVersion) {
        try {
            String plans = JsonUtils.marshal(productVersion.getPlans());
            Map<String, Object> map = JsonUtils.convertClassToMap(productVersion);
            map.put("plans", plans);
            return new ObjectMapper().convertValue(map, ProductDaoVersion.class);

        } catch (IOException ex) {
            throw new ServiceException(ex);
        }
    }

    private ProductVersion convertToVersion(ProductDaoVersion productDaoVersion) {
        try {
            List<Plan> plans = JsonUtils.unmarshalToList(productDaoVersion.getPlans());
            Map<String, Object> map = JsonUtils.convertClassToMap(productDaoVersion);
            map.put("plans", plans);
            return new ObjectMapper().convertValue(map, ProductVersion.class);

        } catch (IOException ex) {
            throw new ServiceException(ex);
        }
    }

    private List<ProductVersion> convertToVersionList(List<ProductDaoVersion> productDaoVersions) {
        List<ProductVersion> list = new ArrayList<>();
        for (ProductDaoVersion daoVersion : productDaoVersions) {
            list.add(convertToVersion(daoVersion));
        }
        return list;
    }


    @Override
    public List<ProductVersion> selectByProductId(String organization_id, String product_id) {
        Map map = new HashMap();
        map.put("organization_id", organization_id);
        map.put("product_id", product_id);
        List<ProductDaoVersion> list = this.getSqlSessionTemplate().selectList(this.getNamespace() + ".selectByProductId", map);
        return convertToVersionList(list);
    }

    @Override
    public ProductVersion selectByVersion(String organization_id, String product_id, Long version) {
        Map map = new HashMap();
        map.put("organization_id", organization_id);
        map.put("product_id", product_id);
        map.put("version", version);
        ProductDaoVersion daoVersion = this.getSqlSessionTemplate().selectOne(this.getNamespace() + ".selectByVersion", map);
        return convertToVersion(daoVersion);
    }

    @Override
    public ProductVersion selectByCurrentVersion(String organization_id, String product_id) {
        Map map = new HashMap();
        map.put("organization_id", organization_id);
        map.put("product_id", product_id);
        ProductDaoVersion daoVersion = this.getSqlSessionTemplate().selectOne(this.getNamespace() + ".selectByCurrentVersion", map);
        return convertToVersion(daoVersion);
    }

    @Override
    public ProductVersion selectMaxVersion(String organization_id, String product_id) {
        Map map = new HashMap();
        map.put("organization_id", organization_id);
        map.put("product_id", product_id);
        ProductDaoVersion daoVersion = this.getSqlSessionTemplate().selectOne(this.getNamespace() + ".selectMaxVersion", map);
        return convertToVersion(daoVersion);
    }

    @Override
    public ProductVersion selectById(Long id) {
        ProductDaoVersion daoVersion = this.getSqlSessionTemplate().selectOne(this.getNamespace() + ".selectById", id);
        return convertToVersion(daoVersion);
    }

    @Override
    public ProductVersion insertVersion(ProductVersion productVersion) {
        this.getSqlSessionTemplate().insert(this.getNamespace() + ".insertVersion", convertToDao(productVersion));
        return this.selectById(productVersion.getId());
    }

    @Override
    public ProductVersion updateVersion(ProductVersion productVersion) {
        this.getSqlSessionTemplate().update(this.getNamespace() + ".updateVersion", convertToDao(productVersion));
        return this.selectByVersion(productVersion.getOrganization_id(), productVersion.getProduct_id(), productVersion.getVersion());
    }

    @Override
    public int updateVersionAsCurrent(String organization_id, String product_id, Long version) {
        Map map = new HashMap();
        map.put("organization_id", organization_id);
        map.put("product_id", product_id);
        map.put("version", version);
        this.getSqlSessionTemplate().update(this.getNamespace() + ".updateVersionAsInCurrent", map);
        return this.getSqlSessionTemplate().update(this.getNamespace() + ".updateVersionAsCurrent", map);
    }

    @Override
    public int deleteVersion(String organization_id, String product_id, Long version) {
        Map map = new HashMap();
        map.put("organization_id", organization_id);
        map.put("product_id", product_id);
        map.put("version", version);
        return this.getSqlSessionTemplate().delete(this.getNamespace() + ".deleteVersion", map);
    }
}