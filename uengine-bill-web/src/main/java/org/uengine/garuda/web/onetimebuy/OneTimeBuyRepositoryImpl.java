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
package org.uengine.garuda.web.onetimebuy;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.uengine.garuda.common.exception.ServiceException;
import org.uengine.garuda.common.repository.PersistentRepositoryImpl;
import org.uengine.garuda.model.OneTimeBuy;
import org.uengine.garuda.model.Product;
import org.uengine.garuda.model.ProductDao;
import org.uengine.garuda.util.DateUtils;
import org.uengine.garuda.util.JsonUtils;
import org.uengine.garuda.web.product.ProductRepository;

import java.io.IOException;
import java.util.*;

/**
 * @author Seungpil PARK
 */
@Repository
public class OneTimeBuyRepositoryImpl extends PersistentRepositoryImpl<String, Object> implements OneTimeBuyRepository {

    @Override
    public String getNamespace() {
        return this.NAMESPACE;
    }

    @Autowired
    public OneTimeBuyRepositoryImpl(SqlSessionTemplate sqlSessionTemplate) {
        super.setSqlSessionTemplate(sqlSessionTemplate);
    }

    @Override
    public OneTimeBuy selectById(String organization_id, Long record_id) {
        Map map = new HashMap();
        map.put("organization_id", organization_id);
        map.put("record_id", record_id);
        return this.getSqlSessionTemplate().selectOne(this.getNamespace() + ".selectById", map);
    }

    @Override
    public OneTimeBuy insert(OneTimeBuy oneTimeBuy) {
        int insert = this.getSqlSessionTemplate().insert(this.getNamespace() + ".insert", oneTimeBuy);
        if (insert > 0) {
            return this.selectById(oneTimeBuy.getOrganization_id(), oneTimeBuy.getRecord_id());
        } else {
            return null;
        }
    }

    @Override
    public OneTimeBuy update(OneTimeBuy oneTimeBuy) {
        this.getSqlSessionTemplate().update(this.getNamespace() + ".update", oneTimeBuy);
        return this.selectById(oneTimeBuy.getOrganization_id(), oneTimeBuy.getRecord_id());
    }

    @Override
    public Map selectByCondition(String organization_id, String searchKey, Long offset, Long limit) {

        Map map = new HashMap();
        map.put("organization_id", organization_id);
        map.put("searchKey", searchKey);
        map.put("offset", offset);
        map.put("limit", limit);
        List<OneTimeBuy> oneTimeBuyList = this.getSqlSessionTemplate().selectList(this.getNamespace() + ".selectByCondition", map);
        Long total = this.getSqlSessionTemplate().selectOne(this.getNamespace() + ".selectByConditionCount", map);
        Long max = this.getSqlSessionTemplate().selectOne(this.getNamespace() + ".selectCount", organization_id);

        Map result = new HashMap();
        result.put("list", oneTimeBuyList);
        result.put("total", total + "");
        result.put("max", max + "");
        result.put("offset", offset + "");
        return result;
    }

    @Override
    public List<OneTimeBuy> selectByAccountId(String organization_id, String account_id) {
        Map map = new HashMap();
        map.put("organization_id", organization_id);
        map.put("account_id", account_id);
        return this.getSqlSessionTemplate().selectList(this.getNamespace() + ".selectByAccountId", map);
    }

    @Override
    public List<OneTimeBuy> selectBcdPendingBuys(Date billingDate) {
        return this.getSqlSessionTemplate().selectList(this.getNamespace() + ".selectBcdPendingBuys", DateUtils.parseDate(billingDate, "yyyy-MM-dd"));
    }

    @Override
    public List<OneTimeBuy> selectAccountPendingBuys(String account_id) {
        return this.getSqlSessionTemplate().selectList(this.getNamespace() + ".selectAccountPendingBuys", account_id);
    }
}