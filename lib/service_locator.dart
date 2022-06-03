import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

Future<void> initializeServiceLocator() async {
  _initCore();
  _initFeatures();
  _initRepositories();
  _initDataSources();
  await _initExternalDependencies();
}

void _initCore() {}

void _initFeatures() {}

void _initRepositories() {}

void _initDataSources() {}

Future<void> _initExternalDependencies() async {
  serviceLocator.registerLazySingletonAsync<SharedPreferences>(
      () async => await SharedPreferences.getInstance());
  serviceLocator.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());
}
