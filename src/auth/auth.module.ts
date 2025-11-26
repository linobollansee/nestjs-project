// Import Module decorator to define a NestJS module
// Importiere Module-Dekorator zum Definieren eines NestJS-Moduls
import { Module } from "@nestjs/common";

// Import JwtModule for JWT token handling
// Importiere JwtModule für JWT-Token-Verarbeitung
import { JwtModule } from "@nestjs/jwt";

// Import PassportModule for authentication strategies
// Importiere PassportModule für Authentifizierungsstrategien
import { PassportModule } from "@nestjs/passport";

// Import AuthService for authentication logic
// Importiere AuthService für Authentifizierungslogik
import { AuthService } from "./auth.service";

// Import AuthController for authentication endpoints
// Importiere AuthController für Authentifizierungs-Endpunkte
import { AuthController } from "./auth.controller";

// Import UsersModule to access user data
// Importiere UsersModule zum Zugriff auf Benutzerdaten
import { UsersModule } from "../users/users.module";

// Import JWT strategy for token validation
// Importiere JWT-Strategie zur Token-Validierung
import { JwtStrategy } from "./strategies/jwt.strategy";

// Module for authentication functionality
// Modul für Authentifizierungsfunktionalität
@Module({
  imports: [
    UsersModule, // Import UsersModule to use UsersService / Importiere UsersModule zur Nutzung des UsersService
    PassportModule, // Import PassportModule for authentication / Importiere PassportModule für Authentifizierung
    JwtModule.register({
      secret: "your-secret-key", // JWT secret key (use environment variable in production) / JWT-Geheimschlüssel (in Produktion Umgebungsvariable verwenden)
      signOptions: { expiresIn: "24h" }, // Token expires in 24 hours / Token läuft nach 24 Stunden ab
    }),
  ],
  controllers: [AuthController], // Register the controller / Registriere den Controller
  providers: [AuthService, JwtStrategy], // Register service and strategy / Registriere Service und Strategie
  exports: [AuthService], // Export AuthService for use in other modules / Exportiere AuthService zur Verwendung in anderen Modulen
})
export class AuthModule {}
