import 'package:dartz/dartz.dart';
import 'package:my_favorite_games/app/core/error/failure/failure.dart';
import 'package:my_favorite_games/app/modules/search/domain/entities/game.dart';

abstract class FavoritesRepository {
  Future<Either<Failure, bool>> addFavorite(Game game);
  Future<Either<Failure, bool>> hasFavorite(Game game);
  Future<Either<Failure, bool>> removeFavorite(Game game);
}
