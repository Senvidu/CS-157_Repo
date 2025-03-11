package com.example.hopebridge.repos;

import com.example.hopebridge.entities.Donation;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

// Repository interface for handling database operations related to the Donation entity
public interface DonationRepository extends JpaRepository<Donation, Long> {
// Custom query method to retrieve a list of donations made by a specific donor
    List<Donation> findByDonorId(Long donorId);
}
