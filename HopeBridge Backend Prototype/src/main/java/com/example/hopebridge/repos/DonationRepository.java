package com.example.hopebridge.repos;

import com.example.hopebridge.entities.Donation;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface DonationRepository extends JpaRepository<Donation, Long> {
    List<Donation> findByDonorId(Long donorId);
}
