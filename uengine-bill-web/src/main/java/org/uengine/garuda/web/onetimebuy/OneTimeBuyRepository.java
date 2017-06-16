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

import org.uengine.garuda.model.OneTimeBuy;
import org.uengine.garuda.model.Product;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @author Seungpil PARK
 */
public interface OneTimeBuyRepository {

    String NAMESPACE = OneTimeBuyRepository.class.getName();

    OneTimeBuy selectById(String organization_id,Long record_id);

    OneTimeBuy insert(OneTimeBuy oneTimeBuy);

    OneTimeBuy update(OneTimeBuy oneTimeBuy);

    Map selectByCondition(String organization_id, String searchKey, Long offset, Long limit);

    List<OneTimeBuy> selectByAccountId(String organization_id,String account_id);

    List<OneTimeBuy> selectBcdPendingBuys(Date billingDate);
}
