# Quick Start Script for Book Library API
# This script starts the server and provides quick test commands

Write-Host "Starting NestJS Book Library API..." -ForegroundColor Green
Write-Host "Server will be available at: http://localhost:3000/api" -ForegroundColor Cyan
Write-Host ""

# Start the server in background
$job = Start-Job -ScriptBlock {
    Set-Location $using:PWD
    npm run start:dev
}

Write-Host "Waiting for server to start..." -ForegroundColor Yellow
Start-Sleep -Seconds 10

Write-Host ""
Write-Host "=== Quick Test Commands ===" -ForegroundColor Green
Write-Host ""

# Test 1: Register User
Write-Host "1. Registering test user..." -ForegroundColor Cyan
try {
    $userResponse = Invoke-RestMethod -Uri "http://localhost:3000/api/users" -Method Post -ContentType "application/json" -Body '{"username":"testuser","email":"test@example.com","password":"password123"}'
    $userId = $userResponse.id
    Write-Host "   User created: $($userResponse.username) - $($userResponse.email)" -ForegroundColor Green
} catch {
    Write-Host "   Failed to create user - may already exist" -ForegroundColor Yellow
}

Write-Host ""

# Test 2: Login
Write-Host "2. Logging in..." -ForegroundColor Cyan
try {
    $authResponse = Invoke-RestMethod -Uri "http://localhost:3000/api/auth" -Method Post -ContentType "application/json" -Body '{"email":"test@example.com","password":"password123"}'
    $token = $authResponse.token
    Write-Host "   Login successful! Token obtained." -ForegroundColor Green
} catch {
    Write-Host "   Login failed" -ForegroundColor Red
    Stop-Job -Job $job
    Remove-Job -Job $job
    exit
}

Write-Host ""

# Test 3: Create Book
Write-Host "3. Creating a book..." -ForegroundColor Cyan
try {
    $headers = @{ Authorization = "Bearer $token" }
    $bookResponse = Invoke-RestMethod -Uri "http://localhost:3000/api/books" -Method Post -ContentType "application/json" -Headers $headers -Body '{"title":"1984","author":"George Orwell","publishedYear":1949}'
    $bookId = $bookResponse.id
    Write-Host "   Book created: $($bookResponse.title) by $($bookResponse.author)" -ForegroundColor Green
} catch {
    Write-Host "   Failed to create book" -ForegroundColor Red
}

Write-Host ""

# Test 4: Get All Books
Write-Host "4. Retrieving all books..." -ForegroundColor Cyan
try {
    $books = Invoke-RestMethod -Uri "http://localhost:3000/api/books" -Method Get -Headers $headers
    Write-Host "   Found $($books.Count) book(s)" -ForegroundColor Green
    foreach ($book in $books) {
        Write-Host "     - $($book.title) by $($book.author) - Year: $($book.publishedYear)" -ForegroundColor White
    }
} catch {
    Write-Host "   Failed to get books" -ForegroundColor Red
}

Write-Host ""
Write-Host "=== API is running! ===" -ForegroundColor Green
Write-Host ""
Write-Host "Your JWT Token:" -ForegroundColor Yellow
Write-Host $token -ForegroundColor White
Write-Host ""
Write-Host "Test the API using:" -ForegroundColor Cyan
Write-Host "  - README.md for detailed documentation"
Write-Host "  - API_TESTING.md for curl and PowerShell examples"
Write-Host ""
Write-Host "Press Ctrl+C to stop the server..." -ForegroundColor Yellow

# Keep the script running
try {
    while ($true) {
        Start-Sleep -Seconds 1
    }
} finally {
    Stop-Job -Job $job
    Remove-Job -Job $job
    Write-Host "Server stopped." -ForegroundColor Red
}
