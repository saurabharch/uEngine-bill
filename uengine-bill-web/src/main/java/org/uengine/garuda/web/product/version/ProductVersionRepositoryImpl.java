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
import org.uengine.garuda.killbill.KBService;
import org.uengine.garuda.killbill.api.model.Clock;
import org.uengine.garuda.model.Organization;
import org.uengine.garuda.model.ProductDaoVersion;
import org.uengine.garuda.model.ProductVersion;
import org.uengine.garuda.model.SubscriptionEventsExt;
import org.uengine.garuda.model.catalog.Plan;
import org.uengine.garuda.util.JsonUtils;
import org.uengine.garuda.web.organization.OrganizationService;
import org.uengine.garuda.web.product.event.SubscriptionEventRepository;

import java.io.IOException;
import java.util.*;

/**
 * @author Seungpil PARK
 */
@Repository
public class ProductVersionRepositoryImpl extends PersistentRepositoryImpl<String, Object> implements ProductVersionRepository {

    @Autowired
    private OrganizationService organizationService;

    @Autowired
    private KBService kbService;

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
            if (productVersion == null) {
                return null;
            }
            String plans = JsonUtils.marshal(productVersion.getPlans());
            Map<String, Object> map = JsonUtils.convertClassToMap(productVersion);
            map.put("plans", plans);
            map.remove("is_current");
            return new ObjectMapper().convertValue(map, ProductDaoVersion.class);

        } catch (IOException ex) {
            throw new ServiceException(ex);
        }
    }

    private ProductVersion convertToVersion(ProductDaoVersion productDaoVersion, List<ProductDaoVersion> versions, Clock clock) {
        try {
            if (productDaoVersion == null) {
                return null;
            }
            //비교 군이 넘어오지 않았다면 비교군을 구해주도록 한다.
            if (versions == null) {
                versions = this.selectDaoByProductId(productDaoVersion.getOrganization_id(), productDaoVersion.getProduct_id());
            }

            //킬빌 서버의 현재 시각을 구한다.
            if (clock == null) {
                Organization organization = organizationService.selectById(productDaoVersion.getOrganization_id());
                clock = kbService.getTime(organization.getTenant_api_key(), organization.getTenant_api_secret());
            }
            Date currentUtcTime = clock.getCurrentUtcTime();

            //비교군과 주어진 버젼의 effective 날짜를 비교하여 is_current 를 구한다.
            //버젼이 시간이 currentUtcTime 보다 이전인 그룹중 가장 시간 값이 큰 것.
            String is_current = "N";
            ProductDaoVersion maxTimeVersion = null;
            for (ProductDaoVersion version : versions) {
                if (version.getEffective_date().getTime() < currentUtcTime.getTime()) {
                    if (maxTimeVersion == null) {
                        maxTimeVersion = version;
                    } else {
                        if (maxTimeVersion.getEffective_date().getTime() < version.getEffective_date().getTime()) {
                            maxTimeVersion = version;
                        }
                    }
                }
            }
            if (productDaoVersion.getId() == maxTimeVersion.getId()) {
                is_current = "Y";
            }

            List<Plan> plans = JsonUtils.unmarshalToList(productDaoVersion.getPlans());
            Map<String, Object> map = JsonUtils.convertClassToMap(productDaoVersion);
            map.put("plans", plans);
            map.put("is_current", is_current);
            return new ObjectMapper().convertValue(map, ProductVersion.class);

        } catch (IOException ex) {
            throw new ServiceException(ex);
        }
    }

    private List<ProductVersion> convertToVersionList(List<ProductDaoVersion> productDaoVersions) {
        List<ProductVersion> list = new ArrayList<>();
        if (productDaoVersions == null || productDaoVersions.isEmpty()) {
            return list;
        }
        Organization organization = organizationService.selectById(productDaoVersions.get(0).getOrganization_id());
        Clock clock = kbService.getTime(organization.getTenant_api_key(), organization.getTenant_api_secret());

        for (ProductDaoVersion daoVersion : productDaoVersions) {
            list.add(convertToVersion(daoVersion, productDaoVersions, clock));
        }
        return list;
    }

    private List<ProductDaoVersion> selectDaoByProductId(String organization_id, String product_id) {
        Map map = new HashMap();
        map.put("organization_id", organization_id);
        map.put("product_id", product_id);
        return this.getSqlSessionTemplate().selectList(this.getNamespace() + ".selectByProductId", map);
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
        return convertToVersion(daoVersion, null,null);
    }

    @Override
    public ProductVersion selectByCurrentVersion(String organization_id, String product_id) {
        List<ProductVersion> productVersions = this.selectByProductId(organization_id, product_id);
        if (productVersions == null) {
            return null;
        } else {
            for (ProductVersion productVersion : productVersions) {
                if ("Y".equals(productVersion.getIs_current())) {
                    return productVersion;
                }
            }
            return null;
        }
    }

    @Override
    public ProductVersion selectMaxVersion(String organization_id, String product_id) {
        Map map = new HashMap();
        map.put("organization_id", organization_id);
        map.put("product_id", product_id);
        ProductDaoVersion daoVersion = this.getSqlSessionTemplate().selectOne(this.getNamespace() + ".selectMaxVersion", map);
        return convertToVersion(daoVersion, null,null);
    }

    @Override
    public ProductVersion selectById(Long id) {
        ProductDaoVersion daoVersion = this.getSqlSessionTemplate().selectOne(this.getNamespace() + ".selectById", id);
        return convertToVersion(daoVersion, null,null);
    }

    @Override
    public ProductVersion insertVersion(ProductVersion productVersion) {
        ProductDaoVersion daoVersion = convertToDao(productVersion);
        this.getSqlSessionTemplate().insert(this.getNamespace() + ".insertVersion", daoVersion);
        return this.selectById(daoVersion.getId());
    }

    @Override
    public ProductVersion updateVersion(ProductVersion productVersion) {
        this.getSqlSessionTemplate().update(this.getNamespace() + ".updateVersion", convertToDao(productVersion));
        return this.selectByVersion(productVersion.getOrganization_id(), productVersion.getProduct_id(), productVersion.getVersion());
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