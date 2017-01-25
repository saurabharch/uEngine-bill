package org.uengine.garuda.killbill;

import org.opencloudengine.garuda.client.model.OauthUser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.uengine.garuda.authentication.AuthInformation;
import org.uengine.garuda.authentication.AuthenticationService;
import org.uengine.garuda.common.exception.ServiceException;
import org.uengine.garuda.killbill.api.model.Tenant;
import org.uengine.garuda.model.Authority;
import org.uengine.garuda.model.Organization;
import org.uengine.garuda.model.OrganizationEmail;
import org.uengine.garuda.util.StringUtils;
import org.uengine.garuda.web.organization.OrganizationRepository;
import org.uengine.garuda.web.organization.OrganizationRole;
import org.uengine.garuda.web.organization.OrganizationService;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Service
public class KBServiceImpl implements KBService {

    @Autowired
    @Qualifier("config")
    private Properties config;

    @Autowired
    private OrganizationRepository organizationRepository;

    @Autowired
    private KBRepository kbRepository;

    @Autowired
    private AuthenticationService authenticationService;

    @Autowired
    private KBServiceFactory killbillServiceFactory;

    private Logger logger = LoggerFactory.getLogger(KBService.class);

}
