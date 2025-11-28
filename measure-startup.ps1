# Startup Performance Measurement Script | Startleistungsmessungs-Skript
# This script measures the time taken by each phase of server startup | Dieses Skript misst die Zeit jeder Phase des Server-Starts

# Display script header | Skript-Kopfzeile anzeigen
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "NestJS Startup Performance Analysis" -ForegroundColor Cyan
Write-Host "NestJS-Startleistungsanalyse" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Initialize timing variables | Zeitvariablen initialisieren
$timings = @{}

# Phase 1: Measure TypeScript Compilation | Phase 1: TypeScript-Kompilierung messen
Write-Host "Phase 1: TypeScript Compilation | TypeScript-Kompilierung" -ForegroundColor Yellow
Write-Host "  Running: npm run build..." -ForegroundColor Gray
$compileStart = Get-Date
npm run build | Out-Null
$compileEnd = Get-Date
$compileTime = ($compileEnd - $compileStart).TotalMilliseconds
$timings['TypeScript Compilation'] = $compileTime
Write-Host "  Completed in: $([math]::Round($compileTime, 2))ms" -ForegroundColor Green
Write-Host ""

# Phase 2: Measure Node.js Process Startup | Phase 2: Node.js-Prozessstart messen
Write-Host "Phase 2: Node.js Process Startup | Node.js-Prozessstart" -ForegroundColor Yellow
Write-Host "  Starting Node.js process..." -ForegroundColor Gray
$nodeStart = Get-Date
# Start server in background | Server im Hintergrund starten
$job = Start-Job -ScriptBlock {
    # Set working directory | Arbeitsverzeichnis setzen
    Set-Location $using:PWD
    # Run compiled application | Kompilierte Anwendung ausfuehren
    node dist/main.js
}
# Wait for job to start | Auf Job-Start warten
Start-Sleep -Milliseconds 100
$nodeEnd = Get-Date
$nodeStartupTime = ($nodeEnd - $nodeStart).TotalMilliseconds
$timings['Node.js Process Launch'] = $nodeStartupTime
Write-Host "  Process launched in: $([math]::Round($nodeStartupTime, 2))ms" -ForegroundColor Green
Write-Host ""

# Phase 3: Measure NestJS Module Initialization | Phase 3: NestJS-Modul-Initialisierung messen
Write-Host "Phase 3: NestJS Application Initialization | NestJS-Anwendungsinitialisierung" -ForegroundColor Yellow
Write-Host "  Waiting for modules to initialize..." -ForegroundColor Gray
$initStart = Get-Date
# Wait for server to be ready | Auf serverbereiten warten
Start-Sleep -Milliseconds 500
# Try to connect to server | Versuchen, eine Verbindung zum Server herzustellen
$maxAttempts = 50
$attempt = 0
$serverReady = $false
while ($attempt -lt $maxAttempts -and -not $serverReady) {
    try {
        # Attempt health check | Gesundheitspruefung versuchen
        $null = Invoke-WebRequest -Uri "http://localhost:3000/api/users" -Method Get -TimeoutSec 1 -ErrorAction Stop
        # Server responded | Server hat geantwortet
        $serverReady = $true
    } catch {
        # Server not ready yet | Server noch nicht bereit
        Start-Sleep -Milliseconds 50
        $attempt++
    }
}
$initEnd = Get-Date
$initTime = ($initEnd - $initStart).TotalMilliseconds
$timings['NestJS Initialization'] = $initTime
Write-Host "  Server ready in: $([math]::Round($initTime, 2))ms" -ForegroundColor Green
Write-Host ""

# Phase 4: Measure First Request Response Time | Phase 4: Erste Anfrage-Antwortzeit messen
Write-Host "Phase 4: First HTTP Request | Erste HTTP-Anfrage" -ForegroundColor Yellow
Write-Host "  Sending test request..." -ForegroundColor Gray
$requestStart = Get-Date
try {
    # Send test request to create user | Testanfrage zum Erstellen eines Benutzers senden
    $response = Invoke-RestMethod -Uri "http://localhost:3000/api/users" -Method Post -ContentType "application/json" -Body '{"username":"perftest","email":"perf@test.com","password":"test123"}' -ErrorAction Stop
    $requestEnd = Get-Date
    $requestTime = ($requestEnd - $requestStart).TotalMilliseconds
    $timings['First Request Response'] = $requestTime
    Write-Host "  Request completed in: $([math]::Round($requestTime, 2))ms" -ForegroundColor Green
} catch {
    # Request failed | Anfrage fehlgeschlagen
    $requestEnd = Get-Date
    $requestTime = ($requestEnd - $requestStart).TotalMilliseconds
    $timings['First Request Response'] = $requestTime
    Write-Host "  Request completed in: $([math]::Round($requestTime, 2))ms (may have failed)" -ForegroundColor Yellow
}
Write-Host ""

# Phase 5: Measure Subsequent Request (Warmed Up) | Phase 5: Nachfolgende Anfrage messen (aufgewaermt)
Write-Host "Phase 5: Subsequent Request (Warm) | Nachfolgende Anfrage (Warm)" -ForegroundColor Yellow
Write-Host "  Sending second test request..." -ForegroundColor Gray
$warmRequestStart = Get-Date
try {
    # Send authentication request | Authentifizierungsanfrage senden
    $authResponse = Invoke-RestMethod -Uri "http://localhost:3000/api/auth" -Method Post -ContentType "application/json" -Body '{"email":"perf@test.com","password":"test123"}' -ErrorAction Stop
    $warmRequestEnd = Get-Date
    $warmRequestTime = ($warmRequestEnd - $warmRequestStart).TotalMilliseconds
    $timings['Warm Request Response'] = $warmRequestTime
    Write-Host "  Request completed in: $([math]::Round($warmRequestTime, 2))ms" -ForegroundColor Green
} catch {
    # Request failed | Anfrage fehlgeschlagen
    $warmRequestEnd = Get-Date
    $warmRequestTime = ($warmRequestEnd - $warmRequestStart).TotalMilliseconds
    $timings['Warm Request Response'] = $warmRequestTime
    Write-Host "  Request completed in: $([math]::Round($warmRequestTime, 2))ms (may have failed)" -ForegroundColor Yellow
}
Write-Host ""

# Stop the server | Server stoppen
Write-Host "Stopping server..." -ForegroundColor Yellow
Stop-Job -Job $job
Remove-Job -Job $job
Write-Host "Server stopped." -ForegroundColor Green
Write-Host ""

# Calculate total time | Gesamtzeit berechnen
$totalTime = $compileTime + $nodeStartupTime + $initTime

# Display performance summary | Leistungszusammenfassung anzeigen
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "PERFORMANCE SUMMARY | LEISTUNGSZUSAMMENFASSUNG" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Display each phase with percentage | Jede Phase mit Prozentsatz anzeigen
foreach ($phase in $timings.Keys | Sort-Object { $timings[$_] } -Descending) {
    # Get timing value | Zeitwert abrufen
    $time = $timings[$phase]
    # Calculate percentage of total startup | Prozentsatz der Gesamtstartzeit berechnen
    $percentage = if ($totalTime -gt 0) { ($time / $totalTime) * 100 } else { 0 }
    # Format the output | Ausgabe formatieren
    $timeStr = "$([math]::Round($time, 2))ms".PadRight(12)
    $percentStr = "($([math]::Round($percentage, 1))%)".PadRight(8)
    # Display phase timing | Phasen-Timing anzeigen
    Write-Host "  $phase : " -NoNewline -ForegroundColor White
    Write-Host "$timeStr $percentStr" -ForegroundColor Cyan
}

Write-Host ""
Write-Host "----------------------------------------" -ForegroundColor Cyan
# Display total startup time | Gesamtstartzeit anzeigen
Write-Host "  Total Startup Time | Gesamtstartzeit: " -NoNewline -ForegroundColor White
Write-Host "$([math]::Round($totalTime, 2))ms" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Provide recommendation | Empfehlung geben
Write-Host "RECOMMENDATION | EMPFEHLUNG:" -ForegroundColor Yellow
# Calculate recommended wait time | Empfohlene Wartezeit berechnen
$recommendedWait = [math]::Ceiling($totalTime / 1000 * 1.5)
Write-Host "  Recommended wait time in scripts: $recommendedWait seconds" -ForegroundColor White
Write-Host "  Empfohlene Wartezeit in Skripten: $recommendedWait Sekunden" -ForegroundColor White
Write-Host "  (Includes 50% safety margin | Beinhaltet 50% Sicherheitsmarge)" -ForegroundColor Gray
Write-Host ""
