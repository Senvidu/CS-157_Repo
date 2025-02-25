package com.example.hopebridge.services;

import com.example.hopebridge.entities.Product;
import com.example.hopebridge.repos.ProductRepository;
import com.example.hopebridge.requests.AddProductRequest;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ProductService {

    private final ProductRepository productRepository;

    public ProductService(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }

    public void addProduct(AddProductRequest addProductRequest)
    {
        Product newProduct = Product.builder()
                .name(addProductRequest.getName())
                .price(addProductRequest.getPrice())
                .eligibleForVoucher(addProductRequest.getEligibleForVoucher())
                .build();
        productRepository.save(newProduct);

    }

    public List<Product> getEligibleProducts()
    {
        return productRepository.findByEligibleForVoucherTrue();
    }
}
