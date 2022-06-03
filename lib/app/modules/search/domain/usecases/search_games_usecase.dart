import 'package:dartz/dartz.dart';
import 'package:my_favorite_games/app/core/errors/failure.dart';
import 'package:my_favorite_games/app/core/usecases/usecase.dart';
import 'package:my_favorite_games/app/modules/search/domain/entities/game.dart';
import 'package:my_favorite_games/app/modules/search/domain/repositories/search_repository.dart';

class SearchGamesUsecase implements UseCase<List<Game>, Params> {
  final SearchRepository searchRepository;

  SearchGamesUsecase(this.searchRepository);

  @override
  Future<Either<Failure, List<Game>>> call(Params params) async {
    return await searchRepository.searchGames(params.searchTerm);
  }
}

class Params {
  final String searchTerm;

  Params({required this.searchTerm});
}
