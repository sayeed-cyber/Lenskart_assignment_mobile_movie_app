import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/movie.dart';
import '../models/genre.dart';
import '../constants/api_constants.dart';
import '../screens/movie_detail_screen.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final double width;
  final double height;

  const MovieCard({
    super.key,
    required this.movie,
    this.width = 140,
    this.height = 210,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailScreen(movieId: movie.id),
          ),
        );
      },
      child: Container(
        width: width,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Movie poster
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: width,
                height: height,
                color: const Color(0xFF2F2F2F),
                child: movie.posterPath != null
                    ? CachedNetworkImage(
                        imageUrl: ApiConstants.getImageUrl(movie.posterPath!),
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: const Color(0xFF2F2F2F),
                          child: const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Color(0xFFE50914),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: const Color(0xFF2F2F2F),
                          child: const Icon(
                            Icons.movie,
                            size: 40,
                            color: Color(0xFF666666),
                          ),
                        ),
                      )
                    : const Icon(
                        Icons.movie,
                        size: 40,
                        color: Color(0xFF666666),
                      ),
              ),
            ),
            const SizedBox(height: 8),
            // Movie title
            Text(
              movie.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            // Rating and year
            Row(
              children: [
                const Icon(
                  Icons.star_rounded,
                  color: Color(0xFFFFD700),
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  movie.getRating(),
                  style: const TextStyle(
                    color: Color(0xFFB3B3B3),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  movie.getYear(),
                  style: const TextStyle(
                    color: Color(0xFF888888),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MovieGridCard extends StatelessWidget {
  final Movie movie;

  const MovieGridCard({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailScreen(movieId: movie.id),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFF2F2F2F),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Movie poster
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(8)),
                child: movie.posterPath != null
                    ? CachedNetworkImage(
                        imageUrl: ApiConstants.getImageUrl(movie.posterPath!),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        placeholder: (context, url) => Container(
                          color: const Color(0xFF2F2F2F),
                          child: const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Color(0xFFE50914),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: const Color(0xFF2F2F2F),
                          child: const Icon(
                            Icons.movie,
                            size: 40,
                            color: Color(0xFF666666),
                          ),
                        ),
                      )
                    : Container(
                        color: const Color(0xFF2F2F2F),
                        child: const Icon(
                          Icons.movie,
                          size: 40,
                          color: Color(0xFF666666),
                        ),
                      ),
              ),
            ),
            // Movie info
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Color(0xFFFFD700),
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        movie.getRating(),
                        style: const TextStyle(
                          color: Color(0xFFB3B3B3),
                          fontSize: 11,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        movie.getYear(),
                        style: const TextStyle(
                          color: Color(0xFF888888),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    GenreHelper.getGenreString(movie.genreIds, maxGenres: 2),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF888888),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
