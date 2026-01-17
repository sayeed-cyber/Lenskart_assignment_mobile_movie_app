
# Lenskart Assignment: Movie App

This repository contains a Netflix-style movie app built with Flutter for the Lenskart assignment. The app uses the TMDB API to fetch and display movies, allowing users to browse, search, add to favourites, and manage a watchlist.

---

## 📂 Project Structure & Navigation

### Main Entry Point
- **lib/main.dart**: App entry, theme setup, provider initialization, and navigation root.

### Navigation Flow
1. **Splash Screen** (`lib/screens/splash_screen.dart`): Animated splash, then navigates to Home.
2. **Home Screen** (`lib/screens/home_screen.dart`): Bottom navigation with three tabs:
    - Movies
    - Favourites
    - Watchlist
3. **Movies Screen** (`lib/screens/movies_screen.dart`):
    - Displays movie lists (Popular, Top Rated, Now Playing, Upcoming)
    - Search bar for movie search
    - Tapping a movie opens Movie Detail
4. **Movie Detail Screen** (`lib/screens/movie_detail_screen.dart`):
    - Shows detailed info, genres, rating, overview
    - Add/remove from Favourites or Watchlist
5. **Favourites Screen** (`lib/screens/favourites_screen.dart`):
    - Lists all favourite movies
6. **Watchlist Screen** (`lib/screens/watchlist_screen.dart`):
    - Lists all watchlist movies

### Core Folders & Files
- **lib/constants/**
  - `api_constants.dart`: TMDB API endpoints, keys, image URLs
  - `app_theme.dart`: App color scheme and theme
- **lib/models/**
  - `movie.dart`: Movie model (basic info)
  - `movie_detail.dart`: Movie detail model (extended info)
  - `genre.dart`: Genre model and helper
- **lib/providers/**
  - `movie_provider.dart`: State for movies, search, categories
  - `favourites_provider.dart`: State for favourites
  - `watchlist_provider.dart`: State for watchlist
- **lib/services/**
  - `api_service.dart`: Handles all TMDB API requests
  - `storage_service.dart`: Local storage for favourites/watchlist
- **lib/widgets/**
  - `movie_card.dart`: UI card for displaying a movie
  - `loading_widget.dart`: Loading indicators and shimmer
  - `error_widget.dart`: Error display widget

---

## 🛠️ How to Run
1. **Install Flutter** ([flutter.dev](https://flutter.dev/docs/get-started/install))
2. **Get a TMDB API Key** ([TMDB](https://www.themoviedb.org/))
3. **Configure API Key**
    - Edit `lib/constants/api_constants.dart` and set your API key:
      ```dart
      static const String apiKey = 'YOUR_TMDB_API_KEY';
      ```
4. **Install dependencies**
    ```sh
    flutter pub get
    ```
5. **Run the app**
    ```sh
    flutter run
    ```

---

## 📝 File-by-File Overview

### Screens
- **splash_screen.dart**: Animated splash, then navigates to HomeScreen.
- **home_screen.dart**: Main navigation (bottom nav bar: Movies, Favourites, Watchlist).
- **movies_screen.dart**: Movie list, search, pull-to-refresh.
- **movie_detail_screen.dart**: Details, genres, add/remove favourites/watchlist.
- **favourites_screen.dart**: List of favourite movies.
- **watchlist_screen.dart**: List of watchlist movies.

### Providers
- **movie_provider.dart**: Fetches movies, manages search and categories.
- **favourites_provider.dart**: Handles favourite movies (add/remove/load).
- **watchlist_provider.dart**: Handles watchlist movies (add/remove/load).

### Services
- **api_service.dart**: All TMDB API calls (popular, top-rated, details, search).
- **storage_service.dart**: Uses shared_preferences for local storage.

### Models
- **movie.dart**: Movie data structure.
- **movie_detail.dart**: Detailed movie info.
- **genre.dart**: Genre data and mapping.

### Widgets
- **movie_card.dart**: UI for a single movie (used in lists).
- **loading_widget.dart**: Loading spinner and shimmer effect.
- **error_widget.dart**: Error message display.

### Constants
- **api_constants.dart**: API URLs, endpoints, and helpers.
- **app_theme.dart**: App-wide color and theme settings.

---

## 📦 Other Files
- **pubspec.yaml**: Project dependencies and assets.
- **assets/**: App images and icons.
- **test/**: Widget and unit tests.

---

## 📱 UX & Navigation
- Bottom navigation for quick switching between Movies, Favourites, and Watchlist.
- Tap a movie for details and actions.
- Pull-to-refresh and search on Movies screen.
- Persistent local storage for user lists.

---

## ℹ️ Notes
- This project is for the Lenskart assignment.
- All code is organized for clarity and scalability.
- For any issues, please check the comments in each file or contact the author.

### 4. Install Dependencies

```bash
flutter pub get
```

### 5. Run the App

```bash
flutter run
```

### 6. Build APK

```bash
flutter build apk --release
```

The APK will be generated at: `build/app/outputs/flutter-apk/app-release.apk`

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── constants/
│   ├── api_constants.dart    # API configuration
│   └── app_theme.dart        # App theme & colors
├── models/
│   ├── movie.dart            # Movie model
│   └── genre.dart            # Genre model
├── services/
│   ├── api_service.dart      # TMDB API calls
│   └── storage_service.dart  # Local storage
├── providers/
│   ├── movie_provider.dart   # Movie state management
│   ├── favourites_provider.dart
│   └── watchlist_provider.dart
├── screens/
│   ├── splash_screen.dart
│   ├── home_screen.dart
│   ├── movies_screen.dart
│   ├── favourites_screen.dart
│   ├── watchlist_screen.dart
│   └── movie_detail_screen.dart
└── widgets/
    ├── movie_card.dart
    ├── loading_widget.dart
    └── error_widget.dart
```

## Technologies Used

- **Flutter** - UI framework
- **Provider** - State management
- **HTTP** - API calls
- **Shared Preferences** - Local storage
- **Cached Network Image** - Image caching
- **Shimmer** - Loading animations

## API Documentation

Using [TMDB API](https://developers.themoviedb.org/3)

## Screenshots


Below are some screenshots of the app:

<p align="center">
  <img src="./WhatsApp Image 2026-01-17 at 16.56.54.jpeg" alt="Screenshot 1" width="250" />
  <img src="./WhatsApp Image 2026-01-17 at 16.56.54 (1).jpeg" alt="Screenshot 2" width="250" />
  <img src="./WhatsApp Image 2026-01-17 at 16.56.55.jpeg" alt="Screenshot 3" width="250" />
  <img src="./WhatsApp Image 2026-01-17 at 16.56.56.jpeg" alt="Screenshot 4" width="250" />
  <img src="./WhatsApp Image 2026-01-17 at 16.56.56 (1).jpeg" alt="Screenshot 5" width="250" />
</p>

## License

This project is for educational purposes.
