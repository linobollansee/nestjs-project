# API Endpoints Reference / API-Endpunkte-Referenz

## 🇬🇧 English Version

### Base URL

```
http://localhost:3000/api
```

## Authentication Endpoints

### Login

- **Endpoint:** `POST /auth`
- **Description:** Authenticate user and receive JWT token
- **Auth Required:** No
- **Request Body:**
  ```json
  {
    "email": "user@example.com",
    "password": "password123"
  }
  ```
- **Success Response (200):**
  ```json
  {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
  }
  ```
- **Error Response (401):**
  ```json
  {
    "statusCode": 401,
    "message": "Invalid credentials"
  }
  ```

---

## User Endpoints

### Register User

- **Endpoint:** `POST /users`
- **Description:** Create a new user account
- **Auth Required:** No
- **Request Body:**
  ```json
  {
    "username": "johndoe",
    "email": "john@example.com",
    "password": "password123"
  }
  ```
- **Success Response (201):**
  ```json
  {
    "id": "123e4567-e89b-12d3-a456-426614174000",
    "username": "johndoe",
    "email": "john@example.com"
  }
  ```
- **Error Response (409):**
  ```json
  {
    "statusCode": 409,
    "message": "User with this email already exists"
  }
  ```

### List All Users

- **Endpoint:** `GET /users`
- **Description:** Get all registered users
- **Auth Required:** Yes (Bearer token)
- **Headers:**
  ```
  Authorization: Bearer <token>
  ```
- **Success Response (200):**
  ```json
  [
    {
      "id": "123e4567-e89b-12d3-a456-426614174000",
      "username": "johndoe",
      "email": "john@example.com"
    }
  ]
  ```

### Get User by ID

- **Endpoint:** `GET /users/{id}`
- **Description:** Get specific user details
- **Auth Required:** Yes (Bearer token)
- **URL Parameters:**
  - `id` - User UUID
- **Headers:**
  ```
  Authorization: Bearer <token>
  ```
- **Success Response (200):**
  ```json
  {
    "id": "123e4567-e89b-12d3-a456-426614174000",
    "username": "johndoe",
    "email": "john@example.com"
  }
  ```
- **Error Response (404):**
  ```json
  {
    "statusCode": 404,
    "message": "User with ID {id} not found",
    "error": "Not Found"
  }
  ```

### Update User

- **Endpoint:** `PUT /users/{id}`
- **Description:** Update user information
- **Auth Required:** Yes (Bearer token)
- **URL Parameters:**
  - `id` - User UUID
- **Headers:**
  ```
  Authorization: Bearer <token>
  ```
- **Request Body:**
  ```json
  {
    "username": "johndoe_updated",
    "email": "john.new@example.com",
    "password": "newpassword123"
  }
  ```
- **Success Response (200):**
  ```json
  {
    "id": "123e4567-e89b-12d3-a456-426614174000",
    "username": "johndoe_updated",
    "email": "john.new@example.com"
  }
  ```

### Delete User

- **Endpoint:** `DELETE /users/{id}`
- **Description:** Delete a user account
- **Auth Required:** Yes (Bearer token)
- **URL Parameters:**
  - `id` - User UUID
- **Headers:**
  ```
  Authorization: Bearer <token>
  ```
- **Success Response (204):** No content
- **Error Response (404):**
  ```json
  {
    "statusCode": 404,
    "message": "User with ID {id} not found",
    "error": "Not Found"
  }
  ```

---

## Book Endpoints

All book endpoints require authentication (Bearer token).

### List All Books

- **Endpoint:** `GET /books`
- **Description:** Get all books in the library
- **Auth Required:** Yes (Bearer token)
- **Headers:**
  ```
  Authorization: Bearer <token>
  ```
- **Success Response (200):**
  ```json
  [
    {
      "id": "456e7890-e89b-12d3-a456-426614174001",
      "title": "The Great Gatsby",
      "author": "F. Scott Fitzgerald",
      "publishedYear": 1925
    }
  ]
  ```

### Get Book by ID

- **Endpoint:** `GET /books/{id}`
- **Description:** Get specific book details
- **Auth Required:** Yes (Bearer token)
- **URL Parameters:**
  - `id` - Book UUID
- **Headers:**
  ```
  Authorization: Bearer <token>
  ```
- **Success Response (200):**
  ```json
  {
    "id": "456e7890-e89b-12d3-a456-426614174001",
    "title": "The Great Gatsby",
    "author": "F. Scott Fitzgerald",
    "publishedYear": 1925
  }
  ```
- **Error Response (404):**
  ```json
  {
    "statusCode": 404,
    "message": "Book with ID {id} not found",
    "error": "Not Found"
  }
  ```

### Create Book

- **Endpoint:** `POST /books`
- **Description:** Add a new book to the library
- **Auth Required:** Yes (Bearer token)
- **Headers:**
  ```
  Authorization: Bearer <token>
  ```
- **Request Body:**
  ```json
  {
    "title": "1984",
    "author": "George Orwell",
    "publishedYear": 1949
  }
  ```
- **Success Response (201):**
  ```json
  {
    "id": "456e7890-e89b-12d3-a456-426614174001",
    "title": "1984",
    "author": "George Orwell",
    "publishedYear": 1949
  }
  ```
- **Error Response (400):**
  ```json
  {
    "statusCode": 400,
    "message": [
      "title should not be empty",
      "author should not be empty",
      "publishedYear must be an integer number"
    ],
    "error": "Bad Request"
  }
  ```

### Update Book

- **Endpoint:** `PUT /books/{id}`
- **Description:** Update book information
- **Auth Required:** Yes (Bearer token)
- **URL Parameters:**
  - `id` - Book UUID
- **Headers:**
  ```
  Authorization: Bearer <token>
  ```
- **Request Body:**
  ```json
  {
    "title": "Nineteen Eighty-Four",
    "author": "George Orwell",
    "publishedYear": 1949
  }
  ```
- **Success Response (200):**
  ```json
  {
    "id": "456e7890-e89b-12d3-a456-426614174001",
    "title": "Nineteen Eighty-Four",
    "author": "George Orwell",
    "publishedYear": 1949
  }
  ```
- **Error Response (404):**
  ```json
  {
    "statusCode": 404,
    "message": "Book with ID {id} not found",
    "error": "Not Found"
  }
  ```

### Delete Book

- **Endpoint:** `DELETE /books/{id}`
- **Description:** Remove a book from the library
- **Auth Required:** Yes (Bearer token)
- **URL Parameters:**
  - `id` - Book UUID
- **Headers:**
  ```
  Authorization: Bearer <token>
  ```
- **Success Response (204):** No content
- **Error Response (404):**
  ```json
  {
    "statusCode": 404,
    "message": "Book with ID {id} not found",
    "error": "Not Found"
  }
  ```

---

## Common Error Responses

### 401 Unauthorized (Missing Token)

```json
{
  "statusCode": 401,
  "message": "Unauthorized"
}
```

### 401 Unauthorized (Invalid Token)

```json
{
  "statusCode": 401,
  "message": "Unauthorized"
}
```

### 400 Bad Request (Validation Error)

```json
{
  "statusCode": 400,
  "message": ["field validation error message"],
  "error": "Bad Request"
}
```

---

## Status Codes Summary

| Code | Description  | When                                          |
| ---- | ------------ | --------------------------------------------- |
| 200  | OK           | Successful GET, PUT, or POST /auth            |
| 201  | Created      | Successful POST (create user or book)         |
| 204  | No Content   | Successful DELETE                             |
| 400  | Bad Request  | Validation errors                             |
| 401  | Unauthorized | Missing or invalid token, invalid credentials |
| 404  | Not Found    | Resource doesn't exist                        |
| 409  | Conflict     | Duplicate resource (email already exists)     |

---

## Authentication Flow

1. **Register** → `POST /api/users` (public)
2. **Login** → `POST /api/auth` (public) → Receive `token`
3. **Access Protected Endpoints** → Include `Authorization: Bearer {token}` header
4. **Token expires in 24 hours** → Login again to get new token

---

## Data Models

### Book

```typescript
{
  id: string; // UUID
  title: string; // Required
  author: string; // Required
  publishedYear: number; // Required, integer
}
```

### User (Response)

```typescript
{
  id: string; // UUID
  username: string; // Required
  email: string; // Required, email format
  // password is never returned
}
```

### User (Input)

```typescript
{
  username: string; // Required
  email: string; // Required, email format
  password: string; // Required, minimum length varies
}
```

### Auth Request

```typescript
{
  email: string; // Required, email format
  password: string; // Required
}
```

### Auth Response

```typescript
{
  "token": string; // JWT token
}
```

---

## 🇩🇪 Deutsche Version

### Basis-URL

```
http://localhost:3000/api
```

### Authentifizierungs-Endpunkte

#### Anmelden

- **Endpunkt:** `POST /auth`
- **Beschreibung:** Benutzer authentifizieren und JWT-Token erhalten
- **Authentifizierung erforderlich:** Nein
- **Request Body:**
  ```json
  {
    "email": "user@example.com",
    "password": "password123"
  }
  ```
- **Erfolgsantwort (200):**
  ```json
  {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
  }
  ```
- **Fehlerantwort (401):**
  ```json
  {
    "statusCode": 401,
    "message": "Invalid credentials"
  }
  ```

---

### Benutzer-Endpunkte

#### Benutzer registrieren

- **Endpunkt:** `POST /users`
- **Beschreibung:** Neues Benutzerkonto erstellen
- **Authentifizierung erforderlich:** Nein
- **Request Body:**
  ```json
  {
    "username": "johndoe",
    "email": "john@example.com",
    "password": "password123"
  }
  ```
- **Erfolgsantwort (201):**
  ```json
  {
    "id": "123e4567-e89b-12d3-a456-426614174000",
    "username": "johndoe",
    "email": "john@example.com"
  }
  ```
- **Fehlerantwort (409):**
  ```json
  {
    "statusCode": 409,
    "message": "User with this email already exists"
  }
  ```

#### Alle Benutzer auflisten

- **Endpunkt:** `GET /users`
- **Beschreibung:** Alle registrierten Benutzer abrufen
- **Authentifizierung erforderlich:** Ja (Bearer-Token)
- **Headers:**
  ```
  Authorization: Bearer <token>
  ```
- **Erfolgsantwort (200):**
  ```json
  [
    {
      "id": "123e4567-e89b-12d3-a456-426614174000",
      "username": "johndoe",
      "email": "john@example.com"
    }
  ]
  ```

#### Benutzer nach ID abrufen

- **Endpunkt:** `GET /users/{id}`
- **Beschreibung:** Spezifische Benutzerdetails abrufen
- **Authentifizierung erforderlich:** Ja (Bearer-Token)
- **URL-Parameter:**
  - `id` - Benutzer-UUID
- **Headers:**
  ```
  Authorization: Bearer <token>
  ```
- **Erfolgsantwort (200):**
  ```json
  {
    "id": "123e4567-e89b-12d3-a456-426614174000",
    "username": "johndoe",
    "email": "john@example.com"
  }
  ```
- **Fehlerantwort (404):**
  ```json
  {
    "statusCode": 404,
    "message": "User with ID {id} not found",
    "error": "Not Found"
  }
  ```

#### Benutzer aktualisieren

- **Endpunkt:** `PUT /users/{id}`
- **Beschreibung:** Benutzerinformationen aktualisieren
- **Authentifizierung erforderlich:** Ja (Bearer-Token)
- **URL-Parameter:**
  - `id` - Benutzer-UUID
- **Headers:**
  ```
  Authorization: Bearer <token>
  ```
- **Request Body:**
  ```json
  {
    "username": "johndoe_updated",
    "email": "john.new@example.com",
    "password": "newpassword123"
  }
  ```
- **Erfolgsantwort (200):**
  ```json
  {
    "id": "123e4567-e89b-12d3-a456-426614174000",
    "username": "johndoe_updated",
    "email": "john.new@example.com"
  }
  ```

#### Benutzer löschen

- **Endpunkt:** `DELETE /users/{id}`
- **Beschreibung:** Ein Benutzerkonto löschen
- **Authentifizierung erforderlich:** Ja (Bearer-Token)
- **URL-Parameter:**
  - `id` - Benutzer-UUID
- **Headers:**
  ```
  Authorization: Bearer <token>
  ```
- **Erfolgsantwort (204):** Kein Inhalt
- **Fehlerantwort (404):**
  ```json
  {
    "statusCode": 404,
    "message": "User with ID {id} not found",
    "error": "Not Found"
  }
  ```

---

### Buch-Endpunkte

Alle Buch-Endpunkte erfordern Authentifizierung (Bearer-Token).

#### Alle Bücher auflisten

- **Endpunkt:** `GET /books`
- **Beschreibung:** Alle Bücher in der Bibliothek abrufen
- **Authentifizierung erforderlich:** Ja (Bearer-Token)
- **Headers:**
  ```
  Authorization: Bearer <token>
  ```
- **Erfolgsantwort (200):**
  ```json
  [
    {
      "id": "456e7890-e89b-12d3-a456-426614174001",
      "title": "The Great Gatsby",
      "author": "F. Scott Fitzgerald",
      "publishedYear": 1925
    }
  ]
  ```

#### Buch nach ID abrufen

- **Endpunkt:** `GET /books/{id}`
- **Beschreibung:** Spezifische Buchdetails abrufen
- **Authentifizierung erforderlich:** Ja (Bearer-Token)
- **URL-Parameter:**
  - `id` - Buch-UUID
- **Headers:**
  ```
  Authorization: Bearer <token>
  ```
- **Erfolgsantwort (200):**
  ```json
  {
    "id": "456e7890-e89b-12d3-a456-426614174001",
    "title": "The Great Gatsby",
    "author": "F. Scott Fitzgerald",
    "publishedYear": 1925
  }
  ```
- **Fehlerantwort (404):**
  ```json
  {
    "statusCode": 404,
    "message": "Book with ID {id} not found",
    "error": "Not Found"
  }
  ```

#### Buch erstellen

- **Endpunkt:** `POST /books`
- **Beschreibung:** Ein neues Buch zur Bibliothek hinzufügen
- **Authentifizierung erforderlich:** Ja (Bearer-Token)
- **Headers:**
  ```
  Authorization: Bearer <token>
  ```
- **Request Body:**
  ```json
  {
    "title": "1984",
    "author": "George Orwell",
    "publishedYear": 1949
  }
  ```
- **Erfolgsantwort (201):**
  ```json
  {
    "id": "456e7890-e89b-12d3-a456-426614174001",
    "title": "1984",
    "author": "George Orwell",
    "publishedYear": 1949
  }
  ```
- **Fehlerantwort (400):**
  ```json
  {
    "statusCode": 400,
    "message": [
      "title should not be empty",
      "author should not be empty",
      "publishedYear must be an integer number"
    ],
    "error": "Bad Request"
  }
  ```

#### Buch aktualisieren

- **Endpunkt:** `PUT /books/{id}`
- **Beschreibung:** Buchinformationen aktualisieren
- **Authentifizierung erforderlich:** Ja (Bearer-Token)
- **URL-Parameter:**
  - `id` - Buch-UUID
- **Headers:**
  ```
  Authorization: Bearer <token>
  ```
- **Request Body:**
  ```json
  {
    "title": "Nineteen Eighty-Four",
    "author": "George Orwell",
    "publishedYear": 1949
  }
  ```
- **Erfolgsantwort (200):**
  ```json
  {
    "id": "456e7890-e89b-12d3-a456-426614174001",
    "title": "Nineteen Eighty-Four",
    "author": "George Orwell",
    "publishedYear": 1949
  }
  ```
- **Fehlerantwort (404):**
  ```json
  {
    "statusCode": 404,
    "message": "Book with ID {id} not found",
    "error": "Not Found"
  }
  ```

#### Buch löschen

- **Endpunkt:** `DELETE /books/{id}`
- **Beschreibung:** Ein Buch aus der Bibliothek entfernen
- **Authentifizierung erforderlich:** Ja (Bearer-Token)
- **URL-Parameter:**
  - `id` - Buch-UUID
- **Headers:**
  ```
  Authorization: Bearer <token>
  ```
- **Erfolgsantwort (204):** Kein Inhalt
- **Fehlerantwort (404):**
  ```json
  {
    "statusCode": 404,
    "message": "Book with ID {id} not found",
    "error": "Not Found"
  }
  ```

---

### Häufige Fehlerantworten

#### 401 Unauthorized (Fehlendes Token)

```json
{
  "statusCode": 401,
  "message": "Unauthorized"
}
```

#### 401 Unauthorized (Ungültiges Token)

```json
{
  "statusCode": 401,
  "message": "Unauthorized"
}
```

#### 400 Bad Request (Validierungsfehler)

```json
{
  "statusCode": 400,
  "message": ["Feldvalidierungsfehlermeldung"],
  "error": "Bad Request"
}
```

---

### Statuscodes-Zusammenfassung

| Code | Beschreibung | Wann                                                     |
| ---- | ------------ | -------------------------------------------------------- |
| 200  | OK           | Erfolgreiche GET-, PUT- oder POST /auth-Anfrage          |
| 201  | Created      | Erfolgreiche POST-Anfrage (Benutzer oder Buch erstellen) |
| 204  | No Content   | Erfolgreiche DELETE-Anfrage                              |
| 400  | Bad Request  | Validierungsfehler                                       |
| 401  | Unauthorized | Fehlendes oder ungültiges Token, ungültige Anmeldedaten  |
| 404  | Not Found    | Ressource existiert nicht                                |
| 409  | Conflict     | Doppelte Ressource (E-Mail existiert bereits)            |

---

### Authentifizierungsablauf

1. **Registrieren** → `POST /api/users` (öffentlich)
2. **Anmelden** → `POST /api/auth` (öffentlich) → `token` erhalten
3. **Auf geschützte Endpunkte zugreifen** → `Authorization: Bearer {token}` Header hinzufügen
4. **Token läuft nach 24 Stunden ab** → Erneut anmelden, um neues Token zu erhalten

---

### Datenmodelle

#### Buch

```typescript
{
  id: string; // UUID
  title: string; // Erforderlich
  author: string; // Erforderlich
  publishedYear: number; // Erforderlich, Ganzzahl
}
```

#### Benutzer (Antwort)

```typescript
{
  id: string; // UUID
  username: string; // Erforderlich
  email: string; // Erforderlich, E-Mail-Format
  // Passwort wird niemals zurückgegeben
}
```

#### Benutzer (Eingabe)

```typescript
{
  username: string; // Erforderlich
  email: string; // Erforderlich, E-Mail-Format
  password: string; // Erforderlich, Mindestlänge variiert
}
```

#### Auth Request

```typescript
{
  email: string; // Erforderlich, E-Mail-Format
  password: string; // Erforderlich
}
```

#### Auth Response

```typescript
{
  token: string; // JWT-Token
}
```
