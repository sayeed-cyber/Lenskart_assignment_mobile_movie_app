import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/storage_service.dart';

class WatchlistProvider with ChangeNotifier {
  final StorageService _storageService = StorageService();
  
  List<Movie> _watchlist = [];
  bool _isLoading = false;

  List<Movie> get watchlist => _watchlist;
  bool get isLoading => _isLoading;
  
  int get count => _watchlist.length;
  bool get isEmpty => _watchlist.isEmpty;

  // Load watchlist from storage
  Future<void> loadWatchlist() async {
    _isLoading = true;
    notifyListeners();

    try {
      _watchlist = await _storageService.getWatchlist();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add to watchlist
  Future<bool> addToWatchlist(Movie movie) async {
    try {
      final success = await _storageService.addToWatchlist(movie);
      if (success) {
        await loadWatchlist();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // Remove from watchlist
  Future<bool> removeFromWatchlist(int movieId) async {
    try {
      final success = await _storageService.removeFromWatchlist(movieId);
      if (success) {
        await loadWatchlist();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // Toggle watchlist
  Future<bool> toggleWatchlist(Movie movie) async {
    final isInList = await isInWatchlist(movie.id);
    if (isInList) {
      return await removeFromWatchlist(movie.id);
    } else {
      return await addToWatchlist(movie);
    }
  }

  // Check if movie is in watchlist
  Future<bool> isInWatchlist(int movieId) async {
    return await _storageService.isInWatchlist(movieId);
  }

  // Check synchronously (from loaded list)
  bool isInWatchlistSync(int movieId) {
    return _watchlist.any((m) => m.id == movieId);
  }

  // Clear all watchlist
  Future<void> clearAllWatchlist() async {
    _watchlist = [];
    await _storageService.saveWatchlist([]);
    notifyListeners();
  }
}
