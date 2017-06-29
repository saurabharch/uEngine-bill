package org.uengine.garuda.killbill.api;

import org.apache.http.Header;
import org.apache.http.HttpResponse;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.uengine.garuda.common.exception.ServiceException;
import org.uengine.garuda.util.DateUtils;
import org.uengine.garuda.util.JsonUtils;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by uengine on 2016. 6. 16..
 */
public class CreditsApi extends KillbillApi {

    private Logger logger = LoggerFactory.getLogger(CreditsApi.class);

    public Map createCredit(BigDecimal creditAmount, String currency, String accountId, String description, Date effectiveDate) {
        String method = "POST";
        String path = "/1.0/kb/credits?autoCommit=true";

        try {
            Map headers = new HashMap();
            Map params = new HashMap();
            params.put("creditAmount" , creditAmount);
            params.put("currency" , currency);
            params.put("accountId" , accountId);
            params.put("description" , description);
            if(effectiveDate != null){
                params.put("effectiveDate" , DateUtils.parseDate(effectiveDate, "yyyy-MM-dd"));
            }
            String creditJson = JsonUtils.marshal(params);
            HttpResponse httpResponse = this.apiRequest(method, path, creditJson, headers);
            if (httpResponse.getStatusLine().getStatusCode() != 201) {
                logger.error("Failed to create credit {}", creditJson);
                throw new ServiceException("Failed to create credit");
            }

            Header location = httpResponse.getHeaders("location")[0];
            String[] split = location.getValue().split("/");
            return this.getCredit(split[split.length - 1]);

        } catch (IOException ex) {
            throw new ServiceException("Failed to create invoiceCharges", ex);
        }
    }

    public Map getCredit(String creditId) {
        String method = "GET";
        String path = "/1.0/kb/credits/" + creditId;

        Map headers = new HashMap();
        try {
            HttpResponse httpResponse = this.apiRequest(method, path, null, headers);
            if (httpResponse.getStatusLine().getStatusCode() == 200) {
                String credit = EntityUtils.toString(httpResponse.getEntity());
                return JsonUtils.unmarshal(credit);
            } else {
                logger.error("Failed to get credit {}", creditId);
                throw new ServiceException("Failed to get credit, " + creditId);
            }
        } catch (IOException ex) {
            throw new ServiceException("Failed to get bundle, " + creditId, ex);
        }
    }

}
