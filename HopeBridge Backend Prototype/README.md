# HopeBridge Backend

A Spring Boot REST API for the HopeBridge platform.

## Tech Stack
- Java 17
- Spring Boot 3.4.2
- PostgreSQL
- JWT Authentication
- Spring Security

## How to Run
1. Make sure PostgreSQL is running on port 5432
2. Create a database called `hopebridge`
3. Run: `mvn spring-boot:run`

## API Endpoints
- POST /auth/register
- POST /auth/login
- GET  /api/jobs
- POST /api/jobs
- GET  /api/shop/products
- POST /api/donations/oneTime
- POST /api/donations/subscription
