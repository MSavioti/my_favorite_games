import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_favorite_games/app/infrastructure/dependency_injection/service_locator.dart';
import 'package:my_favorite_games/app/modules/favorites/domain/usecases/get_favorites_usecase.dart';
import 'package:my_favorite_games/app/modules/home/presentation/home_presenter.dart';
import 'package:my_favorite_games/app/shared/entities/game.dart';
import 'package:my_favorite_games/app/shared/helpers/no_params.dart';

class HomeRiverpodPresenter implements HomePresenter {
  final useCase = serviceLocator.get<GetFavoritesUseCase>();
  late final FutureProvider<List<Game>> provider;

  HomeRiverpodPresenter() {
    provider = FutureProvider((ref) async => loadFavorites());
  }

  @override
  Future<List<Game>> loadFavorites() async {
    final result = await useCase(NoParams());

    final games = result.fold<List<Game>>(
      (l) => throw Exception(l.error.toString()),
      (r) => r,
    );

    return games;
  }
}
