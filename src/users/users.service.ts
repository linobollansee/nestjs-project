// Import necessary decorators and exceptions from NestJS
// Importiere notwendige Dekoratoren und Exceptions aus NestJS
import {
  Injectable, // Makes class injectable as a provider / Macht Klasse als Provider injizierbar
  NotFoundException, // Exception for 404 errors / Exception f\u00fcr 404-Fehler
  ConflictException, // Exception for 409 conflicts / Exception f\u00fcr 409-Konflikte
} from "@nestjs/common";

// Import User interface for type definitions
// Importiere User-Interface f\u00fcr Typdefinitionen
import { User } from "./interfaces/user.interface";

// Import DTOs for data validation and transformation
// Importiere DTOs f\u00fcr Datenvalidierung und -transformation
import { CreateUserDto } from "./dto/create-user.dto";
import { UpdateUserDto } from "./dto/update-user.dto";

// Import UUID library for generating unique identifiers
// Importiere UUID-Bibliothek zum Generieren eindeutiger Identifikatoren
import { v4 as uuidv4 } from "uuid";

// Import bcrypt for password hashing
// Importiere bcrypt f\u00fcr Passwort-Hashing
import * as bcrypt from "bcrypt";

// Service class containing business logic for user operations
// Service-Klasse mit Gesch\u00e4ftslogik f\u00fcr Benutzer-Operationen
@Injectable()
export class UsersService {
  // In-memory array to store users (replace with database in production)
  // In-Memory-Array zum Speichern von Benutzern (in Produktion durch Datenbank ersetzen)
  private users: User[] = [];

  // Get all users without password field
  // Hole alle Benutzer ohne Passwort-Feld
  async findAll(): Promise<Omit<User, "password">[]> {
    // Map through users and exclude password from each user object
    // Durchlaufe Benutzer und schlie\u00dfe Passwort von jedem Benutzer-Objekt aus
    return this.users.map(({ password, ...user }) => user);
  }

  // Find a single user by ID without password field
  // Finde einen einzelnen Benutzer nach ID ohne Passwort-Feld
  async findOne(id: string): Promise<Omit<User, "password">> {
    // Search for the user in the array
    // Suche nach dem Benutzer im Array
    const user = this.users.find((u) => u.id === id);

    // If user not found, throw 404 error
    // Wenn Benutzer nicht gefunden, wirf 404-Fehler
    if (!user) {
      throw new NotFoundException(`User with ID ${id} not found`);
    }

    // Destructure to exclude password from response
    // Destrukturiere, um Passwort aus Antwort auszuschlie\u00dfen
    const { password, ...result } = user;
    return result;
  }

  // Find user by email (includes password for authentication)
  // Finde Benutzer nach E-Mail (inklusive Passwort f\u00fcr Authentifizierung)
  async findByEmail(email: string): Promise<User | undefined> {
    return this.users.find((u) => u.email === email);
  }

  // Create a new user with hashed password
  // Erstelle einen neuen Benutzer mit gehashtem Passwort
  async create(createUserDto: CreateUserDto): Promise<Omit<User, "password">> {
    // Check if user with email already exists
    // Pr\u00fcfe, ob Benutzer mit E-Mail bereits existiert
    const existingUser = await this.findByEmail(createUserDto.email);
    if (existingUser) {
      // Throw 409 Conflict if email is already taken
      // Wirf 409-Konflikt, wenn E-Mail bereits vergeben ist
      throw new ConflictException("User with this email already exists");
    }

    // Hash the password with bcrypt (10 salt rounds)
    // Hashe das Passwort mit bcrypt (10 Salt-Runden)
    const hashedPassword = await bcrypt.hash(createUserDto.password, 10);

    // Create new user object with generated UUID and hashed password
    // Erstelle neues Benutzer-Objekt mit generierter UUID und gehashtem Passwort
    const user: User = {
      id: uuidv4(), // Generate unique ID / Generiere eindeutige ID
      username: createUserDto.username, // Set username / Setze Benutzernamen
      email: createUserDto.email, // Set email / Setze E-Mail
      password: hashedPassword, // Set hashed password / Setze gehashtes Passwort
    };

    // Add user to the array
    // F\u00fcge Benutzer zum Array hinzu
    this.users.push(user);

    // Return user without password field
    // Gib Benutzer ohne Passwort-Feld zur\u00fcck
    const { password, ...result } = user;
    return result;
  }

  // Update an existing user by ID
  // Aktualisiere einen bestehenden Benutzer nach ID
  async update(
    id: string,
    updateUserDto: UpdateUserDto
  ): Promise<Omit<User, "password">> {
    // Find the index of the user in the array
    // Finde den Index des Benutzers im Array
    const userIndex = this.users.findIndex((u) => u.id === id);

    // If user not found, throw 404 error
    // Wenn Benutzer nicht gefunden, wirf 404-Fehler
    if (userIndex === -1) {
      throw new NotFoundException(`User with ID ${id} not found`);
    }

    // Hash the new password with bcrypt (10 salt rounds)
    // Hashe das neue Passwort mit bcrypt (10 Salt-Runden)
    const hashedPassword = await bcrypt.hash(updateUserDto.password, 10);

    // Create updated user object with same ID and hashed password
    // Erstelle aktualisiertes Benutzer-Objekt mit gleicher ID und gehashtem Passwort
    const updatedUser: User = {
      id, // Keep the same ID / Behalte die gleiche ID
      username: updateUserDto.username, // Update username / Aktualisiere Benutzernamen
      email: updateUserDto.email, // Update email / Aktualisiere E-Mail
      password: hashedPassword, // Set new hashed password / Setze neues gehashtes Passwort
    };

    // Replace old user with updated user
    // Ersetze alten Benutzer durch aktualisierten Benutzer
    this.users[userIndex] = updatedUser;

    // Return user without password field
    // Gib Benutzer ohne Passwort-Feld zur\u00fcck
    const { password, ...result } = updatedUser;
    return result;
  }

  // Delete a user by ID
  // L\u00f6sche einen Benutzer nach ID
  async delete(id: string): Promise<void> {
    // Find the index of the user in the array
    // Finde den Index des Benutzers im Array
    const userIndex = this.users.findIndex((u) => u.id === id);

    // If user not found, throw 404 error
    // Wenn Benutzer nicht gefunden, wirf 404-Fehler
    if (userIndex === -1) {
      throw new NotFoundException(`User with ID ${id} not found`);
    }

    // Remove user from array
    // Entferne Benutzer aus Array
    this.users.splice(userIndex, 1);
  }
}
