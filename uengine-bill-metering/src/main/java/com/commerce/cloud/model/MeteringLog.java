package com.commerce.cloud.model;

import lombok.Data;
import lombok.NoArgsConstructor;
//import org.springframework.data.annotation.Id;
//import org.springframework.data.elasticsearch.annotations.Document;
//import org.springframework.data.elasticsearch.annotations.Field;
//import org.springframework.data.elasticsearch.annotations.FieldType;

import java.sql.Timestamp;
import java.util.List;

@Data
//@Document(indexName = "billing", type = "metering")
public class MeteringLog {
    //@Id
    String id;
    String userName;
    String accountId;
    String clientKey;
    String remoteAddr;
    String requestURI;
    String method;
    String serviceId;
    int responseStatus;
    String organizationId;
    Timestamp timestamp;

    //@Field(type = FieldType.Nested, includeInParent = true)
    List<Subscription> subscriptions;

    @Data
    @NoArgsConstructor
    public static class Subscription {
        private String id;
        private String plan;
        private String product;
    }
}
