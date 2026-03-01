# ✅ COMPLETE SOLUTION - AUTO_INCREMENT Error

## What's Wrong?

Your MySQL `user` table doesn't have AUTO_INCREMENT configured on the `id` field.

When the backend tries to create a new user, it expects the database to auto-generate an ID, but MySQL throws an error because the table isn't set up for that.

## The Solution (QUICK FIX)

### Open MySQL Terminal
```bash
mysql -u root -p
```

### Run This SQL (Copy & Paste ALL of it)
```sql
USE print_on_one;
DROP TABLE IF EXISTS user;
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
DESCRIBE user;
```

### Check Output
You should see the table with `id` column showing `auto_increment` in the `Extra` column.

### Exit MySQL
```sql
EXIT;
```

---

## Restart Backend

Stop the backend (Ctrl+C) and restart:
```powershell
cd "C:\REST API\print-on-one-backend"
.\mvnw.cmd spring-boot:run
```

Wait for:
```
Started PrintOnOneBackendApplication
```

---

## Test Now!

1. **Go to signup page**: `http://localhost:3000/signup`
2. **Fill form**:
   - Name: John Doe
   - Email: john@example.com
   - City: New York
   - Password: Test123
   - Confirm: Test123
   - ✓ Check Terms
3. **Click "Create Account"**

### Expected Result
✅ Success! "Account created successfully! Redirecting to login..."

---

## Why This Works

**Java Code:**
```java
@Id
@GeneratedValue(strategy = GenerationType.IDENTITY)
private int id;
```

This tells the database: "Auto-generate the ID using database identity/auto-increment"

**MySQL Configuration:**
```sql
id INT AUTO_INCREMENT PRIMARY KEY
```

This configures the database to auto-generate IDs (1, 2, 3, 4, ...)

**Result:** When you create a user, the database automatically assigns the next available ID. ✅

---

## Files to Reference

- **MYSQL_QUICK_FIX.txt** - Super quick 3-step guide
- **MYSQL_COMPLETE_FIX.md** - Detailed guide with verification steps
- **database-setup.sql** - Original setup script (for future reference)

---

## Summary

| Step | Action | Command |
|------|--------|---------|
| 1 | Open MySQL | `mysql -u root -p` |
| 2 | Fix Table | Run SQL above |
| 3 | Verify | `DESCRIBE user;` |
| 4 | Exit | `EXIT;` |
| 5 | Restart Backend | `.\mvnw.cmd spring-boot:run` |
| 6 | Test Signup | Go to signup page |

---

**Status**: 🟢 Ready to Fix

Follow the SQL commands above and your signup will work! 🎉

