import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_favorite_games/app/core/error/exception/local_storage_exception.dart';
import 'package:my_favorite_games/app/core/error/failure/local_storage_failure.dart';
import 'package:my_favorite_games/app/core/shared/entities/game.dart';
import 'package:my_favorite_games/app/core/shared/models/game_model.dart';
import 'package:my_favorite_games/app/modules/favorites/data/datasources/local_data_source_implementation.dart';
import 'package:my_favorite_games/app/modules/favorites/data/repositories/favorites_repository_implementation.dart';

import '../../../../../fixtures/fixture_reader.dart';
import 'favorites_repository_implementation_test.mocks.dart';

@GenerateMocks([LocalDataSourceImplementation])
void main() {
  final mockLocalDataSource = MockLocalDataSourceImplementation();
  final favoritesRepositoryImpl = FavoritesRepositoryImplementation(
    localDataSource: mockLocalDataSource,
  );
  final tGame = Game.dummy();
  final tGameModel = GameModel.fromMap(json.decode(fixture('game.json')));

  group('add favorite', () {
    test(
      'should return the favorited Game when call to add a favorite is successful',
      () async {
        when(mockLocalDataSource.addFavorite(any))
            .thenAnswer((_) async => tGameModel);

        final result = await favoritesRepositoryImpl.addFavorite(tGame);

        expect(result, isA<Right<LocalStorageFailure, Game>>());
        expect(result, equals(Right<LocalStorageFailure, Game>(tGame)));
        verify(mockLocalDataSource.addFavorite(tGame));
      },
    );

    test(
      'should return a LocalStorageFailure when the to add a favorite is not successful',
      () async {
        when(mockLocalDataSource.addFavorite(any))
            .thenThrow(LocalStorageException());

        final result = await favoritesRepositoryImpl.addFavorite(tGame);

        expect(result, isA<Left<LocalStorageFailure, Game>>());
      },
    );
  });

  group('has favorite', () {
    test(
      'should return true when the game checked is added as favorite',
      () async {
        when(mockLocalDataSource.hasFavorite(any))
            .thenAnswer((_) async => true);

        final result = await favoritesRepositoryImpl.hasFavorite(tGame.id);

        expect(result, isA<Right<LocalStorageFailure, bool>>());
        expect(result, equals(const Right<LocalStorageFailure, bool>(true)));
        verify(mockLocalDataSource.hasFavorite(tGame.id));
      },
    );

    test(
      'should return false when the game checked is not added as favorite',
      () async {
        when(mockLocalDataSource.hasFavorite(any))
            .thenAnswer((_) async => false);

        final result = await favoritesRepositoryImpl.hasFavorite(tGame.id);

        expect(result, isA<Right<LocalStorageFailure, bool>>());
        expect(result, equals(const Right<LocalStorageFailure, bool>(false)));
        verify(mockLocalDataSource.hasFavorite(tGame.id));
      },
    );
  });

  group('remove favorite', () {
    test(
      'should return the removed Game if attempt to remove a favorite is successful',
      () async {
        when(mockLocalDataSource.removeFavorite(any))
            .thenAnswer((_) async => tGameModel);

        final result = await favoritesRepositoryImpl.removeFavorite(tGame.id);

        expect(result, isA<Right<LocalStorageFailure, Game>>());
        expect(result, equals(Right<LocalStorageFailure, Game>(tGame)));
        verify(mockLocalDataSource.removeFavorite(tGame.id));
      },
    );

    test(
      'should return a LocalStorageFailure if attempt to remove a favorite is not successful',
      () async {
        when(mockLocalDataSource.removeFavorite(any))
            .thenThrow(LocalStorageException());

        final result = await favoritesRepositoryImpl.removeFavorite(tGame.id);

        expect(result, isA<Left<LocalStorageFailure, Game>>());
        verify(mockLocalDataSource.removeFavorite(tGame.id));
      },
    );
  });

  group('retrieve all stored favorites', () {
    final tDecodedGames =
        json.decode(fixture('search_result_success.json')) as List;
    final tGames =
        tDecodedGames.map((game) => GameModel.fromMap(game)).toList();

    test(
      'should return a List of Game with favorites data when the call to retrieve saved favorite games is successful',
      () async {
        when(mockLocalDataSource.getFavorites())
            .thenAnswer((_) async => [tGameModel, tGameModel, tGameModel]);

        final result = await favoritesRepositoryImpl.getFavorites();

        expect(result, isA<Right<LocalStorageFailure, List<Game>>>());

        final games = result.fold((l) => <Game>[], (r) => r);

        expect(games, containsAll(tGames));
      },
    );

    test(
      'should return an empty List of Game when there\'s no favorite games saved',
      () async {
        when(mockLocalDataSource.getFavorites())
            .thenAnswer((_) async => <GameModel>[]);

        final result = await favoritesRepositoryImpl.getFavorites();

        expect(result, isA<Right<LocalStorageFailure, List<Game>>>());

        final games = result.fold((l) => <Game>[], (r) => r);
        expect(games.isEmpty, true);
      },
    );

    test(
      'should return a LocalStorageFailure when the call to retrieve saved favorite games is not successful',
      () async {
        when(mockLocalDataSource.getFavorites())
            .thenThrow(LocalStorageException());

        final result = await favoritesRepositoryImpl.getFavorites();

        expect(result, isA<Left<LocalStorageFailure, List<Game>>>());
        verify(mockLocalDataSource.getFavorites());
      },
    );
  });
}
