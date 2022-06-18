import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_favorite_games/app/infrastructure/dependency_injection/service_locator.dart';
import 'package:my_favorite_games/app/modules/search/domain/usecases/search_games_usecase.dart';
import 'package:my_favorite_games/app/modules/search/presentation/search_presenter.dart';
import 'package:my_favorite_games/app/shared/entities/game.dart';

class SearchRiverpodPresenter implements SearchPresenter {
  final String searchTerm;
  final useCase = serviceLocator.get<SearchGamesUsecase>();
  late final FutureProvider<List<Game>> provider;

  SearchRiverpodPresenter({required this.searchTerm}) {
    provider = FutureProvider((ref) async => searchGames(searchTerm));
  }

  @override
  Future<List<Game>> searchGames(String searchTerm) async {
    final result = await useCase(searchTerm);

    final games = result.fold<List<Game>>(
      (l) => throw Exception(l.error.toString()),
      (r) => r,
    );

    return games;
  }
}
