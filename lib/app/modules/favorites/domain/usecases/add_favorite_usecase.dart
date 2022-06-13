import 'package:my_favorite_games/app/core/error/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:my_favorite_games/app/core/usecases/usecase.dart';
import 'package:my_favorite_games/app/modules/favorites/domain/repositories/favorites_repository.dart';
import 'package:my_favorite_games/app/modules/search/domain/entities/game.dart';

class AddFavoriteUseCase implements UseCase<bool, Game> {
  final FavoritesRepository favoritesRepository;

  AddFavoriteUseCase({
    required this.favoritesRepository,
  });

  @override
  Future<Either<Failure, bool>> call(Game game) async {
    return await favoritesRepository.addFavorite(game);
  }
}
