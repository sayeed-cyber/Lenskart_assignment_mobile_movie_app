import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../widgets/movie_card.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart' as custom_error;

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleSearch(String query) {
    final provider = context.read<MovieProvider>();
    if (query.isEmpty) {
      setState(() => _isSearching = false);
      provider.clearSearch();
    } else {
      setState(() => _isSearching = true);
      provider.searchMovies(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await context.read<MovieProvider>().refreshAll();
          },
          color: const Color(0xFFE50914),
          child: CustomScrollView(
            slivers: [
              // App Bar
              SliverAppBar(
                floating: true,
                backgroundColor: const Color(0xFF141414),
                elevation: 0,
                title: const Text(
                  'Assignment_MovieApp',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    color: Colors.white,
                  ),
                ),
              ),

              // Search Bar
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _searchController,
                    onChanged: _handleSearch,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search movies...',
                      hintStyle: const TextStyle(color: Color(0xFF888888)),
                      prefixIcon: const Icon(Icons.search, color: Color(0xFF888888)),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, color: Color(0xFF888888)),
                              onPressed: () {
                                _searchController.clear();
                                _handleSearch('');
                              },
                            )
                          : null,
                      filled: true,
                      fillColor: const Color(0xFF2F2F2F),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),

              // Content
              if (_isSearching)
                _buildSearchResults()
              else
                _buildMovieSections(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    return Consumer<MovieProvider>(
      builder: (context, provider, child) {
        if (provider.isSearching) {
          return const SliverFillRemaining(
            child: LoadingWidget(),
          );
        }

        if (provider.searchError != null) {
          return SliverFillRemaining(
            child: custom_error.ErrorDisplayWidget(
              message: provider.searchError!,
              onRetry: () => _handleSearch(_searchController.text),
            ),
          );
        }

        if (provider.searchResults.isEmpty) {
          return SliverFillRemaining(
            child: custom_error.EmptyStateWidget(
              icon: Icons.search_off,
              title: 'No Results Found',
              message: 'Try searching with different keywords',
            ),
          );
        }

        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.65,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return MovieGridCard(movie: provider.searchResults[index]);
              },
              childCount: provider.searchResults.length,
            ),
          ),
        );
      },
    );
  }

  Widget _buildMovieSections() {
    return SliverList(
      delegate: SliverChildListDelegate([
        _buildNowPlayingSection(),
        const SizedBox(height: 24),
        _buildPopularSection(),
        const SizedBox(height: 24),
        _buildTopRatedSection(),
        const SizedBox(height: 24),
        _buildUpcomingSection(),
        const SizedBox(height: 24),
      ]),
    );
  }

  Widget _buildNowPlayingSection() {
    return Consumer<MovieProvider>(
      builder: (context, provider, child) {
        return _buildMovieSection(
          title: 'Now Playing',
          movies: provider.nowPlayingMovies,
          isLoading: provider.isLoadingNowPlaying,
          error: provider.nowPlayingError,
          onRetry: provider.loadNowPlayingMovies,
        );
      },
    );
  }

  Widget _buildPopularSection() {
    return Consumer<MovieProvider>(
      builder: (context, provider, child) {
        return _buildMovieSection(
          title: 'Popular',
          movies: provider.popularMovies,
          isLoading: provider.isLoadingPopular,
          error: provider.popularError,
          onRetry: provider.loadPopularMovies,
        );
      },
    );
  }

  Widget _buildTopRatedSection() {
    return Consumer<MovieProvider>(
      builder: (context, provider, child) {
        return _buildMovieSection(
          title: 'Top Rated',
          movies: provider.topRatedMovies,
          isLoading: provider.isLoadingTopRated,
          error: provider.topRatedError,
          onRetry: provider.loadTopRatedMovies,
        );
      },
    );
  }

  Widget _buildUpcomingSection() {
    return Consumer<MovieProvider>(
      builder: (context, provider, child) {
        return _buildMovieSection(
          title: 'Upcoming',
          movies: provider.upcomingMovies,
          isLoading: provider.isLoadingUpcoming,
          error: provider.upcomingError,
          onRetry: provider.loadUpcomingMovies,
        );
      },
    );
  }

  Widget _buildMovieSection({
    required String title,
    required List movies,
    required bool isLoading,
    required String? error,
    required VoidCallback onRetry,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 24,
                decoration: BoxDecoration(
                  color: const Color(0xFFE50914),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        if (isLoading)
          const HorizontalMovieListShimmer()
        else if (error != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: custom_error.ErrorDisplayWidget(
              message: error,
              onRetry: onRetry,
            ),
          )
        else if (movies.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: custom_error.EmptyStateWidget(
              title: 'No Movies',
              message: 'No movies available at the moment',
            ),
          )
        else
          SizedBox(
            height: 260,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return MovieCard(movie: movies[index]);
              },
            ),
          ),
      ],
    );
  }
}
