import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:my_favorite_games/app/core/network/network_info.dart';
import 'package:my_favorite_games/app/core/network/network_info_implementation.dart';
import 'package:my_favorite_games/app/infrastructure/environment/env.dart';
import 'package:my_favorite_games/app/modules/favorites/data/datasources/local_data_source.dart';
import 'package:my_favorite_games/app/modules/favorites/data/datasources/local_data_source_implementation.dart';
import 'package:my_favorite_games/app/modules/favorites/data/repositories/favorites_repository_implementation.dart';
import 'package:my_favorite_games/app/modules/favorites/domain/repositories/favorites_repository.dart';
import 'package:my_favorite_games/app/modules/favorites/domain/usecases/add_favorite_usecase.dart';
import 'package:my_favorite_games/app/modules/favorites/domain/usecases/get_favorites_usecase.dart';
import 'package:my_favorite_games/app/modules/favorites/domain/usecases/has_favorite_usecase.dart';
import 'package:my_favorite_games/app/modules/favorites/domain/usecases/remove_favorite_usecase.dart';
import 'package:my_favorite_games/app/modules/favorites/domain/usecases/toggle_favorite_usecase.dart';
import 'package:my_favorite_games/app/modules/search/data/datasources/search_data_source.dart';
import 'package:my_favorite_games/app/modules/search/data/datasources/search_data_source_implementation.dart';
import 'package:my_favorite_games/app/modules/search/data/repositories/search_repository_implementation.dart';
import 'package:my_favorite_games/app/modules/search/domain/repositories/search_repository.dart';
import 'package:my_favorite_games/app/modules/search/domain/usecases/search_games_usecase.dart';
import 'package:my_favorite_games/app/shared/models/hive/hive_game_model.dart';
import 'package:path_provider/path_provider.dart';

final serviceLocator = GetIt.instance;

Future<void> initializeServiceLocator() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initExternalDependencies();
  _initCore();
  _initDataSources();
  _initRepositories();
  _initFeatures();
}

Future<void> _initExternalDependencies() async {
  // Hive
  final documentsPath = await getApplicationDocumentsDirectory();
  Hive.init(documentsPath.path);
  Hive.registerAdapter(HiveGameModelAdapter());

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

void _initCore() {
  serviceLocator.registerLazySingleton<NetworkInfo>(() =>
      NetworkInfoImplementation(internetConnectionChecker: serviceLocator()));
}

void _initDataSources() {
  serviceLocator.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImplementation(hiveInterface: Hive));
  serviceLocator.registerLazySingleton<SearchDataSource>(
      () => SearchDataSourceImplementation(client: serviceLocator()));
}

void _initRepositories() {
  serviceLocator.registerLazySingleton<FavoritesRepository>(() =>
      FavoritesRepositoryImplementation(localDataSource: serviceLocator()));
  serviceLocator.registerLazySingleton<SearchRepository>(
      () => SearchRepositoryImplementation(
            networkInfo: serviceLocator(),
            searchDataSource: serviceLocator(),
          ));
}

void _initFeatures() {
  serviceLocator.registerLazySingleton<SearchGamesUsecase>(
      () => SearchGamesUsecase(searchRepository: serviceLocator()));
  serviceLocator.registerLazySingleton<AddFavoriteUseCase>(
      () => AddFavoriteUseCase(favoritesRepository: serviceLocator()));
  serviceLocator.registerLazySingleton<GetFavoritesUseCase>(
      () => GetFavoritesUseCase(favoritesRepository: serviceLocator()));
  serviceLocator.registerLazySingleton<HasFavoriteUseCase>(
      () => HasFavoriteUseCase(favoritesRepository: serviceLocator()));
  serviceLocator.registerLazySingleton<RemoveFavoriteUseCase>(
      () => RemoveFavoriteUseCase(favoritesRepository: serviceLocator()));
  serviceLocator.registerLazySingleton<ToggleFavoriteUseCase>(
      () => ToggleFavoriteUseCase(favoritesRepository: serviceLocator()));
}
