# Complete MySQL Fix for AUTO_INCREMENT Error

## The Problem
```
ERROR: Field 'id' doesn't have a default value
```

Your MySQL table doesn't have AUTO_INCREMENT properly configured.

## Complete Fix - Follow These Steps

### Step 1: Open MySQL Terminal
```bash
mysql -u root -p
```

Enter your MySQL password when prompted.

### Step 2: Run These Commands One by One

```sql
-- Use the database
USE print_on_one;

-- Check current table
DESCRIBE user;

-- Drop the old table
DROP TABLE IF EXISTS user;

-- Create fresh table with proper AUTO_INCREMENT
CREATE TABLE user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255),
    city VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY idx_user_email (email)
);

-- Verify table is created correctly
DESCRIBE user;

-- Exit MySQL
EXIT;
```

### Step 3: Expected Output

When you run `DESCRIBE user;`, you should see:

```
| Field      | Type             | Null | Key | Default           | Extra          |
|------------|------------------|------|-----|-------------------|----------------|
| id         | int              | NO   | PRI | NULL              | auto_increment |
| name       | varchar(255)     | NO   |     | NULL              |                |
| email      | varchar(255)     | NO   | UNI | NULL              |                |
| password   | varchar(255)     | YES  |     | NULL              |                |
| city       | varchar(255)     | YES  |     | NULL              |                |
| created_at | timestamp        | NO   |     | CURRENT_TIMESTAMP |                |
| updated_at | timestamp        | NO   |     | CURRENT_TIMESTAMP | on update      |
```

**The key thing**: `id` row should have `auto_increment` in the `Extra` column.

### Step 4: Restart Backend

Stop the backend (Ctrl+C in the terminal where it's running).

Then start it again:
```powershell
cd "C:\REST API\print-on-one-backend"
.\mvnw.cmd spring-boot:run
```

### Step 5: Test Signup

1. Open browser: `http://localhost:3000/signup`
2. Fill form:
   ```
   Name: John Doe
   Email: john@example.com
   City: New York
   Password: Test123
   ```
3. Click "Create Account"
4. Should see: ✅ "Account created successfully!"

---

## If Above Doesn't Work

Try this alternative approach - Delete ALL data and rebuild:

### Option A: Complete Fresh Setup

```sql
-- Connect to MySQL
mysql -u root -p

-- Drop entire database
DROP DATABASE IF EXISTS print_on_one;

-- Create fresh database
CREATE DATABASE print_on_one;

-- Use the database
USE print_on_one;

-- Create fresh table
CREATE TABLE user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255),
    city VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY idx_user_email (email)
);

-- Verify
DESCRIBE user;

-- Exit
EXIT;
```

Then update your `application.properties`:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/print_on_one
spring.datasource.username=root
spring.datasource.password=YOUR_PASSWORD
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=false
```

---

## Verify Everything

### Test 1: Check Table Exists
```sql
mysql -u root -p -e "USE print_on_one; DESCRIBE user;"
```

### Test 2: Test Insert
```sql
mysql -u root -p -e "USE print_on_one; INSERT INTO user (name, email, password, city) VALUES ('Test', 'test@example.com', 'pass', 'TestCity'); SELECT * FROM user;"
```

Should return a row with auto-generated ID.

### Test 3: Check AUTO_INCREMENT Status
```sql
mysql -u root -p -e "USE print_on_one; SHOW TABLE STATUS LIKE 'user';"
```

Look for `Auto_increment` value - should be > 0.

---

## What The Java Code Expects

Your `User.java` has:
```java
@Id
@GeneratedValue(strategy = GenerationType.IDENTITY)
private int id;
```

This means:
- `@Id` = Primary key
- `@GeneratedValue(strategy = GenerationType.IDENTITY)` = Let database auto-generate using AUTO_INCREMENT

So MySQL MUST have AUTO_INCREMENT for this to work.

---

## Quick Checklist

- [ ] MySQL table `user` exists in `print_on_one` database
- [ ] `id` column has `auto_increment` in Extra field
- [ ] `email` column has `UNIQUE` constraint
- [ ] `password` column is nullable (VARCHAR(255))
- [ ] `city` column is nullable (VARCHAR(255))
- [ ] Backend is running
- [ ] Frontend is running
- [ ] Test signup works

---

## If You Still Get the Error

Check these things:

1. **Wrong database**: Make sure you're using `print_on_one`, not `test` or other database
2. **Wrong table**: Table name must be exactly `user` (case-sensitive on Linux)
3. **Wrong user/password**: Verify MySQL credentials in `application.properties`
4. **Table not reloaded**: Restart backend after changing table

---

**Status**: Follow the steps above and your signup will work! ✅

