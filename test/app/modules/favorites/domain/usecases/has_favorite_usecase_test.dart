import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_favorite_games/app/core/error/failure/local_storage_failure.dart';
import 'package:my_favorite_games/app/core/messages/messages.dart';
import 'package:my_favorite_games/app/modules/favorites/domain/repositories/favorites_repository.dart';
import 'package:my_favorite_games/app/modules/favorites/domain/usecases/has_favorite_usecase.dart';
import 'package:my_favorite_games/app/shared/entities/game.dart';

import 'add_favorite_usecase_test.mocks.dart';

@GenerateMocks([FavoritesRepository])
void main() {
  final mockFavoritesRepository = MockFavoritesRepository();
  final useCase = HasFavoriteUseCase(
    favoritesRepository: mockFavoritesRepository,
  );
  final tGame = Game.dummy();

  group('check if game is favorite', () {
    test(
      'should return true when the game checked is added as favorite',
      () async {
        when(mockFavoritesRepository.hasFavorite(any)).thenAnswer(
            (_) async => const Right<LocalStorageFailure, bool>(true));

        final result = await useCase(tGame);
        expect(result, const Right<LocalStorageFailure, bool>(true));
        verify(mockFavoritesRepository.hasFavorite(tGame.id));
      },
    );

    test(
      'should return false when the game checked is not added as favorite',
      () async {
        when(mockFavoritesRepository.hasFavorite(any)).thenAnswer(
          (_) async => const Left<LocalStorageFailure, bool>(
              LocalStorageFailure(localStorageErrorMessage)),
        );

        final result = await useCase(tGame);
        expect(
          result,
          const Left<LocalStorageFailure, bool>(
              LocalStorageFailure(localStorageErrorMessage)),
        );
        verify(mockFavoritesRepository.hasFavorite(tGame.id));
      },
    );
  });
}
