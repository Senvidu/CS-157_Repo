package com.example.hopebridge.entities;

import jakarta.persistence.*;

@Entity
public class Transaction {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ManyToOne
    @JoinColumn(name = "supermarket_id")
    private Supermarket supermarket;
    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;
    private Double price;
    private boolean usedVoucher;

    public Transaction() {}
    public Transaction(Long id, Supermarket supermarket, Product product, Double price, boolean usedVoucher) {
        this.id = id; this.supermarket = supermarket; this.product = product; this.price = price; this.usedVoucher = usedVoucher;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Supermarket getSupermarket() { return supermarket; }
    public void setSupermarket(Supermarket supermarket) { this.supermarket = supermarket; }
    public Product getProduct() { return product; }
    public void setProduct(Product product) { this.product = product; }
    public Double getPrice() { return price; }
    public void setPrice(Double price) { this.price = price; }
    public boolean isUsedVoucher() { return usedVoucher; }
    public void setUsedVoucher(boolean usedVoucher) { this.usedVoucher = usedVoucher; }

    public static Builder builder() { return new Builder(); }
    public static class Builder {
        private Long id; private Supermarket supermarket; private Product product; private Double price; private boolean usedVoucher;
        public Builder id(Long id) { this.id = id; return this; }
        public Builder supermarket(Supermarket supermarket) { this.supermarket = supermarket; return this; }
        public Builder product(Product product) { this.product = product; return this; }
        public Builder price(Double price) { this.price = price; return this; }
        public Builder usedVoucher(boolean usedVoucher) { this.usedVoucher = usedVoucher; return this; }
        public Transaction build() { return new Transaction(id, supermarket, product, price, usedVoucher); }
    }
}
