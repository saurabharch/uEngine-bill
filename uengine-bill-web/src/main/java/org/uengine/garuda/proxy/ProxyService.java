package org.uengine.garuda.proxy;

import org.apache.http.HttpResponse;

public interface ProxyService {

    void doProxy(ProxyRequest proxyRequest) throws Exception;
}
