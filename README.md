# Rick and Morty Flutter App

A Flutter application that showcases characters from the Rick and Morty universe. This app demonstrates modern Flutter development practices with a clean architecture approach.

## Features

- Browse Rick and Morty characters
- View character details including species and images
- Favorite characters functionality
- Material Design 3 UI implementation
- Offline support using Hive local storage
- GraphQL integration for efficient data fetching

## Architecture & Technologies

The project follows Clean Architecture principles with the following layers:

- **Data Layer**: Handles external data sources and repositories implementation
- **Domain Layer**: Contains business logic and entities
- **Presentation Layer**: Manages UI and state management

### Key Dependencies

- `get_it`: Dependency injection
- `dio`: HTTP client for API communication
- `hive`: Local storage solution
- `graphql`: GraphQL client for API integration
- `path_provider`: File system access for local storage

## Getting Started

### Prerequisites

- Flutter SDK (>=2.19.1 <3.0.0)
- Dart SDK
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── data/           # Data layer with API and local storage implementation
├── domain/         # Business logic and entities
├── presentation/   # UI components and state management
└── main.dart       # Application entry point
```

## Contributing

Feel free to submit issues and enhancement requests.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
