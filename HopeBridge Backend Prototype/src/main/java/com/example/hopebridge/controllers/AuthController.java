package com.example.hopebridge.controllers;

import com.example.hopebridge.entities.User;
import com.example.hopebridge.repos.UserRepository;
import com.example.hopebridge.requests.LoginCustomerRequest;
import com.example.hopebridge.requests.RegisterCustomerRequest;
import com.example.hopebridge.services.JwtUtil;
import com.example.hopebridge.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/auth")
public class AuthController {
    private final UserRepository userRepository;
    private final JwtUtil jwtUtil;
    private final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    @Autowired
    private UserService userService;

    public AuthController(UserRepository userRepository, JwtUtil jwtUtil) {
        this.userRepository = userRepository;
        this.jwtUtil = jwtUtil;
    }

    @PostMapping("/register")
    public ResponseEntity<?> registerUser(@RequestBody RegisterCustomerRequest user) {
        userService.registerUser(user);
        return ResponseEntity.ok(Map.of("message", "User registered successfully"));
    }

    @PostMapping("/login")
    public ResponseEntity<?> loginUser(@RequestBody LoginCustomerRequest loginRequest) {
        Optional<User> userOpt = userRepository.findByUsername(loginRequest.getUsername());

        // Check if user exists
        if (userOpt.isEmpty()) {
            return ResponseEntity.status(401).body(Map.of("error", "Invalid credentials"));
        }

        User user = userOpt.get();

        // Verify password
        if (!passwordEncoder.matches(loginRequest.getPassword(), user.getPassword())) {
            return ResponseEntity.status(401).body(Map.of("error", "Invalid password"));
        }

        // Generate JWT token
        List<String> roles = List.of(user.getRole()); // Convert single role to list
        System.out.println("User: " + user.getUsername() + " logged in with roles: " + roles);
        String token = jwtUtil.generateToken(user.getUsername(), roles);

        return ResponseEntity.ok(Map.of("token", token));
    }
}