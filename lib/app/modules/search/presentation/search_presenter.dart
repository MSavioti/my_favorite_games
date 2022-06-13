import 'package:my_favorite_games/app/modules/search/domain/entities/game.dart';

abstract class SearchPresenter {
  Future<List<Game>> searchGames(String searchTerm);
}
