package com.example.hopebridge.controllers;

import com.example.hopebridge.entities.Order;
import com.example.hopebridge.services.OrderService;
import org.springframework.http.ResponseEntity;
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
    public ResponseEntity<Order> placeOrder(@RequestBody Order order) {
    // Placing an order and returning the saved order object
        return ResponseEntity.ok(orderService.placeOrder(order));
    }

    @GetMapping("/orders/{userId}")
    public ResponseEntity<List<Order>> getOrders(@PathVariable Long userId) {
    // Fetching all orders placed by a specific user
        return ResponseEntity.ok(orderService.getOrdersByUser(userId));
    }
}
