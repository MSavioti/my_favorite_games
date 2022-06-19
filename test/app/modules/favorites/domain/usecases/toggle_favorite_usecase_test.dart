import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_favorite_games/app/core/error/failure/local_storage_failure.dart';
import 'package:my_favorite_games/app/core/messages/messages.dart';
import 'package:my_favorite_games/app/modules/favorites/domain/repositories/favorites_repository.dart';
import 'package:my_favorite_games/app/modules/favorites/domain/usecases/toggle_favorite_usecase.dart';
import 'package:my_favorite_games/app/shared/entities/game.dart';

import 'toggle_favorite_usecase_test.mocks.dart';

@GenerateMocks([FavoritesRepository])
void main() {
  final mockFavoritesRepository = MockFavoritesRepository();
  final useCase = ToggleFavoriteUseCase(
    favoritesRepository: mockFavoritesRepository,
  );
  final tGame = Game.dummy();

  group('toggle favorite', () {
    test(
      'should return the removed Game if attempt to remove a favorite is successful',
      () async {
        when(mockFavoritesRepository.hasFavorite(any)).thenAnswer(
            (_) async => const Right<LocalStorageFailure, bool>(true));
        when(mockFavoritesRepository.removeFavorite(any))
            .thenAnswer((_) async => Right<LocalStorageFailure, Game>(tGame));

        final result = await useCase(tGame);
        expect(result, Right<LocalStorageFailure, Game>(tGame));
        verify(mockFavoritesRepository.hasFavorite(any));
        verify(mockFavoritesRepository.removeFavorite(any));
      },
    );

    test(
      'should return the favorited Game when call to add a favorite is successful',
      () async {
        when(mockFavoritesRepository.hasFavorite(any)).thenAnswer(
            (_) async => const Right<LocalStorageFailure, bool>(false));
        when(mockFavoritesRepository.addFavorite(any))
            .thenAnswer((_) async => Right<LocalStorageFailure, Game>(tGame));

        final result = await useCase(tGame);
        expect(result, Right<LocalStorageFailure, Game>(tGame));
        verify(mockFavoritesRepository.hasFavorite(any));
        verify(mockFavoritesRepository.addFavorite(any));
      },
    );

    test(
      'should return a LocalStorageFailure if attempt to add or remove a favorite is not successful',
      () async {
        when(mockFavoritesRepository.hasFavorite(any)).thenAnswer((_) async =>
            const Left(LocalStorageFailure(localStorageErrorMessage)));

        final result = await useCase(tGame);
        expect(
          result,
          const Left<LocalStorageFailure, Game>(
              LocalStorageFailure(localStorageErrorMessage)),
        );
        verify(mockFavoritesRepository.hasFavorite(any));
      },
    );
  });
}
