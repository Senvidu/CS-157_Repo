package com.example.hopebridge.entities;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "supermarkets")
@Data
//supermarket class is to buy product through voucher
public class Supermarket {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String location;
    private Double profitShare;
}
