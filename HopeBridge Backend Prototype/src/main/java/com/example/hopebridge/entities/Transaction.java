package com.example.hopebridge.entities;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
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

    private Double price; // Amount spent on the product
    private boolean usedVoucher; // Indicates if a voucher was used or redeemed
}
