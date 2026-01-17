class Genre {
  final int id;
  final String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class GenreHelper {
  static final Map<int, String> _genreMap = {
    28: 'Action',
    12: 'Adventure',
    16: 'Animation',
    35: 'Comedy',
    80: 'Crime',
    99: 'Documentary',
    18: 'Drama',
    10751: 'Family',
    14: 'Fantasy',
    36: 'History',
    27: 'Horror',
    10402: 'Music',
    9648: 'Mystery',
    10749: 'Romance',
    878: 'Sci-Fi',
    10770: 'TV Movie',
    53: 'Thriller',
    10752: 'War',
    37: 'Western',
  };

  static String getGenreName(int id) {
    return _genreMap[id] ?? 'Unknown';
  }

  static List<String> getGenreNames(List<int> genreIds) {
    return genreIds.map((id) => getGenreName(id)).toList();
  }

  static String getGenreString(List<int> genreIds, {int maxGenres = 3}) {
    final names = getGenreNames(genreIds);
    if (names.isEmpty) return 'No genres';
    return names.take(maxGenres).join(' • ');
  }
}
