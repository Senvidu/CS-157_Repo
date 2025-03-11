package com.example.hopebridge.repos;

import com.example.hopebridge.entities.Job;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

// Repository interface for handling database operations related to the Job
public interface JobRepository extends JpaRepository<Job, Long> {
 // Custom query method
    List<Job> findByEmployerId(Long employerId);
}
