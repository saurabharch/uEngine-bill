package org.uengine.garuda.web.rule;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.util.UriComponentsBuilder;
import org.uengine.garuda.authentication.AuthenticationService;
import org.uengine.garuda.killbill.KBRepository;
import org.uengine.garuda.killbill.KBService;
import org.uengine.garuda.model.BillingRule;
import org.uengine.garuda.model.NotificationConfig;
import org.uengine.garuda.model.Organization;
import org.uengine.garuda.util.JsonUtils;
import org.uengine.garuda.web.organization.OrganizationRepository;
import org.uengine.garuda.web.organization.OrganizationRole;
import org.uengine.garuda.web.organization.OrganizationService;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;
import java.util.Properties;

/**
 * Created by uengine on 2017. 1. 11..
 */

@Controller
@RequestMapping("/rest/v1")
public class NotificationConfigRestController {

    @Autowired
    @Qualifier("config")
    private Properties config;

    @Autowired
    private OrganizationService organizationService;

    @Autowired
    private NotificationConfigRepository notificationConfigRepository;

    @Autowired
    private KBRepository kbRepository;

    @Autowired
    AuthenticationService authenticationService;

    @RequestMapping(value = "/notification_config", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<Map> getNotificationConfiguration(HttpServletRequest request) {
        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.MEMBER);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            NotificationConfig notificationConfig = notificationConfigRepository.selectConfigByOrgId(role.getOrganization().getId());

            //규칙이 생성되지 않은 조직이라면 디폴트 규칙을 생성해주도록 한다.
            if(notificationConfig == null){
                Organization organization  = role.getOrganization();
                Map tenant = kbRepository.getTenantById(organization.getTenant_id());
                if (tenant != null) {
                    Long record_id = Long.parseLong(tenant.get("record_id") + "");

                    notificationConfig = new NotificationConfig();
                    notificationConfig.setOrganization_id(organization.getId());
                    notificationConfig.setTenant_id(organization.getTenant_id());
                    notificationConfig.setTenant_record_id(record_id);
                    notificationConfig.setConfiguration(notificationConfigRepository.getDefaultConfig());
                    notificationConfig = notificationConfigRepository.insertConfig(notificationConfig);
                }
            }
            Map map = JsonUtils.marshal(notificationConfig.getConfiguration());
            return new ResponseEntity<>(map, HttpStatus.OK);
        } catch (Exception ex) {
            ex.printStackTrace();
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value = "/notification_config", method = RequestMethod.POST)
    public ResponseEntity<Void> uploadNotificationConfiguration(HttpServletRequest request, @RequestBody Map map, UriComponentsBuilder ucBuilder) {

        try {
            OrganizationRole role = organizationService.getOrganizationRole(request, OrganizationRole.ADMIN);
            if (!role.getAccept()) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }

            NotificationConfig notificationConfig = notificationConfigRepository.selectConfigByOrgId(role.getOrganization().getId());
            notificationConfig.setConfiguration(JsonUtils.marshal(map));

            notificationConfigRepository.updateConfig(notificationConfig);

            HttpHeaders headers = new HttpHeaders();
            headers.setLocation(ucBuilder.path("/rest/v1/notification_config").buildAndExpand().toUri());
            return new ResponseEntity<>(headers, HttpStatus.CREATED);
        } catch (Exception ex) {
            ex.printStackTrace();
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }
}
