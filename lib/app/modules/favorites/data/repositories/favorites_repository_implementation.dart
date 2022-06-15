import 'package:dartz/dartz.dart';
import 'package:my_favorite_games/app/core/error/exception/local_storage_exception.dart';
import 'package:my_favorite_games/app/core/error/failure/local_storage_failure.dart';
import 'package:my_favorite_games/app/core/messages/messages.dart';
import 'package:my_favorite_games/app/modules/favorites/data/datasources/local_data_source.dart';

import 'package:my_favorite_games/app/modules/favorites/domain/repositories/favorites_repository.dart';
import 'package:my_favorite_games/app/shared/entities/game.dart';

class FavoritesRepositoryImplementation implements FavoritesRepository {
  final LocalDataSource localDataSource;

  const FavoritesRepositoryImplementation({required this.localDataSource});

  @override
  Future<Either<LocalStorageFailure, Game>> addFavorite(Game game) async {
    try {
      final result = await localDataSource.addFavorite(game);
      return Right(result);
    } on LocalStorageException {
      return const Left(LocalStorageFailure(localStorageErrorMessage));
    }
  }

  @override
  Future<Either<LocalStorageFailure, bool>> hasFavorite(String gameid) async {
    try {
      final result = await localDataSource.hasFavorite(gameid);
      return Right(result);
    } on LocalStorageException {
      return const Left(LocalStorageFailure(localStorageErrorMessage));
    }
  }

  @override
  Future<Either<LocalStorageFailure, Game>> removeFavorite(
    String gameid,
  ) async {
    try {
      final result = await localDataSource.removeFavorite(gameid);
      return Right(result);
    } on LocalStorageException {
      return const Left(LocalStorageFailure(localStorageErrorMessage));
    }
  }

  @override
  Future<Either<LocalStorageFailure, List<Game>>> getFavorites() async {
    try {
      final result = await localDataSource.getFavorites();
      return Right(result);
    } on LocalStorageException {
      return const Left(LocalStorageFailure(localStorageErrorMessage));
    }
  }
}
