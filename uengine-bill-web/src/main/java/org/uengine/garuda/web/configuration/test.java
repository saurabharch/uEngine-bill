package org.uengine.garuda.web.configuration;

import com.fasterxml.jackson.databind.DeserializationConfig;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.core.io.ClassPathResource;
import org.uengine.garuda.model.Organization;
import org.uengine.garuda.util.JsonUtils;

import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by uengine on 2015. 5. 22..
 */
public class test {

    public static void main(String[] args) throws Exception {

        //컨스트럭터에 의해 선언이 됨.
        Organization organization = new Organization();

        //클래스의 prototype 의 이용.
        organization.setId("고유아이디");
        System.out.println(organization.getId());



//        ObjectMapper objectMapper = new ObjectMapper();
//        objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
//
//        TestClass testClass = objectMapper.convertValue(map, TestClass.class);

    }
}
