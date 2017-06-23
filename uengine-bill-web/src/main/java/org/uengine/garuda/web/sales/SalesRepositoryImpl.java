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

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.uengine.garuda.common.repository.PersistentRepositoryImpl;
import org.uengine.garuda.model.OneTimeBuy;
import org.uengine.garuda.model.ProductDistributionHistory;
import org.uengine.garuda.util.DateUtils;
import org.uengine.garuda.web.onetimebuy.OneTimeBuyRepository;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author Seungpil PARK
 */
@Repository
public class SalesRepositoryImpl extends PersistentRepositoryImpl<String, Object> implements SalesRepository {

    @Override
    public String getNamespace() {
        return this.NAMESPACE;
    }

    @Autowired
    public SalesRepositoryImpl(SqlSessionTemplate sqlSessionTemplate) {
        super.setSqlSessionTemplate(sqlSessionTemplate);
    }

    @Override
    public ProductDistributionHistory insertHistory(ProductDistributionHistory history) {
        int insert = this.getSqlSessionTemplate().insert(this.getNamespace() + ".insertHistory", history);
        if (insert > 0) {
            return this.selectById(history.getOrganization_id(), history.getRecord_id());
        } else {
            return null;
        }
    }

    @Override
    public List<ProductDistributionHistory> selectAccountBalance(String organization_id, String vendor_id) {
        Map map = new HashMap();
        map.put("organization_id", organization_id);
        map.put("vendor_id", vendor_id);
        return this.getSqlSessionTemplate().selectList(this.getNamespace() + ".selectAccountBalance", map);
    }

    @Override
    public List<ProductDistributionHistory> selectPerDateSummary(Map params) {
        return this.getSqlSessionTemplate().selectList(this.getNamespace() + ".selectPerDateSummary", params);
    }

    @Override
    public Map selectByCondition(String organization_id, String vendor_id, String product_id, String searchKey, Long offset, Long limit) {
        Map map = new HashMap();
        map.put("organization_id", organization_id);
        map.put("vendor_id", vendor_id);
        map.put("product_id", product_id);
        map.put("searchKey", searchKey);
        map.put("offset", offset);
        map.put("limit", limit);
        List<ProductDistributionHistory> historyList = this.getSqlSessionTemplate().selectList(this.getNamespace() + ".selectByCondition", map);
        Long total = this.getSqlSessionTemplate().selectOne(this.getNamespace() + ".selectByConditionCount", map);
        Long max = this.getSqlSessionTemplate().selectOne(this.getNamespace() + ".selectCount", map);

        Map result = new HashMap();
        result.put("list", historyList);
        result.put("total", total + "");
        result.put("max", max + "");
        result.put("offset", offset + "");
        return result;
    }

    @Override
    public ProductDistributionHistory selectById(String organization_id, Long record_id) {
        Map map = new HashMap();
        map.put("organization_id", organization_id);
        map.put("record_id", record_id);
        return this.getSqlSessionTemplate().selectOne(this.getNamespace() + ".selectById", map);
    }

    @Override
    public int deleteById(String organization_id, Long record_id) {
        Map map = new HashMap();
        map.put("organization_id", organization_id);
        map.put("record_id", record_id);
        return this.getSqlSessionTemplate().delete(this.getNamespace() + ".deleteById", map);
    }

    @Override
    public ProductDistributionHistory updateNotes(String organization_id, Long record_id, String vendor_id, String notes) {
        Map map = new HashMap();
        map.put("organization_id", organization_id);
        map.put("record_id", record_id);
        map.put("vendor_id", vendor_id);
        map.put("notes", notes);
        int update = this.getSqlSessionTemplate().update(this.getNamespace() + ".updateNotes", map);
        if (update > 0) {
            return this.selectById(organization_id, record_id);
        } else {
            return null;
        }
    }
}