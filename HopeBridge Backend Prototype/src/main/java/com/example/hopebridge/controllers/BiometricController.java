package com.example.hopebridge.controllers;

import com.example.hopebridge.services.BiometricService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/biometrics")
public class BiometricController {

    private final BiometricService biometricService;

    public BiometricController(BiometricService biometricService) {
        this.biometricService = biometricService;
    }

    @PostMapping("/register")
    public String registerBiometric(@RequestParam Long userId, @RequestParam String fingerprintHash) {
        return biometricService.registerBiometric(userId, fingerprintHash);
    }

    @PostMapping("/verify")
    public boolean verifyBiometric(@RequestParam Long userId, @RequestParam String fingerprintHash) {
        return biometricService.verifyBiometric(userId, fingerprintHash);
    }
}
