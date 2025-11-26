// Import Injectable decorator to make this class a provider
// Importiere Injectable-Dekorator, um diese Klasse zu einem Provider zu machen
import { Injectable, NotFoundException } from "@nestjs/common";

// Import Book interface for type definitions
// Importiere Book-Interface für Typdefinitionen
import { Book } from "./interfaces/book.interface";

// Import DTOs for data validation and transformation
// Importiere DTOs für Datenvalidierung und -transformation
import { CreateBookDto } from "./dto/create-book.dto";
import { UpdateBookDto } from "./dto/update-book.dto";

// Import UUID library for generating unique identifiers
// Importiere UUID-Bibliothek zum Generieren eindeutiger Identifikatoren
import { v4 as uuidv4 } from "uuid";

// Service class containing business logic for book operations
// Service-Klasse mit Geschäftslogik für Buch-Operationen
@Injectable()
export class BooksService {
  // In-memory array to store books (replace with database in production)
  // In-Memory-Array zum Speichern von Büchern (in Produktion durch Datenbank ersetzen)
  private books: Book[] = [];

  // Get all books from the collection
  // Hole alle Bücher aus der Sammlung
  findAll(): Book[] {
    return this.books;
  }

  // Find a single book by its ID
  // Finde ein einzelnes Buch anhand seiner ID
  findOne(id: string): Book {
    // Search for the book in the array
    // Suche nach dem Buch im Array
    const book = this.books.find((b) => b.id === id);

    // If book not found, throw 404 error
    // Wenn Buch nicht gefunden, wirf 404-Fehler
    if (!book) {
      throw new NotFoundException(`Book with ID ${id} not found`);
    }
    return book;
  }

  // Create a new book in the collection
  // Erstelle ein neues Buch in der Sammlung
  create(createBookDto: CreateBookDto): Book {
    // Create new book object with generated UUID
    // Erstelle neues Buch-Objekt mit generierter UUID
    const book: Book = {
      id: uuidv4(), // Generate unique ID / Generiere eindeutige ID
      ...createBookDto, // Spread DTO properties / Verteile DTO-Eigenschaften
    };

    // Add book to the array
    // Füge Buch zum Array hinzu
    this.books.push(book);
    return book;
  }

  // Update an existing book by ID
  // Aktualisiere ein bestehendes Buch nach ID
  update(id: string, updateBookDto: UpdateBookDto): Book {
    // Find the index of the book in the array
    // Finde den Index des Buches im Array
    const bookIndex = this.books.findIndex((b) => b.id === id);

    // If book not found, throw 404 error
    // Wenn Buch nicht gefunden, wirf 404-Fehler
    if (bookIndex === -1) {
      throw new NotFoundException(`Book with ID ${id} not found`);
    }

    // Create updated book object with same ID
    // Erstelle aktualisiertes Buch-Objekt mit gleicher ID
    const updatedBook: Book = {
      id, // Keep the same ID / Behalte die gleiche ID
      ...updateBookDto, // Apply updates from DTO / Wende Aktualisierungen aus DTO an
    };

    // Replace old book with updated book
    // Ersetze altes Buch durch aktualisiertes Buch
    this.books[bookIndex] = updatedBook;
    return updatedBook;
  }

  // Delete a book by ID
  // Lösche ein Buch nach ID
  delete(id: string): void {
    // Find the index of the book in the array
    // Finde den Index des Buches im Array
    const bookIndex = this.books.findIndex((b) => b.id === id);

    // If book not found, throw 404 error
    // Wenn Buch nicht gefunden, wirf 404-Fehler
    if (bookIndex === -1) {
      throw new NotFoundException(`Book with ID ${id} not found`);
    }

    // Remove book from array
    // Entferne Buch aus Array
    this.books.splice(bookIndex, 1);
  }
}
