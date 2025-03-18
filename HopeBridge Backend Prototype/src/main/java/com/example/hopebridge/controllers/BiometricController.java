package com.example.hopebridge.controllers;

import com.example.hopebridge.requests.BiometricRegisterRequest;
import com.example.hopebridge.services.BiometricService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/biometric")
public class BiometricController {

    private final BiometricService biometricService;

    public BiometricController(BiometricService biometricService) {
        this.biometricService = biometricService;
    }

    @PostMapping("/register")
    public String registerBiometric(@RequestBody BiometricRegisterRequest request) {
        return biometricService.registerBiometric(request);
    }

    @PostMapping("/verify")
    public boolean verifyBiometric(@RequestParam Long userId, @RequestParam String fingerprintHash) {
        return biometricService.verifyBiometric(userId, fingerprintHash);
    }
}
