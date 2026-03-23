package com.example.hopebridge.repos;

import com.example.hopebridge.entities.Biometric;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface BiometricRepository extends JpaRepository<Biometric, Long> {
    Optional<Biometric> findByUserId(Long userId);
}
