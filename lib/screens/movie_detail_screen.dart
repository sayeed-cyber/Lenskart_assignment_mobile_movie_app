import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../models/movie.dart';
import '../models/movie_detail.dart';
import '../services/api_service.dart';
import '../constants/api_constants.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart' as custom_error;
import '../providers/favourites_provider.dart';
import '../providers/watchlist_provider.dart';
import 'dart:math' as math;

class MovieDetailScreen extends StatefulWidget {
  final int movieId;

  const MovieDetailScreen({super.key, required this.movieId});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final ApiService _apiService = ApiService();
  late Future<MovieDetail> _movieDetailFuture;
  bool _isFavourite = false;
  bool _isInWatchlist = false;

  @override
  void initState() {
    super.initState();
    _movieDetailFuture = _apiService.getMovieDetails(widget.movieId);
    _checkFavouriteStatus();
    _checkWatchlistStatus();
  }

  Future<void> _checkFavouriteStatus() async {
    final isFav = await context.read<FavouritesProvider>().isFavourite(widget.movieId);
    if (mounted) {
      setState(() => _isFavourite = isFav);
    }
  }

  Future<void> _checkWatchlistStatus() async {
    final isInList = await context.read<WatchlistProvider>().isInWatchlist(widget.movieId);
    if (mounted) {
      setState(() => _isInWatchlist = isInList);
    }
  }

  void _showPlayingNotification() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.play_circle_outline, color: Colors.white),
            SizedBox(width: 12),
            Text(
              'Movie is Playing',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        backgroundColor: const Color(0xFFE50914),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
  }

  Future<void> _toggleFavourite(MovieDetail detail) async {
    final movie = Movie(
      id: detail.id,
      title: detail.title,
      overview: detail.overview,
      posterPath: detail.posterPath,
      backdropPath: detail.backdropPath,
      releaseDate: detail.releaseDate,
      voteAverage: detail.voteAverage,
      voteCount: detail.voteCount,
      genreIds: detail.genres.map((g) => g.id).toList(),
      popularity: detail.popularity,
      originalLanguage: '',
    );

    final success = await context.read<FavouritesProvider>().toggleFavourite(movie);
    if (success) {
      setState(() => _isFavourite = !_isFavourite);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isFavourite ? 'Added to Favourites' : 'Removed from Favourites'),
            backgroundColor: const Color(0xFFE50914),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    }
  }

  Future<void> _toggleWatchlist(MovieDetail detail) async {
    final movie = Movie(
      id: detail.id,
      title: detail.title,
      overview: detail.overview,
      posterPath: detail.posterPath,
      backdropPath: detail.backdropPath,
      releaseDate: detail.releaseDate,
      voteAverage: detail.voteAverage,
      voteCount: detail.voteCount,
      genreIds: detail.genres.map((g) => g.id).toList(),
      popularity: detail.popularity,
      originalLanguage: '',
    );

    final success = await context.read<WatchlistProvider>().toggleWatchlist(movie);
    if (success) {
      setState(() => _isInWatchlist = !_isInWatchlist);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isInWatchlist ? 'Added to Watchlist' : 'Removed from Watchlist'),
            backgroundColor: const Color(0xFFE50914),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<MovieDetail>(
        future: _movieDetailFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }

          if (snapshot.hasError) {
            return custom_error.ErrorDisplayWidget(
              message: snapshot.error.toString(),
              onRetry: () {
                setState(() {
                  _movieDetailFuture = _apiService.getMovieDetails(widget.movieId);
                });
              },
            );
          }

          if (!snapshot.hasData) {
            return const custom_error.EmptyStateWidget(
              title: 'No Data',
              message: 'Movie details not found',
            );
          }

          final movie = snapshot.data!;
          return _buildMovieDetail(movie);
        },
      ),
    );
  }

  Widget _buildMovieDetail(MovieDetail movie) {
    return CustomScrollView(
      slivers: [
        // Movie Banner with gradient
        SliverAppBar(
          expandedHeight: 400,
          pinned: true,
          backgroundColor: const Color(0xFF141414),
          leading: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              fit: StackFit.expand,
              children: [
                // Backdrop image
                if (movie.backdropPath != null)
                  CachedNetworkImage(
                    imageUrl: ApiConstants.getOriginalImageUrl(movie.backdropPath!),
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: const Color(0xFF2F2F2F),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: const Color(0xFF2F2F2F),
                      child: const Icon(Icons.movie, size: 60, color: Color(0xFF666666)),
                    ),
                  )
                else
                  Container(
                    color: const Color(0xFF2F2F2F),
                    child: const Icon(Icons.movie, size: 60, color: Color(0xFF666666)),
                  ),
                // Gradient overlay
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                        const Color(0xFF141414),
                      ],
                      stops: const [0.3, 0.7, 1.0],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Movie Details
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  movie.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                // Year, Runtime, Status
                Row(
                  children: [
                    Text(
                      movie.getYear(),
                      style: const TextStyle(
                        color: Color(0xFFB3B3B3),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: const BoxDecoration(
                        color: Color(0xFFB3B3B3),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      movie.getRuntimeFormatted(),
                      style: const TextStyle(
                        color: Color(0xFFB3B3B3),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF666666)),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        movie.status,
                        style: const TextStyle(
                          color: Color(0xFFB3B3B3),
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Rating and Actions
                Row(
                  children: [
                    // Circular Progress Rating
                    CircularRatingWidget(
                      rating: movie.getRatingPercentage(),
                    ),
                    const SizedBox(width: 24),

                    // Favourite Button
                    _buildActionButton(
                      icon: _isFavourite ? Icons.favorite : Icons.favorite_outline,
                      label: 'Favourite',
                      onTap: () => _toggleFavourite(movie),
                      isActive: _isFavourite,
                    ),
                    const SizedBox(width: 16),

                    // Watchlist Button
                    _buildActionButton(
                      icon: _isInWatchlist ? Icons.bookmark : Icons.bookmark_outline,
                      label: 'Watchlist',
                      onTap: () => _toggleWatchlist(movie),
                      isActive: _isInWatchlist,
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Genres
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: movie.genres.map((genre) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2F2F2F),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFE50914).withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        genre.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),

                // Tagline
                if (movie.tagline.isNotEmpty) ...[
                  Text(
                    '"${movie.tagline}"',
                    style: const TextStyle(
                      color: Color(0xFFE50914),
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Overview Section
                const Text(
                  'Overview',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  movie.overview,
                  style: const TextStyle(
                    color: Color(0xFFB3B3B3),
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),

                // Release Date
                _buildInfoRow('Release Date', movie.releaseDate),
                const SizedBox(height: 12),
                _buildInfoRow('Rating', '${movie.voteAverage}/10 (${movie.voteCount} votes)'),
                const SizedBox(height: 32),

                // Play Now Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton.icon(
                    onPressed: _showPlayingNotification,
                    icon: const Icon(Icons.play_arrow_rounded, size: 32),
                    label: const Text(
                      'Play Now',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE50914),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 8,
                      shadowColor: const Color(0xFFE50914).withOpacity(0.5),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isActive = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isActive
                  ? const Color(0xFFE50914).withOpacity(0.2)
                  : const Color(0xFF2F2F2F),
              shape: BoxShape.circle,
              border: Border.all(
                color: isActive ? const Color(0xFFE50914) : Colors.transparent,
                width: 2,
              ),
            ),
            child: Icon(
              icon,
              color: isActive ? const Color(0xFFE50914) : Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              color: isActive ? const Color(0xFFE50914) : const Color(0xFFB3B3B3),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xFF888888),
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

// Circular Rating Widget
class CircularRatingWidget extends StatelessWidget {
  final int rating; // 0-100

  const CircularRatingWidget({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    final percentage = rating / 100;
    final color = _getRatingColor(rating);

    return SizedBox(
      width: 80,
      height: 80,
      child: Stack(
        children: [
          // Background circle
          CustomPaint(
            size: const Size(80, 80),
            painter: CircularProgressPainter(
              progress: 1.0,
              color: const Color(0xFF2F2F2F),
              strokeWidth: 6,
            ),
          ),
          // Progress circle
          CustomPaint(
            size: const Size(80, 80),
            painter: CircularProgressPainter(
              progress: percentage,
              color: color,
              strokeWidth: 6,
            ),
          ),
          // Rating text
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$rating%',
                  style: TextStyle(
                    color: color,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Score',
                  style: TextStyle(
                    color: Color(0xFF888888),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getRatingColor(int rating) {
    if (rating >= 70) return const Color(0xFF21D07A);
    if (rating >= 50) return const Color(0xFFD2D531);
    return const Color(0xFFDB2360);
  }
}

class CircularProgressPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  CircularProgressPainter({
    required this.progress,
    required this.color,
    this.strokeWidth = 8,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}
