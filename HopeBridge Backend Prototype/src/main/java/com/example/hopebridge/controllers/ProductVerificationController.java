package com.example.hopebridge.controllers;

import com.example.hopebridge.services.ProductVerificationService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/products")
public class ProductVerificationController {

    private final ProductVerificationService productVerificationService;

    public ProductVerificationController(ProductVerificationService productVerificationService) {
        this.productVerificationService = productVerificationService;
    }

    @GetMapping("/verify/{productId}")
    public boolean verifyProduct(@PathVariable Long productId) {
        return productVerificationService.verifyProduct(productId);
    }
}
