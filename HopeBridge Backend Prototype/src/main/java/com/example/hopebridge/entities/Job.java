package com.example.hopebridge.entities;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
//job class to add a job to the employment portal
public class Job {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;
    private String description;
    private String location;
    private Double salary;

    @ManyToOne
    @JoinColumn(name = "posted_by")
    private User employer;
}

