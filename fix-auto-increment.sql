-- MySQL Fix for User Table AUTO_INCREMENT

-- Connect to your database first:
-- mysql -u root -p

-- Then use this database:
USE print_on_one;

-- Fix 1: Add AUTO_INCREMENT if table is empty
ALTER TABLE user MODIFY id INT AUTO_INCREMENT PRIMARY KEY;

-- Fix 2: If that doesn't work, drop and recreate:
-- DROP TABLE user;
-- CREATE TABLE user (
--     id INT AUTO_INCREMENT PRIMARY KEY,
--     name VARCHAR(255) NOT NULL,
--     email VARCHAR(255) NOT NULL UNIQUE,
--     password VARCHAR(255),
--     city VARCHAR(255),
--     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--     updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
-- );

-- Verify the table structure:
DESCRIBE user;

-- Check if AUTO_INCREMENT is set:
SHOW CREATE TABLE user;

