package com.example.hopebridge.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "products")
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private Double price;
    private boolean eligibleForVoucher;

    public Product() {}
    public Product(Long id, String name, Double price, boolean eligibleForVoucher) {
        this.id = id; this.name = name; this.price = price; this.eligibleForVoucher = eligibleForVoucher;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public Double getPrice() { return price; }
    public void setPrice(Double price) { this.price = price; }
    public boolean isEligibleForVoucher() { return eligibleForVoucher; }
    public void setEligibleForVoucher(boolean eligibleForVoucher) { this.eligibleForVoucher = eligibleForVoucher; }

    public static Builder builder() { return new Builder(); }
    public static class Builder {
        private Long id; private String name; private Double price; private boolean eligibleForVoucher;
        public Builder id(Long id) { this.id = id; return this; }
        public Builder name(String name) { this.name = name; return this; }
        public Builder price(Double price) { this.price = price; return this; }
        public Builder eligibleForVoucher(boolean eligibleForVoucher) { this.eligibleForVoucher = eligibleForVoucher; return this; }
        public Product build() { return new Product(id, name, price, eligibleForVoucher); }
    }
}
