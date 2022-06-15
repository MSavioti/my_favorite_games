import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:my_favorite_games/app/shared/entities/game.dart';
import 'package:my_favorite_games/app/modules/favorites/data/datasources/local_data_source_implementation.dart';

import 'local_data_source_implementation_test.mocks.dart';

@GenerateMocks([Box])
void main() {
  late final Game tGame;
  late final MockBox mockBox;
  late final LocalDataSourceImplementation localDataSource;

  setUpAll(() async {
    tGame = Game.dummy();
    mockBox = MockBox();
    localDataSource = LocalDataSourceImplementation(favoritesBox: mockBox);
  });

  group('add favorite', () {
    test(
      'should return a GameModel representing a game added as favorite when a call to add a game as favorite is successful',
      () async {
        final result = await localDataSource.addFavorite(tGame);

        expect(result, tGame);
      },
    );

    test(
      'should throw a LocalStorageException when a call to add a game as favorite is not successful',
      () async {
        throw UnimplementedError();
      },
    );
  });
}
