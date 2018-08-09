package com.commerce.cloud.kafka;

import org.springframework.cloud.stream.annotation.Input;
import org.springframework.cloud.stream.annotation.Output;
import org.springframework.messaging.MessageChannel;
import org.springframework.messaging.SubscribableChannel;

public interface BillingStreams {
    String INPUT = "billing-target";
    String OUTPUT = "billing-source";

    @Input("billing-target")
    SubscribableChannel billingTarget();

    @Output("billing-source")
    MessageChannel billingSource();
}
