import 'package:dartz/dartz.dart';
import 'package:my_favorite_games/app/core/error/failure/local_storage_failure.dart';
import 'package:my_favorite_games/app/shared/usecases/usecase.dart';
import 'package:my_favorite_games/app/modules/favorites/domain/repositories/favorites_repository.dart';
import 'package:my_favorite_games/app/shared/entities/game.dart';

class AddFavoriteUseCase implements UseCase<Game, Game> {
  final FavoritesRepository favoritesRepository;

  AddFavoriteUseCase({
    required this.favoritesRepository,
  });

  @override
  Future<Either<LocalStorageFailure, Game>> call(Game game) async {
    return await favoritesRepository.addFavorite(game);
  }
}
