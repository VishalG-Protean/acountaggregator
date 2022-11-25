import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/lib/ui/profiles_grid.dart';
import '../../top_level_providers.dart';
import '../create_profile/create_profile_page_builder.dart';

class ProfileSelectionPage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profilesData = ref.watch(profilesDataProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('RiverPod Profile selection'),
      ),
      body: ProfilesGrid(
        profilesData: profilesData,
        onAddProfile: () => addProfile(context),
        onSelectedProfile: (profile) async {
          final dataStore = ref.read(dataStoreProvider);
          // the selected profile is an app-state variable.
          // changing this will cause a reload of AppStartupPage
          await dataStore.setSelectedProfile(profile);
        },
      ),
    );
  }

  Future<void> addProfile(BuildContext context) async {
    await Navigator.of(context).push<void>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => CreateProfilePageBuilder(),
      ),
    );
  }
}
