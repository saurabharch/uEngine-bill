package org.uengine.garuda.web.sales;

import org.uengine.garuda.killbill.api.model.Clock;
import org.uengine.garuda.model.OneTimeBuy;
import org.uengine.garuda.model.Organization;
import org.uengine.garuda.model.ProductDistributionHistory;
import org.uengine.garuda.web.onetimebuy.OneTimeBuyRequest;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

public interface SalesService {
    ProductDistributionHistory selectById(Organization organization, Long record_id);

    Map getAccountSalesBalance(Organization organization, String vendor_id);

    Map getPerDateSummaryForOrganization(Organization organization, SalesSummaryFilter summaryFilter) throws Exception;

    Map getPerDateSummary(Organization organization, SalesSummaryFilter summaryFilter) throws Exception;

    Map getAccountSalesByCondition(Organization organization, String vendor_id, String searchKey, Long offset, Long limit);

    Map getProductSalesByCondition(Organization organization, String product_id, String searchKey, Long offset, Long limit);

    Map getOrgSalesByCondition(Organization organization, String searchKey, Long offset, Long limit);

    ProductDistributionHistory withdrawAccountBalance(Organization organization, String vendor_id, SalesWithdrawRequest withdrawRequest);

    int cancelWithdraw(Organization organization, Long record_id);

    ProductDistributionHistory updateNote(Organization organization, Long record_id, String vendor_id, String notes);
}
