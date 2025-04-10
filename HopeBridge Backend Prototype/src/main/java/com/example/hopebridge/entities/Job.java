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
    private Double salary;
    private String location;


    @ManyToOne
    @JoinColumn(name = "employer_id")  // the column in "job" table referencing "user.id"
    private User employer;
}