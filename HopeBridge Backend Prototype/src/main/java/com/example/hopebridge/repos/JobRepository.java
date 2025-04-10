package com.example.hopebridge.repos;

import com.example.hopebridge.entities.Job;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface JobRepository extends JpaRepository<Job, Long> {
    // Find all jobs for a given employer
    List<Job> findByEmployerId(Long employerId);
}