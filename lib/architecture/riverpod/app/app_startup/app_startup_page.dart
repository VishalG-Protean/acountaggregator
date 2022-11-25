import 'package:flutter/material.dart';
import '../../top_level_providers.dart';
import '../favourites/favourites_screen.dart';
import '../now_playing/now_playing_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../profile_selection/profile_selection_screen.dart';
import '../../../../core/lib/ui/home_navigation_builder.dart';

/// This is the "root" widget of the app, which sits just below MaterialApp.
/// It performs app-state initialization and returns the appropriate page.

class AppStartupPage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(appStartupModelProvider);
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
