import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_favorite_games/app/core/error/failure/failure.dart';
import 'package:my_favorite_games/app/core/shared/entities/game.dart';
import 'package:my_favorite_games/app/modules/search/domain/repositories/search_repository.dart';
import 'package:my_favorite_games/app/modules/search/domain/usecases/search_games_usecase.dart';

import 'search_games_usecase_test.mocks.dart';

@GenerateMocks([SearchRepository])
void main() {
  final MockSearchRepository mockSearchRepository = MockSearchRepository();
  final tGame = Game.dummy();
  final usecase = SearchGamesUsecase(mockSearchRepository);
  const tSearchTerm = 'Game Name';

  test('should return a list of games List<Game>', () async {
    when(mockSearchRepository.searchGames(any))
        .thenAnswer((_) async => Right(<Game>[tGame]));

    final result = await usecase(tSearchTerm);

    expect(result, isA<Right<Failure, List<Game>>>());
    verify(mockSearchRepository.searchGames(tSearchTerm));
  });
}
