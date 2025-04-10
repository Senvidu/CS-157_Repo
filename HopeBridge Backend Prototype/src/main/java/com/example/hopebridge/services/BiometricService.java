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

    /**
     * Registers biometric data.
     * If biometric data for the given user already exists, it updates the fingerprint hash.
     * Otherwise, it creates a new biometric record.
     */
    public String registerBiometric(BiometricRegisterRequest request) {
        Optional<User> userOpt = userRepository.findById(Long.valueOf(request.getUserId()));
        if (userOpt.isPresent()) {
            Optional<Biometric> existingBiometric = biometricRepository.findByUserId(Long.valueOf(request.getUserId()));
            Biometric biometric;
            if (existingBiometric.isPresent()) {
                biometric = existingBiometric.get();
                biometric.setFingerprintHash(request.getFingerprintHash());
                biometricRepository.save(biometric);
                return "Biometric data updated successfully!";
            } else {
                biometric = new Biometric();
                biometric.setUser(userOpt.get());
                biometric.setFingerprintHash(request.getFingerprintHash());
                biometricRepository.save(biometric);
                return "Biometric data registered successfully!";
            }
        }
        return "User not found!";
    }

    /**
     * Verifies biometric data by comparing the stored fingerprint hash with the one provided in the request.
     * Returns an Optional containing the Biometric record if verification passes,
     * or an empty Optional if the data is invalid.
     */
    public Optional<Biometric> verifyBiometric(BiometricRegisterRequest request) {
        Optional<Biometric> biometricOpt = biometricRepository.findByUserId(Long.valueOf(request.getUserId()));
        if (biometricOpt.isPresent()
                && biometricOpt.get().getFingerprintHash().equals(request.getFingerprintHash())) {
            return biometricOpt;
        }
        return Optional.empty();
    }

    /**
     * Updates biometric data for an existing user.
     * This method explicitly updates the fingerprint hash if a biometric record exists.
     */
    public String updateBiometric(BiometricRegisterRequest request) {
        Optional<Biometric> biometricOpt = biometricRepository.findByUserId(Long.valueOf(request.getUserId()));
        if (biometricOpt.isPresent()) {
            Biometric biometric = biometricOpt.get();
            biometric.setFingerprintHash(request.getFingerprintHash());
            biometricRepository.save(biometric);
            return "Biometric data updated successfully!";
        }
        return "Biometric data not found!";
    }

    /**
     * Deletes the biometric record for the given user.
     */
    public String deleteBiometric(BiometricRegisterRequest request) {
        Optional<Biometric> biometricOpt = biometricRepository.findByUserId(Long.valueOf(request.getUserId()));
        if (biometricOpt.isPresent()) {
            biometricRepository.delete(biometricOpt.get());
            return "Biometric data deleted successfully!";
        }
        return "Biometric data not found!";
    }
}