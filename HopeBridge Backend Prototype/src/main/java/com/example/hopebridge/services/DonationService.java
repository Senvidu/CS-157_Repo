package com.example.hopebridge.services;

import com.example.hopebridge.entities.Donation;
import com.example.hopebridge.repos.DonationRepository;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class DonationService {

    private final DonationRepository donationRepository;

    public DonationService(DonationRepository donationRepository) {
        this.donationRepository = donationRepository;
    }

    public Donation makeDonation(Donation donation) {
        return donationRepository.save(donation);
    }

    public List<Donation> getAllDonations() {
        return donationRepository.findAll();
    }
}
