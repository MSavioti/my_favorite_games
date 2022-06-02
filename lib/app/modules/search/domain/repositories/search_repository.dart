import 'package:dartz/dartz.dart';
import 'package:my_favorite_games/app/core/errors/failure.dart';
import 'package:my_favorite_games/app/modules/search/domain/entities/game.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<Game>>> searchGames(String searchTerm);
}
