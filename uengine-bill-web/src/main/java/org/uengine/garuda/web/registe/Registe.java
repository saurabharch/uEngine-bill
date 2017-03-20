package org.uengine.garuda.web.registe;

import java.util.Date;

/**
 * Created by uengine on 2015. 6. 3..
 */
public class Registe {

    private Long id;
    private String user_id;
    private String token;
    private Date registration;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public Date getRegistration() {
        return registration;
    }

    public void setRegistration(Date registration) {
        this.registration = registration;
    }
}
