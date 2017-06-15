package org.uengine.garuda.web.product.version;

import org.uengine.garuda.model.Organization;
import org.uengine.garuda.model.Product;
import org.uengine.garuda.model.ProductVersion;
import org.uengine.garuda.model.catalog.Plan;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;

public interface ProductVersionService {

    List<Map> listVersionExcludePlans(String organization_id, String product_id) throws IOException;

    List<ProductVersion> listVersion(String organization_id, String product_id);

    ProductVersion getVersion(String organization_id, String product_id, Long version);

    ProductVersion getCurrentVersion(String organization_id, String product_id);

    ProductVersion getVersionByEffectiveDate(String organization_id, String product_id, Date effectiveDate);

    ProductVersion createVersion(String organization_id, String product_id, ProductVersion productVersion);

    ProductVersion updateVersion(String organization_id, String product_id, Long version, ProductVersion productVersion);

    int deleteVersion(String organization_id, String product_id, Long version);

    Plan getPlanFromVersionByPlanName(ProductVersion version, String plan_name);
}
