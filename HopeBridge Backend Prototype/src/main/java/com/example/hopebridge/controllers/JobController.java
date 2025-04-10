package com.example.hopebridge.controllers;

import com.example.hopebridge.entities.Job;
import com.example.hopebridge.services.JobService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/jobs")
public class JobController {

    private final JobService jobService;

    public JobController(JobService jobService) {
        this.jobService = jobService;
    }

    /**
     * POST /api/jobs
     * Example JSON:
     * {
     *   "title": "Software Developer",
     *   "description": "Develop software applications",
     *   "location": "Colombo",
     *   "salary": 75000,
     *   "employer": {
     *     "id": 2
     *   }
     * }
     */
    @PostMapping
    public ResponseEntity<Job> postJob(@RequestBody Job job) {
        // This automatically binds the incoming JSON to a Job entity,
        // including employer.id = 2, which JPA will recognize as a reference
        // to an existing User with ID=2 (assuming one exists).
        Job savedJob = jobService.createJob(job);
        return ResponseEntity.ok(savedJob);
    }

    /**
     * GET /api/jobs
     * Returns a JSON array of all stored jobs.
     */
    @GetMapping
    public ResponseEntity<List<Job>> listJobs() {
        List<Job> jobs = jobService.getAllJobs();
        return ResponseEntity.ok(jobs);
    }
}