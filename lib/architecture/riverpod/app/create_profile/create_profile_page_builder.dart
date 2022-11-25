import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/lib/models/app_state/create_profile_state.dart';
import '../../../../core/lib/ui/create_profile_page.dart';
import '../../top_level_providers.dart';
import 'create_profile_model.dart';

final createProfileModelProvider =
    StateNotifierProvider<CreateProfileModel, CreateProfileState>((ref) {
  final dataStore = ref.watch(dataStoreProvider);
  return CreateProfileModel(dataStore: dataStore);
});

class CreateProfilePageBuilder extends ConsumerWidget {
  Future<void> createProfile(
      BuildContext context, WidgetRef ref, String name) async {
    final model = ref.read(createProfileModelProvider.notifier);
    final success = await model.createProfile(name);
    if (success) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(createProfileModelProvider);
    return CreateProfilePage(
      onSubmit: (name) => createProfile(context, ref, name),
      isLoading: state.maybeWhen(
        loading: () => true,
        orElse: () => false,
      ),
      errorText: state.maybeWhen(
        error: (error) => error,
        orElse: () => null,
      ),
    );
  }
}
