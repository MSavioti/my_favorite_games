import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:my_favorite_games/app/core/models/game_model.dart';
import 'package:my_favorite_games/app/core/entities/game.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  final tGameModel = GameModel.dummy();

  test('should be a subclass of Game entity', () async {
    expect(tGameModel, isA<Game>());
  });

  test(
      'should create a valid GameModel instance when the fromMap constructor is called',
      () {
    final jsonMap = json.decode(fixture('game.json'));
    final gameMap = GameModel.fromMap(jsonMap);
    expect(gameMap, tGameModel);
  });

  test('should convert the contents of a GameModel to a Map<String, dynamic>',
      () {
    final result = tGameModel.toMap();
    expect(result, isA<Map<String, dynamic>>());

    final expectedMap = {
      "gameID": "0",
      "steamAppID": "0",
      "cheapest": "0.00",
      "external": "Game Name",
      "thumb": "https://site/image.jpg"
    };

    expect(result, expectedMap);
  });
}
