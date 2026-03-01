# Testing Guide for Signup Implementation

## Manual Testing

### Test 1: Valid Registration

**Steps:**
1. Navigate to signup page
2. Fill in the form with valid data:
   ```
   Full Name: John Doe
   Email: john.doe@example.com
   City: New York
   Password: SecurePass123
   Confirm Password: SecurePass123
   ```
3. Check "I agree to the Terms of Service and Privacy Policy"
4. Click "Create Account"

**Expected Results:**
- ✅ Success alert appears: "Account created successfully! Redirecting to login..."
- ✅ Page redirects to /login after 2 seconds
- ✅ Form fields are cleared
- ✅ User data appears in database

**Database Check:**
```sql
SELECT * FROM user WHERE email = 'john.doe@example.com';
-- Password should be hashed (starts with $2a$10$), not plain text
```

---

### Test 2: Invalid Email Format

**Steps:**
1. Fill in all fields with valid data except email
2. Email field: `invalidemail`
3. Click "Create Account"

**Expected Results:**
- ✅ Form does not submit
- ✅ Error message appears below email field: "Please enter a valid email address"
- ✅ Form-level error alert: "Please fix the errors above before submitting."

---

### Test 3: Weak Password

**Steps:**
1. Fill in all fields with valid data
2. Password: `weak`
3. Confirm Password: `weak`
4. Click "Create Account"

**Expected Results:**
- ✅ Form does not submit
- ✅ Error message below password: "Password must be at least 8 characters with uppercase, lowercase, and a number"
- ✅ Helper text shows requirements

---

### Test 4: Password Mismatch

**Steps:**
1. Fill in all fields
2. Password: `SecurePass123`
3. Confirm Password: `SecurePass456`
4. Click "Create Account"

**Expected Results:**
- ✅ Form does not submit
- ✅ Error below confirm password: "Passwords do not match"

---

### Test 5: Terms Not Agreed

**Steps:**
1. Fill in all fields with valid data
2. Do NOT check "I agree to the Terms..."
3. Click "Create Account"

**Expected Results:**
- ✅ Form does not submit
- ✅ Form-level error appears
- ✅ Terms checkbox shows error styling

---

### Test 6: Duplicate Email

**Steps:**
1. Register user with email: `test@example.com`
2. Try to register again with same email

**Expected Results:**
- ✅ Form submits but shows error message
- ✅ Error message: "Email already exists" or similar
- ✅ User is not created twice

*Note: This requires implementing duplicate email checking in the backend*

---

### Test 7: Network Error Handling

**Steps:**
1. Stop the backend server
2. Try to fill and submit the signup form

**Expected Results:**
- ✅ Loading spinner appears briefly
- ✅ Error alert appears with appropriate message
- ✅ User can correct and retry

---

### Test 8: Real-time Validation

**Steps:**
1. Enter invalid data in a field (e.g., weak password)
2. See error message
3. Correct the field
4. Error message should disappear immediately

**Expected Results:**
- ✅ Errors clear in real-time as user types
- ✅ No need to re-submit form to see errors disappear

---

## Automated Testing (Optional)

### Unit Tests for Frontend Validation

```javascript
// Example test using Jest
import { render, screen, fireEvent } from '@testing-library/react';
import SignupPage from './SignupPage';

describe('SignupPage Validation', () => {
  test('should show error for invalid email', () => {
    render(<SignupPage />);
    
    const emailInput = screen.getByPlaceholderText('Enter your email address');
    fireEvent.change(emailInput, { target: { value: 'invalid' } });
    fireEvent.click(screen.getByText('Create Account'));
    
    expect(screen.getByText('Please enter a valid email address')).toBeInTheDocument();
  });

  test('should show error for weak password', () => {
    render(<SignupPage />);
    
    const passwordInput = screen.getByPlaceholderText('Create a strong password');
    fireEvent.change(passwordInput, { target: { value: 'weak' } });
    fireEvent.click(screen.getByText('Create Account'));
    
    expect(screen.getByText(/Password must be at least 8 characters/)).toBeInTheDocument();
  });

  test('should show error for mismatched passwords', () => {
    render(<SignupPage />);
    
    const passwordInput = screen.getByPlaceholderText('Create a strong password');
    const confirmInput = screen.getByPlaceholderText('Confirm your password');
    
    fireEvent.change(passwordInput, { target: { value: 'SecurePass123' } });
    fireEvent.change(confirmInput, { target: { value: 'DifferentPass123' } });
    fireEvent.click(screen.getByText('Create Account'));
    
    expect(screen.getByText('Passwords do not match')).toBeInTheDocument();
  });
});
```

---

## Performance Testing

### Response Time Test

1. **Frontend Validation**: Should be instant (< 50ms)
2. **Backend Response**: Should be < 1 second
3. **Database Insert**: Should be < 500ms

---

## Security Testing

### Test 1: Password is Hashed

```sql
-- After signup with password: SecurePass123
SELECT email, password FROM user WHERE email = 'test@example.com';

-- ❌ BAD (Plain text): SecurePass123
-- ✅ GOOD (Hashed): $2a$10$SlVXVXNlckhhc2hlZFBhc3N3b3JkSGFzaGVk...
```

### Test 2: SQL Injection Protection

**Steps:**
1. In email field, try: `test@example.com' OR '1'='1`
2. Submit form

**Expected Results:**
- ✅ Input is treated as literal string
- ✅ No database bypass
- ✅ Error for invalid email format

### Test 3: XSS Protection

**Steps:**
1. In name field, try: `<script>alert('XSS')</script>`
2. Submit form

**Expected Results:**
- ✅ Script is not executed
- ✅ Input is sanitized
- ✅ User is created with the literal string as name

---

## Browser Compatibility Testing

Test in:
- [ ] Chrome (latest)
- [ ] Firefox (latest)
- [ ] Safari (latest)
- [ ] Edge (latest)
- [ ] Mobile browsers (Chrome, Safari)

**Expected Results:**
- ✅ Form displays correctly
- ✅ Validation works
- ✅ No console errors
- ✅ Responsive layout works

---

## Edge Cases

### Test 1: Unicode Characters in Name
```
Name: "José García Müller"
```
Should work correctly.

### Test 2: Email with Plus Addressing
```
Email: "test+signup@example.com"
```
Should accept (common for testing).

### Test 3: Very Long Input
```
Name: (500+ characters)
```
Should either truncate or show error.

### Test 4: Special Characters in Password
```
Password: "P@ssw0rd!#$%^"
```
Should accept special characters.

### Test 5: Rapid Submissions
- Click submit button multiple times quickly
- Expected: Only one request sent, duplicate submission prevented

---

## Accessibility Testing

- [ ] Tab through all form fields in order
- [ ] Labels are associated with inputs
- [ ] Error messages are announced
- [ ] Color contrast meets WCAG standards
- [ ] Works with screen readers
- [ ] Keyboard navigation works

---

## Integration Testing

### Test 1: End-to-End Signup to Login

1. Register new user
2. Get redirected to login
3. Login with same credentials
4. Verify password hashing works

**Expected Results:**
- ✅ User can log in with plain text password
- ✅ Backend correctly verifies against hashed password

---

## Test Data Sets

### Valid Test Cases

```javascript
const validUsers = [
  {
    name: "John Doe",
    email: "john@example.com",
    city: "New York",
    password: "SecurePass123"
  },
  {
    name: "Jane Smith",
    email: "jane.smith@example.co.uk",
    city: "London",
    password: "MyP@ssw0rd2026"
  },
  {
    name: "محمد علي",
    email: "mohammad@example.com",
    city: "Dubai",
    password: "ArabicUser123"
  },
  {
    name: "李明",
    email: "li.ming@example.cn",
    city: "Beijing",
    password: "ChineseUser456"
  }
];
```

### Invalid Test Cases

```javascript
const invalidUsers = [
  {
    name: "",
    email: "john@example.com",
    city: "New York",
    password: "SecurePass123",
    expectedError: "Name is required"
  },
  {
    name: "John Doe",
    email: "invalid-email",
    city: "New York",
    password: "SecurePass123",
    expectedError: "Please enter a valid email address"
  },
  {
    name: "John Doe",
    email: "john@example.com",
    city: "",
    password: "SecurePass123",
    expectedError: "City is required"
  },
  {
    name: "John Doe",
    email: "john@example.com",
    city: "New York",
    password: "weak",
    expectedError: "Password must be at least 8 characters"
  },
  {
    name: "John Doe",
    email: "john@example.com",
    city: "New York",
    password: "SecurePass123",
    confirmPassword: "DifferentPass123",
    expectedError: "Passwords do not match"
  }
];
```

---

## Debugging Tips

### Browser DevTools

1. **Console Tab**
   - Check for JavaScript errors
   - Look for validation logs

2. **Network Tab**
   - Monitor API requests to `/api/v1/adduser`
   - Check request payload
   - Verify response status codes

3. **Application Tab**
   - Check localStorage for any stored data
   - Verify cookies if applicable

### Backend Logs

```bash
# Monitor backend logs in real-time
.\mvnw.cmd spring-boot:run | findstr /I "error warning signup user"
```

Look for:
- Password hashing logs
- Database insert logs
- Any errors or warnings

---

## Success Criteria

✅ All tests pass with expected results
✅ No console errors
✅ No backend errors
✅ Data correctly stored in database
✅ Passwords are hashed, not plain text
✅ User experience is smooth and responsive
✅ Error messages are clear and helpful
✅ Form validation prevents invalid submissions
✅ Redirect to login works properly

---

**Testing Date**: _______________
**Tester Name**: _______________
**Status**: [ ] PASS [ ] FAIL
**Notes**: _________________________________


