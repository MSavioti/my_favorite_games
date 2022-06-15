import 'package:hive/hive.dart';
import 'package:my_favorite_games/app/shared/models/game_model.dart';
import 'package:my_favorite_games/app/shared/entities/game.dart';
import 'package:my_favorite_games/app/modules/favorites/data/datasources/local_data_source.dart';

class LocalDataSourceImplementation implements LocalDataSource {
  final Box favoritesBox;

  LocalDataSourceImplementation({required this.favoritesBox});

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
