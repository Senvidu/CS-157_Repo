package com.example.hopebridge.controllers;

import com.example.hopebridge.services.ProductVerificationService;
import org.springframework.web.bind.annotation.*;


//Controller for handling product verification requests.

@RestController
@RequestMapping("/api/products")
public class ProductVerificationController {

    private final ProductVerificationService productVerificationService;
//Constructor to inject ProductVerificationService.
    public ProductVerificationController(ProductVerificationService productVerificationService) {
        this.productVerificationService = productVerificationService;
    }
//Endpoint to verify a product by it's id
    @GetMapping("/verify/{productId}")
    public boolean verifyProduct(@PathVariable Long productId) {
        return productVerificationService.verifyProduct(productId);
    }
}
