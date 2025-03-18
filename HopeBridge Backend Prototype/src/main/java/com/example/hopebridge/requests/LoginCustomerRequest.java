package com.example.hopebridge.requests;

import lombok.*;


@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class LoginCustomerRequest {
    private String username;
    private String password;
}
