import 'package:dartz/dartz.dart';
import 'package:my_favorite_games/app/core/error/failure/local_storage_failure.dart';
import 'package:my_favorite_games/app/core/messages/messages.dart';
import 'package:my_favorite_games/app/shared/usecases/usecase.dart';
import 'package:my_favorite_games/app/modules/favorites/domain/repositories/favorites_repository.dart';
import 'package:my_favorite_games/app/shared/entities/game.dart';

class ToggleFavoriteUseCase implements UseCase<Game, Game> {
  final FavoritesRepository favoritesRepository;

  ToggleFavoriteUseCase({
    required this.favoritesRepository,
  });

  @override
  Future<Either<LocalStorageFailure, Game>> call(Game game) async {
    final result = await favoritesRepository.hasFavorite(game.id);

    if (result.isLeft()) {
      return const Left(LocalStorageFailure(localStorageErrorMessage));
    }

    final isFavorite = result.fold((l) => false, (r) => r);

    if (isFavorite) {
      final removed = await favoritesRepository.removeFavorite(game.id);
      return removed;
    } else {
      final added = await favoritesRepository.addFavorite(game);
      return added;
    }
  }
}
