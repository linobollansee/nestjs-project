// Import Injectable decorator to make this class a provider
// Importiere Injectable-Dekorator, um diese Klasse zu einem Provider zu machen
import { Injectable } from "@nestjs/common";

// Import AuthGuard from Passport for authentication
// Importiere AuthGuard von Passport für Authentifizierung
import { AuthGuard } from "@nestjs/passport";

// JWT Authentication Guard to protect routes
// JWT-Authentifizierungs-Guard zum Schützen von Routen
// This guard uses the 'jwt' strategy to validate JWT tokens
// Dieser Guard verwendet die 'jwt'-Strategie zur Validierung von JWT-Tokens
@Injectable()
export class JwtAuthGuard extends AuthGuard("jwt") {}
