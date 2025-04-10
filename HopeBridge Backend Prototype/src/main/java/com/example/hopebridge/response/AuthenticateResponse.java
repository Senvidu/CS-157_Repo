package com.example.hopebridge.response;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;

@JsonInclude(JsonInclude.Include.NON_NULL) // Only include non-null fields in JSON
public class AuthenticateResponse {

    @JsonProperty("token")
    private String token;

    // No-argument constructor (needed for JSON deserialization)
    public AuthenticateResponse() {
    }

    // Getter/Setter
    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    // Static method to get the builder instance
    public static Builder builder() {
        return new Builder();
    }

    // Inner static Builder class
    public static class Builder {
        private String token;

        public Builder() {
        }

        public Builder token(String token) {
            this.token = token;
            return this;
        }

        public AuthenticateResponse build() {
            var response = new AuthenticateResponse();
            response.setToken(this.token);
            return response;
        }
    }
}