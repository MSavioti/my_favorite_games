import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_favorite_games/app/core/errors/failure.dart';
import 'package:my_favorite_games/app/modules/search/data/repositories/search_repository_implementation.dart';
import 'package:my_favorite_games/app/modules/search/domain/entities/game.dart';

void main() {
  final searchRepositoryImplementation = SearchRepositoryImplementation();
  final tGame = Game.dummy();

  test('should get a list of games List<Game>', () async {
    when(searchRepositoryImplementation.searchGames('batman'))
        .thenAnswer((_) async => Right<Failure, List<Game>>(<Game>[tGame]));

    final result = searchRepositoryImplementation.searchGames('batman');
    verify(searchRepositoryImplementation.searchGames('batman'));
    expect(result, Right(tGame));
  });
}
