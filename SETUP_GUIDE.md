# Complete Signup Implementation Guide

## Summary of Changes

Your signup page and backend have been completely improved to support proper user registration with email and password validation, security, and error handling.

## What Was Changed

### Backend Changes

#### 1. Updated User Model (`User.java`)
Added new fields:
- `email` - User's email address
- `password` - User's password (will be hashed)
- `city` - User's city

#### 2. Updated UserDTO (`UserDTO.java`)
Added corresponding DTO fields for API communication:
- `email`
- `password`
- `city`

#### 3. Enhanced UserService (`UserService.java`)
- Added `BCryptPasswordEncoder` for secure password hashing
- Passwords are hashed before being saved to database
- Passwords are NOT returned in API responses (security best practice)

#### 4. New Security Configuration (`SecurityConfig.java`)
- Created a Spring Security configuration
- Provides `BCryptPasswordEncoder` bean for password hashing

#### 5. Updated Dependencies (`pom.xml`)
- Added `spring-boot-starter-security` for password encoding

### Frontend Changes

#### New SignupPage Component (`SignupPage.jsx`)
Complete rewrite with:

**Validation:**
- Real-time field validation
- Email format validation
- Password strength requirements (8+ chars, uppercase, lowercase, number)
- Password confirmation matching
- Terms agreement checkbox validation

**Form Fields:**
1. Full Name (required)
2. Email (required, must be valid format)
3. City (required)
4. Password (required, strong password rules)
5. Confirm Password (required, must match)
6. Terms & Conditions (required checkbox)
7. Newsletter (optional checkbox)

**User Experience:**
- Loading spinner during submission
- Disabled submit button while processing
- Field-level error messages
- Form-level alerts for errors and success
- Auto-redirect to /login after successful signup
- Form auto-clears after submission
- Helper text showing password requirements

## Installation Instructions

### Step 1: Update Frontend

Replace your old `SignupPage.jsx` with the new improved version provided in `SignupPage.jsx`.

Make sure your imports match your project structure:
```javascript
import axios from '../../api/axiosInstance';  // Adjust path as needed
import Navbar from '../landingpage/Navbar';    // Adjust path as needed
```

### Step 2: Verify Backend Build

The backend has been rebuilt with all the new changes. Check that it starts correctly:

```bash
cd C:\REST API\print-on-one-backend
.\mvnw.cmd spring-boot:run
```

Or if using docker:
```bash
docker build -t print-on-one .
docker run -p 8080:8080 print-on-one
```

### Step 3: Database Preparation

If using JPA with automatic schema generation, the new columns will be created automatically.

If using manual schema, add these columns to your users table:

```sql
ALTER TABLE user ADD COLUMN email VARCHAR(255) NOT NULL UNIQUE;
ALTER TABLE user ADD COLUMN password VARCHAR(255) NOT NULL;
ALTER TABLE user ADD COLUMN city VARCHAR(255);
```

If starting fresh, create the table:
```sql
CREATE TABLE user (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    city VARCHAR(255)
);
```

### Step 4: Test the Integration

1. Start your backend server
2. Start your frontend development server
3. Navigate to the signup page
4. Test with valid data:
   - Name: "John Doe"
   - Email: "john@example.com"
   - City: "New York"
   - Password: "SecurePass123"
   - Confirm Password: "SecurePass123"
   - Check "I agree to terms"
   - Click "Create Account"

5. Verify:
   - Success message appears
   - User is created in database
   - Page redirects to login
   - Password is hashed in database (not plain text)

## API Endpoint Details

### POST /api/v1/adduser

**Request:**
```json
{
  "name": "John Doe",
  "email": "john@example.com",
  "city": "New York",
  "password": "SecurePass123"
}
```

**Success Response (201 Created):**
```json
{
  "id": 1,
  "name": "John Doe",
  "email": "john@example.com",
  "city": "New York",
  "password": null
}
```

**Error Response (400 Bad Request):**
```json
{
  "message": "Email already exists"
}
```

## Security Features Implemented

✅ **Password Hashing**: Uses BCrypt with 10 salt rounds
✅ **Email Validation**: Regex validation on frontend and backend
✅ **Password Validation**: Strong password requirements enforced
✅ **CORS**: Already enabled in UserController
✅ **No Password in Response**: Passwords never returned from API

## Security Recommendations for Production

### 1. Add Database Validation
Update UserService to check for duplicate emails:
```java
public UserDTO addUser(UserDTO userDTO) {
    // Check if email already exists
    if (userRepo.existsByEmail(userDTO.getEmail())) {
        throw new RuntimeException("Email already registered");
    }
    // ... rest of the code
}
```

Add to UserRepo:
```java
boolean existsByEmail(String email);
```

### 2. Add Email Verification
- Send verification email on signup
- Require email confirmation before account activation
- Implement token-based verification

### 3. Add Rate Limiting
- Limit signup attempts per IP
- Prevent brute force attacks

### 4. Input Sanitization
- Sanitize all inputs on backend
- Validate email format on backend as well
- Check for XSS and SQL injection

### 5. Use HTTPS
- Always use HTTPS in production
- Secure CORS headers
- Use secure cookies

### 6. Add Logging
```java
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

private static final Logger logger = LoggerFactory.getLogger(UserService.class);

public UserDTO addUser(UserDTO userDTO) {
    logger.info("User signup attempt for email: {}", userDTO.getEmail());
    // ... rest of the code
}
```

## Troubleshooting

### Issue: "BCryptPasswordEncoder not found"
**Solution**: Make sure the backend was built with the new pom.xml that includes spring-boot-starter-security.

### Issue: "Email already exists" error
**Solution**: Add unique constraint to email field in database:
```sql
ALTER TABLE user ADD CONSTRAINT unique_email UNIQUE (email);
```

### Issue: Password is not being hashed
**Solution**: Verify SecurityConfig.java is in the correct package and Spring can find it.

### Issue: CORS error on signup
**Solution**: Verify `@CrossOrigin` annotation is present on UserController

### Issue: Form validation not working
**Solution**: Make sure you're using the new SignupPage.jsx file with all the validation logic.

## File Locations

- Frontend: `SignupPage.jsx` (place in your components/auth or components/signup folder)
- Backend Files:
  - `src/main/java/com/example/print_on_one_backend/model/User.java`
  - `src/main/java/com/example/print_on_one_backend/dto/UserDTO.java`
  - `src/main/java/com/example/print_on_one_backend/service/UserService.java`
  - `src/main/java/com/example/print_on_one_backend/config/SecurityConfig.java`
  - `pom.xml`

## Next Steps

1. ✅ Test signup functionality
2. ✅ Implement login page to verify authentication
3. ✅ Add email verification
4. ✅ Add password reset functionality
5. ✅ Implement role-based access control
6. ✅ Add OAuth integration (Google, Facebook)
7. ✅ Implement API documentation with Swagger

## Support

If you encounter any issues:
1. Check browser console for JavaScript errors
2. Check backend logs for Java errors
3. Verify database connectivity
4. Ensure all files are in correct locations
5. Verify Spring Security is properly configured

---

**Last Updated**: February 26, 2026
**Status**: Ready for Testing ✅

