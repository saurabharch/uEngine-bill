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
    ProductDistributionHistory selectById(String organization_id, Long record_id);

    Map getAccountSalesBalance(String organization_id, String vendor_id);

    Map getPerDateSummary(String organization_id, SalesSummaryFilter summaryFilter);

    ProductDistributionHistory insertHistory(ProductDistributionHistory history);

    Map getAccountSalesByCondition(String organization_id, String vendor_id, String searchKey, Long offset, Long limit);

    Map getProductSalesByCondition(String organization_id, String product_id, String searchKey, Long offset, Long limit);

    Map getOrgSalesByCondition(String organization_id, String searchKey, Long offset, Long limit);

    ProductDistributionHistory withdrawAccountBalance(String organization_id, String vendor_id, SalesWithdrawRequest withdrawRequest);

    int cancelWithdraw(String organization_id, Long record_id);

    ProductDistributionHistory updateNote(String organization_id, Long record_id, String notes);
}
