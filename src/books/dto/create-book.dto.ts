// Import validation decorators from class-validator
// Importiere Validierungs-Dekoratoren aus class-validator
import { IsString, IsInt, IsNotEmpty } from "class-validator";

// Data Transfer Object for creating a new book
// Datenübertragungs-Objekt zum Erstellen eines neuen Buches
export class CreateBookDto {
  // Book title - must be a non-empty string
  // Buchtitel - muss ein nicht-leerer String sein
  @IsNotEmpty() // Validates that the value is not empty / Validiert, dass der Wert nicht leer ist
  @IsString() // Validates that the value is a string / Validiert, dass der Wert ein String ist
  title: string;

  // Book author - must be a non-empty string
  // Buchautor - muss ein nicht-leerer String sein
  @IsNotEmpty() // Validates that the value is not empty / Validiert, dass der Wert nicht leer ist
  @IsString() // Validates that the value is a string / Validiert, dass der Wert ein String ist
  author: string;

  // Year the book was published - must be a non-empty integer
  // Jahr der Veröffentlichung - muss eine nicht-leere Ganzzahl sein
  @IsNotEmpty() // Validates that the value is not empty / Validiert, dass der Wert nicht leer ist
  @IsInt() // Validates that the value is an integer / Validiert, dass der Wert eine Ganzzahl ist
  publishedYear: number;
}
