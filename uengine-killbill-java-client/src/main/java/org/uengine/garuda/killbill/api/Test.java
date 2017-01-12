package org.uengine.garuda.killbill.api;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.uengine.garuda.killbill.api.model.Tenant;
import org.uengine.garuda.util.JsonUtils;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by uengine on 2016. 12. 13..
 */
public class Test {

    public static void main(String[] args) throws Exception {
//        String user = "admin";
//        String password = "password";
//        String apiKey = "bob";
//        String apiSecret = "lazar";
//        String host = "ob.essencia.live";
//        int port = 8080;
//
//        //포시에스 테넌트 생성
//        KillbillApi api = new KillbillApi(host, port, user, password, apiKey, apiSecret);
//        api.createTenant("uengine");
//        Map tenant = api.getTenantByApiKey("uengine");

        Map map = new HashMap();
        map.put("externalKey","bbb");

        ObjectMapper objectMapper = new ObjectMapper();
        Tenant tenant1 = objectMapper.convertValue(map, Tenant.class);
        System.out.println(tenant1.getExternalKey());

//        Tenant tenant = (Tenant) JsonUtils.convertMapToClass(map, Tenant.class);
//        System.out.println(tenant.getExternalKey());

    }
}
