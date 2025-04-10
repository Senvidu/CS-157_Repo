package com.example.hopebridge.requests;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AddJob {
    private String title;
    private String description;
    private Double salary;
    private String location;
    //private Long employerId;
}