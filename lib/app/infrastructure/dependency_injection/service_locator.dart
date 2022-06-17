import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:my_favorite_games/app/infrastructure/environment/env.dart';
import 'package:my_favorite_games/app/shared/models/hive/hive_game_model.dart';
import 'package:path_provider/path_provider.dart';

final serviceLocator = GetIt.instance;

Future<void> initializeServiceLocator() async {
  WidgetsFlutterBinding.ensureInitialized();
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
