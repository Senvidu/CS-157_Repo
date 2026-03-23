package com.example.hopebridge.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "supermarkets")
public class Supermarket {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String location;
    private Double profitShare;

    public Supermarket() {}
    public Supermarket(Long id, String name, String location, Double profitShare) {
        this.id = id; this.name = name; this.location = location; this.profitShare = profitShare;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
    public Double getProfitShare() { return profitShare; }
    public void setProfitShare(Double profitShare) { this.profitShare = profitShare; }
}
