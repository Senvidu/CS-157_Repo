package com.example.hopebridge.entities;

import jakarta.persistence.*;

@Entity
public class Biometric {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @OneToOne
    @JoinColumn(name = "user_id", referencedColumnName = "id")
    private User user;
    private String fingerprintHash;

    public Biometric() {}
    public Biometric(Long id, User user, String fingerprintHash) { this.id = id; this.user = user; this.fingerprintHash = fingerprintHash; }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
    public String getFingerprintHash() { return fingerprintHash; }
    public void setFingerprintHash(String fingerprintHash) { this.fingerprintHash = fingerprintHash; }

    public static Builder builder() { return new Builder(); }
    public static class Builder {
        private Long id; private User user; private String fingerprintHash;
        public Builder id(Long id) { this.id = id; return this; }
        public Builder user(User user) { this.user = user; return this; }
        public Builder fingerprintHash(String fingerprintHash) { this.fingerprintHash = fingerprintHash; return this; }
        public Biometric build() { return new Biometric(id, user, fingerprintHash); }
    }
}
