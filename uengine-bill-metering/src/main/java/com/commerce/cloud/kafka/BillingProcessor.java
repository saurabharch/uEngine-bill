package com.commerce.cloud.kafka;

import com.commerce.cloud.BillingController;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.stream.annotation.Input;
import org.springframework.cloud.stream.annotation.StreamListener;
import org.springframework.messaging.MessageChannel;
import org.springframework.messaging.MessageHeaders;
import org.springframework.messaging.support.MessageBuilder;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.util.MimeTypeUtils;
import reactor.core.publisher.Flux;
import reactor.core.scheduler.Schedulers;

import java.net.URLDecoder;
import java.util.Map;

@Service
public class BillingProcessor {

    @Autowired
    private BillingController billingController;

    private final Log logger = LogFactory.getLog(getClass());

    private BillingStreams billingStreams;

    public BillingProcessor(BillingStreams billingStreams) {
        this.billingStreams = billingStreams;
    }


    public void sendBillingMessage(final String billingMessage) {
        try {
            String decode = URLDecoder.decode(billingMessage, "utf-8");
            logger.info("Sending billingMessage : " + decode);

            MessageChannel messageChannel = billingStreams.billingSource();
            messageChannel.send(MessageBuilder
                    .withPayload(decode)
                    .setHeader(MessageHeaders.CONTENT_TYPE, MimeTypeUtils.APPLICATION_JSON)
                    .build());
        } catch (Exception ex) {

        }
    }

    @StreamListener
    public void receiveBillingMessage(@Input(BillingStreams.INPUT) Flux<String> inbound) {
        inbound
                .log()
                .subscribeOn(Schedulers.elastic())
                .subscribe(value -> {
                    try {
                        Map map = new ObjectMapper().readValue(value, Map.class);
                        billingController.emitterSend(map);
                        logger.info("receive billingMessage : " + value);

                    } catch (Exception ex) {
                        //throw new RuntimeException("Conversation failed");
                    }
                }, error -> System.err.println("CAUGHT " + error));

    }
}


