import 'package:dartz/dartz.dart';
import 'package:my_favorite_games/app/core/errors/failure.dart';
import 'package:my_favorite_games/app/modules/search/domain/entities/game.dart';
import 'package:my_favorite_games/app/modules/search/domain/repositories/search_repository.dart';

class SearchGamesUsecase {
  final SearchRepository searchRepository;

  SearchGamesUsecase(this.searchRepository);

  Future<Either<Failure, List<Game>>> call(String searchTerm) async {
    return await searchRepository.searchGames(searchTerm);
  }
}
