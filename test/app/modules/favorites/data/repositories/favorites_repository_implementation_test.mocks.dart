// Mocks generated by Mockito 5.2.0 from annotations
// in my_favorite_games/test/app/modules/favorites/data/repositories/favorites_repository_implementation_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:hive/hive.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:my_favorite_games/app/modules/favorites/data/datasources/local_data_source_implementation.dart'
    as _i4;
import 'package:my_favorite_games/app/shared/entities/game.dart' as _i6;
import 'package:my_favorite_games/app/shared/models/game_model.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeBox_0<E> extends _i1.Fake implements _i2.Box<E> {}

class _FakeGameModel_1 extends _i1.Fake implements _i3.GameModel {}

/// A class which mocks [LocalDataSourceImplementation].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocalDataSourceImplementation extends _i1.Mock
    implements _i4.LocalDataSourceImplementation {
  MockLocalDataSourceImplementation() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Box<dynamic> get favoritesBox =>
      (super.noSuchMethod(Invocation.getter(#favoritesBox),
          returnValue: _FakeBox_0<dynamic>()) as _i2.Box<dynamic>);
  @override
  _i5.Future<_i3.GameModel> addFavorite(_i6.Game? game) =>
      (super.noSuchMethod(Invocation.method(#addFavorite, [game]),
              returnValue: Future<_i3.GameModel>.value(_FakeGameModel_1()))
          as _i5.Future<_i3.GameModel>);
  @override
  _i5.Future<bool> hasFavorite(String? gameId) =>
      (super.noSuchMethod(Invocation.method(#hasFavorite, [gameId]),
          returnValue: Future<bool>.value(false)) as _i5.Future<bool>);
  @override
  _i5.Future<_i3.GameModel> removeFavorite(String? gameId) =>
      (super.noSuchMethod(Invocation.method(#removeFavorite, [gameId]),
              returnValue: Future<_i3.GameModel>.value(_FakeGameModel_1()))
          as _i5.Future<_i3.GameModel>);
  @override
  _i5.Future<List<_i3.GameModel>> getFavorites() =>
      (super.noSuchMethod(Invocation.method(#getFavorites, []),
              returnValue: Future<List<_i3.GameModel>>.value(<_i3.GameModel>[]))
          as _i5.Future<List<_i3.GameModel>>);
}
