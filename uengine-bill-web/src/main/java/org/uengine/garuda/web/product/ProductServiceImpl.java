package org.uengine.garuda.web.product;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.uengine.garuda.model.*;
import org.uengine.garuda.model.catalog.ProductCategory;
import org.uengine.garuda.web.product.event.SubscriptionEventRepository;

import java.util.*;

@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    @Qualifier("config")
    private Properties config;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private SubscriptionEventRepository subscriptionEventRepository;

    private Logger logger = LoggerFactory.getLogger(ProductRepository.class);

    @Override
    public Map selectProductByCondition(String organization_id, String is_active, String category, String searchKey, Long offset, Long limit) {
        return productRepository.selectProductByCondition(organization_id, is_active,category, searchKey, offset, limit);
    }

    @Override
    public Product selectProductById(String organization_id, String id) {
        return productRepository.selectProductById(organization_id, id);
    }

    @Override
    public Product insertProduct(Organization organization, Product product) {
        product.setOrganization_id(organization.getId());
        product.setTenant_id(organization.getTenant_id());
        if (!ProductCategory.ADD_ON.toString().equals(product.getCategory()) &&
                !ProductCategory.BASE.toString().equals(product.getCategory()) &&
                !ProductCategory.ONE_TIME.toString().equals(product.getCategory())) {
            product.setCategory(ProductCategory.BASE.toString());
        }
        return productRepository.insertProduct(product);
    }

    @Override
    public Product updateProductById(Organization organization, Product product) {
        product.setOrganization_id(organization.getId());
        return productRepository.updateProductById(product);
    }

    @Override
    public int deleteProductById(String organization_id, String id) {
        //프로덕트 관련 서브스크립션이 있다면 삭제 불가.
        Long countByProduct = subscriptionEventRepository.selectSubscriptionCountByProduct(organization_id, id);
        if (countByProduct > 0) {
            return 0;
        } else {
            return productRepository.deleteProductById(organization_id, id);
        }
    }

    @Override
    public Product updateProductActiveById(Product product, String is_active) {
        return productRepository.updateProductActiveById(product.getOrganization_id(), product.getId(), is_active);
    }

    @Override
    public int updatePlanUsageSeq(String organization_id, String id, Long plan_seq, Long usage_seq) {
        return productRepository.updatePlanUsageSeq(organization_id, id, plan_seq, usage_seq);
    }
}
