// Import JWT extraction and strategy from passport-jwt
// Importiere JWT-Extraktion und Strategie aus passport-jwt
import { ExtractJwt, Strategy } from "passport-jwt";

// Import PassportStrategy to extend Passport strategy
// Importiere PassportStrategy zum Erweitern der Passport-Strategie
import { PassportStrategy } from "@nestjs/passport";

// Import Injectable decorator to make this class a provider
// Importiere Injectable-Dekorator, um diese Klasse zu einem Provider zu machen
import { Injectable } from "@nestjs/common";

// JWT Strategy for validating JWT tokens in requests
// JWT-Strategie zur Validierung von JWT-Tokens in Requests
@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy) {
  constructor() {
    // Configure the JWT strategy
    // Konfiguriere die JWT-Strategie
    super({
      // Extract JWT from Authorization header as Bearer token
      // Extrahiere JWT aus Authorization-Header als Bearer-Token
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),

      // Don't ignore token expiration (tokens will expire after set time)
      // Ignoriere Token-Ablauf nicht (Tokens laufen nach festgelegter Zeit ab)
      ignoreExpiration: false,

      // Secret key to verify token signature (use environment variable in production)
      // Geheimschlüssel zur Verifizierung der Token-Signatur (in Produktion Umgebungsvariable verwenden)
      secretOrKey: "your-secret-key",
    });
  }

  // Validate method is called automatically after token verification
  // Validate-Methode wird automatisch nach Token-Verifizierung aufgerufen
  async validate(payload: any) {
    // Return user object that will be attached to the request
    // Gib Benutzer-Objekt zurück, das an den Request angehängt wird
    return { userId: payload.sub, email: payload.email };
  }
}
