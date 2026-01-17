import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/movie.dart';

class StorageService {
  static const String _favouritesKey = 'favourites';
  static const String _watchlistKey = 'watchlist';

  // Favourites
  Future<List<Movie>> getFavourites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? favouritesJson = prefs.getString(_favouritesKey);
      
      if (favouritesJson == null) return [];
      
      final List<dynamic> decoded = json.decode(favouritesJson);
      return decoded.map((json) => Movie.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<bool> saveFavourites(List<Movie> movies) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<Map<String, dynamic>> jsonList =
          movies.map((movie) => movie.toJson()).toList();
      final String encoded = json.encode(jsonList);
      return await prefs.setString(_favouritesKey, encoded);
    } catch (e) {
      return false;
    }
  }

  Future<bool> addToFavourites(Movie movie) async {
    try {
      final favourites = await getFavourites();
      
      // Check if already exists
      if (favourites.any((m) => m.id == movie.id)) {
        return true;
      }
      
      favourites.add(movie);
      return await saveFavourites(favourites);
    } catch (e) {
      return false;
    }
  }

  Future<bool> removeFromFavourites(int movieId) async {
    try {
      final favourites = await getFavourites();
      favourites.removeWhere((m) => m.id == movieId);
      return await saveFavourites(favourites);
    } catch (e) {
      return false;
    }
  }

  Future<bool> isFavourite(int movieId) async {
    try {
      final favourites = await getFavourites();
      return favourites.any((m) => m.id == movieId);
    } catch (e) {
      return false;
    }
  }

  // Watchlist
  Future<List<Movie>> getWatchlist() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? watchlistJson = prefs.getString(_watchlistKey);
      
      if (watchlistJson == null) return [];
      
      final List<dynamic> decoded = json.decode(watchlistJson);
      return decoded.map((json) => Movie.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<bool> saveWatchlist(List<Movie> movies) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<Map<String, dynamic>> jsonList =
          movies.map((movie) => movie.toJson()).toList();
      final String encoded = json.encode(jsonList);
      return await prefs.setString(_watchlistKey, encoded);
    } catch (e) {
      return false;
    }
  }

  Future<bool> addToWatchlist(Movie movie) async {
    try {
      final watchlist = await getWatchlist();
      
      // Check if already exists
      if (watchlist.any((m) => m.id == movie.id)) {
        return true;
      }
      
      watchlist.add(movie);
      return await saveWatchlist(watchlist);
    } catch (e) {
      return false;
    }
  }

  Future<bool> removeFromWatchlist(int movieId) async {
    try {
      final watchlist = await getWatchlist();
      watchlist.removeWhere((m) => m.id == movieId);
      return await saveWatchlist(watchlist);
    } catch (e) {
      return false;
    }
  }

  Future<bool> isInWatchlist(int movieId) async {
    try {
      final watchlist = await getWatchlist();
      return watchlist.any((m) => m.id == movieId);
    } catch (e) {
      return false;
    }
  }

  // Clear all data
  Future<bool> clearAllData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_favouritesKey);
      await prefs.remove(_watchlistKey);
      return true;
    } catch (e) {
      return false;
    }
  }
}
