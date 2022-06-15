import 'package:my_favorite_games/app/shared/entities/game.dart';

abstract class SearchPresenter {
  Future<List<Game>> searchGames(String searchTerm);
}
