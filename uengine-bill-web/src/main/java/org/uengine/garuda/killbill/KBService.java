package org.uengine.garuda.killbill;
import org.uengine.garuda.killbill.api.model.Clock;

import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public interface KBService {

    void uploadRetry(String apiKey, String apiSecret, String retryJson);

    Map getRetry(String apiKey, String apiSecret);

    Clock getTime(String apiKey, String apiSecret);

    Clock updateTime(String apiKey, String apiSecret, String requestedDate);

    void convertPaginationHeader(HttpServletResponse response);
}
