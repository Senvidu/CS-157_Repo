package com.example.hopebridge.controllers;

import com.example.hopebridge.entities.Donation;
import com.example.hopebridge.entities.SubsDonation;
import com.example.hopebridge.entities.User;
import com.example.hopebridge.requests.DonationReq;
import com.example.hopebridge.services.DonationService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/donations")
public class DonationController
{
    @GetMapping("/check")
    public String check()
    {
        return "Donation Controller is working";
    }

    @GetMapping("/donations-list")
    public ResponseEntity<List<Donation>> getDonationsList() {
        List<Donation> donations = donationService.getAllDonations();
        return ResponseEntity.ok(donations);
    }

    private final DonationService donationService;

    public DonationController(DonationService donationService) {
        this.donationService = donationService;
    }

    @PostMapping("/oneTime")
    public ResponseEntity<Donation> oneTimeDonation
            (   @RequestBody DonationReq donation,
                @AuthenticationPrincipal User user
            )
    {
       // donation.setUserName(user.getUsername());
        return ResponseEntity.ok(donationService.makeDonation(donation, user));
    }

    @PostMapping("/subscription")
    public ResponseEntity<SubsDonation> subscription
            (@RequestBody SubsDonation donation,
             @AuthenticationPrincipal User user
            )
    {

        return ResponseEntity.ok(donationService.makeSubscription(donation, user));
    }
}
