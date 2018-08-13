package com.commerce.cloud.billing;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Service;

@Service
@Data
@ConfigurationProperties(prefix = "billing")
public class BillingConfig {
    private String url;
    private String authentication;
}
