import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:my_favorite_games/app/infrastructure/environment/env.dart';
import 'package:my_favorite_games/app/modules/favorites/data/datasources/local_data_source.dart';
import 'package:my_favorite_games/app/modules/favorites/data/datasources/local_data_source_implementation.dart';
import 'package:my_favorite_games/app/modules/favorites/data/repositories/favorites_repository_implementation.dart';
import 'package:my_favorite_games/app/modules/favorites/domain/repositories/favorites_repository.dart';
import 'package:my_favorite_games/app/shared/models/hive/hive_game_model.dart';
import 'package:path_provider/path_provider.dart';

final serviceLocator = GetIt.instance;

Future<void> initializeServiceLocator() async {
  WidgetsFlutterBinding.ensureInitialized();
  _initCore();
  await _initExternalDependencies();
  _initFeatures();
  _initRepositories();
  _initDataSources();
}

void _initCore() {}

Future<void> _initExternalDependencies() async {
  // Hive
  final documentsPath = await getApplicationDocumentsDirectory();
  Hive.init(documentsPath.path);
  Hive.registerAdapter(HiveGameModelAdapter());
  serviceLocator.registerLazySingletonAsync<Box>(
    () => Hive.openBox('favorites'),
    instanceName: 'favoritesBox',
  );

  // Internet Connection Checker
  serviceLocator.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());

  // Dio
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

void _initFeatures() {}

void _initRepositories() {
  serviceLocator.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImplementation(hiveInterface: Hive));
  serviceLocator.registerLazySingleton<FavoritesRepository>(() =>
      FavoritesRepositoryImplementation(localDataSource: serviceLocator()));
}

void _initDataSources() {}
