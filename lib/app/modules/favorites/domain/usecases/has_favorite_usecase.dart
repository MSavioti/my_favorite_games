import 'package:dartz/dartz.dart';
import 'package:my_favorite_games/app/core/error/failure/local_storage_failure.dart';
import 'package:my_favorite_games/app/core/shared/usecases/usecase.dart';
import 'package:my_favorite_games/app/modules/favorites/domain/repositories/favorites_repository.dart';
import 'package:my_favorite_games/app/core/shared/entities/game.dart';

class HasFavoriteUseCase implements UseCase<bool, Game> {
  final FavoritesRepository favoritesRepository;

  HasFavoriteUseCase({
    required this.favoritesRepository,
  });

  @override
  Future<Either<LocalStorageFailure, bool>> call(Game game) async {
    return await favoritesRepository.hasFavorite(game.id);
  }
}
