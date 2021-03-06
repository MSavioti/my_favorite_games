// Mocks generated by Mockito 5.2.0 from annotations
// in my_favorite_games/test/app/modules/favorites/domain/usecases/has_favorite_usecase_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:my_favorite_games/app/core/error/failure/local_storage_failure.dart'
    as _i5;
import 'package:my_favorite_games/app/modules/favorites/domain/repositories/favorites_repository.dart'
    as _i3;
import 'package:my_favorite_games/app/shared/entities/game.dart' as _i6;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [FavoritesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockFavoritesRepository extends _i1.Mock
    implements _i3.FavoritesRepository {
  MockFavoritesRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.LocalStorageFailure, _i6.Game>> addFavorite(
          _i6.Game? game) =>
      (super.noSuchMethod(Invocation.method(#addFavorite, [game]),
              returnValue:
                  Future<_i2.Either<_i5.LocalStorageFailure, _i6.Game>>.value(
                      _FakeEither_0<_i5.LocalStorageFailure, _i6.Game>()))
          as _i4.Future<_i2.Either<_i5.LocalStorageFailure, _i6.Game>>);
  @override
  _i4.Future<_i2.Either<_i5.LocalStorageFailure, bool>> hasFavorite(
          String? gameId) =>
      (super.noSuchMethod(Invocation.method(#hasFavorite, [gameId]),
          returnValue: Future<_i2.Either<_i5.LocalStorageFailure, bool>>.value(
              _FakeEither_0<_i5.LocalStorageFailure, bool>())) as _i4
          .Future<_i2.Either<_i5.LocalStorageFailure, bool>>);
  @override
  _i4.Future<_i2.Either<_i5.LocalStorageFailure, _i6.Game>> removeFavorite(
          String? gameId) =>
      (super.noSuchMethod(Invocation.method(#removeFavorite, [gameId]),
              returnValue:
                  Future<_i2.Either<_i5.LocalStorageFailure, _i6.Game>>.value(
                      _FakeEither_0<_i5.LocalStorageFailure, _i6.Game>()))
          as _i4.Future<_i2.Either<_i5.LocalStorageFailure, _i6.Game>>);
  @override
  _i4.Future<_i2.Either<_i5.LocalStorageFailure, List<_i6.Game>>>
      getFavorites() => (super.noSuchMethod(
          Invocation.method(#getFavorites, []),
          returnValue: Future<
                  _i2.Either<_i5.LocalStorageFailure, List<_i6.Game>>>.value(
              _FakeEither_0<_i5.LocalStorageFailure, List<_i6.Game>>())) as _i4
          .Future<_i2.Either<_i5.LocalStorageFailure, List<_i6.Game>>>);
}
