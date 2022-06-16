import 'package:hive/hive.dart';
import 'package:my_favorite_games/app/core/error/exception/local_storage_exception.dart';
import 'package:my_favorite_games/app/shared/models/game_model.dart';
import 'package:my_favorite_games/app/shared/entities/game.dart';
import 'package:my_favorite_games/app/modules/favorites/data/datasources/local_data_source.dart';
import 'package:my_favorite_games/app/shared/models/hive/hive_game_model.dart';

class LocalDataSourceImplementation implements LocalDataSource {
  final HiveInterface hiveInterface;
  bool isInitialized = false;

  LocalDataSourceImplementation({required this.hiveInterface});

  @override
  Future<GameModel> addFavorite(Game game) async {
    final hiveGame = HiveGameModel.fromGame(game);

    try {
      final searchedGame = await _retrieveFavorite(game.id);

      if (searchedGame == null) {
        await _saveFavorite(hiveGame);
      }

      return hiveGame;
    } on HiveError {
      throw LocalStorageException();
    }
  }

  @override
  Future<bool> hasFavorite(String gameId) async {
    try {
      final searchedGame = await _retrieveFavorite(gameId);
      return searchedGame != null;
    } on HiveError {
      throw LocalStorageException();
    }
  }

  @override
  Future<GameModel> removeFavorite(String gameId) async {
    try {
      final searchedGame = await _retrieveFavorite(gameId);

      if (searchedGame == null) {
        throw LocalStorageException();
      }

      await _removeFavorite(gameId);
      return searchedGame;
    } on HiveError {
      throw LocalStorageException();
    }
  }

  @override
  Future<List<GameModel>> getFavorites() {
    // TODO: implement getFavorites
    throw UnimplementedError();
  }

  Future<HiveGameModel?> _retrieveFavorite(String gameId) async {
    final favoritesBox =
        await hiveInterface.openBox<HiveGameModel>('favorites');
    final favorite = favoritesBox.get(gameId);
    return favorite;
  }

  Future<void> _saveFavorite(HiveGameModel favorite) async {
    final favoritesBox =
        await hiveInterface.openBox<HiveGameModel>('favorites');
    await favoritesBox.put(favorite.id, favorite);
  }

  Future<void> _removeFavorite(String gameId) async {
    final favoritesBox =
        await hiveInterface.openBox<HiveGameModel>('favorites');
    await favoritesBox.delete(gameId);
  }
}
