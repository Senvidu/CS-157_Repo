package com.example.hopebridge.services;

import com.example.hopebridge.entities.Product;
import com.example.hopebridge.repos.ProductRepository;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class ProductVerificationService {

    private final ProductRepository productRepository;

    public ProductVerificationService(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    public boolean verifyProduct(Long productId) {
        Optional<Product> product = productRepository.findById(productId);
        return product.isPresent(); // Return true if product exists, false otherwise
    }
}
