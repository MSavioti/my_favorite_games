import 'package:my_favorite_games/app/shared/entities/game.dart';

abstract class GamePresenter {
  Future<bool> isGameFavorite();

  Future<Game> toggleFavorite();
}
