package com.commerce.cloud.kafka;

import org.springframework.cloud.stream.annotation.Input;
import org.springframework.cloud.stream.annotation.Output;
import org.springframework.messaging.MessageChannel;
import org.springframework.messaging.SubscribableChannel;

public interface MeteringStreams {
    String INPUT = "metering-sub";

    @Input("metering-sub")
    SubscribableChannel meteringSub();
}
