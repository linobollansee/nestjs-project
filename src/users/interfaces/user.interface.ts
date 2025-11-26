// Interface defining the structure of a User object
// Interface zur Definition der Struktur eines Benutzer-Objekts
export interface User {
  id: string; // Unique identifier (UUID) / Eindeutige Kennung (UUID)
  username: string; // User's display name / Anzeigename des Benutzers
  email: string; // User's email address / E-Mail-Adresse des Benutzers
  password: string; // Hashed password (never return in responses) / Gehashtes Passwort (niemals in Antworten zurückgeben)
}
