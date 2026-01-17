# Quick Start Guide

## Prerequisites

- Flutter SDK installed (3.0.0 or higher)
- Android Studio / VS Code with Flutter extensions
- Android emulator or physical device
- Internet connection

## Setup Steps

### 1. Install Dependencies

Open terminal in the project root and run:

```bash
flutter pub get
```

### 2. Get TMDB API Key

**This is REQUIRED for the app to work!**

Follow the detailed guide in [TMDB_API_SETUP.md](TMDB_API_SETUP.md) or:

1. Go to https://www.themoviedb.org/
2. Create a free account
3. Go to Settings → API → Request API Key
4. Copy your API Key (v3 auth)
5. Open `lib/constants/api_constants.dart`
6. Replace `YOUR_TMDB_API_KEY_HERE` with your actual key

### 3. Run the App

```bash
# Check for connected devices
flutter devices

# Run in debug mode
flutter run

# Or run on specific device
flutter run -d <device_id>
```

### 4. Build APK (Optional)

To create an installable APK:

```bash
# Build release APK
flutter build apk --release

# APK location: build/app/outputs/flutter-apk/app-release.apk
```

To build a smaller APK per architecture:

```bash
flutter build apk --split-per-abi
```

## Features Checklist

After running the app, you should see:

- ✅ Splash screen with animation
- ✅ Bottom navigation (Movies, Favourites, Watchlist)
- ✅ Movies screen with sections:
  - Now Playing
  - Popular
  - Top Rated
  - Upcoming
- ✅ Search functionality
- ✅ Click on movie to see details:
  - Movie banner
  - Title, year, runtime
  - Circular progress rating
  - Genres
  - Overview/Description
  - Favourite & Watchlist buttons
  - Play Now button (shows notification)
- ✅ Add/remove from Favourites
- ✅ Add/remove from Watchlist
- ✅ Persistent storage (data saved locally)

## Testing the App

1. **Browse Movies**: Scroll through different movie categories
2. **Search**: Try searching for "Avengers" or "Batman"
3. **View Details**: Click on any movie card
4. **Add to Favourites**: Click the heart icon on movie details
5. **Add to Watchlist**: Click the bookmark icon on movie details
6. **Play Button**: Click "Play Now" to see the notification
7. **Navigate Tabs**: Switch between Movies, Favourites, and Watchlist

## Common Issues

### "Failed to load movies" error
- Check if you've added the TMDB API key correctly
- Verify your internet connection
- Make sure the API key has no extra spaces

### App crashes on startup
- Run `flutter clean` then `flutter pub get`
- Restart your IDE
- Check if Flutter SDK is properly installed: `flutter doctor`

### Images not loading
- This is normal if TMDB servers are slow
- Wait a few seconds for images to cache
- Check your internet speed

### Build errors
```bash
# Clean the project
flutter clean

# Get dependencies again
flutter pub get

# Rebuild
flutter run
```

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── constants/
│   ├── api_constants.dart       # API configuration (ADD YOUR KEY HERE!)
│   └── app_theme.dart           # Dark theme colors
├── models/                      # Data models
├── services/                    # API & Storage services
├── providers/                   # State management
├── screens/                     # All app screens
└── widgets/                     # Reusable UI components
```

## Development Tips

- Use hot reload (`r` in terminal) for quick UI changes
- Use hot restart (`R` in terminal) for logic changes
- Check console for debug messages
- Use Flutter DevTools for performance analysis

## Building for Production

```bash
# Clean build
flutter clean
flutter pub get

# Build release APK
flutter build apk --release --no-tree-shake-icons

# Build App Bundle (for Play Store)
flutter build appbundle --release
```

---

**Ready to start?** Make sure you've completed step 2 (TMDB API Key) before running!
