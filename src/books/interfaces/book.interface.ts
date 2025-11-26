// Interface defining the structure of a Book object
// Interface zur Definition der Struktur eines Buch-Objekts
export interface Book {
  id: string; // Unique identifier (UUID) / Eindeutige Kennung (UUID)
  title: string; // Book title / Buchtitel
  author: string; // Book author / Buchautor
  publishedYear: number; // Year of publication / Jahr der Veröffentlichung
}
