import 'package:proteanmobileapp/core/lib/models/app_models/profiles_data.dart';
import 'package:proteanmobileapp/core/lib/models/tmdb/tmdb_movie_basic.dart';
import 'package:proteanmobileapp/core/lib/persistence/data_store.dart';
import 'package:proteanmobileapp/core/lib/ui/movies_grid.dart';
import 'package:proteanmobileapp/core/lib/ui/scrollable_movies_page_builder.dart';
import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

class FavouritesPage extends StatelessWidget with GetItMixin {
  @override
  Widget build(BuildContext context) {
    final profilesData = watchStream<DataStore, ProfilesData>(
            (dataStore) => dataStore.profilesData(), ProfilesData())
        .data;
    if (profilesData != null && profilesData.selectedId != null) {
      final profileFavouriteMovies =
          watchStream<DataStore, List<TMDBMovieBasic>>(
              (dataStore) => dataStore.favouriteMovies(
                  profileId: profilesData.selectedId!),
              []).data!;
      return ScrollableMoviesPageBuilder(
        title: 'Get_It Favourites',
        builder: (_, __) => MoviesGrid(movies: profileFavouriteMovies),
      );
    } else {
      return Container();
    }
  }
}
