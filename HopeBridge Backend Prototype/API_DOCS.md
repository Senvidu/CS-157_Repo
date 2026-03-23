# HopeBridge API Documentation

## Base URL
http://localhost:8080

## Authentication
All endpoints except /auth/login and /auth/register require a Bearer token.

Add this header to all protected requests:
Authorization: Bearer <your_jwt_token>

## Endpoints

### Auth
| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | /auth/register | Register new user |
| POST | /auth/login | Login and get JWT token |

### Jobs
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | /api/jobs | Get all jobs |
| POST | /api/jobs | Post a new job |

### Shop
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | /api/shop/products | Get all products |
| GET | /api/shop/products/eligible | Get voucher eligible products |
| POST | /api/shop/addProducts | Add a new product |
| POST | /api/shop/order | Place an order |
| GET | /api/shop/orders/{userId} | Get orders by user |

### Donations
| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | /api/donations/oneTime | Make a one-time donation |
| POST | /api/donations/subscription | Make a subscription donation |

### Vouchers
| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | /api/vouchers/create | Create a voucher |

### Biometrics
| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | /api/biometrics/register | Register biometric |
| POST | /api/biometrics/verify | Verify biometric |
