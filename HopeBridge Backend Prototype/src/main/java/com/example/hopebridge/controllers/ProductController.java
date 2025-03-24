package com.example.hopebridge.controllers;

import com.example.hopebridge.entities.Product;
import com.example.hopebridge.requests.AddProductRequest;
import com.example.hopebridge.services.ProductService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.task.DelegatingSecurityContextAsyncTaskExecutor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/shop")
public class ProductController {

    private final ProductService productService;
// Constructor-based dependency injection
    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/products")
    public ResponseEntity<List<Product>> getAllProducts() {
     // Fetching all products from the service layer
        return ResponseEntity.ok(productService.getAllProducts());
    }

    @GetMapping("/products/eligible")
    public ResponseEntity<List<Product>> getEligibleProducts() {
    // Fetching only eligible products
        return ResponseEntity.ok(productService.getEligibleProducts());
    }

    @PostMapping("/addProducts")
    public ResponseEntity<?> addProducts(@RequestBody AddProductRequest addProductRequest)
    {
        try
        {
        // Ensure validation for addProductRequest before passing it to service
            productService.addProduct(addProductRequest);
            return ResponseEntity.ok("The product "+addProductRequest.getName()+" was Successfully added!!");
        } catch (Exception e) {
        // Avoid throwing generic RuntimeException, instead return a proper ResponseEntity
            throw new RuntimeException(e);
        }
    }
}
