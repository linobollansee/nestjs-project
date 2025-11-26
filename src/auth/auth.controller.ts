// Import necessary decorators from NestJS common package
// Importiere notwendige Dekoratoren aus dem NestJS-Common-Paket
import { Controller, Post, Body, HttpCode, HttpStatus } from "@nestjs/common";

// Import AuthService for authentication logic
// Importiere AuthService für Authentifizierungslogik
import { AuthService } from "./auth.service";

// Import DTO for login request validation
// Importiere DTO für Login-Request-Validierung
import { AuthDto } from "./dto/auth.dto";

// Controller for /api/auth endpoints
// Controller für /api/auth-Endpunkte
@Controller("auth")
export class AuthController {
  // Inject AuthService through constructor
  // Injiziere AuthService über Konstruktor
  constructor(private authService: AuthService) {}

  // POST /api/auth - Login endpoint to authenticate user and return JWT token
  // POST /api/auth - Login-Endpunkt zur Authentifizierung des Benutzers und Rückgabe des JWT-Tokens
  @Post()
  @HttpCode(HttpStatus.OK) // Return 200 status for successful login / Gib 200-Status für erfolgreichen Login zurück
  async login(@Body() authDto: AuthDto) {
    // Call login service with email and password from request body
    // Rufe Login-Service mit E-Mail und Passwort aus Request-Body auf
    return this.authService.login(authDto.email, authDto.password);
  }
}
