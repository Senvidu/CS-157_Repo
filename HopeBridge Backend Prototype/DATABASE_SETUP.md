# Database Setup Guide

## Prerequisites
- PostgreSQL 17 installed
- pgAdmin 4 (optional)

## Steps

### 1. Start PostgreSQL
Open Command Prompt as Administrator:
```
net start postgresql-x64-17
```

### 2. Create Database
Connect to PostgreSQL:
```
"C:\Program Files\PostgreSQL\17\bin\psql.exe" -U postgres -p 5432
```

Run this command:
```sql
CREATE DATABASE hopebridge;
```

### 3. Configure application.properties
```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/hopebridge
spring.datasource.username=postgres
spring.datasource.password=your_password
spring.jpa.hibernate.ddl-auto=update
```

### 4. Tables
Tables are auto-created by Hibernate on first run:
- users
- jobs
- products
- orders
- donations
- subscription_donations
- vouchers
- transactions
- supermarkets
