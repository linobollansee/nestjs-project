// Import validation decorators from class-validator
// Importiere Validierungs-Dekoratoren aus class-validator
import { IsString, IsEmail, IsNotEmpty } from "class-validator";

// Data Transfer Object for updating an existing user
// Datenübertragungs-Objekt zum Aktualisieren eines bestehenden Benutzers
export class UpdateUserDto {
  // Username - must be a non-empty string
  // Benutzername - muss ein nicht-leerer String sein
  @IsNotEmpty() // Validates that the value is not empty / Validiert, dass der Wert nicht leer ist
  @IsString() // Validates that the value is a string / Validiert, dass der Wert ein String ist
  username: string;

  // Email address - must be a non-empty valid email
  // E-Mail-Adresse - muss eine nicht-leere gültige E-Mail sein
  @IsNotEmpty() // Validates that the value is not empty / Validiert, dass der Wert nicht leer ist
  @IsEmail() // Validates email format / Validiert E-Mail-Format
  email: string;

  // Password - must be a non-empty string (will be hashed)
  // Passwort - muss ein nicht-leerer String sein (wird gehasht)
  @IsNotEmpty() // Validates that the value is not empty / Validiert, dass der Wert nicht leer ist
  @IsString() // Validates that the value is a string / Validiert, dass der Wert ein String ist
  password: string;
}
