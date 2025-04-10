package com.example.hopebridge.controllers;

import com.example.hopebridge.entities.Order;
import com.example.hopebridge.entities.User;
import com.example.hopebridge.requests.PlaceOrderRequest;
import com.example.hopebridge.services.OrderService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/shop")
public class OrderController {

    private final OrderService orderService;

    // Constructor-based dependency injection for better testability and maintainability
    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    @PostMapping("/order")
    public ResponseEntity<Order> placeOrder(@RequestBody PlaceOrderRequest placeOrderRequest,@AuthenticationPrincipal User user) {
    // Creates a new order and returns the saved order details in the response.

        if (orderService.placeOrder(placeOrderRequest, user)!= null)
        {
            System.out.println("Product ID: " + placeOrderRequest.getProductId());
            System.out.println("Order placed successfully");
            return ResponseEntity.ok(orderService.placeOrder(placeOrderRequest, user));
        } else {
            return ResponseEntity.badRequest().build();
        }


    }

    @GetMapping("/orders/{userId}")
    public ResponseEntity<List<Order>> getOrders(@PathVariable Long userId) {
    // Fetching all orders placed by a specific user
        return ResponseEntity.ok(orderService.getOrdersByUser(userId));
    }
}
