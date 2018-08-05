/**
 * Copyright (C) 2011 uEngine Project (http://www.uengine.io).
 * <p/>
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * <p/>
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * <p/>
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package org.uengine.garuda.web.system;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.uengine.garuda.authentication.AuthInformation;
import org.uengine.garuda.authentication.AuthenticationService;
import org.uengine.garuda.util.DateUtils;
import org.uengine.garuda.util.ExceptionUtils;
import org.uengine.garuda.web.configuration.ConfigurationHelper;
import org.uengine.garuda.web.configuration.DefaultController;
import org.uengine.iam.client.model.OauthUser;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Security Auth Controller
 *
 * @author Seungpil PARK
 * @since 2.0
 */
@Controller
@RequestMapping("/rest/v1")
public class UserRestController extends DefaultController {

    @Autowired
    private UserService userService;

    @Autowired
    private IamServiceFactory iamServiceFactory;

    @Autowired
    private AuthenticationService authenticationService;

    @Autowired
    ConfigurationHelper configurationHelper;

    /**
     * SLF4J Logging
     */
    private Logger logger = LoggerFactory.getLogger(UserRestController.class);

    @RequestMapping(value = "/access_token", method = RequestMethod.POST, produces = "application/json")
    public ResponseEntity<Map> accessToken(HttpServletRequest request,
                                           HttpServletResponse response) {

        try {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String scope = request.getParameter("scope");

            if (!configurationHelper.get("authorization.scope").equals(scope)) {
                return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
            }
            Map map = userService.accessToken(username, password, scope);
            if ((int) map.get("status") != 200) {
                return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
            }
            return new ResponseEntity<>(map, HttpStatus.OK);

        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }

    @RequestMapping(value = "/token_info", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<OauthUser> tokenInfo(HttpServletRequest request,
                                               HttpServletResponse response
    ) throws IOException {

        try {
            AuthInformation authInformation = authenticationService.validateRequest(
                    request,
                    configurationHelper.get("tokeninfo.authorization"),
                    AuthInformation.LOCATION_PARAM,
                    AuthInformation.TOKEN_TYPE_JWT);

            if (authInformation.getError() != null) {
                return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
            }

            authInformation.getOauthUser().setUserPassword(null);
            return new ResponseEntity<>(authInformation.getOauthUser(), HttpStatus.OK);


        } catch (Exception ex) {
            ExceptionUtils.httpExceptionKBResponse(ex, response);
            return null;
        }
    }
}
