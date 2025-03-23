package com.example.hopebridge.entities;
import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "vouchers")
@Data
//voucher class is to do transaction without handling money
public class Voucher {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String code;
    private Double amount;
    private boolean redeemed;

    @ManyToOne
    private User user;
}
