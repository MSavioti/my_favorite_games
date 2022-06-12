import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:my_favorite_games/app/infrastructure/env.dart';
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
  serviceLocator.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: Env.baseUrl,
        connectTimeout: 10000,
        receiveTimeout: 10000,
        validateStatus: (status) {
          return status != null && status <= 402;
        },
      ),
    ),
  );
}
