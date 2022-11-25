import 'package:proteanmobileapp/core/lib/models/app_models/profiles_data.dart';
import 'package:proteanmobileapp/core/lib/models/app_state/app_startup_state.dart';
import 'package:proteanmobileapp/core/lib/persistence/data_store.dart';
import 'package:proteanmobileapp/core/lib/ui/profiles_grid.dart';
import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:proteanmobileapp/architecture/get_it/app/app_startup/app_startup_model.dart';
import 'package:proteanmobileapp/architecture/get_it/app/create_profile/create_profile_page_builder.dart';

class ProfileSelectionPage extends StatelessWidget with GetItMixin {
  Future<void> addProfile(BuildContext context) async {
    await Navigator.of(context).push<void>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => CreateProfilePageBuilder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = watch<AppStartupModel, AppStartupState>();
    final profilesData = state.maybeWhen(
      profileLoaded: (profilesData) => profilesData,
      orElse: () => ProfilesData(profiles: {}),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get_It Profile selection'),
      ),
      body: ProfilesGrid(
        profilesData: profilesData,
        onAddProfile: () => addProfile(context),
        onSelectedProfile: (profile) async {
          final dataStore = get<DataStore>();
          // the selected profile is an app-state variable.
          // changing this will cause a reload of AppStartupPage
          await dataStore.setSelectedProfile(profile);
        },
      ),
    );
  }
}
