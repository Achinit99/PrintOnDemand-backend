# 🚀 How to Run Your Signup System

## Quick Start (3 Steps)

### Step 1: Start Backend Server
```bash
cd "C:\REST API\print-on-one-backend"
.\mvnw.cmd spring-boot:run
```

**Expected Output:**
```
Started PrintOnOneBackendApplication in X.XXX seconds
```

The backend will run on: `http://localhost:8080`

---

### Step 2: Start Frontend Server
Open a new terminal and run:
```bash
cd your-frontend-folder
npm start
```

The frontend will run on: `http://localhost:3000`

---

### Step 3: Test Signup
1. Go to: `http://localhost:3000/signup`
2. Fill the form with valid data:
   ```
   Name: John Doe
   Email: john@example.com
   City: New York
   Password: SecurePass123
   Confirm: SecurePass123
   ✓ Check Terms
   ```
3. Click "Create Account"
4. You should see: ✅ "Account created successfully! Redirecting to login..."

---

## Detailed Setup Instructions

### Prerequisites
- Java 17+ installed
- Node.js/npm installed
- MySQL or H2 database
- Git (optional)

### Backend Setup

#### Option A: Using Maven (Recommended)

**1. Navigate to backend folder:**
```bash
cd "C:\REST API\print-on-one-backend"
```

**2. Build the project (first time only):**
```bash
.\mvnw.cmd clean install -DskipTests
```

This will:
- Download all dependencies
- Compile the code
- Create JAR file

**3. Run the backend:**
```bash
.\mvnw.cmd spring-boot:run
```

**4. Verify it's running:**
- Open browser: `http://localhost:8080/api/v1/getusers`
- You should see: `[]` (empty list of users)

---

#### Option B: Using Pre-built JAR

```bash
cd "C:\REST API\print-on-one-backend\target"
java -jar print-on-one-backend-0.0.1-SNAPSHOT.jar
```

---

### Database Setup

#### For MySQL:

**1. Create database:**
```bash
mysql -u root -p
```

**2. Run setup script:**
```sql
CREATE DATABASE print_on_one;
USE print_on_one;

CREATE TABLE user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    city VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

**3. Update application.properties:**
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/print_on_one
spring.datasource.username=root
spring.datasource.password=your_password
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
spring.jpa.hibernate.ddl-auto=update
```

---

#### For H2 (Development - Easiest):

H2 is already configured in `application.properties`:
```properties
spring.datasource.url=jdbc:h2:mem:testdb
spring.datasource.driverClassName=org.h2.Driver
spring.datasource.username=sa
spring.datasource.password=
spring.h2.console.enabled=true
```

No setup needed! H2 runs in memory.

Access H2 Console: `http://localhost:8080/h2-console`

---

### Frontend Setup

**1. Navigate to frontend folder:**
```bash
cd your-frontend-folder
```

**2. Install dependencies (first time only):**
```bash
npm install
```

**3. Make sure SignupPage.jsx is in correct location:**
```
src/components/auth/SignupPage.jsx
```

**4. Update imports in SignupPage.jsx if needed:**
```javascript
import axios from '../../api/axiosInstance';
import Navbar from '../landingpage/Navbar';
```

**5. Start development server:**
```bash
npm start
```

Browser will open automatically to `http://localhost:3000`

---

## Running Everything (Complete Guide)

### Terminal 1: Backend
```bash
cd "C:\REST API\print-on-one-backend"
.\mvnw.cmd spring-boot:run
```

Wait until you see:
```
Started PrintOnOneBackendApplication in X.XXX seconds
```

### Terminal 2: Frontend
```bash
cd your-frontend-folder
npm start
```

Wait until you see:
```
Compiled successfully!
You can now view your-app in the browser.
```

### Terminal 3: Test API (Optional)
```bash
# Test if backend is running
curl http://localhost:8080/api/v1/getusers

# Should return: []
```

---

## Troubleshooting

### Backend Won't Start

**Error:** `Port 8080 already in use`
```bash
# Change port in application.properties
server.port=8081
```

**Error:** `Database connection refused`
- Check MySQL is running: `mysql -u root -p -e "SELECT 1"`
- Update database credentials in `application.properties`

**Error:** `BCryptPasswordEncoder not found`
```bash
.\mvnw.cmd clean install -DskipTests
.\mvnw.cmd spring-boot:run
```

---

### Frontend Won't Start

**Error:** `npm command not found`
- Install Node.js from nodejs.org

**Error:** `Port 3000 already in use`
```bash
# Change port
PORT=3001 npm start
```

**Error:** `Module not found`
```bash
# Reinstall dependencies
rm -r node_modules
npm install
npm start
```

---

### Signup Not Working

**Issue:** Form submits but nothing happens
- Check browser console (F12) for errors
- Check backend logs for error messages
- Verify API endpoint: `http://localhost:8080/api/v1/adduser`

**Issue:** "Email already exists" error
- Clear database or use different email
- For H2: Just restart backend (in-memory DB resets)
- For MySQL: `DELETE FROM user;`

**Issue:** Password not hashing
- Verify `SecurityConfig.java` exists
- Rebuild: `.\mvnw.cmd clean install -DskipTests`

---

## Quick Test Commands

### Test Backend API with cURL

```bash
# Get all users
curl http://localhost:8080/api/v1/getusers

# Create new user
curl -X POST http://localhost:8080/api/v1/adduser ^
  -H "Content-Type: application/json" ^
  -d "{\"name\":\"Test\",\"email\":\"test@example.com\",\"city\":\"TestCity\",\"password\":\"Pass123\"}"
```

### Test with Postman

1. Open Postman
2. Create new POST request
3. URL: `http://localhost:8080/api/v1/adduser`
4. Headers: `Content-Type: application/json`
5. Body (raw JSON):
```json
{
  "name": "John Doe",
  "email": "john@example.com",
  "city": "New York",
  "password": "SecurePass123"
}
```
6. Click Send

Expected response:
```json
{
  "id": 1,
  "name": "John Doe",
  "email": "john@example.com",
  "city": "New York",
  "password": null
}
```

---

## File Locations Reference

```
Backend:
C:\REST API\print-on-one-backend\
├── src\main\java\com\example\print_on_one_backend\
│   ├── service\UserService.java ✅ (ready)
│   ├── model\User.java ✅ (ready)
│   ├── dto\UserDTO.java ✅ (ready)
│   ├── config\SecurityConfig.java ✅ (ready)
│   └── controller\UserController.java ✅ (ready)
├── pom.xml ✅ (ready)
└── target\print-on-one-backend-0.0.1-SNAPSHOT.jar ✅ (ready)

Frontend:
your-frontend-folder\
└── src\components\auth\
    └── SignupPage.jsx ✅ (ready)
```

---

## Step-by-Step Execution

### First Time Setup

**1. Build Backend (once)**
```bash
cd "C:\REST API\print-on-one-backend"
.\mvnw.cmd clean install -DskipTests
```

**2. Setup Database (once)**
- For MySQL: Run SQL script
- For H2: No setup needed

**3. Install Frontend Dependencies (once)**
```bash
cd your-frontend-folder
npm install
```

### Daily Execution

**Terminal 1 - Backend:**
```bash
cd "C:\REST API\print-on-one-backend"
.\mvnw.cmd spring-boot:run
```

**Terminal 2 - Frontend:**
```bash
cd your-frontend-folder
npm start
```

**Then open browser:**
```
http://localhost:3000/signup
```

---

## Logs to Watch For

### Backend Startup Logs
```
✅ Started PrintOnOneBackendApplication
✅ Tomcat started on port(s): 8080
✅ HikariPool - Connection is alive
```

### Frontend Startup Logs
```
✅ Compiled successfully!
✅ webpack compiled
```

### Signup Success Logs
**Browser Console:**
```
✅ POST /api/v1/adduser 201 Created
✅ Account created successfully!
```

---

## Production Deployment

### Build JAR for Deployment
```bash
cd "C:\REST API\print-on-one-backend"
.\mvnw.cmd clean package -DskipTests
```

JAR location: `target\print-on-one-backend-0.0.1-SNAPSHOT.jar`

### Run JAR
```bash
java -jar target\print-on-one-backend-0.0.1-SNAPSHOT.jar
```

### Frontend Build for Deployment
```bash
cd your-frontend-folder
npm run build
```

This creates `build\` folder for deployment.

---

## Getting Help

If something doesn't work:

1. **Check Logs** - Backend logs show most errors
2. **Verify Ports** - Make sure 8080 and 3000 are free
3. **Rebuild** - Run clean build: `.\mvnw.cmd clean install -DskipTests`
4. **Check Files** - Verify all files are in correct locations
5. **Database** - Verify database is set up and running

---

**Status**: ✅ Ready to Run
**Last Updated**: February 26, 2026

