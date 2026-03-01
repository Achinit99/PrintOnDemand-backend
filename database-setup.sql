-- SQL Script for User Table with New Fields
-- This script updates the existing user table or creates a new one with all required fields

-- Option 1: If you already have a user table and want to add new columns
-- Uncomment this section if the table already exists

/*
ALTER TABLE user ADD COLUMN email VARCHAR(255) NOT NULL UNIQUE;
ALTER TABLE user ADD COLUMN password VARCHAR(255) NOT NULL;
ALTER TABLE user ADD COLUMN city VARCHAR(255);

-- Add index on email for faster lookups
CREATE INDEX idx_user_email ON user(email);
*/

-- Option 2: Create a fresh user table (recommended for new projects)
-- Uncomment this section if starting fresh

/*
CREATE TABLE user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    city VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY idx_user_email (email)
);
*/

-- Option 3: Create table if it doesn't exist (safest approach)

CREATE TABLE IF NOT EXISTS user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    city VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY idx_user_email (email)
);

-- Sample test data (optional)
-- This is just for testing, remove before production

-- INSERT INTO user (name, email, password, city) VALUES
-- ('Test User', 'test@example.com', '$2a$10$...hashed_password...', 'Test City');

-- Note: Passwords should be hashed using BCrypt
-- Never store plain text passwords!
-- The password column should store the output of BCryptPasswordEncoder.encode()

-- Example password hash for "SecurePass123":
-- $2a$10$SlVXVXNlckhhc2hlZFBhc3N3b3JkSGFzaGVkUGFzc3dvcmQ=

-- For testing, you can use this query to see all users:
-- SELECT id, name, email, city, created_at FROM user;

-- To verify a user's password matches, Spring Security compares using:
-- BCryptPasswordEncoder.matches(plainPassword, hashedPassword)

-- Migration notes:
-- 1. If you have existing users without email/password, you'll need to handle them:
--    a) Delete them: DELETE FROM user WHERE email IS NULL;
--    b) Or set default values: UPDATE user SET email = CONCAT('user', id, '@example.com'), password = 'temp_hash';
--
-- 2. After migration, test with:
--    SELECT COUNT(*) FROM user;
--    SELECT * FROM user LIMIT 1;
--
-- 3. Verify the email index is working:
--    SHOW INDEX FROM user;

-- For H2 Database (Development):
-- Use this if you're using H2 for development instead of MySQL

/*
CREATE TABLE IF NOT EXISTS USER (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    NAME VARCHAR(255) NOT NULL,
    EMAIL VARCHAR(255) NOT NULL UNIQUE,
    PASSWORD VARCHAR(255) NOT NULL,
    CITY VARCHAR(255),
    CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UPDATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    KEY IDX_USER_EMAIL (EMAIL)
);
*/

-- For PostgreSQL:
/*
CREATE TABLE IF NOT EXISTS "user" (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    city VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT unique_email UNIQUE (email)
);

CREATE INDEX idx_user_email ON "user"(email);
*/

