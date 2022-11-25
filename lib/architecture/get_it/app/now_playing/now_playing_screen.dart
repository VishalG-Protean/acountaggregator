import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:proteanmobileapp/core/lib/ui/scrollable_movies_page_builder.dart';
import 'package:proteanmobileapp/core/lib/models/app_state/now_playing_state.dart';
import 'package:proteanmobileapp/architecture/get_it/app/now_playing/favourite_movies_grid.dart';
import 'package:proteanmobileapp/architecture/get_it/app/now_playing/now_playing_model.dart';

class NowPlayingPage extends StatelessWidget with GetItMixin {
  static const moviesGridKey = Key('moviesGrid');

  @override
  Widget build(BuildContext context) {
    return ScrollableMoviesPageBuilder(
      title: 'Get_It Now Playing',
      onNextPageRequested: () {
        final moviesModel = get<NowPlayingModel>();
        moviesModel.fetchNextPage();
      },
      builder: (_, controller) {

        final state = watch<NowPlayingModel, NowPlayingState>();
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
