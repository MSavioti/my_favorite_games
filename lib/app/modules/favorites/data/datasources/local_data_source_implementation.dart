import 'package:my_favorite_games/app/core/shared/models/game_model.dart';
import 'package:my_favorite_games/app/core/shared/entities/game.dart';
import 'package:my_favorite_games/app/modules/favorites/data/datasources/local_data_source.dart';

class LocalDataSourceImplementation implements LocalDataSource {
  @override
  Future<GameModel> addFavorite(Game game) {
    // TODO: implement addFavorite
    throw UnimplementedError();
  }

  @override
  Future<bool> hasFavorite(String gameId) {
    // TODO: implement hasFavorite
    throw UnimplementedError();
  }

  @override
  Future<GameModel> removeFavorite(String gameId) {
    // TODO: implement removeFavorite
    throw UnimplementedError();
  }

  @override
  Future<List<GameModel>> getFavorites() {
    // TODO: implement getFavorites
    throw UnimplementedError();
  }
}
