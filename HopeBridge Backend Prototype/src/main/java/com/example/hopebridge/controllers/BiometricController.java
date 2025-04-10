package com.example.hopebridge.controllers;

import com.example.hopebridge.entities.Biometric;
import com.example.hopebridge.entities.User;
import com.example.hopebridge.repos.BiometricRepository;
import com.example.hopebridge.requests.BiometricRegisterRequest;
import com.example.hopebridge.services.BiometricService;
import com.example.hopebridge.services.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/biometric")
public class BiometricController {

    private final BiometricService biometricService;

    @Autowired
    private  BiometricRepository biometricRepository;

    @Autowired
    private JwtUtil jwtUtil;

    public BiometricController(BiometricService biometricService) {
        this.biometricService = biometricService;
    }

    @PostMapping("/register")
    public ResponseEntity<?> registerBiometric(@RequestBody BiometricRegisterRequest request) {
        biometricService.registerBiometric(request);
        return ResponseEntity.ok(Map.of("message", "Biometric data registered successfully"));
    }

    @PostMapping("/verify")
    public ResponseEntity<?> verifyBiometric(@RequestBody BiometricRegisterRequest request) {
        // Retrieve biometric record for the given user ID
        Optional<Biometric> biometricOpt = biometricRepository.findByUserId(Long.valueOf(request.getUserId()));
        if (biometricOpt.isEmpty()) {
            return ResponseEntity.status(401)
                    .body(Map.of("error", "Invalid biometric data"));
        }

        Biometric biometric = biometricOpt.get();

        // Verify the fingerprint hash matches the stored value
        if (!biometric.getFingerprintHash().equals(request.getFingerprintHash())) {
            return ResponseEntity.status(401)
                    .body(Map.of("error", "Invalid biometric data"));
        }

        // If the biometric data is valid, retrieve the associated user
        User user = biometric.getUser();

        // Generate the JWT token using the user's username and roles
        List<String> roles = List.of(user.getRole());
        String token = jwtUtil.generateToken(user.getUsername(), roles);

        return ResponseEntity.ok(Map.of("token", token));
    }
}
