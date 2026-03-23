package com.example.hopebridge.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "vouchers")
public class Voucher {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String code;
    private Double amount;
    private boolean redeemed;
    @ManyToOne
    private User user;

    public Voucher() {}
    public Voucher(Long id, String code, Double amount, boolean redeemed, User user) {
        this.id = id; this.code = code; this.amount = amount; this.redeemed = redeemed; this.user = user;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }
    public Double getAmount() { return amount; }
    public void setAmount(Double amount) { this.amount = amount; }
    public boolean isRedeemed() { return redeemed; }
    public void setRedeemed(boolean redeemed) { this.redeemed = redeemed; }
    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
}
