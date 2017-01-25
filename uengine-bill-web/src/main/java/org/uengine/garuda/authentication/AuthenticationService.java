package org.uengine.garuda.authentication;

import javax.servlet.http.HttpServletRequest;

public interface AuthenticationService {

    AuthInformation validateRequest(HttpServletRequest request, String key, String location, String tokenType);

}
