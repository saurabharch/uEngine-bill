package org.uengine.garuda.proxy;

import org.apache.http.HttpResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.Properties;

@Service
public class ProxyServiceImpl implements ProxyService {
    @Autowired
    @Qualifier("config")
    private Properties config;

    /**
     * SLF4J Logging
     */
    private Logger logger = LoggerFactory.getLogger(ProxyServiceImpl.class);

    @Override
    public void doProxy(ProxyRequest proxyRequest) throws Exception{
        try {
            new ProxyAction(proxyRequest).service();
        } catch (Exception ex) {
            logger.error("error", ex);
            throw new Exception(ex);
        }
    }
}
