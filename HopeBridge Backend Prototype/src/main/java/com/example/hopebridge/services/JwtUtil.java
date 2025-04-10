package com.example.hopebridge.services;

import io.jsonwebtoken.*;
import io.jsonwebtoken.security.Keys;
import org.springframework.stereotype.Service;
import java.security.Key;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class JwtUtil {
    private final String SECRET_KEY = "b5859b41871174583374007b09025acc71884e82dd7d899f88f38fa0ac14f76ef520a968e996c1a0feea556288cc1e5e485ec2c755de3b6e53a2c7ffcb3712e61bbe3c614a5171e27143bac1fb6aad630ffbc97db01960dfa9bc479ccab301b1d70b9645c8f2158c4fa7a8d9910a67ead875841d85a9974903d7f17357b3a17e840f5779765ac2b71891f59f4c593d40d786394f574e456e3a0fe306b547b7f2ec45c9f3699de143755e855bd57a0088958c1d109f993df7cb9050b85e6378d89f019785c461aba03e9713ba26f15bc9bbea09cec5a8b431894de15e6b067b7547d75384e188b486018137350ca626150d481dfd01a72315e48851c6a801f632";
    private final long EXPIRATION_TIME = 1000 * 60 * 60; // 1 hour

    private Key getSigningKey() {
        return Keys.hmacShaKeyFor(SECRET_KEY.getBytes());
    }

    //  Generate token with username and roles
    public String generateToken(String username, List<String> roles) {
        return Jwts.builder()
                .setSubject(username)
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis() + EXPIRATION_TIME))
                .addClaims(Map.of("roles", roles)) // Add roles as a claim
                .signWith(getSigningKey(), SignatureAlgorithm.HS256)
                .compact();
    }

    //  Extract username from token
    public String extractUsername(String token) {
        return Jwts.parserBuilder()
                .setSigningKey(getSigningKey())
                .build()
                .parseClaimsJws(token)
                .getBody()
                .getSubject();
    }

    //  Extract roles from token
    public List<String> extractRoles(String token) {
        Claims claims = Jwts.parserBuilder()
                .setSigningKey(getSigningKey())
                .build()
                .parseClaimsJws(token)
                .getBody();

        return (List<String>) claims.get("roles");
    }

    // Validate token
    public boolean validateToken(String token, String username) {
        return username.equals(extractUsername(token)) && !isTokenExpired(token);
    }

    //  Check if token is expired
    private boolean isTokenExpired(String token) {
        return Jwts.parserBuilder()
                .setSigningKey(getSigningKey())
                .build()
                .parseClaimsJws(token)
                .getBody()
                .getExpiration()
                .before(new Date());
    }
}