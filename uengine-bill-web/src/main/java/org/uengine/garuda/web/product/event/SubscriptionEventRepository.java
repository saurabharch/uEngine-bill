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
import org.uengine.garuda.model.Product;
import org.uengine.garuda.model.SubscriptionEventsExt;

import java.util.List;
import java.util.Map;

/**
 * @author Seungpil PARK
 */
public interface SubscriptionEventRepository {

    String NAMESPACE = SubscriptionEventRepository.class.getName();

    List<Map> selectSubscriptionCountByProductVersion(String organization_id, String product_id, Long version);

    SubscriptionEventsExt selectById(Long id);

    SubscriptionEventsExt insert(SubscriptionEventsExt subscriptionEventsExt);

    int delete(Long id);
}
