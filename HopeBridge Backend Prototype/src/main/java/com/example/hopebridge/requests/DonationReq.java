package com.example.hopebridge.requests;

public class DonationReq {
    private Double amount;
    private String message;

    public DonationReq() {}
    public Double getAmount() { return amount; }
    public void setAmount(Double amount) { this.amount = amount; }
    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }
}
