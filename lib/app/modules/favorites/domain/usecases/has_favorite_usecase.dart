import 'package:dartz/dartz.dart';
import 'package:my_favorite_games/app/core/error/failure/local_storage_failure.dart';
import 'package:my_favorite_games/app/shared/usecases/usecase.dart';
import 'package:my_favorite_games/app/modules/favorites/domain/repositories/favorites_repository.dart';

class HasFavoriteUseCase implements UseCase<bool, String> {
  final FavoritesRepository favoritesRepository;

  HasFavoriteUseCase({
    required this.favoritesRepository,
  });

  @override
  Future<Either<LocalStorageFailure, bool>> call(String gameId) async {
    return await favoritesRepository.hasFavorite(gameId);
  }
}
