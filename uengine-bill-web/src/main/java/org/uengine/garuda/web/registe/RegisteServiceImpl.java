package org.uengine.garuda.web.registe;

import org.opencloudengine.garuda.client.model.OauthUser;
import org.uengine.garuda.common.exception.ServiceException;
import org.uengine.garuda.mail.MailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.crypto.codec.Base64;
import org.springframework.stereotype.Service;
import org.uengine.garuda.web.system.UserService;

import java.util.Properties;

@Service
public class RegisteServiceImpl implements RegisteService {

    @Autowired
    @Qualifier("config")
    private Properties config;

    @Autowired
    private RegisteRepository registeRepository;

    @Autowired
    private UserService userService;

    @Autowired
    private MailService mailService;


    @Override
    public void sendRegisteMail(String userName) {

        OauthUser user = userService.selectByUserName(userName);
        Registe registe = new Registe();
        registe.setUser_id(user.get_id());

        String email = user.get("email").toString();

        String fromUser = System.getProperty("org.killbill.mail.from");
        String token = new String(Base64.encode(String.valueOf(System.currentTimeMillis()).getBytes()));
        registe.setToken(token);

        registeRepository.insertRegiste(registe);
        mailService.registe(registe.getUser_id(), token, "Confirm Registration", fromUser, "uEngine", email, null);
    }

    @Override
    public void completeRegiste(String user_id, String token) {

        Registe managedRegiste = registeRepository.selectByUserIdAndToken(user_id,token);
        if (managedRegiste == null) throw new ServiceException("가입 확인 처리할 대상이 없습니다.");

        OauthUser user = userService.selectByUserId(user_id);
        userService.acknowledge(user.getUserName());
    }
}
