# Complete API Test Script for Book Library API | Vollstaendiges API-Test-Skript fuer Buch-Bibliotheks-API
# This script tests ALL endpoints in the API | Dieses Skript testet ALLE Endpunkte in der API

# Display script header | Skript-Kopfzeile anzeigen
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Complete API Endpoint Test Suite" -ForegroundColor Cyan
Write-Host "Vollstaendige API-Endpunkt-Testsuite" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Start the server in background | Server im Hintergrund starten
Write-Host "Starting NestJS server..." -ForegroundColor Yellow
# Create a background job that runs the server | Hintergrundjob erstellen, der den Server ausfuehrt
$job = Start-Job -ScriptBlock {
    # Set working directory to current location | Arbeitsverzeichnis auf aktuellen Speicherort setzen
    Set-Location $using:PWD
    # Run the NestJS development server | NestJS-Entwicklungsserver ausfuehren
    npm run start:dev
}

# Wait for server to initialize | Auf Server-Initialisierung warten
Write-Host "Waiting for server to start (10 seconds)..." -ForegroundColor Yellow
# Sleep 10 seconds for server startup | 10 Sekunden fuer Server-Start schlafen
Start-Sleep -Seconds 10
Write-Host "Server should be ready!" -ForegroundColor Green
Write-Host ""

# Set the base URL for all API requests | Basis-URL fuer alle API-Anfragen festlegen
$baseUrl = "http://localhost:3000/api"

# Initialize test counter variables | Test-Zaehler-Variablen initialisieren
$testsPassed = 0
$testsFailed = 0

# Function to display test results | Funktion zur Anzeige von Testergebnissen
function Show-TestResult {
    # Define function parameters | Funktionsparameter definieren
    param(
        # Test name parameter | Testname-Parameter
        [string]$TestName,
        # Success status parameter | Erfolgsstatus-Parameter
        [bool]$Success,
        # Optional details parameter | Optionaler Details-Parameter
        [string]$Details = ""
    )
    
    # Check if test was successful | Pruefen, ob Test erfolgreich war
    if ($Success) {
        # Increment passed counter | Bestandene-Zaehler erhoehen
        $script:testsPassed++
        # Display success message in green | Erfolgsmeldung in Gruen anzeigen
        Write-Host "PASS: $TestName" -ForegroundColor Green
        # Display details if provided | Details anzeigen, falls vorhanden
        if ($Details) { Write-Host "  $Details" -ForegroundColor Gray }
    } else {
        # Increment failed counter | Fehlgeschlagene-Zaehler erhoehen
        $script:testsFailed++
        # Display failure message in red | Fehlermeldung in Rot anzeigen
        Write-Host "FAIL: $TestName" -ForegroundColor Red
        # Display details if provided | Details anzeigen, falls vorhanden
        if ($Details) { Write-Host "  $Details" -ForegroundColor Gray }
    }
}

# Print section separator | Abschnittstrenner ausgeben
Write-Host ""
Write-Host "=== USER REGISTRATION TESTS ===" -ForegroundColor Yellow
Write-Host "=== BENUTZERREGISTRIERUNGSTESTS ===" -ForegroundColor Yellow
Write-Host ""

# Test 1: Create first user | Test 1: Ersten Benutzer erstellen
Write-Host "Test 1: POST /api/users (Create User 1)" -ForegroundColor Cyan
Write-Host "  Sending request to: $baseUrl/users" -ForegroundColor Gray
Write-Host "  Method: POST | Body: username=testuser1, email=test1@example.com" -ForegroundColor Gray
try {
    # Send POST request to create first user | POST-Anfrage zum Erstellen des ersten Benutzers senden
    $user1Response = Invoke-RestMethod -Uri "$baseUrl/users" -Method Post -ContentType "application/json" -Body '{"username":"testuser1","email":"test1@example.com","password":"password123"}'
    # Store user1 ID for later tests | Benutzer1-ID fuer spaetere Tests speichern
    $user1Id = $user1Response.id
    # Display test result as passed | Testergebnis als bestanden anzeigen
    Show-TestResult -TestName "Create User 1" -Success $true -Details "User: $($user1Response.username), Email: $($user1Response.email), ID: $user1Id"
} catch {
    # Display test result as failed | Testergebnis als fehlgeschlagen anzeigen
    Show-TestResult -TestName "Create User 1" -Success $false -Details $_.Exception.Message
    # Exit script if user creation fails | Skript beenden, wenn Benutzererstellung fehlschlaegt
    exit
}

# Test 2: Create second user | Test 2: Zweiten Benutzer erstellen
Write-Host "Test 2: POST /api/users (Create User 2)" -ForegroundColor Cyan
Write-Host "  Sending request to: $baseUrl/users" -ForegroundColor Gray
Write-Host "  Method: POST | Body: username=testuser2, email=test2@example.com" -ForegroundColor Gray
try {
    # Send POST request to create second user | POST-Anfrage zum Erstellen des zweiten Benutzers senden
    $user2Response = Invoke-RestMethod -Uri "$baseUrl/users" -Method Post -ContentType "application/json" -Body '{"username":"testuser2","email":"test2@example.com","password":"password456"}'
    # Store user2 ID for later tests | Benutzer2-ID fuer spaetere Tests speichern
    $user2Id = $user2Response.id
    # Display test result as passed | Testergebnis als bestanden anzeigen
    Show-TestResult -TestName "Create User 2" -Success $true -Details "User: $($user2Response.username), Email: $($user2Response.email), ID: $user2Id"
} catch {
    # Display test result as failed | Testergebnis als fehlgeschlagen anzeigen
    Show-TestResult -TestName "Create User 2" -Success $false -Details $_.Exception.Message
}

# Print section separator | Abschnittstrenner ausgeben
Write-Host ""
Write-Host "=== AUTHENTICATION TESTS ===" -ForegroundColor Yellow
Write-Host "=== AUTHENTIFIZIERUNGSTESTS ===" -ForegroundColor Yellow
Write-Host ""

# Test 3: Login with first user | Test 3: Mit erstem Benutzer anmelden
Write-Host "Test 3: POST /api/auth (Login User 1)" -ForegroundColor Cyan
Write-Host "  Sending request to: $baseUrl/auth" -ForegroundColor Gray
Write-Host "  Method: POST | Body: email=test1@example.com, password=password123" -ForegroundColor Gray
try {
    # Send POST request to authenticate user1 | POST-Anfrage zur Authentifizierung von Benutzer1 senden
    $authResponse = Invoke-RestMethod -Uri "$baseUrl/auth" -Method Post -ContentType "application/json" -Body '{"email":"test1@example.com","password":"password123"}'
    # Extract JWT token from response | JWT-Token aus Antwort extrahieren
    $token = $authResponse.token
    # Display test result as passed | Testergebnis als bestanden anzeigen
    Show-TestResult -TestName "Login User 1" -Success $true -Details "Token obtained"
    # Display the JWT token immediately | JWT-Token sofort anzeigen
    Write-Host ""
    Write-Host "JWT Token | JWT-Token:" -ForegroundColor Yellow
    Write-Host $token -ForegroundColor White
    Write-Host ""
} catch {
    # Display test result as failed | Testergebnis als fehlgeschlagen anzeigen
    Show-TestResult -TestName "Login User 1" -Success $false -Details $_.Exception.Message
    # Exit script if login fails | Skript beenden, wenn Anmeldung fehlschlaegt
    exit
}

# Create authorization header with JWT token | Autorisierungs-Header mit JWT-Token erstellen
Write-Host "Creating authorization header with JWT token..." -ForegroundColor Gray
$headers = @{ Authorization = "Bearer $token" }

# Print section separator | Abschnittstrenner ausgeben
Write-Host ""
Write-Host "=== USER RETRIEVAL TESTS ===" -ForegroundColor Yellow
Write-Host "=== BENUTZERABRUFTESTS ===" -ForegroundColor Yellow
Write-Host ""

# Test 4: Get all users | Test 4: Alle Benutzer abrufen
Write-Host "Test 4: GET /api/users (Get All Users)" -ForegroundColor Cyan
Write-Host "  Sending request to: $baseUrl/users" -ForegroundColor Gray
Write-Host "  Method: GET | Headers: Authorization=Bearer $token" -ForegroundColor Gray
try {
    # Send GET request to retrieve all users | GET-Anfrage zum Abrufen aller Benutzer senden
    $allUsers = Invoke-RestMethod -Uri "$baseUrl/users" -Method Get -Headers $headers
    # Display test result as passed | Testergebnis als bestanden anzeigen
    Show-TestResult -TestName "Get All Users" -Success $true -Details "Found $($allUsers.Count) user(s)"
} catch {
    # Display test result as failed | Testergebnis als fehlgeschlagen anzeigen
    Show-TestResult -TestName "Get All Users" -Success $false -Details $_.Exception.Message
}

# Test 5: Get user by ID | Test 5: Benutzer nach ID abrufen
Write-Host "Test 5: GET /api/users/:id (Get User 1 by ID)" -ForegroundColor Cyan
Write-Host "  Sending request to: $baseUrl/users/$user1Id" -ForegroundColor Gray
Write-Host "  Method: GET | Headers: Authorization=Bearer $token" -ForegroundColor Gray
try {
    # Send GET request to retrieve specific user | GET-Anfrage zum Abrufen eines bestimmten Benutzers senden
    $user1 = Invoke-RestMethod -Uri "$baseUrl/users/$user1Id" -Method Get -Headers $headers
    # Display test result as passed | Testergebnis als bestanden anzeigen
    Show-TestResult -TestName "Get User 1 by ID" -Success $true -Details "User: $($user1.username), Email: $($user1.email)"
} catch {
    # Display test result as failed | Testergebnis als fehlgeschlagen anzeigen
    Show-TestResult -TestName "Get User 1 by ID" -Success $false -Details $_.Exception.Message
}

# Print section separator | Abschnittstrenner ausgeben
Write-Host ""
Write-Host "=== USER UPDATE TESTS ===" -ForegroundColor Yellow
Write-Host "=== BENUTZERAKTUALISIERUNGSTESTS ===" -ForegroundColor Yellow
Write-Host ""

# Test 6: Update user | Test 6: Benutzer aktualisieren
Write-Host "Test 6: PUT /api/users/:id (Update User 1)" -ForegroundColor Cyan
Write-Host "  Sending request to: $baseUrl/users/$user1Id" -ForegroundColor Gray
Write-Host "  Method: PUT | Body: username=testuser1_updated, email=test1@example.com" -ForegroundColor Gray
try {
    # Send PUT request to update user with all required fields | PUT-Anfrage zum Aktualisieren des Benutzers mit allen erforderlichen Feldern senden
    $updatedUser = Invoke-RestMethod -Uri "$baseUrl/users/$user1Id" -Method Put -ContentType "application/json" -Headers $headers -Body '{"username":"testuser1_updated","email":"test1@example.com","password":"newpassword123"}'
    # Display test result as passed | Testergebnis als bestanden anzeigen
    Show-TestResult -TestName "Update User 1" -Success $true -Details "New username: $($updatedUser.username)"
} catch {
    # Display test result as failed | Testergebnis als fehlgeschlagen anzeigen
    Show-TestResult -TestName "Update User 1" -Success $false -Details $_.Exception.Message
}

# Print section separator | Abschnittstrenner ausgeben
Write-Host ""
Write-Host "=== BOOK CREATION TESTS ===" -ForegroundColor Yellow
Write-Host "=== BUCHERSTELLUNGSTESTS ===" -ForegroundColor Yellow
Write-Host ""

# Test 7: Create first book | Test 7: Erstes Buch erstellen
Write-Host "Test 7: POST /api/books (Create Book 1)" -ForegroundColor Cyan
Write-Host "  Sending request to: $baseUrl/books" -ForegroundColor Gray
Write-Host "  Method: POST | Body: title=1984, author=George Orwell, year=1949" -ForegroundColor Gray
try {
    # Send POST request to create first book | POST-Anfrage zum Erstellen des ersten Buches senden
    $book1Response = Invoke-RestMethod -Uri "$baseUrl/books" -Method Post -ContentType "application/json" -Headers $headers -Body '{"title":"1984","author":"George Orwell","publishedYear":1949}'
    # Store book1 ID for later tests | Buch1-ID fuer spaetere Tests speichern
    $book1Id = $book1Response.id
    # Display test result as passed | Testergebnis als bestanden anzeigen
    Show-TestResult -TestName "Create Book 1" -Success $true -Details "Book: $($book1Response.title) by $($book1Response.author) ($($book1Response.publishedYear)), ID: $book1Id"
} catch {
    # Display test result as failed | Testergebnis als fehlgeschlagen anzeigen
    Show-TestResult -TestName "Create Book 1" -Success $false -Details $_.Exception.Message
}

# Test 8: Create second book | Test 8: Zweites Buch erstellen
Write-Host "Test 8: POST /api/books (Create Book 2)" -ForegroundColor Cyan
Write-Host "  Sending request to: $baseUrl/books" -ForegroundColor Gray
Write-Host "  Method: POST | Body: title=To Kill a Mockingbird, author=Harper Lee, year=1960" -ForegroundColor Gray
try {
    # Send POST request to create second book | POST-Anfrage zum Erstellen des zweiten Buches senden
    $book2Response = Invoke-RestMethod -Uri "$baseUrl/books" -Method Post -ContentType "application/json" -Headers $headers -Body '{"title":"To Kill a Mockingbird","author":"Harper Lee","publishedYear":1960}'
    # Store book2 ID for later tests | Buch2-ID fuer spaetere Tests speichern
    $book2Id = $book2Response.id
    # Display test result as passed | Testergebnis als bestanden anzeigen
    Show-TestResult -TestName "Create Book 2" -Success $true -Details "Book: $($book2Response.title) by $($book2Response.author) ($($book2Response.publishedYear)), ID: $book2Id"
} catch {
    # Display test result as failed | Testergebnis als fehlgeschlagen anzeigen
    Show-TestResult -TestName "Create Book 2" -Success $false -Details $_.Exception.Message
}

# Test 9: Create third book | Test 9: Drittes Buch erstellen
Write-Host "Test 9: POST /api/books (Create Book 3)" -ForegroundColor Cyan
Write-Host "  Sending request to: $baseUrl/books" -ForegroundColor Gray
Write-Host "  Method: POST | Body: title=The Great Gatsby, author=F. Scott Fitzgerald, year=1925" -ForegroundColor Gray
try {
    # Send POST request to create third book | POST-Anfrage zum Erstellen des dritten Buches senden
    $book3Response = Invoke-RestMethod -Uri "$baseUrl/books" -Method Post -ContentType "application/json" -Headers $headers -Body '{"title":"The Great Gatsby","author":"F. Scott Fitzgerald","publishedYear":1925}'
    # Store book3 ID for later tests | Buch3-ID fuer spaetere Tests speichern
    $book3Id = $book3Response.id
    # Display test result as passed | Testergebnis als bestanden anzeigen
    Show-TestResult -TestName "Create Book 3" -Success $true -Details "Book: $($book3Response.title) by $($book3Response.author) ($($book3Response.publishedYear)), ID: $book3Id"
} catch {
    # Display test result as failed | Testergebnis als fehlgeschlagen anzeigen
    Show-TestResult -TestName "Create Book 3" -Success $false -Details $_.Exception.Message
}

# Print section separator | Abschnittstrenner ausgeben
Write-Host ""
Write-Host "=== BOOK RETRIEVAL TESTS ===" -ForegroundColor Yellow
Write-Host "=== BUCHABRUFTESTS ===" -ForegroundColor Yellow
Write-Host ""

# Test 10: Get all books | Test 10: Alle Buecher abrufen
Write-Host "Test 10: GET /api/books (Get All Books)" -ForegroundColor Cyan
Write-Host "  Sending request to: $baseUrl/books" -ForegroundColor Gray
Write-Host "  Method: GET | Headers: Authorization=Bearer $token" -ForegroundColor Gray
try {
    # Send GET request to retrieve all books | GET-Anfrage zum Abrufen aller Buecher senden
    $allBooks = Invoke-RestMethod -Uri "$baseUrl/books" -Method Get -Headers $headers
    # Display test result as passed | Testergebnis als bestanden anzeigen
    Show-TestResult -TestName "Get All Books" -Success $true -Details "Found $($allBooks.Count) book(s)"
    # Loop through each book to display details | Durch jedes Buch iterieren, um Details anzuzeigen
    foreach ($book in $allBooks) {
        # Display individual book information | Einzelne Buchinformationen anzeigen
        Write-Host "  - $($book.title) by $($book.author) ($($book.publishedYear))" -ForegroundColor Gray
    }
} catch {
    # Display test result as failed | Testergebnis als fehlgeschlagen anzeigen
    Show-TestResult -TestName "Get All Books" -Success $false -Details $_.Exception.Message
}

# Test 11: Get book by ID | Test 11: Buch nach ID abrufen
Write-Host "Test 11: GET /api/books/:id (Get Book 1 by ID)" -ForegroundColor Cyan
Write-Host "  Sending request to: $baseUrl/books/$book1Id" -ForegroundColor Gray
Write-Host "  Method: GET | Headers: Authorization=Bearer $token" -ForegroundColor Gray
try {
    # Send GET request to retrieve specific book | GET-Anfrage zum Abrufen eines bestimmten Buches senden
    $book1 = Invoke-RestMethod -Uri "$baseUrl/books/$book1Id" -Method Get -Headers $headers
    # Display test result as passed | Testergebnis als bestanden anzeigen
    Show-TestResult -TestName "Get Book 1 by ID" -Success $true -Details "Book: $($book1.title) by $($book1.author) ($($book1.publishedYear))"
} catch {
    # Display test result as failed | Testergebnis als fehlgeschlagen anzeigen
    Show-TestResult -TestName "Get Book 1 by ID" -Success $false -Details $_.Exception.Message
}

# Print section separator | Abschnittstrenner ausgeben
Write-Host ""
Write-Host "=== BOOK UPDATE TESTS ===" -ForegroundColor Yellow
Write-Host "=== BUCHAKTUALISIERUNGSTESTS ===" -ForegroundColor Yellow
Write-Host ""

# Test 12: Update book | Test 12: Buch aktualisieren
Write-Host "Test 12: PUT /api/books/:id (Update Book 2)" -ForegroundColor Cyan
Write-Host "  Sending request to: $baseUrl/books/$book2Id" -ForegroundColor Gray
Write-Host "  Method: PUT | Body: title=To Kill a Mockingbird - Special Edition, year=1961" -ForegroundColor Gray
try {
    # Send PUT request to update book with all required fields | PUT-Anfrage zum Aktualisieren des Buches mit allen erforderlichen Feldern senden
    $updatedBook = Invoke-RestMethod -Uri "$baseUrl/books/$book2Id" -Method Put -ContentType "application/json" -Headers $headers -Body '{"title":"To Kill a Mockingbird - Special Edition","author":"Harper Lee","publishedYear":1961}'
    # Display test result as passed | Testergebnis als bestanden anzeigen
    Show-TestResult -TestName "Update Book 2" -Success $true -Details "New title: $($updatedBook.title), Year: $($updatedBook.publishedYear)"
} catch {
    # Display test result as failed | Testergebnis als fehlgeschlagen anzeigen
    Show-TestResult -TestName "Update Book 2" -Success $false -Details $_.Exception.Message
}

# Print section separator | Abschnittstrenner ausgeben
Write-Host ""
Write-Host "=== BOOK DELETION TESTS ===" -ForegroundColor Yellow
Write-Host "=== BUCHLOESCHTESTS ===" -ForegroundColor Yellow
Write-Host ""

# Test 13: Delete a book | Test 13: Ein Buch loeschen
Write-Host "Test 13: DELETE /api/books/:id (Delete Book 3)" -ForegroundColor Cyan
Write-Host "  Sending request to: $baseUrl/books/$book3Id" -ForegroundColor Gray
Write-Host "  Method: DELETE | Headers: Authorization=Bearer $token" -ForegroundColor Gray
try {
    # Send DELETE request to remove book | DELETE-Anfrage zum Entfernen des Buches senden
    Invoke-RestMethod -Uri "$baseUrl/books/$book3Id" -Method Delete -Headers $headers
    # Display test result as passed | Testergebnis als bestanden anzeigen
    Show-TestResult -TestName "Delete Book 3" -Success $true -Details "Book with ID $book3Id deleted"
} catch {
    # Display test result as failed | Testergebnis als fehlgeschlagen anzeigen
    Show-TestResult -TestName "Delete Book 3" -Success $false -Details $_.Exception.Message
}

# Test 14: Verify book was deleted | Test 14: Ueberpruefen, dass Buch geloescht wurde
Write-Host "Test 14: GET /api/books (Verify Book 3 Deleted)" -ForegroundColor Cyan
Write-Host "  Verifying deletion by fetching all books..." -ForegroundColor Gray
try {
    # Send GET request to retrieve all books | GET-Anfrage zum Abrufen aller Buecher senden
    $booksAfterDelete = Invoke-RestMethod -Uri "$baseUrl/books" -Method Get -Headers $headers
    # Check if book count decreased | Pruefen, ob Buchanzahl abgenommen hat
    $deletionVerified = $booksAfterDelete.Count -eq ($allBooks.Count - 1)
    # Display test result | Testergebnis anzeigen
    Show-TestResult -TestName "Verify Book 3 Deleted" -Success $deletionVerified -Details "Books remaining: $($booksAfterDelete.Count)"
} catch {
    # Display test result as failed | Testergebnis als fehlgeschlagen anzeigen
    Show-TestResult -TestName "Verify Book 3 Deleted" -Success $false -Details $_.Exception.Message
}

# Print section separator | Abschnittstrenner ausgeben
Write-Host ""
Write-Host "=== USER DELETION TESTS ===" -ForegroundColor Yellow
Write-Host "=== BENUTZERLOESCHTESTS ===" -ForegroundColor Yellow
Write-Host ""

# Test 15: Delete a user | Test 15: Einen Benutzer loeschen
Write-Host "Test 15: DELETE /api/users/:id (Delete User 2)" -ForegroundColor Cyan
Write-Host "  Sending request to: $baseUrl/users/$user2Id" -ForegroundColor Gray
Write-Host "  Method: DELETE | Headers: Authorization=Bearer $token" -ForegroundColor Gray
try {
    # Send DELETE request to remove user | DELETE-Anfrage zum Entfernen des Benutzers senden
    Invoke-RestMethod -Uri "$baseUrl/users/$user2Id" -Method Delete -Headers $headers
    # Display test result as passed | Testergebnis als bestanden anzeigen
    Show-TestResult -TestName "Delete User 2" -Success $true -Details "User with ID $user2Id deleted"
} catch {
    # Display test result as failed | Testergebnis als fehlgeschlagen anzeigen
    Show-TestResult -TestName "Delete User 2" -Success $false -Details $_.Exception.Message
}

# Test 16: Verify user was deleted | Test 16: Ueberpruefen, dass Benutzer geloescht wurde
Write-Host "Test 16: GET /api/users (Verify User 2 Deleted)" -ForegroundColor Cyan
Write-Host "  Verifying deletion by fetching all users..." -ForegroundColor Gray
try {
    # Send GET request to retrieve all users | GET-Anfrage zum Abrufen aller Benutzer senden
    $usersAfterDelete = Invoke-RestMethod -Uri "$baseUrl/users" -Method Get -Headers $headers
    # Check if user count decreased | Pruefen, ob Benutzeranzahl abgenommen hat
    $userDeletionVerified = $usersAfterDelete.Count -eq ($allUsers.Count - 1)
    # Display test result | Testergebnis anzeigen
    Show-TestResult -TestName "Verify User 2 Deleted" -Success $userDeletionVerified -Details "Users remaining: $($usersAfterDelete.Count)"
} catch {
    # Display test result as failed | Testergebnis als fehlgeschlagen anzeigen
    Show-TestResult -TestName "Verify User 2 Deleted" -Success $false -Details $_.Exception.Message
}

# Print final summary | Abschliessende Zusammenfassung ausgeben
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "TEST SUMMARY | TESTZUSAMMENFASSUNG" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
# Calculate total tests | Gesamtanzahl der Tests berechnen
$totalTests = $testsPassed + $testsFailed
# Display total tests count | Gesamttestanzahl anzeigen
Write-Host "Total Tests | Gesamt: $totalTests" -ForegroundColor White
# Display passed tests count in green | Anzahl bestandener Tests in Gruen anzeigen
Write-Host "Passed | Bestanden: $testsPassed" -ForegroundColor Green
# Display failed tests count in red | Anzahl fehlgeschlagener Tests in Rot anzeigen
Write-Host "Failed | Fehlgeschlagen: $testsFailed" -ForegroundColor Red
# Calculate success rate | Erfolgsrate berechnen
$successRate = if ($totalTests -gt 0) { [math]::Round(($testsPassed / $totalTests) * 100, 2) } else { 0 }
# Display success rate | Erfolgsrate anzeigen
Write-Host "Success Rate | Erfolgsrate: $successRate%" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
# Determine exit code based on test results | Exitcode basierend auf Testergebnissen bestimmen
if ($testsFailed -eq 0) {
    # All tests passed | Alle Tests bestanden
    Write-Host "All tests passed! | Alle Tests bestanden!" -ForegroundColor Green
} else {
    # Some tests failed | Einige Tests fehlgeschlagen
    Write-Host "Some tests failed. | Einige Tests sind fehlgeschlagen." -ForegroundColor Red
}

# Clean up server job | Server-Job aufraeumen
Write-Host ""
Write-Host "Stopping server..." -ForegroundColor Yellow
# Stop the background server job | Hintergrund-Serverjob stoppen
Stop-Job -Job $job
# Remove the job from memory | Job aus Speicher entfernen
Remove-Job -Job $job
# Display server stopped message | Server-Stopp-Nachricht anzeigen
Write-Host "Server stopped." -ForegroundColor Green

# Exit with appropriate code | Mit entsprechendem Code beenden
if ($testsFailed -eq 0) {
    # Exit with success code | Mit Erfolgscode beenden
    exit 0
} else {
    # Exit with error code | Mit Fehlercode beenden
    exit 1
}
