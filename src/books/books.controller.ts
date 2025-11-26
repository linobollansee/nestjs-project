// Import necessary decorators and types from NestJS common package
// Importiere notwendige Dekoratoren und Typen aus dem NestJS-Common-Paket
import {
  Controller, // Decorator to define a controller / Dekorator zum Definieren eines Controllers
  Get, // Decorator for GET endpoints / Dekorator für GET-Endpunkte
  Post, // Decorator for POST endpoints / Dekorator für POST-Endpunkte
  Put, // Decorator for PUT endpoints / Dekorator für PUT-Endpunkte
  Delete, // Decorator for DELETE endpoints / Dekorator für DELETE-Endpunkte
  Body, // Decorator to extract request body / Dekorator zum Extrahieren des Request-Bodys
  Param, // Decorator to extract URL parameters / Dekorator zum Extrahieren von URL-Parametern
  HttpCode, // Decorator to set HTTP status code / Dekorator zum Setzen des HTTP-Statuscodes
  HttpStatus, // Enum with HTTP status codes / Enum mit HTTP-Statuscodes
  UseGuards, // Decorator to apply guards / Dekorator zum Anwenden von Guards
} from "@nestjs/common";

// Import the BooksService for business logic
// Importiere den BooksService für Geschäftslogik
import { BooksService } from "./books.service";

// Import DTOs for request validation
// Importiere DTOs für Request-Validierung
import { CreateBookDto } from "./dto/create-book.dto";
import { UpdateBookDto } from "./dto/update-book.dto";

// Import Book interface for type safety
// Importiere Book-Interface für Typsicherheit
import { Book } from "./interfaces/book.interface";

// Import JWT authentication guard
// Importiere JWT-Authentifizierungs-Guard
import { JwtAuthGuard } from "../auth/guards/jwt-auth.guard";

// Controller for /api/books endpoints
// Controller für /api/books-Endpunkte
@Controller("books")
// Apply JWT authentication to all routes in this controller
// Wende JWT-Authentifizierung auf alle Routen in diesem Controller an
@UseGuards(JwtAuthGuard)
export class BooksController {
  // Inject BooksService through constructor
  // Injiziere BooksService über Konstruktor
  constructor(private readonly booksService: BooksService) {}

  // GET /api/books - Get all books
  // GET /api/books - Hole alle Bücher
  @Get()
  findAll(): Book[] {
    return this.booksService.findAll();
  }

  // GET /api/books/:id - Get a single book by ID
  // GET /api/books/:id - Hole ein einzelnes Buch nach ID
  @Get(":id")
  findOne(@Param("id") id: string): Book {
    return this.booksService.findOne(id);
  }

  // POST /api/books - Create a new book
  // POST /api/books - Erstelle ein neues Buch
  @Post()
  @HttpCode(HttpStatus.CREATED) // Return 201 status / Gib 201-Status zurück
  create(@Body() createBookDto: CreateBookDto): Book {
    return this.booksService.create(createBookDto);
  }

  // PUT /api/books/:id - Update a book by ID
  // PUT /api/books/:id - Aktualisiere ein Buch nach ID
  @Put(":id")
  update(@Param("id") id: string, @Body() updateBookDto: UpdateBookDto): Book {
    return this.booksService.update(id, updateBookDto);
  }

  // DELETE /api/books/:id - Delete a book by ID
  // DELETE /api/books/:id - Lösche ein Buch nach ID
  @Delete(":id")
  @HttpCode(HttpStatus.NO_CONTENT) // Return 204 status / Gib 204-Status zurück
  delete(@Param("id") id: string): void {
    this.booksService.delete(id);
  }
}
