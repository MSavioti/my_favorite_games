import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_favorite_games/app/infrastructure/dependency_injection/service_locator.dart';
import 'package:my_favorite_games/app/modules/favorites/domain/usecases/has_favorite_usecase.dart';
import 'package:my_favorite_games/app/modules/favorites/domain/usecases/toggle_favorite_usecase.dart';
import 'package:my_favorite_games/app/modules/game/presentation/game_presenter.dart';
import 'package:my_favorite_games/app/shared/entities/game.dart';

class GameRiverpodPresenter implements GamePresenter {
  final Game game;
  late final FutureProvider<bool> isFavoriteProvider;

  final toggleFavoriteUseCase = serviceLocator.get<ToggleFavoriteUseCase>();
  final hasFavoriteUseCase = serviceLocator.get<HasFavoriteUseCase>();

  GameRiverpodPresenter({required this.game}) {
    isFavoriteProvider = FutureProvider<bool>((ref) async => isGameFavorite());
  }

  @override
  Future<bool> isGameFavorite() async {
    final result = await hasFavoriteUseCase(game.id);
    final isFavorite = result.fold(
      (l) => throw (Exception(l.error.toString())),
      (r) => r,
    );

    return isFavorite;
  }

  @override
  Future<Game> toggleFavorite() async {
    final result = await toggleFavoriteUseCase(game);

    final resultingGame = result.fold(
      (l) => throw Exception(l.error.toString()),
      (r) => r,
    );

    return resultingGame;
  }
}
