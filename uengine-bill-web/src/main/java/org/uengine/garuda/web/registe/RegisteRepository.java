package org.uengine.garuda.web.registe;

public interface RegisteRepository {

    String NAMESPACE = RegisteRepository.class.getName();

    Registe selectByUserIdAndToken(String user_id, String token);

    int insertRegiste(Registe registe);

}
