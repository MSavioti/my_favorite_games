import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_favorite_games/app/core/error/exception/local_storage_exception.dart';
import 'package:my_favorite_games/app/shared/entities/game.dart';
import 'package:my_favorite_games/app/modules/favorites/data/datasources/local_data_source_implementation.dart';
import 'package:my_favorite_games/app/shared/models/hive/hive_game_model.dart';

import 'local_data_source_implementation_test.mocks.dart';

@GenerateMocks([Box, HiveInterface])
void main() {
  late final MockHiveInterface mockHiveInterface;
  late final MockBox<HiveGameModel> mockBox;
  late final LocalDataSourceImplementation localDataSource;
  late final Game tGame;
  late final HiveGameModel tHiveGameModel;

  setUpAll(() async {
    final path = '${Directory.current.path}/test/favorites';
    mockHiveInterface = MockHiveInterface();
    mockHiveInterface.init(path);

    mockBox = MockBox<HiveGameModel>();
    localDataSource = LocalDataSourceImplementation(
      hiveInterface: mockHiveInterface,
    );

    tGame = Game.dummy();
    tHiveGameModel = const HiveGameModel(
      id: '0',
      steamAppID: '0',
      externalName: 'Game Name',
      cheapestPrice: '0.00',
      thumbnail: 'https://site/image.jpg',
    );
  });

  tearDownAll(() async {
    await mockHiveInterface.deleteFromDisk();
  });

  group('add favorite', () {
    test(
      'should return a GameModel representing a game added as favorite when a call to add a game as favorite is successful',
      () async {
        when(mockHiveInterface.openBox('favorites'))
            .thenAnswer((_) async => mockBox);
        when(mockBox.get(any)).thenReturn(null);

        final result = await localDataSource.addFavorite(tGame);

        expect(result, tGame);
        verify(mockHiveInterface.openBox('favorites'));
        verify(mockBox.put(tHiveGameModel.id, any));
        verify(mockBox.get(any));
      },
    );

    test(
      'should throw a LocalStorageException when a call to add a game as favorite is not successful',
      () async {
        when(mockHiveInterface.openBox('favorites'))
            .thenThrow(HiveError('Forced error for testing'));

        final functionCall = localDataSource.addFavorite(tGame);

        await expectLater(functionCall, throwsA(isA<LocalStorageException>()));
      },
    );
  });

  group(
    'has favorite',
    () {
      test(
        'should return true when the checking for a favorite does not find a game with the provided ID',
        () async {
          when(mockHiveInterface.openBox('favorites'))
              .thenAnswer((_) async => mockBox);
          when(mockBox.get(tHiveGameModel.id)).thenReturn(tHiveGameModel);

          final result = await localDataSource.hasFavorite(tGame.id);

          expect(result, true);
          verify(mockHiveInterface.openBox('favorites'));
          verify(mockBox.get(any));
        },
      );

      test(
        'should return false when the checking for a saved favorite does not find a favorite game with the provided ID',
        () async {
          when(mockHiveInterface.openBox('favorites'))
              .thenAnswer((_) async => mockBox);
          when(mockBox.get(any)).thenReturn(null);

          final result = await localDataSource.hasFavorite(tGame.id);

          expect(result, false);
          verify(mockHiveInterface.openBox('favorites'));
          verify(mockBox.get(any));
        },
      );

      test(
        'should throw a LocalStorageException when a call to check for a saved favorite cannot check for a game ID',
        () async {
          when(mockHiveInterface.openBox('favorites'))
              .thenThrow(HiveError('Forced error for testing'));

          final functionCall = localDataSource.hasFavorite(tGame.id);

          await expectLater(
              functionCall, throwsA(isA<LocalStorageException>()));
        },
      );
    },
  );

  group(
    'remove favorites',
    () {
      test(
        'should return the removed Game when attempt to remove a favorite is successful',
        () async {
          when(mockHiveInterface.openBox('favorites'))
              .thenAnswer((_) async => mockBox);
          when(mockBox.get(tHiveGameModel.id)).thenReturn(tHiveGameModel);

          final result = await localDataSource.removeFavorite(tGame.id);

          expect(result, tHiveGameModel);
          verify(mockHiveInterface.openBox('favorites'));
          verify(mockBox.get(any));
          verify(mockBox.delete(tHiveGameModel.id));
        },
      );

      test(
        'should throw a LocalStorageException when attempt to remove a favorite is not successful',
        () async {
          when(mockHiveInterface.openBox('favorites'))
              .thenThrow(HiveError('Forced error for testing'));

          final functionCall = localDataSource.removeFavorite(tGame.id);

          await expectLater(
              functionCall, throwsA(isA<LocalStorageException>()));
        },
      );
    },
  );
}
