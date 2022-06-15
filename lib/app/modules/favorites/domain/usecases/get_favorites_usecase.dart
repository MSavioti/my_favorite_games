import 'package:dartz/dartz.dart';
import 'package:my_favorite_games/app/core/error/failure/local_storage_failure.dart';
import 'package:my_favorite_games/app/core/shared/usecases/usecase.dart';
import 'package:my_favorite_games/app/modules/favorites/domain/repositories/favorites_repository.dart';
import 'package:my_favorite_games/app/core/shared/entities/game.dart';
import 'package:my_favorite_games/app/shared/helpers/no_params.dart';

class GetFavoritesUseCase implements UseCase<List<Game>, NoParams> {
  final FavoritesRepository favoritesRepository;

  GetFavoritesUseCase({
    required this.favoritesRepository,
  });

  @override
  Future<Either<LocalStorageFailure, List<Game>>> call(
    NoParams noParams,
  ) async {
    return await favoritesRepository.getFavorites();
  }
}
