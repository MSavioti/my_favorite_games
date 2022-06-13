import 'package:my_favorite_games/app/core/shared/models/game_model.dart';

abstract class SearchDataSource {
  Future<List<GameModel>> search({required String searchTerm});
}
