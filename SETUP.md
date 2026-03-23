# HopeBridge Setup Guide

## Prerequisites
- Java 17+
- Flutter 3.41.5+
- PostgreSQL 17
- Maven 3.6+

## Backend Setup
1. Navigate to backend folder
2. Configure application.properties
3. Run: mvn spring-boot:run
4. Backend runs on http://localhost:8080

## Frontend Setup
1. Navigate to frontend folder
2. Run: flutter pub get
3. Run: flutter run
4. Choose Chrome or Windows

## Environment
Make sure backend is running before starting frontend.
The frontend connects to http://localhost:8080

## Default Ports
- Backend: 8080
- PostgreSQL: 5432
- Flutter Web: 2182
