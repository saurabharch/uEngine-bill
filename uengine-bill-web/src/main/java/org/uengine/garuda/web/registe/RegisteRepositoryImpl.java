package org.uengine.garuda.web.registe;

import org.mybatis.spring.SqlSessionTemplate;
import org.uengine.garuda.common.repository.PersistentRepositoryImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.Map;

@Repository
public class RegisteRepositoryImpl extends PersistentRepositoryImpl<String, Object> implements RegisteRepository {


    @Override
    public String getNamespace() {
        return this.NAMESPACE;
    }

    @Autowired
    public RegisteRepositoryImpl(SqlSessionTemplate sqlSessionTemplate) {
        super.setSqlSessionTemplate(sqlSessionTemplate);
    }

    @Override
    public int insertRegiste(Registe registe) {
        return this.getSqlSessionTemplate().insert(this.getNamespace() + ".insertRegiste", registe);
    }


    @Override
    public Registe selectByUserIdAndToken(String user_id, String token) {
        Map map = new HashMap();
        map.put("user_id", user_id);
        map.put("token", token);
        return this.getSqlSessionTemplate().selectOne(this.getNamespace() + ".selectByUseridAndToken", map);
    }
}
