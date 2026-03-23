# Test Data Guide

## Creating a Test User

### Register a Donor
POST http://localhost:8080/auth/register
```json
{
  "firstName": "John",
  "lastName": "Doe",
  "phone": "0771234567",
  "email": "john@example.com",
  "username": "johndoe",
  "password": "password123",
  "role": "DONOR"
}
```

### Register a Recipient
POST http://localhost:8080/auth/register
```json
{
  "firstName": "Jane",
  "lastName": "Smith",
  "phone": "0779876543",
  "email": "jane@example.com",
  "username": "janesmith",
  "password": "password123",
  "role": "RECIPIENT"
}
```

### Login
POST http://localhost:8080/auth/login
```json
{
  "username": "johndoe",
  "password": "password123"
}
```

### Add a Product (requires token)
POST http://localhost:8080/api/shop/addProducts
```json
{
  "name": "Rice 1kg",
  "price": 100.00,
  "eligibleForVoucher": true
}
```

### Post a Job (requires token)
POST http://localhost:8080/api/jobs
```json
{
  "title": "Construction Worker",
  "description": "Build houses",
  "location": "Colombo",
  "salary": 45000
}
```
