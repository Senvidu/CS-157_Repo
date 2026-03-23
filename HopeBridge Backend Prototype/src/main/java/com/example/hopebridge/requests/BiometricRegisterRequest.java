package com.example.hopebridge.requests;

public class BiometricRegisterRequest
{
    private Integer userId;
    private String fingerprintHash;

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getFingerprintHash() {
        return fingerprintHash;
    }

    public void setFingerprintHash(String fingerprintHash) {
        this.fingerprintHash = fingerprintHash;
    }
}
