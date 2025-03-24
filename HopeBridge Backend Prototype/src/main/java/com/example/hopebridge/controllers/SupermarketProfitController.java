package com.example.hopebridge.controllers;

import com.example.hopebridge.services.SupermarketProfitService;
import org.springframework.web.bind.annotation.*;

//Controller for handling supermarket profit-related requests.
@RestController
@RequestMapping("/api/supermarkets")
public class SupermarketProfitController {

    private final SupermarketProfitService supermarketProfitService;
//Constructor to inject SupermarketProfitService.

    public SupermarketProfitController(SupermarketProfitService supermarketProfitService) {
        this.supermarketProfitService = supermarketProfitService;
    }

//Endpoint to retrieve the profit of a specific supermarket.
    @GetMapping("/{supermarketId}/profit")
    public double getSupermarketProfit(@PathVariable Long supermarketId) {
        return supermarketProfitService.calculateProfit(supermarketId);
    }
}
