import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/lib/models/app_state/app_startup_state.dart';
import '../../../../core/lib/persistence/data_store.dart';

class AppStartupModel extends StateNotifier<AppStartupState> {
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
        state = AppStartupState.needsProfile();
      } else {
        state = AppStartupState.profileLoaded(profilesData);
      }
    });
  }
}
