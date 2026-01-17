class MovieDetail {
  final int id;
  final String title;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final String releaseDate;
  final double voteAverage;
  final int voteCount;
  final List<Genre> genres;
  final int runtime;
  final String status;
  final String tagline;
  final double popularity;

  MovieDetail({
    required this.id,
    required this.title,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.genres,
    required this.runtime,
    required this.status,
    required this.tagline,
    required this.popularity,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    return MovieDetail(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Unknown',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      releaseDate: json['release_date'] ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      voteCount: json['vote_count'] ?? 0,
      genres: (json['genres'] as List?)
              ?.map((g) => Genre.fromJson(g))
              .toList() ??
          [],
      runtime: json['runtime'] ?? 0,
      status: json['status'] ?? '',
      tagline: json['tagline'] ?? '',
      popularity: (json['popularity'] ?? 0).toDouble(),
    );
  }

  String getYear() {
    if (releaseDate.isEmpty) return 'TBA';
    try {
      return releaseDate.split('-')[0];
    } catch (e) {
      return 'TBA';
    }
  }

  String getRuntimeFormatted() {
    if (runtime == 0) return 'N/A';
    final hours = runtime ~/ 60;
    final minutes = runtime % 60;
    return '${hours}h ${minutes}m';
  }

  String getGenresString() {
    if (genres.isEmpty) return 'No genres';
    return genres.map((g) => g.name).join(', ');
  }

  int getRatingPercentage() {
    return (voteAverage * 10).round();
  }
}

class Genre {
  final int id;
  final String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}
