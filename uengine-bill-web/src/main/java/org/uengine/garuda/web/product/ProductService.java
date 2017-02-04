package org.uengine.garuda.web.product;

import org.opencloudengine.garuda.client.model.OauthUser;
import org.uengine.garuda.model.Authority;
import org.uengine.garuda.model.Organization;
import org.uengine.garuda.model.OrganizationEmail;
import org.uengine.garuda.model.Product;
import org.uengine.garuda.web.organization.OrganizationRole;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

public interface ProductService {

    Map selectProductByCondition(String organization_id, String is_active,String searchKey,Long offset, Long limit);

    Product selectProductById(String organization_id, String id);

    Product insertProduct(Organization organization, Product product);

    Product updateProductById(Organization organization, Product product);

    int deleteProductById(String organization_id, String id);

    Product updateProductActiveById(Product product, String is_active);

    int updatePlanUsageSeq(String organization_id, String id, Long plan_seq, Long usage_seq);
}
