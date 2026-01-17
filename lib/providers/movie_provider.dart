import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/api_service.dart';

enum MovieCategory {
  popular,
  topRated,
  nowPlaying,
  upcoming,
}

class MovieProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  // Popular Movies
  List<Movie> _popularMovies = [];
  bool _isLoadingPopular = false;
  String? _popularError;

  // Top Rated Movies
  List<Movie> _topRatedMovies = [];
  bool _isLoadingTopRated = false;
  String? _topRatedError;

  // Now Playing Movies
  List<Movie> _nowPlayingMovies = [];
  bool _isLoadingNowPlaying = false;
  String? _nowPlayingError;

  // Upcoming Movies
  List<Movie> _upcomingMovies = [];
  bool _isLoadingUpcoming = false;
  String? _upcomingError;

  // Search
  List<Movie> _searchResults = [];
  bool _isSearching = false;
  String? _searchError;
  String _searchQuery = '';

  // Getters
  List<Movie> get popularMovies => _popularMovies;
  bool get isLoadingPopular => _isLoadingPopular;
  String? get popularError => _popularError;

  List<Movie> get topRatedMovies => _topRatedMovies;
  bool get isLoadingTopRated => _isLoadingTopRated;
  String? get topRatedError => _topRatedError;

  List<Movie> get nowPlayingMovies => _nowPlayingMovies;
  bool get isLoadingNowPlaying => _isLoadingNowPlaying;
  String? get nowPlayingError => _nowPlayingError;

  List<Movie> get upcomingMovies => _upcomingMovies;
  bool get isLoadingUpcoming => _isLoadingUpcoming;
  String? get upcomingError => _upcomingError;

  List<Movie> get searchResults => _searchResults;
  bool get isSearching => _isSearching;
  String? get searchError => _searchError;
  String get searchQuery => _searchQuery;

  // Load all movies
  Future<void> loadAllMovies() async {
    await Future.wait([
      loadPopularMovies(),
      loadTopRatedMovies(),
      loadNowPlayingMovies(),
      loadUpcomingMovies(),
    ]);
  }

  // Popular Movies
  Future<void> loadPopularMovies() async {
    _isLoadingPopular = true;
    _popularError = null;
    notifyListeners();

    try {
      _popularMovies = await _apiService.getPopularMovies();
      _isLoadingPopular = false;
      notifyListeners();
    } catch (e) {
      _popularError = e.toString();
      _isLoadingPopular = false;
      notifyListeners();
    }
  }

  // Top Rated Movies
  Future<void> loadTopRatedMovies() async {
    _isLoadingTopRated = true;
    _topRatedError = null;
    notifyListeners();

    try {
      _topRatedMovies = await _apiService.getTopRatedMovies();
      _isLoadingTopRated = false;
      notifyListeners();
    } catch (e) {
      _topRatedError = e.toString();
      _isLoadingTopRated = false;
      notifyListeners();
    }
  }

  // Now Playing Movies
  Future<void> loadNowPlayingMovies() async {
    _isLoadingNowPlaying = true;
    _nowPlayingError = null;
    notifyListeners();

    try {
      _nowPlayingMovies = await _apiService.getNowPlayingMovies();
      _isLoadingNowPlaying = false;
      notifyListeners();
    } catch (e) {
      _nowPlayingError = e.toString();
      _isLoadingNowPlaying = false;
      notifyListeners();
    }
  }

  // Upcoming Movies
  Future<void> loadUpcomingMovies() async {
    _isLoadingUpcoming = true;
    _upcomingError = null;
    notifyListeners();

    try {
      _upcomingMovies = await _apiService.getUpcomingMovies();
      _isLoadingUpcoming = false;
      notifyListeners();
    } catch (e) {
      _upcomingError = e.toString();
      _isLoadingUpcoming = false;
      notifyListeners();
    }
  }

  // Search Movies
  Future<void> searchMovies(String query) async {
    _searchQuery = query;

    if (query.isEmpty) {
      _searchResults = [];
      _searchError = null;
      _isSearching = false;
      notifyListeners();
      return;
    }

    _isSearching = true;
    _searchError = null;
    notifyListeners();

    try {
      _searchResults = await _apiService.searchMovies(query);
      _isSearching = false;
      notifyListeners();
    } catch (e) {
      _searchError = e.toString();
      _isSearching = false;
      notifyListeners();
    }
  }

  void clearSearch() {
    _searchResults = [];
    _searchQuery = '';
    _searchError = null;
    _isSearching = false;
    notifyListeners();
  }

  // Refresh all
  Future<void> refreshAll() async {
    await loadAllMovies();
  }
}
