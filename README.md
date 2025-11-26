# NestJS Book Library API / NestJS Buchbibliothek-API

---

## 🇬🇧 English Version

A RESTful API built with NestJS for managing a book library with user authentication.

### Features

- ✅ Full CRUD operations for books
- ✅ User management and registration
- ✅ JWT-based authentication
- ✅ Protected endpoints with Bearer token
- ✅ Input validation with class-validator
- ✅ OpenAPI 3.0 compliant endpoints

### Installation

```bash
npm install
```

### Running the Application

```bash
# Development mode
npm run start:dev

# Production mode
npm run build
npm run start:prod
```

The API will be available at `http://localhost:3000/api`

### API Endpoints

#### Authentication

**Login**

```bash
POST /api/auth
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "password123"
}

Response:
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

#### Users

**Register a new user**

```bash
POST /api/users
Content-Type: application/json

{
  "username": "johndoe",
  "email": "john@example.com",
  "password": "password123"
}
```

**Get all users (Protected)**

```bash
GET /api/users
Authorization: Bearer <token>
```

**Get user by ID (Protected)**

```bash
GET /api/users/{id}
Authorization: Bearer <token>
```

**Update user (Protected)**

```bash
PUT /api/users/{id}
Authorization: Bearer <token>
Content-Type: application/json

{
  "username": "johndoe",
  "email": "john@example.com",
  "password": "newpassword123"
}
```

**Delete user (Protected)**

```bash
DELETE /api/users/{id}
Authorization: Bearer <token>
```

#### Books

All book endpoints require authentication (Bearer token).

**Get all books**

```bash
GET /api/books
Authorization: Bearer <token>
```

**Get book by ID**

```bash
GET /api/books/{id}
Authorization: Bearer <token>
```

**Add a new book**

```bash
POST /api/books
Authorization: Bearer <token>
Content-Type: application/json

{
  "title": "The Great Gatsby",
  "author": "F. Scott Fitzgerald",
  "publishedYear": 1925
}
```

**Update a book**

```bash
PUT /api/books/{id}
Authorization: Bearer <token>
Content-Type: application/json

{
  "title": "The Great Gatsby",
  "author": "F. Scott Fitzgerald",
  "publishedYear": 1925
}
```

**Delete a book**

```bash
DELETE /api/books/{id}
Authorization: Bearer <token>
```

### Testing the API

**Step 1: Register a user**

```bash
curl -X POST http://localhost:3000/api/users \
  -H "Content-Type: application/json" \
  -d "{\"username\":\"testuser\",\"email\":\"test@example.com\",\"password\":\"password123\"}"
```

**Step 2: Login and get token**

```bash
curl -X POST http://localhost:3000/api/auth \
  -H "Content-Type: application/json" \
  -d "{\"email\":\"test@example.com\",\"password\":\"password123\"}"
```

**Step 3: Use the token to access protected endpoints**

```bash
curl -X POST http://localhost:3000/api/books \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -d "{\"title\":\"1984\",\"author\":\"George Orwell\",\"publishedYear\":1949}"
```

### Project Structure

```
src/
├── auth/                 # Authentication module
│   ├── dto/             # Data transfer objects
│   ├── guards/          # JWT auth guard
│   ├── strategies/      # JWT strategy
│   ├── auth.controller.ts
│   ├── auth.service.ts
│   └── auth.module.ts
├── books/               # Books module
│   ├── dto/            # Create/Update DTOs
│   ├── interfaces/     # Book interface
│   ├── books.controller.ts
│   ├── books.service.ts
│   └── books.module.ts
├── users/               # Users module
│   ├── dto/            # Create/Update DTOs
│   ├── interfaces/     # User interface
│   ├── users.controller.ts
│   ├── users.service.ts
│   └── users.module.ts
├── app.module.ts        # Root module
└── main.ts              # Application entry point
```

### Security Notes

⚠️ **Important**: This is a demo application. In production:

- Move JWT secret to environment variables
- Use a proper database instead of in-memory storage
- Add rate limiting
- Implement refresh tokens
- Add comprehensive error handling
- Use HTTPS only
- Implement proper CORS configuration

### Technologies Used

- NestJS - Progressive Node.js framework
- Passport JWT - JWT authentication
- bcrypt - Password hashing
- class-validator - DTO validation
- class-transformer - Object transformation
- uuid - UUID generation

### License

MIT

---

## 🇩🇪 Deutsche Version

Eine RESTful-API, die mit NestJS erstellt wurde, zur Verwaltung einer Buchbibliothek mit Benutzerauthentifizierung.

### Funktionen

- ✅ Vollständige CRUD-Operationen für Bücher
- ✅ Benutzerverwaltung und Registrierung
- ✅ JWT-basierte Authentifizierung
- ✅ Geschützte Endpunkte mit Bearer-Token
- ✅ Eingabevalidierung mit class-validator
- ✅ OpenAPI 3.0-konforme Endpunkte

### Installation

```bash
npm install
```

### Anwendung ausführen

```bash
# Entwicklungsmodus
npm run start:dev

# Produktionsmodus
npm run build
npm run start:prod
```

Die API ist verfügbar unter `http://localhost:3000/api`

### API-Endpunkte

#### Authentifizierung

**Anmelden**

```bash
POST /api/auth
Content-Type: application/json

{
  "email": "benutzer@beispiel.de",
  "password": "passwort123"
}

Antwort:
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

#### Benutzer

**Neuen Benutzer registrieren**

```bash
POST /api/users
Content-Type: application/json

{
  "username": "maxmustermann",
  "email": "max@beispiel.de",
  "password": "passwort123"
}
```

**Alle Benutzer abrufen (Geschützt)**

```bash
GET /api/users
Authorization: Bearer <token>
```

**Benutzer nach ID abrufen (Geschützt)**

```bash
GET /api/users/{id}
Authorization: Bearer <token>
```

**Benutzer aktualisieren (Geschützt)**

```bash
PUT /api/users/{id}
Authorization: Bearer <token>
Content-Type: application/json

{
  "username": "maxmustermann",
  "email": "max@beispiel.de",
  "password": "neuespasswort123"
}
```

**Benutzer löschen (Geschützt)**

```bash
DELETE /api/users/{id}
Authorization: Bearer <token>
```

#### Bücher

Alle Bücher-Endpunkte erfordern Authentifizierung (Bearer-Token).

**Alle Bücher abrufen**

```bash
GET /api/books
Authorization: Bearer <token>
```

**Buch nach ID abrufen**

```bash
GET /api/books/{id}
Authorization: Bearer <token>
```

**Neues Buch hinzufügen**

```bash
POST /api/books
Authorization: Bearer <token>
Content-Type: application/json

{
  "title": "Der große Gatsby",
  "author": "F. Scott Fitzgerald",
  "publishedYear": 1925
}
```

**Buch aktualisieren**

```bash
PUT /api/books/{id}
Authorization: Bearer <token>
Content-Type: application/json

{
  "title": "Der große Gatsby",
  "author": "F. Scott Fitzgerald",
  "publishedYear": 1925
}
```

**Buch löschen**

```bash
DELETE /api/books/{id}
Authorization: Bearer <token>
```

### API testen

**Schritt 1: Benutzer registrieren**

```bash
curl -X POST http://localhost:3000/api/users \
  -H "Content-Type: application/json" \
  -d "{\"username\":\"testbenutzer\",\"email\":\"test@beispiel.de\",\"password\":\"passwort123\"}"
```

**Schritt 2: Anmelden und Token erhalten**

```bash
curl -X POST http://localhost:3000/api/auth \
  -H "Content-Type: application/json" \
  -d "{\"email\":\"test@beispiel.de\",\"password\":\"passwort123\"}"
```

**Schritt 3: Token für geschützte Endpunkte verwenden**

```bash
curl -X POST http://localhost:3000/api/books \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer IHR_TOKEN_HIER" \
  -d "{\"title\":\"1984\",\"author\":\"George Orwell\",\"publishedYear\":1949}"
```

### Projektstruktur

```
src/
├── auth/                 # Authentifizierungsmodul
│   ├── dto/             # Datenübertragungsobjekte
│   ├── guards/          # JWT-Auth-Guard
│   ├── strategies/      # JWT-Strategie
│   ├── auth.controller.ts
│   ├── auth.service.ts
│   └── auth.module.ts
├── books/               # Büchermodul
│   ├── dto/            # Create/Update DTOs
│   ├── interfaces/     # Book-Interface
│   ├── books.controller.ts
│   ├── books.service.ts
│   └── books.module.ts
├── users/               # Benutzermodul
│   ├── dto/            # Create/Update DTOs
│   ├── interfaces/     # User-Interface
│   ├── users.controller.ts
│   ├── users.service.ts
│   └── users.module.ts
├── app.module.ts        # Root-Modul
└── main.ts              # Anwendungseinstiegspunkt
```

### Sicherheitshinweise

⚠️ **Wichtig**: Dies ist eine Demo-Anwendung. In der Produktion:

- JWT-Geheimschlüssel in Umgebungsvariablen verschieben
- Eine echte Datenbank anstelle von In-Memory-Speicher verwenden
- Rate-Limiting hinzufügen
- Refresh-Tokens implementieren
- Umfassende Fehlerbehandlung hinzufügen
- Nur HTTPS verwenden
- Ordnungsgemäße CORS-Konfiguration implementieren

### Verwendete Technologien

- NestJS - Progressives Node.js-Framework
- Passport JWT - JWT-Authentifizierung
- bcrypt - Passwort-Hashing
- class-validator - DTO-Validierung
- class-transformer - Objekt-Transformation
- uuid - UUID-Generierung

### Lizenz

MIT
