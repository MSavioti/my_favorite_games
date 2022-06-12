import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:my_favorite_games/app/core/error/exception/server_exception.dart';
import 'package:my_favorite_games/app/infrastructure/env.dart';
import 'package:my_favorite_games/app/modules/search/data/datasources/search_data_source.dart';
import 'package:my_favorite_games/app/modules/search/data/models/game_model.dart';

class SearchDataSourceImplementation implements SearchDataSource {
  final Dio client;

  const SearchDataSourceImplementation({required this.client});

  @override
  Future<List<GameModel>> search({required String searchTerm}) async {
    try {
      final response = await client.get(
        Env.searchEndpoint,
        queryParameters: {'title': searchTerm},
      );

      if (response.statusCode != 200) {
        throw ServerException();
      }

      if (response.data.isEmpty) {
        return [];
      }

      final parsedData = json.decode(response.data);
      final items = parsedData as List;
      final games = items.map((e) => GameModel.fromMap(e));
      return games.toList();
    } on DioError {
      throw ServerException();
    }
  }
}
