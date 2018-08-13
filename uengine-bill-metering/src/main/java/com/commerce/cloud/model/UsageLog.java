package com.commerce.cloud.model;

import lombok.Data;

import java.sql.Timestamp;
//import org.springframework.data.annotation.Id;
//import org.springframework.data.elasticsearch.annotations.Document;

@Data
//@Document(indexName = "billing", type = "usage")
public class UsageLog {
    //@Id
    String id;
    String userName;
    String accountId;
    String clientKey;
    String plan;
    String subscriptionId;
    String unit;
    String organizationId;
    String product;
    Timestamp timestamp;
}
