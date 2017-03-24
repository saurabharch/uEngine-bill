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
package org.uengine.garuda.web.product.event;

import org.killbill.billing.entitlement.api.SubscriptionEvent;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.uengine.garuda.common.repository.PersistentRepositoryImpl;
import org.uengine.garuda.model.Organization;
import org.uengine.garuda.model.Product;
import org.uengine.garuda.model.SubscriptionEventsExt;
import org.uengine.garuda.web.product.ProductRepository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * @author Seungpil PARK
 */
@Repository
public class SubscriptionRepositoryImpl extends PersistentRepositoryImpl<String, Object> implements SubscriptionEventRepository {

    @Override
    public String getNamespace() {
        return this.NAMESPACE;
    }

    @Autowired
    public SubscriptionRepositoryImpl(SqlSessionTemplate sqlSessionTemplate) {
        super.setSqlSessionTemplate(sqlSessionTemplate);
    }

    @Override
    public List<SubscriptionEventsExt> selectByAccountIdAndSubId(String account_id, String subscription_id) {
        Map map = new HashMap();
        map.put("account_id", account_id);
        map.put("subscription_id", subscription_id);
        return this.getSqlSessionTemplate().selectList(this.getNamespace() + ".selectByAccountIdAndSubId", map);
    }

    @Override
    public List<Map> selectSubscriptionCountByProductVersion(String organization_id, String product_id, Long version) {
        Map map = new HashMap();
        map.put("organization_id", organization_id);
        map.put("product_id", product_id);
        map.put("version", version);
        return this.getSqlSessionTemplate().selectList(this.getNamespace() + ".selectSubscriptionCountByProductVersion", map);
    }

    @Override
    public Long selectSubscriptionCountByProduct(String organization_id, String product_id) {
        Map map = new HashMap();
        map.put("organization_id", organization_id);
        map.put("product_id", product_id);
        return this.getSqlSessionTemplate().selectOne(this.getNamespace() + ".selectSubscriptionCountByProduct", map);
    }

    @Override
    public SubscriptionEventsExt selectById(Long id) {
        return this.getSqlSessionTemplate().selectOne(this.getNamespace() + ".selectById", id);
    }

    @Override
    public SubscriptionEventsExt insert(SubscriptionEventsExt subscriptionEventsExt) {
        this.getSqlSessionTemplate().insert(this.getNamespace() + ".insert", subscriptionEventsExt);
        return this.selectById(subscriptionEventsExt.getId());
    }

    @Override
    public int delete(Long id) {
        return this.getSqlSessionTemplate().delete(this.getNamespace() + ".delete", id);
    }
}