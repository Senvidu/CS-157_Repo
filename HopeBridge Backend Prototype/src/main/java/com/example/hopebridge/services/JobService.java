package com.example.hopebridge.services;

import com.example.hopebridge.entities.Job;
import com.example.hopebridge.repos.JobRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class JobService {

    private final JobRepository jobRepository;

    public JobService(JobRepository jobRepository) {
        this.jobRepository = jobRepository;
    }

    /**
     * Saves a new Job or updates an existing one (if the ID is set).
     * Make sure the 'employer.id' is valid and exists in the DB.
     */
    public Job createJob(Job job) {
        return jobRepository.save(job);
    }

    /**
     * Retrieves all Job entities from the DB.
     */
    public List<Job> getAllJobs() {
        return jobRepository.findAll();
    }
}