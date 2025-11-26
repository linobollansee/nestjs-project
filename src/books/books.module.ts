// Import Module decorator to define a NestJS module
// Importiere Module-Dekorator zum Definieren eines NestJS-Moduls
import { Module } from "@nestjs/common";

// Import BooksController to handle HTTP requests
// Importiere BooksController zum Verarbeiten von HTTP-Requests
import { BooksController } from "./books.controller";

// Import BooksService to handle business logic
// Importiere BooksService zum Verarbeiten von Geschäftslogik
import { BooksService } from "./books.service";

// Module for book management functionality
// Modul für Buchverwaltungsfunktionalität
@Module({
  controllers: [BooksController], // Register the controller / Registriere den Controller
  providers: [BooksService], // Register the service / Registriere den Service
})
export class BooksModule {}
