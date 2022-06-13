import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_favorite_games/app/core/error/failure/failure.dart';
import 'package:my_favorite_games/app/modules/favorites/domain/repositories/favorites_repository.dart';
import 'package:my_favorite_games/app/modules/favorites/domain/usecases/add_favorite_usecase.dart';
import 'package:my_favorite_games/app/core/shared/entities/game.dart';

import 'add_favorite_usecase_test.mocks.dart';

@GenerateMocks([FavoritesRepository])
void main() {
  final mockFavoritesRepository = MockFavoritesRepository();
  final useCase = AddFavoriteUseCase(
    favoritesRepository: mockFavoritesRepository,
  );
  final tGame = Game.dummy();

  group('add game as favorite', () {
    test(
      'should add a Game as favorite if it is not already added as a favorite',
      () async {
        when(mockFavoritesRepository.addFavorite(any))
            .thenAnswer((_) async => const Right<Failure, bool>(false));

        final result = await useCase(tGame);
        expect(result, const Right<Failure, bool>(false));
        verify(mockFavoritesRepository.addFavorite(tGame));
      },
    );

    test(
      'should not add Game as favorite if it is already added as favorite',
      () async {
        when(mockFavoritesRepository.addFavorite(any))
            .thenAnswer((_) async => const Right<Failure, bool>(true));

        final result = await useCase(tGame);
        expect(result, const Right<Failure, bool>(true));
        verify(mockFavoritesRepository.addFavorite(tGame));
      },
    );
  });
}
