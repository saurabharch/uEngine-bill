package org.uengine.garuda.backend.scheduler.jobs;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.scheduling.quartz.QuartzJobBean;
import org.uengine.garuda.common.exception.ServiceException;
import org.uengine.garuda.killbill.KBServiceFactory;
import org.uengine.garuda.killbill.api.model.Clock;
import org.uengine.garuda.model.OneTimeBuy;
import org.uengine.garuda.model.Organization;
import org.uengine.garuda.util.ApplicationContextRegistry;
import org.uengine.garuda.util.UUIDUtils;
import org.uengine.garuda.web.onetimebuy.OneTimeBuyService;
import org.uengine.garuda.web.onetimebuy.OneTimeBuyState;
import org.uengine.garuda.web.organization.OrganizationRepository;

import java.util.*;

/**
 * ClientJob 의 Stopping Job 을 확인해서 종료시키는 작업.
 *
 * @author Seungpil, Park
 * @since 2.0
 */
public class OneTimeBuyJob extends QuartzJobBean {
    /**
     * SLF4J Logging
     */
    private Logger logger = LoggerFactory.getLogger(OneTimeBuyJob.class);

    @Override
    protected void executeInternal(JobExecutionContext jobExecutionContext) throws JobExecutionException {
        try {
            //TODO DB 락을 구현해야 한다.

            logger.debug("Now check the oneTimeBuy jobs to invoice.");
            ApplicationContext applicationContext = ApplicationContextRegistry.getApplicationContext();
            OneTimeBuyService oneTimeBuyService = applicationContext.getBean(OneTimeBuyService.class);
            OrganizationRepository organizationRepository = applicationContext.getBean(OrganizationRepository.class);
            KBServiceFactory kbServiceFactory = applicationContext.getBean(KBServiceFactory.class);

            //여기서 조직을 하나 선으로 얻는게 필요.
            Organization organization = organizationRepository.selectOneForTest();
            if (organization == null) {
                return;
            }

            //조직을 사용하여 clock api 호출
            Clock clock = kbServiceFactory
                    .apiClient(organization.getTenant_api_key(), organization.getTenant_api_secret())
                    .testApi().getTime();

            //oneTimeBuyList 획득
            List<OneTimeBuy> oneTimeBuyList = oneTimeBuyService.selectBcdPendingBuys(clock.getCurrentUtcTime());

            //oneTimeBuyList 를 organization 별로 나눈다.
            Map<String, List<OneTimeBuy>> oneTimeBuyOrgMap = new HashMap<String, List<OneTimeBuy>>();
            for (OneTimeBuy oneTimeBuy : oneTimeBuyList) {
                String organization_id = oneTimeBuy.getOrganization_id();
                if (!oneTimeBuyOrgMap.containsKey(organization_id)) {
                    oneTimeBuyOrgMap.put(organization_id, new ArrayList<OneTimeBuy>());
                }
                oneTimeBuyOrgMap.get(organization_id).add(oneTimeBuy);
            }

            //조직 별로 charge invoice 를 실행한다.
            for (Map.Entry<String, List<OneTimeBuy>> entry : oneTimeBuyOrgMap.entrySet()) {
                String organization_id = entry.getKey();
                List<OneTimeBuy> oneTimeBuys = entry.getValue();
                Organization org = organizationRepository.selectById(organization_id);
                if (org != null) {
                    oneTimeBuyService.sendOneTimeBuyImmediately(org, clock, oneTimeBuys);
                }
            }
            logger.debug("{} one time buy items invoiced.", oneTimeBuyList.size());


        } catch (Exception ex) {
            throw new ServiceException("Unable to run scheduled jobs", ex);
        }
    }
}
