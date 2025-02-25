package com.example.hopebridge.controllers;

import com.example.hopebridge.entities.Donation;
import com.example.hopebridge.services.DonationService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/donations")
public class DonationController {

    private final DonationService donationService;

    public DonationController(DonationService donationService) {
        this.donationService = donationService;
    }

    @PostMapping
    public ResponseEntity<Donation> donate(@RequestBody Donation donation)
    {
        return ResponseEntity.ok(donationService.makeDonation(donation));
    }

    @GetMapping
    public ResponseEntity<List<Donation>> listDonations() {
        return ResponseEntity.ok(donationService.getAllDonations());
    }
}
