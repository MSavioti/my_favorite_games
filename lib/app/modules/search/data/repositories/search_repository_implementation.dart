import 'package:my_favorite_games/app/modules/search/domain/entities/game.dart';
import 'package:my_favorite_games/app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:my_favorite_games/app/modules/search/domain/repositories/search_repository.dart';

class SearchRepositoryImplementation implements SearchRepository {
  @override
  Future<Either<Failure, List<Game>>> searchGames(String searchTerm) {
    throw UnimplementedError();
  }
}
