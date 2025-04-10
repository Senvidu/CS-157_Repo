package com.example.hopebridge.repos;

import com.example.hopebridge.entities.Job;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface JobRepository extends JpaRepository<Job, Long> {
    // If you want to find jobs by a specific employer:
    List<Job> findByEmployerId(Long employerId);
}