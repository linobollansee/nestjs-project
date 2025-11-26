# API Testing Guide / API-Test-Leitfaden

## 🇬🇧 English Version

This file contains example curl commands to test the Book Library API.

### Prerequisites

- The server must be running: `npm run start:dev`
- Server URL: http://localhost:3000/api

## 1. Register a New User

```bash
curl -X POST http://localhost:3000/api/users ^
  -H "Content-Type: application/json" ^
  -d "{\"username\":\"testuser\",\"email\":\"test@example.com\",\"password\":\"password123\"}"
```

Expected Response (201):

```json
{
  "id": "123e4567-e89b-12d3-a456-426614174000",
  "username": "testuser",
  "email": "test@example.com"
}
```

## 2. Login (Get JWT Token)

```bash
curl -X POST http://localhost:3000/api/auth ^
  -H "Content-Type: application/json" ^
  -d "{\"email\":\"test@example.com\",\"password\":\"password123\"}"
```

Expected Response (200):

```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

**Save the token for the next requests!**

## 3. Create a Book (Protected)

Replace `YOUR_TOKEN` with the token from step 2.

```bash
curl -X POST http://localhost:3000/api/books ^
  -H "Content-Type: application/json" ^
  -H "Authorization: Bearer YOUR_TOKEN" ^
  -d "{\"title\":\"1984\",\"author\":\"George Orwell\",\"publishedYear\":1949}"
```

Expected Response (201):

```json
{
  "id": "456e7890-e89b-12d3-a456-426614174001",
  "title": "1984",
  "author": "George Orwell",
  "publishedYear": 1949
}
```

## 4. Get All Books (Protected)

```bash
curl -X GET http://localhost:3000/api/books ^
  -H "Authorization: Bearer YOUR_TOKEN"
```

Expected Response (200):

```json
[
  {
    "id": "456e7890-e89b-12d3-a456-426614174001",
    "title": "1984",
    "author": "George Orwell",
    "publishedYear": 1949
  }
]
```

## 5. Get Book by ID (Protected)

```bash
curl -X GET http://localhost:3000/api/books/456e7890-e89b-12d3-a456-426614174001 ^
  -H "Authorization: Bearer YOUR_TOKEN"
```

Expected Response (200):

```json
{
  "id": "456e7890-e89b-12d3-a456-426614174001",
  "title": "1984",
  "author": "George Orwell",
  "publishedYear": 1949
}
```

## 6. Update Book (Protected)

```bash
curl -X PUT http://localhost:3000/api/books/456e7890-e89b-12d3-a456-426614174001 ^
  -H "Content-Type: application/json" ^
  -H "Authorization: Bearer YOUR_TOKEN" ^
  -d "{\"title\":\"Nineteen Eighty-Four\",\"author\":\"George Orwell\",\"publishedYear\":1949}"
```

Expected Response (200):

```json
{
  "id": "456e7890-e89b-12d3-a456-426614174001",
  "title": "Nineteen Eighty-Four",
  "author": "George Orwell",
  "publishedYear": 1949
}
```

## 7. Get All Users (Protected)

```bash
curl -X GET http://localhost:3000/api/users ^
  -H "Authorization: Bearer YOUR_TOKEN"
```

Expected Response (200):

```json
[
  {
    "id": "123e4567-e89b-12d3-a456-426614174000",
    "username": "testuser",
    "email": "test@example.com"
  }
]
```

## 8. Get User by ID (Protected)

```bash
curl -X GET http://localhost:3000/api/users/123e4567-e89b-12d3-a456-426614174000 ^
  -H "Authorization: Bearer YOUR_TOKEN"
```

Expected Response (200):

```json
{
  "id": "123e4567-e89b-12d3-a456-426614174000",
  "username": "testuser",
  "email": "test@example.com"
}
```

## 9. Update User (Protected)

```bash
curl -X PUT http://localhost:3000/api/users/123e4567-e89b-12d3-a456-426614174000 ^
  -H "Content-Type: application/json" ^
  -H "Authorization: Bearer YOUR_TOKEN" ^
  -d "{\"username\":\"updateduser\",\"email\":\"test@example.com\",\"password\":\"newpassword123\"}"
```

Expected Response (200):

```json
{
  "id": "123e4567-e89b-12d3-a456-426614174000",
  "username": "updateduser",
  "email": "test@example.com"
}
```

## 10. Delete Book (Protected)

```bash
curl -X DELETE http://localhost:3000/api/books/456e7890-e89b-12d3-a456-426614174001 ^
  -H "Authorization: Bearer YOUR_TOKEN"
```

Expected Response (204): No content

## 11. Delete User (Protected)

```bash
curl -X DELETE http://localhost:3000/api/users/123e4567-e89b-12d3-a456-426614174000 ^
  -H "Authorization: Bearer YOUR_TOKEN"
```

Expected Response (204): No content

## Error Responses

### 401 Unauthorized (No Token)

```json
{
  "statusCode": 401,
  "message": "Unauthorized"
}
```

### 401 Unauthorized (Invalid Credentials)

```json
{
  "statusCode": 401,
  "message": "Invalid credentials"
}
```

### 404 Not Found

```json
{
  "statusCode": 404,
  "message": "Book with ID xxx not found",
  "error": "Not Found"
}
```

### 400 Bad Request (Validation Error)

```json
{
  "statusCode": 400,
  "message": [
    "title should not be empty",
    "publishedYear must be an integer number"
  ],
  "error": "Bad Request"
}
```

## Notes for PowerShell

If using PowerShell directly (not bash), use these commands instead:

```powershell
# Register User
Invoke-RestMethod -Uri "http://localhost:3000/api/users" -Method Post -ContentType "application/json" -Body '{"username":"testuser","email":"test@example.com","password":"password123"}'

# Login
$response = Invoke-RestMethod -Uri "http://localhost:3000/api/auth" -Method Post -ContentType "application/json" -Body '{"email":"test@example.com","password":"password123"}'
$token = $response.token

# Create Book
$headers = @{ Authorization = "Bearer $token" }
Invoke-RestMethod -Uri "http://localhost:3000/api/books" -Method Post -ContentType "application/json" -Headers $headers -Body '{"title":"1984","author":"George Orwell","publishedYear":1949}'

# Get All Books
Invoke-RestMethod -Uri "http://localhost:3000/api/books" -Method Get -Headers $headers
```

---

## 🇩🇪 Deutsche Version

Diese Datei enthält Beispiel-curl-Befehle zum Testen der Buchbibliotheks-API.

### Voraussetzungen

- Der Server muss laufen: `npm run start:dev`
- Server-URL: http://localhost:3000/api

### 1. Einen neuen Benutzer registrieren

```bash
curl -X POST http://localhost:3000/api/users ^
  -H "Content-Type: application/json" ^
  -d "{\"username\":\"testuser\",\"email\":\"test@example.com\",\"password\":\"password123\"}"
```

Erwartete Antwort (201):

```json
{
  "id": "123e4567-e89b-12d3-a456-426614174000",
  "username": "testuser",
  "email": "test@example.com"
}
```

### 2. Anmelden (JWT-Token erhalten)

```bash
curl -X POST http://localhost:3000/api/auth ^
  -H "Content-Type: application/json" ^
  -d "{\"email\":\"test@example.com\",\"password\":\"password123\"}"
```

Erwartete Antwort (200):

```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

**Speichern Sie das Token für die nächsten Anfragen!**

### 3. Ein Buch erstellen (Geschützt)

Ersetzen Sie `YOUR_TOKEN` mit dem Token aus Schritt 2.

```bash
curl -X POST http://localhost:3000/api/books ^
  -H "Content-Type: application/json" ^
  -H "Authorization: Bearer YOUR_TOKEN" ^
  -d "{\"title\":\"1984\",\"author\":\"George Orwell\",\"publishedYear\":1949}"
```

Erwartete Antwort (201):

```json
{
  "id": "456e7890-e89b-12d3-a456-426614174001",
  "title": "1984",
  "author": "George Orwell",
  "publishedYear": 1949
}
```

### 4. Alle Bücher abrufen (Geschützt)

```bash
curl -X GET http://localhost:3000/api/books ^
  -H "Authorization: Bearer YOUR_TOKEN"
```

Erwartete Antwort (200):

```json
[
  {
    "id": "456e7890-e89b-12d3-a456-426614174001",
    "title": "1984",
    "author": "George Orwell",
    "publishedYear": 1949
  }
]
```

### 5. Buch nach ID abrufen (Geschützt)

```bash
curl -X GET http://localhost:3000/api/books/456e7890-e89b-12d3-a456-426614174001 ^
  -H "Authorization: Bearer YOUR_TOKEN"
```

Erwartete Antwort (200):

```json
{
  "id": "456e7890-e89b-12d3-a456-426614174001",
  "title": "1984",
  "author": "George Orwell",
  "publishedYear": 1949
}
```

### 6. Buch aktualisieren (Geschützt)

```bash
curl -X PUT http://localhost:3000/api/books/456e7890-e89b-12d3-a456-426614174001 ^
  -H "Content-Type: application/json" ^
  -H "Authorization: Bearer YOUR_TOKEN" ^
  -d "{\"title\":\"Nineteen Eighty-Four\",\"author\":\"George Orwell\",\"publishedYear\":1949}"
```

Erwartete Antwort (200):

```json
{
  "id": "456e7890-e89b-12d3-a456-426614174001",
  "title": "Nineteen Eighty-Four",
  "author": "George Orwell",
  "publishedYear": 1949
}
```

### 7. Alle Benutzer abrufen (Geschützt)

```bash
curl -X GET http://localhost:3000/api/users ^
  -H "Authorization: Bearer YOUR_TOKEN"
```

Erwartete Antwort (200):

```json
[
  {
    "id": "123e4567-e89b-12d3-a456-426614174000",
    "username": "testuser",
    "email": "test@example.com"
  }
]
```

### 8. Benutzer nach ID abrufen (Geschützt)

```bash
curl -X GET http://localhost:3000/api/users/123e4567-e89b-12d3-a456-426614174000 ^
  -H "Authorization: Bearer YOUR_TOKEN"
```

Erwartete Antwort (200):

```json
{
  "id": "123e4567-e89b-12d3-a456-426614174000",
  "username": "testuser",
  "email": "test@example.com"
}
```

### 9. Benutzer aktualisieren (Geschützt)

```bash
curl -X PUT http://localhost:3000/api/users/123e4567-e89b-12d3-a456-426614174000 ^
  -H "Content-Type: application/json" ^
  -H "Authorization: Bearer YOUR_TOKEN" ^
  -d "{\"username\":\"updateduser\",\"email\":\"test@example.com\",\"password\":\"newpassword123\"}"
```

Erwartete Antwort (200):

```json
{
  "id": "123e4567-e89b-12d3-a456-426614174000",
  "username": "updateduser",
  "email": "test@example.com"
}
```

### 10. Buch löschen (Geschützt)

```bash
curl -X DELETE http://localhost:3000/api/books/456e7890-e89b-12d3-a456-426614174001 ^
  -H "Authorization: Bearer YOUR_TOKEN"
```

Erwartete Antwort (204): Kein Inhalt

### 11. Benutzer löschen (Geschützt)

```bash
curl -X DELETE http://localhost:3000/api/users/123e4567-e89b-12d3-a456-426614174000 ^
  -H "Authorization: Bearer YOUR_TOKEN"
```

Erwartete Antwort (204): Kein Inhalt

### Fehlerantworten

#### 401 Unauthorized (Kein Token)

```json
{
  "statusCode": 401,
  "message": "Unauthorized"
}
```

#### 401 Unauthorized (Ungültige Anmeldedaten)

```json
{
  "statusCode": 401,
  "message": "Invalid credentials"
}
```

#### 404 Not Found

```json
{
  "statusCode": 404,
  "message": "Book with ID xxx not found",
  "error": "Not Found"
}
```

#### 400 Bad Request (Validierungsfehler)

```json
{
  "statusCode": 400,
  "message": [
    "title should not be empty",
    "publishedYear must be an integer number"
  ],
  "error": "Bad Request"
}
```

### Hinweise für PowerShell

Wenn Sie PowerShell direkt verwenden (nicht bash), verwenden Sie stattdessen diese Befehle:

```powershell
# Benutzer registrieren
Invoke-RestMethod -Uri "http://localhost:3000/api/users" -Method Post -ContentType "application/json" -Body '{"username":"testuser","email":"test@example.com","password":"password123"}'

# Anmelden
$response = Invoke-RestMethod -Uri "http://localhost:3000/api/auth" -Method Post -ContentType "application/json" -Body '{"email":"test@example.com","password":"password123"}'
$token = $response.token

# Buch erstellen
$headers = @{ Authorization = "Bearer $token" }
Invoke-RestMethod -Uri "http://localhost:3000/api/books" -Method Post -ContentType "application/json" -Headers $headers -Body '{"title":"1984","author":"George Orwell","publishedYear":1949}'

# Alle Bücher abrufen
Invoke-RestMethod -Uri "http://localhost:3000/api/books" -Method Get -Headers $headers
```
