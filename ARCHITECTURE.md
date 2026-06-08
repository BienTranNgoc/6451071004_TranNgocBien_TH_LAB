# Clean Architecture Structure

## Folder Organization

```
lib/
├── core/                                 # Shared code
│   ├── constants/                       # Constants (messages, strings)
│   ├── db/                              # AppDatabase (SQLite)
│   ├── di/                              # Dependency Injection
│   └── core.dart                        # Exports
│
├── features/
│   ├── profile/                         # Profile Feature (SQLite CRUD) — Phần 3
│   │   ├── data/                        #   datasources (SQLite) / models / repositories
│   │   ├── domain/                      #   entities / repositories / usecases
│   │   └── presentation/                #   provider / pages / widgets
│   │
│   └── auth/                            # Auth Feature — Phần 2
│       ├── data/                        # Data Layer
│       │   ├── datasources/             # External APIs (Firebase)
│       │   ├── models/                  # Data Models (with JSON conversion)
│       │   ├── repositories/            # Repository Implementations
│       │   └── data.dart                # Exports
│       │
│       ├── domain/                      # Domain Layer (Business Logic)
│       │   ├── entities/                # Core entities (UserEntity)
│       │   ├── repositories/            # Abstract repositories
│       │   ├── usecases/                # Use cases (SignUp, Login, etc)
│       │   └── domain.dart              # Exports
│       │
│       └── presentation/                # Presentation Layer (UI)
│           ├── pages/                   # Pages/Screens
│           ├── widgets/                 # Reusable widgets
│           ├── provider/                # State Management (Provider)
│           └── presentation.dart        # Exports
│
└── main.dart                            # App Entry Point
```

## Layer Responsibilities

### Domain Layer
- **Entities**: Pure Dart classes representing core objects
- **Repositories**: Abstract classes defining business logic contracts
- **UseCases**: Encapsulate business logic, implement SOLID principles

### Data Layer
- **DataSources**: Handle external data (Firebase, APIs)
- **Models**: Extend entities with JSON serialization
- **Repositories**: Implement abstract repositories, handle data transformation

### Presentation Layer
- **Pages**: Complete screens
- **Widgets**: Reusable UI components
- **Providers**: State management (uses Provider package)

### Core Layer
- **DI (Service Locator)**: Dependency injection setup
- **Constants**: App-wide constants
- **Config**: Configuration files

## Benefits

✅ **Separation of Concerns**: Each layer has clear responsibility
✅ **Testability**: Business logic isolated from UI and external dependencies
✅ **Reusability**: Easy to reuse components across features
✅ **Scalability**: Easy to add new features following same pattern
✅ **Maintainability**: Clear structure makes code maintenance easier

## Adding New Features

To add a new feature (e.g., Movies):

```
features/movies/
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── presentation/
    ├── pages/
    ├── widgets/
    └── provider/
```

Then setup DI in `core/di/service_locator.dart` for the new feature.
