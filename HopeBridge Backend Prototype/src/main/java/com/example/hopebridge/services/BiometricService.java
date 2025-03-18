package com.example.hopebridge.services;

import com.example.hopebridge.entities.Biometric;
import com.example.hopebridge.entities.User;
import com.example.hopebridge.repos.BiometricRepository;
import com.example.hopebridge.repos.UserRepository;
import com.example.hopebridge.requests.BiometricRegisterRequest;
import org.springframework.stereotype.Service;
import java.util.Optional;

@Service
public class BiometricService {

    private final BiometricRepository biometricRepository;
    private final UserRepository userRepository;

    public BiometricService(BiometricRepository biometricRepository, UserRepository userRepository) {
        this.biometricRepository = biometricRepository;
        this.userRepository = userRepository;
    }

    public String registerBiometric(BiometricRegisterRequest request) {
        Optional<User> user = userRepository.findById(Long.valueOf(request.getUserId()));
        if (user.isPresent()) {
            Biometric biometric = new Biometric();
            biometric.setUser(user.get());
            biometric.setFingerprintHash(request.getFingerprintHash());
            biometricRepository.save(biometric);
            return "Biometric data registered successfully!";
        }
        return "User not found!";
    }

    public boolean verifyBiometric(Long userId, String fingerprintHash) {
        Optional<Biometric> biometric = biometricRepository.findByUserId(userId);
        return biometric.isPresent() && biometric.get().getFingerprintHash().equals(fingerprintHash);
    }
}
