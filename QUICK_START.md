# ⚡ Quick Reference - How to Run

## 30 Second Start

```powershell
# Terminal 1 - Backend
cd "C:\REST API\print-on-one-backend"
.\mvnw.cmd spring-boot:run

# Terminal 2 - Frontend  
cd your-frontend-folder
npm start

# Browser
http://localhost:3000/signup
```

---

## Command Cheat Sheet

### First Time Setup
```powershell
# Backend - Build once
cd "C:\REST API\print-on-one-backend"
.\mvnw.cmd clean install -DskipTests

# Frontend - Install once
cd your-frontend-folder
npm install
```

### Every Time You Run
```powershell
# Backend (Terminal 1)
cd "C:\REST API\print-on-one-backend"
.\mvnw.cmd spring-boot:run

# Frontend (Terminal 2)
cd your-frontend-folder
npm start
```

---

## URLs

| Service | URL |
|---------|-----|
| Frontend | http://localhost:3000 |
| Signup Page | http://localhost:3000/signup |
| Backend API | http://localhost:8080 |
| API Endpoint | http://localhost:8080/api/v1/adduser |
| H2 Console | http://localhost:8080/h2-console |

---

## Test Data

```
Name: John Doe
Email: john@example.com
City: New York
Password: SecurePass123
```

---

## Verify It's Working

### Backend
Open browser: http://localhost:8080/api/v1/getusers
Should see: `[]`

### Frontend  
Open browser: http://localhost:3000
Should load without errors

### Full Test
1. Go to signup page
2. Fill form with test data
3. Click Create Account
4. See success message
5. Get redirected to login

---

## Common Issues

| Problem | Solution |
|---------|----------|
| "Port already in use" | Kill the process or use different port |
| "npm not found" | Install Node.js |
| "Module not found" | Run `npm install` |
| "Database error" | Check MySQL is running |
| "BCryptPasswordEncoder not found" | Run `.\mvnw.cmd clean install -DskipTests` |

---

## File Locations

```
Backend JAR:
C:\REST API\print-on-one-backend\target\print-on-one-backend-0.0.1-SNAPSHOT.jar

SignupPage:
your-frontend\src\components\auth\SignupPage.jsx
```

---

## Kill Process on Port

```powershell
# Find process on port 8080
netstat -ano | findstr :8080

# Kill it (replace PID with actual number)
taskkill /PID <PID> /F

# Or just restart your terminal
```

---

**Status**: ✅ Ready to Go!

