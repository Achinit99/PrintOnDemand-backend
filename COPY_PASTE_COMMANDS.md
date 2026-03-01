# Copy-Paste Commands to Run Everything

## 🚀 FASTEST WAY TO START

Just copy and paste these exact commands!

---

## Step 1: First Time Only - Build Backend

**Copy this entire block and paste in PowerShell:**

```powershell
cd "C:\REST API\print-on-one-backend"
.\mvnw.cmd clean install -DskipTests
```

**Wait for:**
```
[INFO] BUILD SUCCESS
```

---

## Step 2: First Time Only - Install Frontend

**Open new PowerShell and copy this:**

```powershell
cd your-frontend-folder
npm install
```

**Wait for it to finish without errors**

---

## Step 3: Run Backend (Every Time)

**Copy and paste in PowerShell Terminal 1:**

```powershell
cd "C:\REST API\print-on-one-backend"
.\mvnw.cmd spring-boot:run
```

**Wait for:**
```
Started PrintOnOneBackendApplication
```

---

## Step 4: Run Frontend (Every Time)

**Open new PowerShell Terminal 2 and copy this:**

```powershell
cd your-frontend-folder
npm start
```

**Browser will open automatically to http://localhost:3000**

---

## Step 5: Test Signup

Go to: `http://localhost:3000/signup`

Fill with:
- Name: `John Doe`
- Email: `john@example.com`
- City: `New York`
- Password: `SecurePass123`
- Confirm: `SecurePass123`
- ✓ Check Terms

Click "Create Account"

**Expected:** ✅ "Account created successfully! Redirecting to login..."

---

## One-Time Setup Commands Only

If you want to run in one go (first time):

```powershell
# 1. Build backend
cd "C:\REST API\print-on-one-backend"
.\mvnw.cmd clean install -DskipTests

# Wait for BUILD SUCCESS, then...

# 2. Install frontend
cd your-frontend-folder
npm install

# Done with setup!
```

---

## Daily Running Commands

```powershell
# Terminal 1 - Backend
cd "C:\REST API\print-on-one-backend"
.\mvnw.cmd spring-boot:run

# Terminal 2 - Frontend (new terminal)
cd your-frontend-folder
npm start
```

---

## Verify Everything Works

### Test 1: Backend Running
```powershell
curl http://localhost:8080/api/v1/getusers
```

Should show: `[]`

### Test 2: Frontend Running
Open browser: `http://localhost:3000`
Should load without errors

### Test 3: Full Signup
1. Go to: http://localhost:3000/signup
2. Fill form
3. Click Create Account
4. See success message

---

## Troubleshooting Commands

### If Backend Won't Start
```powershell
# Clean rebuild
cd "C:\REST API\print-on-one-backend"
.\mvnw.cmd clean install -DskipTests
.\mvnw.cmd spring-boot:run
```

### If Frontend Won't Start
```powershell
cd your-frontend-folder
rm -r node_modules
npm install
npm start
```

### Port Already in Use
```powershell
# Find what's using port 8080
netstat -ano | findstr :8080

# Kill it (replace XXXX with PID)
taskkill /PID XXXX /F
```

### Reset H2 Database
Just restart the backend. H2 is in-memory, so it resets automatically.

### Reset MySQL Database
```sql
DELETE FROM user;
ALTER TABLE user AUTO_INCREMENT = 1;
```

---

## File Paths Reference

**Replace `your-frontend-folder` with actual path like:**
- `C:\Projects\my-frontend`
- `C:\Users\YourName\Desktop\frontend`
- `C:\frontend`

---

## Success Indicators

✅ Backend started:
```
Started PrintOnOneBackendApplication in X.XXX seconds
Tomcat started on port(s): 8080
```

✅ Frontend started:
```
Compiled successfully!
You can now view your-app in the browser.
```

✅ Signup worked:
```
POST /api/v1/adduser 201 Created
Account created successfully!
Redirecting...
```

---

## Summary

1. **First Time**: Run build and install commands
2. **Every Time**: Run backend then frontend
3. **Test**: Go to http://localhost:3000/signup
4. **Done**: Fill form and create account

---

**That's it! 🎉**

If something doesn't work, check the logs or refer to `HOW_TO_RUN.md` for detailed troubleshooting.

