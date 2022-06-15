import 'package:dartz/dartz.dart';
import 'package:my_favorite_games/app/core/error/failure/failure.dart';
import 'package:my_favorite_games/app/shared/usecases/usecase.dart';
import 'package:my_favorite_games/app/shared/entities/game.dart';
import 'package:my_favorite_games/app/modules/search/domain/repositories/search_repository.dart';

class SearchGamesUsecase implements UseCase<List<Game>, String> {
  final SearchRepository searchRepository;

  SearchGamesUsecase(this.searchRepository);

  @override
  Future<Either<Failure, List<Game>>> call(String searchTerm) async {
    return await searchRepository.searchGames(searchTerm);
  }
}
