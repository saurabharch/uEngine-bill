package org.uengine.garuda.web.organization;

import org.uengine.garuda.model.Organization;
import org.uengine.iam.client.model.OauthUser;

/**
 * Created by uengine on 2017. 1. 11..
 */
public class OrganizationRole {

    public static String ADMIN = "ADMIN";

    public static String MEMBER = "MEMBER";

    public static String ANY = "ANY";

    private String token;

    private String role;

    private Organization organization;

    private OauthUser oauthUser;

    private boolean accept;

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Organization getOrganization() {
        return organization;
    }

    public void setOrganization(Organization organization) {
        this.organization = organization;
    }

    public OauthUser getOauthUser() {
        return oauthUser;
    }

    public void setOauthUser(OauthUser oauthUser) {
        this.oauthUser = oauthUser;
    }

    public boolean getAccept() {
        return accept;
    }

    public void setAccept(boolean accept) {
        this.accept = accept;
    }
}
