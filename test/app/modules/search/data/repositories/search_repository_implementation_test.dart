import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_favorite_games/app/core/error/failure/failure.dart';
import 'package:my_favorite_games/app/core/error/failure/no_internet_failure.dart';
import 'package:my_favorite_games/app/core/messages/messages.dart';
import 'package:my_favorite_games/app/core/network/network_info_implementation.dart';
import 'package:my_favorite_games/app/modules/search/data/datasources/search_data_source_implementation.dart';
import 'package:my_favorite_games/app/core/shared/models/game_model.dart';
import 'package:my_favorite_games/app/modules/search/data/repositories/search_repository_implementation.dart';
import 'package:my_favorite_games/app/core/shared/entities/game.dart';

import '../../../../../fixtures/fixture_reader.dart';
import 'search_repository_implementation_test.mocks.dart';

@GenerateMocks([NetworkInfoImplementation, SearchDataSourceImplementation])
void main() {
  final mockDataSource = MockSearchDataSourceImplementation();
  final mockNetworkInfo = MockNetworkInfoImplementation();
  final searchRepositoryImpl = SearchRepositoryImplementation(
    networkInfo: mockNetworkInfo,
    searchDataSource: mockDataSource,
  );

  group('search when there\'s no internet connection', () {
    test(
        'should return a NoInternetFailure when there\'s no internet connection',
        () async {
      when(mockNetworkInfo.hasInternetConnection)
          .thenAnswer((_) async => false);

      final result = await searchRepositoryImpl.searchGames('batman');
      expect(result, equals(const Left(NoInternetFailure(noInternetMessage))));
      verify(mockNetworkInfo.hasInternetConnection);
    });
  });

  group('search when there\'s internet connecttion', () {
    List<GameModel> games = [];

    setUp(() {
      final searchResult = json.decode(fixture('search_result_success.json'));
      final searchResults = searchResult as List;
      games = searchResults.map((g) => GameModel.fromMap(g)).toList();
    });

    test(
        'should return a List<Game> with data from remote data source when there\'s internet connection',
        () async {
      when(mockNetworkInfo.hasInternetConnection).thenAnswer((_) async => true);
      when(mockDataSource.search(searchTerm: 'batman'))
          .thenAnswer((_) async => games);

      final result = await searchRepositoryImpl.searchGames('batman');
      verify(mockNetworkInfo.hasInternetConnection);
      verify(mockDataSource.search(searchTerm: 'batman'));

      expect(result, isA<Right<Failure, List<Game>>>());
      expect(result, equals(Right<Failure, List<Game>>(games)));
    });
  });
}
