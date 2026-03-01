# ✅ FIX: Field 'id' doesn't have a default value

## The Error
```
ERROR: Field 'id' doesn't have a default value
Hibernate: insert into user (city,email,name,password) values (?,?,?,?)
```

## Root Cause
Your MySQL `user` table doesn't have `AUTO_INCREMENT` on the `id` field. When you try to create a new user without providing an ID, MySQL throws an error.

---

## Solution

### Quick Fix (Copy & Paste in MySQL)

**Option 1: Fix existing table**

```sql
USE print_on_one;
ALTER TABLE user MODIFY id INT AUTO_INCREMENT PRIMARY KEY;
```

**Option 2: Drop and recreate table (if Option 1 doesn't work)**

```sql
USE print_on_one;
DROP TABLE user;

CREATE TABLE user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255),
    city VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

---

## Step-by-Step Fix

### Step 1: Open MySQL Command Line
```bash
mysql -u root -p
```

Enter your MySQL password when prompted.

### Step 2: Run the Fix
```sql
USE print_on_one;
ALTER TABLE user MODIFY id INT AUTO_INCREMENT PRIMARY KEY;
```

### Step 3: Verify the Fix
```sql
DESCRIBE user;
```

You should see:
```
| Field | Type | Null | Key | Default | Extra |
|-------|------|------|-----|---------|-------|
| id    | int  | NO   | PRI | NULL    | auto_increment |
```

The `Extra` column should show `auto_increment`

### Step 4: Restart Backend
Kill the backend process and restart:
```powershell
cd "C:\REST API\print-on-one-backend"
.\mvnw.cmd spring-boot:run
```

### Step 5: Test Signup Again
1. Go to: `http://localhost:3000/signup`
2. Fill form with test data
3. Click "Create Account"
4. ✅ Should work now!

---

## Why This Happened

Your User model has:
```java
@Id
@GeneratedValue(strategy = GenerationType.IDENTITY)
private int id;
```

This tells Hibernate to auto-generate the ID using database AUTO_INCREMENT. But your MySQL table wasn't configured with AUTO_INCREMENT, causing the error.

---

## Verification

### Check Table Structure
```sql
SHOW CREATE TABLE user;
```

Should show:
```sql
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255),
  `city` varchar(255),
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
)
```

### Test Insert
```sql
INSERT INTO user (name, email, password, city) VALUES ('Test', 'test@example.com', 'pass', 'city');
SELECT * FROM user;
```

Should work and show auto-generated ID (1, 2, 3, etc.)

---

## Complete MySQL Commands

If you want to delete everything and start fresh:

```sql
-- Connect to MySQL
mysql -u root -p

-- Use the database
USE print_on_one;

-- Drop existing table
DROP TABLE IF EXISTS user;

-- Create fresh table
CREATE TABLE user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255),
    city VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_email (email)
);

-- Verify
DESCRIBE user;
SHOW CREATE TABLE user;

-- Exit
EXIT;
```

---

## After Fix - What Happens

1. **User submits signup form**
2. **Backend receives data**: name, email, password, city
3. **Database generates ID automatically**: 1, 2, 3, etc.
4. **User created successfully** ✅
5. **Response returned to frontend**
6. **Redirect to login** ✅

---

## Status

✅ **Before**: Error - "Field 'id' doesn't have a default value"
✅ **After**: Success - User created with auto-generated ID

---

**Solution**: Run the ALTER TABLE command in MySQL, then restart the backend and test again!

