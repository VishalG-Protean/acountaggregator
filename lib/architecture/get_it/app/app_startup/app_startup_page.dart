import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:proteanmobileapp/core/lib/ui/home_navigation_builder.dart';
import 'package:proteanmobileapp/architecture/get_it/app/app_startup/app_startup_model.dart';
import 'package:proteanmobileapp/architecture/get_it/app/favourites/favourites_screen.dart';
import 'package:proteanmobileapp/architecture/get_it/app/now_playing/now_playing_screen.dart';
import 'package:proteanmobileapp/architecture/get_it/app/profile_selection/profile_selection_screen.dart';
import 'package:proteanmobileapp/core/lib/models/app_state/app_startup_state.dart';

/// This is the "root" widget of the app, which sits just below MaterialApp.
/// It performs app-state initialization and returns the appropriate page.
class AppStartupPage extends StatelessWidget with GetItMixin {
  @override
  Widget build(BuildContext context) {

    final state = watch<AppStartupModel, AppStartupState>();
    return state.when(
      initializing: () => const Center(child: CircularProgressIndicator()),
      needsProfile: () => ProfileSelectionPage(),
      profileLoaded: (profilesData) => HomeNavigationBuilder(
        builder: (context, tabItem) {
          if (tabItem == TabItem.nowPlaying) {
            return NowPlayingPage();
          } else if (tabItem == TabItem.favourites) {
            return FavouritesPage();
          } else {
            return ProfileSelectionPage();
          }
        },
      ),
    );
  }
}
