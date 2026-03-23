# Security Implementation

## JWT Authentication
- Tokens are generated on login
- Tokens expire after set duration
- All API routes protected except /auth/*

## Password Security
- Passwords hashed using BCrypt
- Never stored in plain text

## CORS Configuration
- Configured to allow Flutter frontend
- All origins allowed in development

## Spring Security
- Stateless session management
- JWT filter on every request
- Role-based access control

## User Roles
- DONOR - Can create fundraisers and donate
- RECIPIENT - Can access shop and job finder
- ADMIN - Full system access
