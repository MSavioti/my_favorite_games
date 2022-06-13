import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_favorite_games/app/core/error/failure/failure.dart';
import 'package:my_favorite_games/app/modules/favorites/domain/repositories/favorites_repository.dart';
import 'package:my_favorite_games/app/modules/favorites/domain/usecases/remove_favorite_usecase.dart';
import 'package:my_favorite_games/app/core/shared/entities/game.dart';

import 'add_favorite_usecase_test.mocks.dart';

@GenerateMocks([FavoritesRepository])
void main() {
  final mockFavoritesRepository = MockFavoritesRepository();
  final useCase = RemoveFavoriteUseCase(
    favoritesRepository: mockFavoritesRepository,
  );
  final tGame = Game.dummy();

  group('remove favorite', () {
    test(
      'should return true if attempt to remove a favorite is successful',
      () async {
        when(mockFavoritesRepository.removeFavorite(any))
            .thenAnswer((_) async => const Right<Failure, bool>(true));

        final result = await useCase(tGame);
        expect(result, const Right<Failure, bool>(true));
        verify(mockFavoritesRepository.removeFavorite(tGame));
      },
    );

    test(
      'should return false if attempt to remove a favorite is not successful',
      () async {
        when(mockFavoritesRepository.removeFavorite(any))
            .thenAnswer((_) async => const Right<Failure, bool>(false));

        final result = await useCase(tGame);
        expect(result, const Right<Failure, bool>(false));
        verify(mockFavoritesRepository.removeFavorite(tGame));
      },
    );
  });
}
