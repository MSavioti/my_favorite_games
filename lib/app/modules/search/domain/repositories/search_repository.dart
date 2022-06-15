import 'package:dartz/dartz.dart';
import 'package:my_favorite_games/app/core/error/failure/failure.dart';
import 'package:my_favorite_games/app/shared/entities/game.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<Game>>> searchGames(String searchTerm);
}
