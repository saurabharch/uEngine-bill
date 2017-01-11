package org.uengine.garuda.web.organization;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.util.UriComponentsBuilder;
import org.uengine.garuda.model.Organization;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Properties;

/**
 * Created by uengine on 2017. 1. 11..
 */

@Controller
@RequestMapping("/rest/v1")
public class OrganizationRestController {

    @Autowired
    @Qualifier("config")
    private Properties config;

    @Autowired
    private OrganizationService organizationService;

    @RequestMapping(value = "/organization", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<List<Organization>> listOrganization(HttpServletRequest request) {

        OrganizationRole organizationRole = organizationService.getOrganizationRole(request, OrganizationRole.ANY);
        if(!organizationRole.getAccept()){
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }

        try {
            List<Organization> organizations = organizationService.selectByUserId(organizationRole.getOauthUser().get_id());
            if (organizations.isEmpty()) {
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
            }
            return new ResponseEntity<>(organizations, HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value = "/organization/{id}", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<Organization> getOrganization(HttpServletRequest request, @PathVariable("id") String id) {
        OrganizationRole organizationRole = organizationService.getOrganizationRole(request, OrganizationRole.MEMBER);
        if(!organizationRole.getAccept()){
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }

        try {
            Organization organization = organizationService.selectById(id);
            if (organization == null) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }
            return new ResponseEntity<>(organization, HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value = "/organization", method = RequestMethod.POST)
    public ResponseEntity<Void> createOrganization(HttpServletRequest request, @RequestBody Organization organization, UriComponentsBuilder ucBuilder) {
        OrganizationRole organizationRole = organizationService.getOrganizationRole(request, OrganizationRole.ANY);
        if(!organizationRole.getAccept()){
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }

        try {
            Organization existOrganization = organizationService.selectByName(organization.getName());
            if (existOrganization != null) {
                return new ResponseEntity<>(HttpStatus.CONFLICT);
            }

            Organization createdOrganization = organizationService.createOrganization(organization);

            HttpHeaders headers = new HttpHeaders();
            headers.setLocation(ucBuilder.path("/rest/v1/organization/{_id}").buildAndExpand(createdOrganization.getId()).toUri());
            return new ResponseEntity<>(headers, HttpStatus.CREATED);
        } catch (Exception ex) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

//    @RequestMapping(value = "/client/{_id}", method = RequestMethod.PUT)
//    public ResponseEntity<OauthClient> updateClient(HttpServletRequest request, @PathVariable("_id") String _id, @RequestBody OauthClient oauthClient) {
//
//        Management management = restAuthService.managementParser(request);
//        if (management == null) {
//            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
//        }
//
//        try {
//            OauthClient currentClient = oauthClientService.selectByManagementIdAndId(management.get_id(), _id);
//
//            if (currentClient == null) {
//                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
//            }
//            oauthClient.set_id(currentClient.get_id());
//            oauthClientService.updateById(oauthClient);
//
//            currentClient = oauthClientService.selectByManagementIdAndId(management.get_id(), _id);
//            return new ResponseEntity<>(currentClient, HttpStatus.OK);
//        } catch (Exception ex) {
//            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
//        }
//    }
//
//    @RequestMapping(value = "/client/{_id}", method = RequestMethod.DELETE)
//    public ResponseEntity<OauthClient> deleteClient(HttpServletRequest request, @PathVariable("_id") String _id) {
//
//        Management management = restAuthService.managementParser(request);
//        if (management == null) {
//            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
//        }
//        try {
//            OauthClient currentClient = oauthClientService.selectByManagementIdAndId(management.get_id(), _id);
//
//            if (currentClient == null) {
//                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
//            }
//
//            oauthClientService.deleteById(currentClient.get_id());
//            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
//        } catch (Exception ex) {
//            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
//        }
//    }
}
