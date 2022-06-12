import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/annotations.dart';
import 'package:my_favorite_games/app/core/error/exception/server_exception.dart';
import 'package:my_favorite_games/app/modules/search/data/datasources/search_data_source_implementation.dart';
import 'package:my_favorite_games/app/modules/search/data/models/game_model.dart';

import '../../../../../fixtures/fixture_reader.dart';

@GenerateMocks([])
void main() {
  late final SearchDataSourceImplementation searchDataSource;
  final dio = Dio();
  final dioAdapter = DioAdapter(dio: dio);
  searchDataSource = SearchDataSourceImplementation(client: dio);

  const String searchEndpoint = 'https://www.cheapshark.com/api/1.0/games';
  const String searchTerm = 'batman';
  final queryParameters = <String, dynamic>{'title': searchTerm};

  dioAdapter.onGet(searchEndpoint, (server) {});

  test('should return a List of GameModel when the response status code is 200',
      () async {
    dioAdapter.onGet(
      searchEndpoint,
      (server) => server.reply(200, fixture('search_result_success.json')),
    );

    dio.httpClientAdapter = dioAdapter;

    final result = await searchDataSource.search(searchTerm: searchTerm);
    expect(result, isA<List<GameModel>>());
  });

  test('should throw a ServerException when the response code is not 200',
      () async {
    dioAdapter.onGet(
      searchEndpoint,
      (server) => server.reply(500, ''),
    );

    dio.httpClientAdapter = dioAdapter;

    final searchFunction = searchDataSource.search(searchTerm: searchTerm);
    await expectLater(searchFunction, throwsA(isA<ServerException>()));
  });

  test(
      'should return a empty response and status code 200 when no results for a search are found',
      () async {
    dioAdapter.onGet(
      searchEndpoint,
      (server) => server.reply(200, ''),
    );

    final result = await searchDataSource.search(searchTerm: searchTerm);
    expect(result, isA<List<GameModel>>());
    expect(result.isEmpty, true);
  });
}
