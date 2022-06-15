import 'package:dartz/dartz.dart';

import 'package:my_favorite_games/app/core/error/exception/no_internet_exception.dart';
import 'package:my_favorite_games/app/core/error/failure/no_internet_failure.dart';
import 'package:my_favorite_games/app/core/messages/messages.dart';
import 'package:my_favorite_games/app/core/network/network_info.dart';
import 'package:my_favorite_games/app/modules/search/data/datasources/search_data_source.dart';
import 'package:my_favorite_games/app/shared/entities/game.dart';
import 'package:my_favorite_games/app/core/error/failure/failure.dart';
import 'package:my_favorite_games/app/modules/search/domain/repositories/search_repository.dart';

class SearchRepositoryImplementation implements SearchRepository {
  final NetworkInfo networkInfo;
  final SearchDataSource searchDataSource;

  const SearchRepositoryImplementation({
    required this.networkInfo,
    required this.searchDataSource,
  });

  @override
  Future<Either<Failure, List<Game>>> searchGames(String searchTerm) async {
    try {
      await _checkConnection();

      final result = await searchDataSource.search(searchTerm: searchTerm);
      return Right(result);
    } on NoInternetException {
      return const Left(NoInternetFailure(noInternetMessage));
    }
  }

  Future<bool> _checkConnection() async {
    final isConnected = await networkInfo.hasInternetConnection;

    if (!isConnected) {
      throw NoInternetException();
    }

    return isConnected;
  }
}
