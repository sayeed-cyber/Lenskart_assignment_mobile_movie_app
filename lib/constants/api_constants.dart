class ApiConstants {
    
  static const String apiKey = 'f408cee07590661f1b8ae34ae8f8e823';
  
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  static const String originalImageBaseUrl = 'https://image.tmdb.org/t/p/original';
  
  // Endpoints
  static const String popularMovies = '/movie/popular';
  static const String topRatedMovies = '/movie/top_rated';
  static const String nowPlayingMovies = '/movie/now_playing';
  static const String upcomingMovies = '/movie/upcoming';
  static const String searchMovie = '/search/movie';
  static const String movieDetails = '/movie';
  static const String genreList = '/genre/movie/list';
  
  // Helper methods
  static String getImageUrl(String? path) {
    if (path == null || path.isEmpty) return '';
    return '$imageBaseUrl$path';
  }
  
  static String getOriginalImageUrl(String? path) {
    if (path == null || path.isEmpty) return '';
    return '$originalImageBaseUrl$path';
  }
}
