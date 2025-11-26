// Import NestFactory to create the NestJS application instance
// Importiere NestFactory, um die NestJS-Anwendungsinstanz zu erstellen
import { NestFactory } from "@nestjs/core";

// Import ValidationPipe for automatic request validation
// Importiere ValidationPipe für automatische Request-Validierung
import { ValidationPipe } from "@nestjs/common";

// Import the root application module
// Importiere das Root-Anwendungsmodul
import { AppModule } from "./app.module";

// Bootstrap function to initialize and start the application
// Bootstrap-Funktion zum Initialisieren und Starten der Anwendung
async function bootstrap() {
  // Create the NestJS application instance with the AppModule
  // Erstelle die NestJS-Anwendungsinstanz mit dem AppModule
  const app = await NestFactory.create(AppModule);

  // Set global prefix 'api' for all routes (e.g., /api/books)
  // Setze globales Präfix 'api' für alle Routen (z.B. /api/books)
  app.setGlobalPrefix("api");

  // Enable global validation pipe for automatic DTO validation
  // Aktiviere globale Validierungs-Pipe für automatische DTO-Validierung
  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true, // Remove properties that don't have decorators / Entferne Eigenschaften ohne Dekoratoren
      transform: true, // Automatically transform payloads to DTO instances / Transformiere Payloads automatisch zu DTO-Instanzen
    })
  );

  // Start the server on port 3000
  // Starte den Server auf Port 3000
  await app.listen(3000);
  console.log("Application is running on: http://localhost:3000/api");
}

// Call the bootstrap function to start the application
// Rufe die Bootstrap-Funktion auf, um die Anwendung zu starten
bootstrap();
