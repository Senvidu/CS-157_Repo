package com.example.hopebridge.services;
import com.example.hopebridge.entities.User;
import com.example.hopebridge.repos.UserRepository;
import com.example.hopebridge.requests.RegisterCustomerRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserService {
    @Autowired
    private UserRepository userRepository;

    private final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    public User registerUser(RegisterCustomerRequest user) {
        user.setPassword(new BCryptPasswordEncoder().encode(user.getPassword()));
        User user1 = User.builder()
                .firstName(user.getFirstName())
                .lastName(user.getLastName())
                .email(user.getEmail())
                .phone(user.getPhone())
                .role(user.getRole())
                .username(user.getUsername())
                .password(passwordEncoder.encode(user.getPassword()))
                .build();
        return userRepository.save(user1);
    }
}

