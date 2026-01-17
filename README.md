# Movie App - Netflix-Style Flutter Application

A beautiful, Netflix-inspired movie application built with Flutter that uses TMDB API to display movies with features like favourites, watchlist, and detailed movie information.

## Features

- 🎬 Browse popular, top-rated, and now playing movies
- 🔍 Search functionality
- ❤️ Add movies to favourites
- 📋 Create a watchlist
- 📱 Netflix/Prime-inspired dark UI
- 🎯 Circular progress indicator for ratings
- 📲 In-app notifications
- 💾 Local storage for user preferences

## Setup Instructions

### 1. Install Flutter

Make sure you have Flutter installed. If not, visit [flutter.dev](https://flutter.dev/docs/get-started/install)

### 2. Get TMDB API Key

1. Go to [TMDB website](https://www.themoviedb.org/)
2. Create a free account
3. Go to Settings → API
4. Request an API key (choose "Developer" option)
5. Copy your API key

### 3. Configure API Key

Open `lib/constants/api_constants.dart` and replace:
```dart
static const String apiKey = 'YOUR_TMDB_API_KEY_HERE';
```
with your actual API key:
```dart
static const String apiKey = 'your_actual_api_key';
```

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

(Add screenshots here after running the app)

## License

This project is for educational purposes.
