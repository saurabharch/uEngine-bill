package org.uengine.garuda.killbill.api;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.http.HttpResponse;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.uengine.garuda.common.exception.ServiceException;
import org.uengine.garuda.killbill.api.model.Tenant;
import org.uengine.garuda.util.JsonUtils;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by uengine on 2016. 6. 16..
 */
public class InvoiceApi extends KillbillApi {

    private Logger logger = LoggerFactory.getLogger(InvoiceApi.class);

    public List<Map> createInvoiceCharges(String accountId, List<Map> invoiceCharges) {
        String method = "POST";
        String path = "/1.0/kb/invoices/charges/" + accountId + "?autoCommit=true";

        try {
            Map headers = new HashMap();
            String invoiceChargesJson = JsonUtils.marshal(invoiceCharges);
            HttpResponse httpResponse = this.apiRequest(method, path, invoiceChargesJson, headers);
            if (httpResponse.getStatusLine().getStatusCode() != 201 && httpResponse.getStatusLine().getStatusCode() != 200) {
                logger.error("Failed to create invoiceCharges {}", invoiceChargesJson);
                throw new ServiceException("Failed to create invoiceCharges");
            }
            String s = EntityUtils.toString(httpResponse.getEntity());
            return JsonUtils.unmarshalToList(s);

        } catch (IOException ex) {
            throw new ServiceException("Failed to create invoiceCharges", ex);
        }
    }
}
