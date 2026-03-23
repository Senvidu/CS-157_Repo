package com.example.hopebridge.entities;

import jakarta.persistence.*;

@Entity
public class Donation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Double amount;
    private String message;
    @ManyToOne
    @JoinColumn(name = "donor_id")
    private User donor;

    public Donation() {}
    public Donation(Long id, Double amount, String message, User donor) { this.id = id; this.amount = amount; this.message = message; this.donor = donor; }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Double getAmount() { return amount; }
    public void setAmount(Double amount) { this.amount = amount; }
    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }
    public User getDonor() { return donor; }
    public void setDonor(User donor) { this.donor = donor; }

    public static Builder builder() { return new Builder(); }
    public static class Builder {
        private Long id; private Double amount; private String message; private User donor;
        public Builder id(Long id) { this.id = id; return this; }
        public Builder amount(Double amount) { this.amount = amount; return this; }
        public Builder message(String message) { this.message = message; return this; }
        public Builder donor(User donor) { this.donor = donor; return this; }
        public Donation build() { return new Donation(id, amount, message, donor); }
    }
}
