package org.uengine.garuda.web.onetimebuy;

import org.uengine.garuda.killbill.api.model.Clock;
import org.uengine.garuda.model.OneTimeBuy;
import org.uengine.garuda.model.Organization;
import org.uengine.garuda.model.Product;

import java.util.Date;
import java.util.List;
import java.util.Map;

public interface OneTimeBuyService {
    List<OneTimeBuy> createOneTimeBuy(Organization organization, List<OneTimeBuyRequest> list, String accountId, Date requestedDate) throws Exception;

    OneTimeBuy selectById(String organization_id, Long record_id);

    OneTimeBuy update(OneTimeBuy oneTimeBuy);

    OneTimeBuy cancelOneTimeBuy(String organization_id, Long record_id);

    Map selectByCondition(String organization_id, String searchKey, Long offset, Long limit);

    List<OneTimeBuy> selectByAccountId(String organization_id, String account_id);

    List<OneTimeBuy> sendOneTimeBuyImmediately(Organization organization, Clock clock, List<OneTimeBuy> oneTimeBuyList);

    List<OneTimeBuy> selectBcdPendingBuys(Date billingDate);
}
