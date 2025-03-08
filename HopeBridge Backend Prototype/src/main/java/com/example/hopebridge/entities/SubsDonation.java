package com.example.hopebridge.entities;

import jakarta.persistence.*;
import lombok.*;


@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity(name = "subscription_donations")
public class SubsDonation
{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Double amount;
    private String message;

    private Integer noOfMonths;

    @ManyToOne
    @JoinColumn(name = "donor_id")
    private User donor;
}
