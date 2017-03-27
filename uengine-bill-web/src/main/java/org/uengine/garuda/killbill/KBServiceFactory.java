package org.uengine.garuda.killbill;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.uengine.garuda.killbill.api.KillbillApi;

import java.util.Properties;

/**
 * Created by uengine on 2016. 6. 16..
 */
@Component
public class KBServiceFactory {

    @Autowired
    @Qualifier("config")
    private Properties config;

    @Value("#{systemProperties['killbill.url']}")
    private String url;

    @Value("#{systemProperties['killbill.user']}")
    private String user;

    @Value("#{systemProperties['killbill.password']}")
    private String password;

    /**
     * SLF4J Logging
     */
    private Logger logger = LoggerFactory.getLogger(KBServiceFactory.class);

    public KillbillApi apiClient() {
        return new KillbillApi(url, user, password, null, null);
    }

    public KillbillApi apiClient(String apiKey, String apiSecret) {
        return new KillbillApi(url, user, password, apiKey, apiSecret);
    }
}
