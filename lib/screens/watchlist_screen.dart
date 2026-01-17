import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/watchlist_provider.dart';
import '../widgets/movie_card.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart' as custom_error;

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE50914).withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.bookmark,
                      color: Color(0xFFE50914),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'My Watchlist',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  Consumer<WatchlistProvider>(
                    builder: (context, provider, child) {
                      if (provider.watchlist.isEmpty) return const SizedBox();
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE50914),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          '${provider.count}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: Consumer<WatchlistProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const LoadingWidget();
                  }

                  if (provider.watchlist.isEmpty) {
                    return custom_error.EmptyStateWidget(
                      icon: Icons.bookmark_outline,
                      title: 'No Watchlist Yet',
                      message:
                          'Movies you want to watch later will appear here.\nAdd some movies to your watchlist!',
                      actionLabel: 'Browse Movies',
                      onAction: () {
                        // Switch to Movies tab (index 0)
                        DefaultTabController.of(context).animateTo(0);
                      },
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      await provider.loadWatchlist();
                    },
                    color: const Color(0xFFE50914),
                    child: GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.65,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: provider.watchlist.length,
                      itemBuilder: (context, index) {
                        return MovieGridCard(
                          movie: provider.watchlist[index],
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
