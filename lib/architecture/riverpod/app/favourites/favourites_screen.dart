import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/lib/models/tmdb/tmdb_movie_basic.dart';
import '../../../../core/lib/ui/movies_grid.dart';
import '../../../../core/lib/ui/scrollable_movies_page_builder.dart';
import '../../top_level_providers.dart';

final profileFavouriteMoviesProvider =
    StreamProvider.autoDispose<List<TMDBMovieBasic>>((ref) {
  final dataStore = ref.watch(dataStoreProvider);
  final profilesData = ref.watch(profilesDataProvider);
  if (profilesData.selectedId != null) {
    return dataStore.favouriteMovies(profileId: profilesData.selectedId!);
  } else {
    throw UnimplementedError();
  }
});

class FavouritesPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileFavouriteMovies = ref.watch(profileFavouriteMoviesProvider);
    return profileFavouriteMovies.when(
      data: (movies) => ScrollableMoviesPageBuilder(
        title: 'RiverPod Favourites',
        builder: (_, __) => MoviesGrid(movies: movies),
      ),
      loading: () => Center(child: CircularProgressIndicator()),
      error: (_, __) => Container(),
    );
  }
}
