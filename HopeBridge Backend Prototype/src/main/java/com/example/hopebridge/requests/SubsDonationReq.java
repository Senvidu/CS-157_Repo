package com.example.hopebridge.requests;

public class SubsDonationReq {
    private Double amount;
    private String message;
    private Integer noOfMonths;

    public SubsDonationReq() {}
    public Double getAmount() { return amount; }
    public void setAmount(Double amount) { this.amount = amount; }
    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }
    public Integer getNoOfMonths() { return noOfMonths; }
    public void setNoOfMonths(Integer noOfMonths) { this.noOfMonths = noOfMonths; }
}
