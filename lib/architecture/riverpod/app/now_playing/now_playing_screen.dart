import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proteanmobileapp/core/lib/api/tmdb_api.dart';
import 'package:proteanmobileapp/core/lib/models/app_state/now_playing_state.dart';
import 'package:proteanmobileapp/core/lib/ui/scrollable_movies_page_builder.dart';
import 'favourite_movies_grid.dart';
import 'now_playing_model.dart';

final moviesModelProvider =
    StateNotifierProvider<NowPlayingModel, NowPlayingState>(
        (ref) => NowPlayingModel(api: TMDBClient()));

class NowPlayingPage extends ConsumerWidget {
  static const moviesGridKey = Key('moviesGrid');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Below scrolling is with pagination feature
    return ScrollableMoviesPageBuilder(
      title: 'RiverPod Now Playing',
      onNextPageRequested: () {
        final moviesModel = ref.read(moviesModelProvider.notifier);
        moviesModel.fetchNextPage();
      },
      builder: (_, controller) {
        final state = ref.watch(moviesModelProvider);
        return state.when(
          data: (movies, _) => FavouritesMovieGrid(
            key: moviesGridKey,
            movies: movies,
            controller: controller,
          ),
          dataLoading: (movies) {
            return movies.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : FavouritesMovieGrid(
                    key: moviesGridKey,
                    movies: movies,
                    controller: controller,
                  );
          },
          error: (error) => Center(child: Text(error)),
        );
      },
    );
  }
}
