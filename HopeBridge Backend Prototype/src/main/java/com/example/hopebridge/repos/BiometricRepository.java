package com.example.hopebridge.repos;

import com.example.hopebridge.entities.Biometric;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

// Repository interface for Biometric entity, allowing database operations
public interface BiometricRepository extends JpaRepository<Biometric, Long> {
// Custom query method to find a biometric record by user Identity
    Optional<Biometric> findByUserId(Long userId);
}
