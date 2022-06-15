import 'package:my_favorite_games/app/core/shared/entities/game.dart';
import 'package:my_favorite_games/app/core/shared/models/game_model.dart';

abstract class LocalDataSource {
  Future<GameModel> addFavorite(Game game);

  Future<bool> hasFavorite(String gameId);

  Future<GameModel> removeFavorite(String gameId);

  Future<List<GameModel>> getFavorites();
}
