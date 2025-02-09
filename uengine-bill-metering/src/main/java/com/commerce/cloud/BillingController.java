package com.commerce.cloud;

import com.commerce.cloud.kafka.BillingProcessor;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CopyOnWriteArrayList;

@RestController
public class BillingController {

    @Autowired
    private BillingProcessor billingProcessor;

    //나랑 붙은 모든 웹클라이언트 저장소.
    private final CopyOnWriteArrayList<SseEmitter> emitters = new CopyOnWriteArrayList<>();

    private final Log logger = LogFactory.getLog(getClass());

    @PostMapping(value = "/event", produces = "application/json")
    public String receiveBillingEvent(@RequestBody String event) {
        billingProcessor.sendBillingMessage(event);
        return "";
    }


    @GetMapping("/emitter")
    //Server Send Event 형식으로 클라이언트로 이벤트를 계속 쏘는 녀석.
    public SseEmitter handle(HttpServletRequest request,
                             HttpServletResponse response
    ) throws Exception {
        try {

            SseEmitter emitter = new SseEmitter(360_000L); //360 sec.
            emitters.add(emitter);

            emitter.onCompletion(() -> this.emitters.remove(emitter));
            emitter.onTimeout(() -> this.emitters.remove(emitter));

            logger.info("emitter counts: " + emitters.size());

            return emitter;
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Unauthorized");
            return null;
        }
    }

    public void emitterSend(Map event) throws Exception {
        List<SseEmitter> deadEmitters = new ArrayList<>();
        this.emitters.forEach(emitter -> {
            try {
                emitter.send(event);
            } catch (Exception e) {
                deadEmitters.add(emitter);
            }
        });
        emitters.removeAll(deadEmitters);
    }
}
