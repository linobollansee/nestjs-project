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

// Import the UsersService for business logic
// Importiere den UsersService für Geschäftslogik
import { UsersService } from "./users.service";

// Import DTOs for request validation
// Importiere DTOs für Request-Validierung
import { CreateUserDto } from "./dto/create-user.dto";
import { UpdateUserDto } from "./dto/update-user.dto";

// Import JWT authentication guard
// Importiere JWT-Authentifizierungs-Guard
import { JwtAuthGuard } from "../auth/guards/jwt-auth.guard";

// Controller for /api/users endpoints
// Controller für /api/users-Endpunkte
@Controller("users")
export class UsersController {
  // Inject UsersService through constructor
  // Injiziere UsersService über Konstruktor
  constructor(private readonly usersService: UsersService) {}

  // GET /api/users - Get all users (protected route)
  // GET /api/users - Hole alle Benutzer (geschützte Route)
  @Get()
  @UseGuards(JwtAuthGuard) // Require JWT authentication / Erfordere JWT-Authentifizierung
  async findAll() {
    return await this.usersService.findAll();
  }

  // GET /api/users/:id - Get a single user by ID (protected route)
  // GET /api/users/:id - Hole einen einzelnen Benutzer nach ID (geschützte Route)
  @Get(":id")
  @UseGuards(JwtAuthGuard) // Require JWT authentication / Erfordere JWT-Authentifizierung
  async findOne(@Param("id") id: string) {
    return await this.usersService.findOne(id);
  }

  // POST /api/users - Create a new user (public route for registration)
  // POST /api/users - Erstelle einen neuen Benutzer (öffentliche Route für Registrierung)
  @Post()
  @HttpCode(HttpStatus.CREATED) // Return 201 status / Gib 201-Status zurück
  async create(@Body() createUserDto: CreateUserDto) {
    return await this.usersService.create(createUserDto);
  }

  // PUT /api/users/:id - Update a user by ID (protected route)
  // PUT /api/users/:id - Aktualisiere einen Benutzer nach ID (geschützte Route)
  @Put(":id")
  @UseGuards(JwtAuthGuard) // Require JWT authentication / Erfordere JWT-Authentifizierung
  async update(@Param("id") id: string, @Body() updateUserDto: UpdateUserDto) {
    return await this.usersService.update(id, updateUserDto);
  }

  // DELETE /api/users/:id - Delete a user by ID (protected route)
  // DELETE /api/users/:id - Lösche einen Benutzer nach ID (geschützte Route)
  @Delete(":id")
  @UseGuards(JwtAuthGuard) // Require JWT authentication / Erfordere JWT-Authentifizierung
  @HttpCode(HttpStatus.NO_CONTENT) // Return 204 status / Gib 204-Status zurück
  async delete(@Param("id") id: string) {
    await this.usersService.delete(id);
  }
}
