// Import Module decorator to define a NestJS module
// Importiere Module-Dekorator zum Definieren eines NestJS-Moduls
import { Module } from "@nestjs/common";

// Import UsersController to handle HTTP requests
// Importiere UsersController zum Verarbeiten von HTTP-Requests
import { UsersController } from "./users.controller";

// Import UsersService to handle business logic
// Importiere UsersService zum Verarbeiten von Geschäftslogik
import { UsersService } from "./users.service";

// Module for user management functionality
// Modul für Benutzerverwaltungsfunktionalität
@Module({
  controllers: [UsersController], // Register the controller / Registriere den Controller
  providers: [UsersService], // Register the service / Registriere den Service
  exports: [UsersService], // Export service for use in other modules (e.g., AuthModule) / Exportiere Service zur Verwendung in anderen Modulen (z.B. AuthModule)
})
export class UsersModule {}
