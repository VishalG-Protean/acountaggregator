import 'package:proteanmobileapp/core/lib/models/app_models/profiles_data.dart';
import 'package:proteanmobileapp/core/lib/models/app_state/app_startup_state.dart';
import 'package:proteanmobileapp/core/lib/models/tmdb/tmdb_movie_basic.dart';
import 'package:proteanmobileapp/core/lib/persistence/data_store.dart';
import 'package:proteanmobileapp/core/lib/ui/favourite_button.dart';
import 'package:proteanmobileapp/core/lib/ui/movies_grid.dart';
import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

import '../../service_locator.dart';

class FavouritesMovieGrid extends StatelessWidget {
  FavouritesMovieGrid(
      {Key? key, required this.movies, required this.controller})
      : super(key: key);
  final List<TMDBMovieBasic> movies;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return MoviesGrid(
      movies: movies,
      controller: controller,
      favouriteBuilder: (context, movie) {
        return FavouriteMovieWidget(movie: movie);
      },
    );
  }
}

class FavouriteMovieWidget extends StatelessWidget with GetItMixin {
  FavouriteMovieWidget({Key? key, required this.movie}) : super(key: key);
  final TMDBMovieBasic movie;
  @override
  Widget build(BuildContext context) {
    final profilesData = watchStream<DataStore, ProfilesData>(
            (dataStore) => dataStore.profilesData(), ProfilesData())
        .data;
    if (profilesData != null && profilesData.selectedId != null) {
      final isFavouriteSnapshot = watchStream<DataStore, bool>(
          (dataStore) => dataStore.favouriteMovie(
              profileId: profilesData.selectedId!, movie: movie),
          false);
      if (isFavouriteSnapshot.hasData) {
        return FavouriteButton(
          isFavourite: isFavouriteSnapshot.data!,
          onFavouriteChanged: (isFavourite) {
            if (profilesData.selectedId != null) {
              /// Storing Movie into Profile List using DB
              final dataStore = getIt<DataStore>();
              dataStore.setFavouriteMovie(
                profileId: profilesData.selectedId!,
                movie: movie,
                isFavourite: isFavourite,
              );
            }
          },
        );
      } else {
        return Container();
      }
    } else {
      return Container();
    }
  }
}
