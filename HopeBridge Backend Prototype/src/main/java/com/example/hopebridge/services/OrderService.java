package com.example.hopebridge.services;

import com.example.hopebridge.entities.Order;
import com.example.hopebridge.entities.Product;
import com.example.hopebridge.entities.User;
import com.example.hopebridge.repos.OrderRepository;
import com.example.hopebridge.repos.ProductRepository;
import com.example.hopebridge.requests.PlaceOrderRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class OrderService {

    private final OrderRepository orderRepository;

    @Autowired
    private  ProductRepository productRepository;

    public OrderService(OrderRepository orderRepository) {
        this.orderRepository = orderRepository;
    }

    public Order placeOrder(PlaceOrderRequest request, User user)
    {
        //Long userId = user.getId();
        Optional<Product> product = productRepository.findById(request.getProductId());
        System.out.println(product.toString());
        try {
            if (!product.isEmpty()) {
                var newOrder = Order.builder()
                        .user(user)
                        .product(product.get())
                        .usedVoucher(request.isUsedVoucher())
                        .build();
                return orderRepository.save(newOrder);

            }else
                throw new IllegalArgumentException("Product not found");
        } catch (IllegalArgumentException e) {
            // Handle the exception as needed
            System.out.println(e.getMessage());
        }
        return null;

    }

    public List<Order> getOrdersByUser(Long userId) {
        return orderRepository.findByUserId(userId);
    }
}
