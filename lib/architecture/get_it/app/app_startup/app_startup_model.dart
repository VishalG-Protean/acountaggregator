import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:proteanmobileapp/core/lib/models/app_state/app_startup_state.dart';
import 'package:proteanmobileapp/core/lib/persistence/data_store.dart';

class AppStartupModel extends ValueNotifier<AppStartupState> {
  AppStartupModel({required this.dataStore})
      : super(const AppStartupState.initializing()) {
    init();
  }

  final DataStore dataStore;
  late StreamSubscription _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void init() {

    _subscription = dataStore.profilesData().listen((profilesData) {

      if (profilesData.selectedId == null || profilesData.profiles.isEmpty) {
        value = AppStartupState.needsProfile();
      } else {
        value = AppStartupState.profileLoaded(profilesData);
      }

    });

  }

}
