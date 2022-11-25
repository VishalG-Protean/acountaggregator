import 'package:proteanmobileapp/core/lib/api/tmdb_api.dart';
import 'package:proteanmobileapp/core/lib/persistence/data_store.dart';
import 'package:proteanmobileapp/core/lib/persistence/sembast_data_store.dart';
import 'package:proteanmobileapp/architecture/get_it/app/app_startup/app_startup_model.dart';
import 'package:proteanmobileapp/architecture/get_it/app/app_startup/app_startup_page.dart';
import 'package:proteanmobileapp/architecture/get_it/app/now_playing/now_playing_model.dart';
import 'package:proteanmobileapp/architecture/get_it/service_locator.dart';
import 'package:proteanmobileapp/architecture/get_it/app/create_profile/create_profile_model.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize data store
  final dataStore = await SembastDataStore.makeDefault();

  getIt.registerSingleton<DataStore>(dataStore);

  getIt.registerLazySingleton<AppStartupModel>(
      () => AppStartupModel(dataStore: dataStore));

  getIt.registerLazySingleton<CreateProfileModel>(
      () => CreateProfileModel(dataStore: dataStore));

  getIt.registerLazySingleton<NowPlayingModel>(
      () => NowPlayingModel(api: TMDBClient()));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: AppStartupPage(),
    );
  }
}
