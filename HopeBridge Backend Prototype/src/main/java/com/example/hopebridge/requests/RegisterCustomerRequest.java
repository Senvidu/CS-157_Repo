package com.example.hopebridge.requests;

        import lombok.AllArgsConstructor;
        import lombok.Data;
        import lombok.NoArgsConstructor;

        @Data
        @NoArgsConstructor
        @AllArgsConstructor
        public class RegisterCustomerRequest {
            private String username;
            private String password;
            private String email;
            private String firstName;
            private String lastName;
            private String phone;
            private String role;
        }