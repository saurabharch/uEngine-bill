package com.commerce.cloud.kafka;

import com.commerce.cloud.model.MeteringLog;
import com.commerce.cloud.model.UsageLog;
import com.commerce.cloud.repository.MeteringRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.stream.annotation.Input;
import org.springframework.cloud.stream.annotation.StreamListener;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;
import reactor.core.scheduler.Schedulers;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class MeteringProcessor {

    @Autowired
    private MeteringRepository meteringRepository;

//    @Autowired
//    private UsageRepository usageRepository;

    private final Log logger = LogFactory.getLog(getClass());

    private MeteringStreams meteringStreams;

    public MeteringProcessor(MeteringStreams meteringStreams) {
        this.meteringStreams = meteringStreams;
    }

    @StreamListener
    public void receiveMeteringMessage(@Input(MeteringStreams.INPUT) Flux<String> inbound) {
        inbound
                .log()
                .subscribeOn(Schedulers.elastic())
                .subscribe(value -> {
                    try {
                        ObjectMapper objectMapper = new ObjectMapper();
                        logger.info("receive MeteringMessage : " + value);
                        Map map = new ObjectMapper().readValue(value, Map.class);
                        String eventType = map.get("eventType").toString();
                        if ("metering".equals(eventType)) {
                            List<Map> logs = (List<Map>) map.get("logs");
                            if (logs != null && logs.size() > 0) {
                                List<MeteringLog> result = new ArrayList<>();
                                for (int i = 0; i < logs.size(); i++) {
                                    MeteringLog log = objectMapper.convertValue(logs.get(i), MeteringLog.class);
                                    result.add(log);
                                }
                                meteringRepository.insertMeteringLog(result);
                            }
                        } else if ("usage".equals(eventType)) {
                            List<Map> logs = (List<Map>) map.get("logs");
                            if (logs != null && logs.size() > 0) {
                                List<UsageLog> result = new ArrayList<>();
                                for (int i = 0; i < logs.size(); i++) {
                                    UsageLog log = objectMapper.convertValue(logs.get(i), UsageLog.class);
                                    result.add(log);
                                }
                                meteringRepository.insertUsageLog(result);

                                //TODO insert to billing framework
                            }
                        }
                    } catch (Exception ex) {
                        logger.error("update UserSubscriptions failed");
                    }
                });
    }
}


