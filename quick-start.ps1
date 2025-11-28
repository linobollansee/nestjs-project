# Quick Start Script for Book Library API | Schnellstart-Skript für Buch-Bibliotheks-API
# This script starts the server and provides quick test commands | Dieses Skript startet den Server und bietet schnelle Testbefehle

# Display startup message in green | Startnachricht in Grün anzeigen
Write-Host "Starting NestJS Book Library API..." -ForegroundColor Green
# Display server URL in cyan | Server-URL in Cyan anzeigen
Write-Host "Server will be available at: http://localhost:3000/api" -ForegroundColor Cyan
# Print empty line for spacing | Leere Zeile zur Abstandsgestaltung ausgeben
Write-Host ""

# Start the server in background | Server im Hintergrund starten
# Create a background job that runs the server | Hintergrundjob erstellen, der den Server ausführt
$job = Start-Job -ScriptBlock {
    # Set working directory to current location | Arbeitsverzeichnis auf aktuellen Speicherort setzen
    Set-Location $using:PWD
    # Run the NestJS development server | NestJS-Entwicklungsserver ausführen
    npm run start:dev
}

# Display waiting message | Wartenachricht anzeigen
Write-Host "Waiting for server to start..." -ForegroundColor Yellow
# Wait 10 seconds for server initialization | 10 Sekunden auf Server-Initialisierung warten
Start-Sleep -Seconds 10

# Print empty line | Leere Zeile ausgeben
Write-Host ""
# Display test section header | Test-Abschnittsüberschrift anzeigen
Write-Host "=== Quick Test Commands ===" -ForegroundColor Green
# Print empty line | Leere Zeile ausgeben
Write-Host ""

# Test 1: Register User | Test 1: Benutzer registrieren
# Display test 1 message | Test 1 Nachricht anzeigen
Write-Host "1. Registering test user..." -ForegroundColor Cyan
# Begin error handling block | Fehlerbehandlungsblock beginnen
try {
    # Send POST request to create user | POST-Anfrage zum Erstellen eines Benutzers senden
    $userResponse = Invoke-RestMethod -Uri "http://localhost:3000/api/users" -Method Post -ContentType "application/json" -Body '{"username":"testuser","email":"test@example.com","password":"password123"}'
    # Extract user ID from response | Benutzer-ID aus Antwort extrahieren
    $userId = $userResponse.id
    # Display success message with user details | Erfolgsmeldung mit Benutzerdetails anzeigen
    Write-Host "   User created: $($userResponse.username) - $($userResponse.email)" -ForegroundColor Green
# Handle errors if user creation fails | Fehler behandeln, wenn Benutzererstellung fehlschlägt
} catch {
    # Display warning that user may already exist | Warnung anzeigen, dass Benutzer bereits existieren könnte
    Write-Host "   Failed to create user - may already exist" -ForegroundColor Yellow
}

# Print empty line | Leere Zeile ausgeben
Write-Host ""

# Test 2: Login | Test 2: Anmeldung
# Display test 2 message | Test 2 Nachricht anzeigen
Write-Host "2. Logging in..." -ForegroundColor Cyan
# Begin error handling block | Fehlerbehandlungsblock beginnen
try {
    # Send POST request to authenticate user | POST-Anfrage zur Benutzerauthentifizierung senden
    $authResponse = Invoke-RestMethod -Uri "http://localhost:3000/api/auth" -Method Post -ContentType "application/json" -Body '{"email":"test@example.com","password":"password123"}'
    # Extract JWT token from response | JWT-Token aus Antwort extrahieren
    $token = $authResponse.token
    # Display success message | Erfolgsmeldung anzeigen
    Write-Host "   Login successful! Token obtained." -ForegroundColor Green
# Handle login failure | Anmeldefehler behandeln
} catch {
    # Display error message | Fehlermeldung anzeigen
    Write-Host "   Login failed" -ForegroundColor Red
    # Stop the background server job | Hintergrund-Serverjob stoppen
    Stop-Job -Job $job
    # Remove the job from memory | Job aus Speicher entfernen
    Remove-Job -Job $job
    # Exit the script | Skript beenden
    exit
}

# Print empty line | Leere Zeile ausgeben
Write-Host ""

# Test 3: Create Book | Test 3: Buch erstellen
# Display test 3 message | Test 3 Nachricht anzeigen
Write-Host "3. Creating a book..." -ForegroundColor Cyan
# Begin error handling block | Fehlerbehandlungsblock beginnen
try {
    # Create authorization header with JWT token | Autorisierungs-Header mit JWT-Token erstellen
    $headers = @{ Authorization = "Bearer $token" }
    # Send POST request to create book with authentication | POST-Anfrage zum Erstellen eines Buches mit Authentifizierung senden
    $bookResponse = Invoke-RestMethod -Uri "http://localhost:3000/api/books" -Method Post -ContentType "application/json" -Headers $headers -Body '{"title":"1984","author":"George Orwell","publishedYear":1949}'
    # Extract book ID from response | Buch-ID aus Antwort extrahieren
    $bookId = $bookResponse.id
    # Display success message with book details | Erfolgsmeldung mit Buchdetails anzeigen
    Write-Host "   Book created: $($bookResponse.title) by $($bookResponse.author)" -ForegroundColor Green
# Handle book creation failure | Fehler bei Bucherstellung behandeln
} catch {
    # Display error message | Fehlermeldung anzeigen
    Write-Host "   Failed to create book" -ForegroundColor Red
}

# Print empty line | Leere Zeile ausgeben
Write-Host ""

# Test 4: Get All Books | Test 4: Alle Bücher abrufen
# Display test 4 message | Test 4 Nachricht anzeigen
Write-Host "4. Retrieving all books..." -ForegroundColor Cyan
# Begin error handling block | Fehlerbehandlungsblock beginnen
try {
    # Send GET request to retrieve all books | GET-Anfrage zum Abrufen aller Bücher senden
    $books = Invoke-RestMethod -Uri "http://localhost:3000/api/books" -Method Get -Headers $headers
    # Display count of books found | Anzahl gefundener Bücher anzeigen
    Write-Host "   Found $($books.Count) book(s)" -ForegroundColor Green
    # Loop through each book | Durch jedes Buch iterieren
    foreach ($book in $books) {
        # Display book details | Buchdetails anzeigen
        Write-Host "     - $($book.title) by $($book.author) - Year: $($book.publishedYear)" -ForegroundColor White
    }
# Handle retrieval failure | Abruffehler behandeln
} catch {
    # Display error message | Fehlermeldung anzeigen
    Write-Host "   Failed to get books" -ForegroundColor Red
}

# Print empty line | Leere Zeile ausgeben
Write-Host ""
# Display API running confirmation | API-Lauf-Bestätigung anzeigen
Write-Host "=== API is running! ===" -ForegroundColor Green
# Print empty line | Leere Zeile ausgeben
Write-Host ""
# Display token section header | Token-Abschnittsüberschrift anzeigen
Write-Host "Your JWT Token:" -ForegroundColor Yellow
# Display the actual JWT token | Tatsächlichen JWT-Token anzeigen
Write-Host $token -ForegroundColor White
# Print empty line | Leere Zeile ausgeben
Write-Host ""
# Display testing instructions header | Testanweisungsüberschrift anzeigen
Write-Host "Test the API using:" -ForegroundColor Cyan
# Display README reference | README-Referenz anzeigen
Write-Host "  - README.md for detailed documentation"
# Display API testing reference | API-Test-Referenz anzeigen
Write-Host "  - API_TESTING.md for curl and PowerShell examples"
# Print empty line | Leere Zeile ausgeben
Write-Host ""
# Display stop instructions | Stopp-Anweisungen anzeigen
Write-Host "Press Ctrl+C to stop the server..." -ForegroundColor Yellow

# Keep the script running | Skript am Laufen halten
# Begin error handling block for script termination | Fehlerbehandlungsblock für Skript-Beendigung beginnen
try {
    # Infinite loop to keep script alive | Endlosschleife, um Skript aktiv zu halten
    while ($true) {
        # Sleep for 1 second to reduce CPU usage | 1 Sekunde schlafen, um CPU-Nutzung zu reduzieren
        Start-Sleep -Seconds 1
    }
# Cleanup actions when script is terminated | Aufräumaktionen bei Skript-Beendigung
} finally {
    # Stop the background server job | Hintergrund-Serverjob stoppen
    Stop-Job -Job $job
    # Remove the job from memory | Job aus Speicher entfernen
    Remove-Job -Job $job
    # Display server stopped message | Server-Stopp-Nachricht anzeigen
    Write-Host "Server stopped." -ForegroundColor Red
}
