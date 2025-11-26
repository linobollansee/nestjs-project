// Import necessary decorators and exceptions from NestJS
// Importiere notwendige Dekoratoren und Exceptions aus NestJS
import { Injectable, UnauthorizedException } from "@nestjs/common";

// Import JwtService for token generation
// Importiere JwtService zur Token-Generierung
import { JwtService } from "@nestjs/jwt";

// Import UsersService to access user data
// Importiere UsersService zum Zugriff auf Benutzerdaten
import { UsersService } from "../users/users.service";

// Import bcrypt for password comparison
// Importiere bcrypt für Passwortvergleich
import * as bcrypt from "bcrypt";

// Service class containing authentication business logic
// Service-Klasse mit Authentifizierungs-Geschäftslogik
@Injectable()
export class AuthService {
  // Inject UsersService and JwtService through constructor
  // Injiziere UsersService und JwtService über Konstruktor
  constructor(
    private usersService: UsersService,
    private jwtService: JwtService
  ) {}

  // Validate user credentials (email and password)
  // Validiere Benutzer-Anmeldedaten (E-Mail und Passwort)
  async validateUser(email: string, password: string): Promise<any> {
    // Find user by email
    // Finde Benutzer nach E-Mail
    const user = await this.usersService.findByEmail(email);

    // If user exists and password matches the hashed password
    // Wenn Benutzer existiert und Passwort mit gehashtem Passwort übereinstimmt
    if (user && (await bcrypt.compare(password, user.password))) {
      // Return user without password field
      // Gib Benutzer ohne Passwort-Feld zurück
      const { password, ...result } = user;
      return result;
    }
    // Return null if validation fails
    // Gib null zurück, wenn Validierung fehlschlägt
    return null;
  }

  // Login user and generate JWT token
  // Melde Benutzer an und generiere JWT-Token
  async login(email: string, password: string) {
    // Validate user credentials
    // Validiere Benutzer-Anmeldedaten
    const user = await this.validateUser(email, password);

    // If user is not valid, throw 401 Unauthorized error
    // Wenn Benutzer nicht gültig ist, wirf 401-Unauthorized-Fehler
    if (!user) {
      throw new UnauthorizedException("Invalid credentials");
    }

    // Create JWT payload with user email and ID
    // Erstelle JWT-Payload mit Benutzer-E-Mail und ID
    const payload = { email: user.email, sub: user.id };

    // Return signed JWT token
    // Gib signiertes JWT-Token zurück
    return {
      token: this.jwtService.sign(payload),
    };
  }
}
