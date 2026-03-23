package com.example.hopebridge.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "orders")
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;
    private boolean usedVoucher;

    public Order() {}
    public Order(Long id, User user, Product product, boolean usedVoucher) {
        this.id = id; this.user = user; this.product = product; this.usedVoucher = usedVoucher;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
    public Product getProduct() { return product; }
    public void setProduct(Product product) { this.product = product; }
    public boolean isUsedVoucher() { return usedVoucher; }
    public void setUsedVoucher(boolean usedVoucher) { this.usedVoucher = usedVoucher; }
}
