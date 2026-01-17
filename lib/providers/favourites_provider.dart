import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/storage_service.dart';

class FavouritesProvider with ChangeNotifier {
  final StorageService _storageService = StorageService();
  
  List<Movie> _favourites = [];
  bool _isLoading = false;

  List<Movie> get favourites => _favourites;
  bool get isLoading => _isLoading;
  
  int get count => _favourites.length;
  bool get isEmpty => _favourites.isEmpty;

  // Load favourites from storage
  Future<void> loadFavourites() async {
    _isLoading = true;
    notifyListeners();

    try {
      _favourites = await _storageService.getFavourites();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add to favourites
  Future<bool> addToFavourites(Movie movie) async {
    try {
      final success = await _storageService.addToFavourites(movie);
      if (success) {
        await loadFavourites();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // Remove from favourites
  Future<bool> removeFromFavourites(int movieId) async {
    try {
      final success = await _storageService.removeFromFavourites(movieId);
      if (success) {
        await loadFavourites();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // Toggle favourite
  Future<bool> toggleFavourite(Movie movie) async {
    final isFav = await isFavourite(movie.id);
    if (isFav) {
      return await removeFromFavourites(movie.id);
    } else {
      return await addToFavourites(movie);
    }
  }

  // Check if movie is in favourites
  Future<bool> isFavourite(int movieId) async {
    return await _storageService.isFavourite(movieId);
  }

  // Check synchronously (from loaded list)
  bool isFavouriteSync(int movieId) {
    return _favourites.any((m) => m.id == movieId);
  }

  // Clear all favourites
  Future<void> clearAllFavourites() async {
    _favourites = [];
    await _storageService.saveFavourites([]);
    notifyListeners();
  }
}
