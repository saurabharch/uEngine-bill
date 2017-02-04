package org.uengine.garuda.web.product.version;

import org.uengine.garuda.model.Organization;
import org.uengine.garuda.model.Product;
import org.uengine.garuda.model.ProductVersion;

import java.io.IOException;
import java.util.List;
import java.util.Map;

public interface ProductVersionService {

    List<Map> listVersionExcludePlans(String organization_id, String product_id) throws IOException;

    List<ProductVersion> listVersion(String organization_id, String product_id);

    ProductVersion getVersion(String organization_id, String product_id, Long version);

    ProductVersion getCurrentVersion(String organization_id, String product_id);

    ProductVersion createVersion(String organization_id, String product_id, ProductVersion productVersion);

    ProductVersion updateVersion(String organization_id, String product_id, Long version, ProductVersion productVersion);

    int updateVersionAsCurrent(String organization_id, String product_id, Long version);

    int deleteVersion(String organization_id, String product_id, Long version);
}
