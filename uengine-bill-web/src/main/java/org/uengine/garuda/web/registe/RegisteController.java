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
package org.uengine.garuda.web.registe;

import org.apache.commons.codec.binary.Base64;
import org.uengine.garuda.common.rest.Response;
import org.uengine.garuda.util.DateUtils;
import org.uengine.garuda.util.EscapeUtils;
import org.uengine.garuda.util.ExceptionUtils;
import org.uengine.garuda.util.NetworkUtils;
import org.uengine.garuda.web.configuration.DefaultController;
import org.uengine.garuda.web.system.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.uengine.iam.client.model.OauthUser;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;
import java.util.Map;
import java.util.Properties;

/**
 * Security Auth Controller
 *
 * @author Seungpil PARK
 * @since 2.0
 */
@Controller
@RequestMapping("/registe")
public class RegisteController extends DefaultController {

    @Autowired
    @Qualifier("config")
    private Properties config;

    @Autowired
    private UserService userService;

    @Autowired
    private RegisteService registeService;

    /**
     * SLF4J Logging
     */
    private Logger logger = LoggerFactory.getLogger(RegisteController.class);

    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public ModelAndView register(HttpSession session) {
        return new ModelAndView("/registe/register");
    }

    /**
     * 사용자가 사용자 등록 정보를 입력하면 입력한 정보로 회원가입 처리한 후 회원가입 확인 이메일을 전송한다.
     */
    @RequestMapping(value = "/request", method = RequestMethod.POST)
    public ModelAndView registerRequest(
            HttpServletRequest request,
            @RequestParam String userName,
            @RequestParam String password,
            @RequestParam String email,
            @RequestParam String confirmPassword) {

        try{
            String unescapedPassword = EscapeUtils.unescape(password);
            OauthUser existUser = userService.selectByUserName(userName);

            //계정은 있으나 메일확인을 받지 못한 경우
            if (userService.waitingConfirmation(userName)) {
                ModelAndView mav = new ModelAndView();
                mav.setViewName("/registe/reaffirm");
                mav.addObject("responseUserName", userName);
                mav.addObject("responseEmail", (String) existUser.getMetaData().get("email"));
                return mav;
            }

            //계정이 이미 있고 메일확인까지 받은 경우
            if (userService.completeAccount(userName)) {
                ModelAndView mav = new ModelAndView();
                mav.setViewName("/registe/exist");
                mav.addObject("responseUserName", userName);
                mav.addObject("responseEmail", (String) existUser.getMetaData().get("email"));
                return mav;
            }

            //신규 계정일 경우 유저를 만들고 이메일 전송 후 화면 이동시킨다.
            String ipAddr = NetworkUtils.getIpAddr(request);
            OauthUser user = new OauthUser();
            user.setUserName(userName);
            user.setUserPassword(unescapedPassword);
            user.getMetaData().put("email", email);

            userService.createUser(user);
            registeService.sendRegisteMail(userName);

            ModelAndView mav = new ModelAndView();
            mav.addObject("responseEmail", email);
            mav.setViewName("/registe/confirmation");
            return mav;
        }catch (Exception ex){
            ex.printStackTrace();
            return null;
        }
    }

    @RequestMapping(value = "/remail", method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public Response remail(@RequestBody Map params) {
        Response response = new Response();
        try {
            String userName = params.get("userName").toString();
            registeService.sendRegisteMail(userName);
            response.setSuccess(true);
        } catch (Exception ex) {
            ex.printStackTrace();
            response.setSuccess(false);
            response.getError().setMessage(ex.getMessage());
            if (ex.getCause() != null) response.getError().setCause(ex.getCause().getMessage());
            response.getError().setException(ExceptionUtils.getFullStackTrace(ex));
        }
        return response;
    }


    /**
     * 이메일 인증이 완료되면 유저상태를 업데이트시긴다.
     * 젠데스크에 유저를 추가한다.
     */
    @RequestMapping(value = "/confirm", method = RequestMethod.GET)
    public ModelAndView confirm(HttpServletResponse res, @RequestParam String userid, @RequestParam String token) throws IOException {
        long tokenTimestamp = Long.parseLong(new String(Base64.decodeBase64(token)));

        if (DateUtils.getDiffDays(new Date(), new Date(tokenTimestamp)) > 1) {
            ModelAndView mav = new ModelAndView();
            mav.setViewName("/auth/error-401");
            return mav;
        }
        try {
            registeService.completeRegiste(userid, token);
            ModelAndView mav = new ModelAndView();
            mav.setViewName("/registe/complete");
            return mav;
        } catch (Exception ex) {
            ex.printStackTrace();
            ModelAndView mav = new ModelAndView();
            mav.setViewName("/auth/error-401");
            return mav;
        }
    }
}
