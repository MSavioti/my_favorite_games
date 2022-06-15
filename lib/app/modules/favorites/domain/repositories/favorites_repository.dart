import 'package:dartz/dartz.dart';
import 'package:my_favorite_games/app/core/error/failure/local_storage_failure.dart';
import 'package:my_favorite_games/app/core/shared/entities/game.dart';

abstract class FavoritesRepository {
  Future<Either<LocalStorageFailure, Game>> addFavorite(Game game);

  Future<Either<LocalStorageFailure, bool>> hasFavorite(String gameid);

  Future<Either<LocalStorageFailure, Game>> removeFavorite(String gameid);

  Future<Either<LocalStorageFailure, List<Game>>> getFavorites();
}
