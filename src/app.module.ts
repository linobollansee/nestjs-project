// Import the Module decorator to define a NestJS module
// Importiere den Module-Dekorator, um ein NestJS-Modul zu definieren
import { Module } from "@nestjs/common";

// Import the Books module for book management functionality
// Importiere das Books-Modul für Buchverwaltungsfunktionalität
import { BooksModule } from "./books/books.module";

// Import the Users module for user management functionality
// Importiere das Users-Modul für Benutzerverwaltungsfunktionalität
import { UsersModule } from "./users/users.module";

// Import the Auth module for authentication functionality
// Importiere das Auth-Modul für Authentifizierungsfunktionalität
import { AuthModule } from "./auth/auth.module";

// Root application module that imports all feature modules
// Root-Anwendungsmodul, das alle Feature-Module importiert
@Module({
  imports: [BooksModule, UsersModule, AuthModule], // Register all feature modules / Registriere alle Feature-Module
})
export class AppModule {}
