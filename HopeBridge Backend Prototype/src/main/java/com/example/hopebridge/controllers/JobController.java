package com.example.hopebridge.controllers;

import com.example.hopebridge.entities.Job;
import com.example.hopebridge.entities.User;
import com.example.hopebridge.repos.UserRepository;
import com.example.hopebridge.requests.AddJob;
import com.example.hopebridge.services.JobService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/jobs")
public class JobController {

    private final JobService jobService;
    private final UserRepository userRepository;

    public JobController(JobService jobService, UserRepository userRepository) {
        this.jobService = jobService;
        this.userRepository = userRepository;
    }

    @PostMapping("/add-job")
    public ResponseEntity<?> postJob(@RequestBody AddJob addJobRequest, @AuthenticationPrincipal User user) {
        // 1. Find the employer by employerId
        try
        {
            System.out.println(user.getId()+" / "+user.getUsername());
            User employer = userRepository.findById(user.getId())
                    .orElseThrow(() -> new RuntimeException("Employer not found"));

            // 2. Construct the Job entity from the request
            Job job = new Job();
            job.setTitle(addJobRequest.getTitle());
            job.setDescription(addJobRequest.getDescription());
            job.setSalary(addJobRequest.getSalary());
            job.setLocation(addJobRequest.getLocation());
            job.setEmployer(employer);

            // 3. Save the Job
            Job savedJob = jobService.createJob(job);

            // 4. Return the saved Job
            return ResponseEntity.ok(savedJob);

        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }

    }

    @GetMapping("/list-jobs")
    public ResponseEntity<List<Job>> listJobs() {
        return ResponseEntity.ok(jobService.getAllJobs());
    }
}