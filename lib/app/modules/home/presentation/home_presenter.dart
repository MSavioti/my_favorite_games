import 'package:my_favorite_games/app/shared/entities/game.dart';

abstract class HomePresenter {
  Future<List<Game>> loadFavorites({int count = 9});
}
