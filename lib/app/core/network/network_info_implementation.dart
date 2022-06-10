import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:my_favorite_games/app/core/network/network_info.dart';

class NetworkInfoImplementation implements NetworkInfo {
  final InternetConnectionChecker internetConnectionChecker;

  NetworkInfoImplementation({required this.internetConnectionChecker});

  @override
  Future<bool> get hasInternetConnection {
    return internetConnectionChecker.hasConnection;
  }
}
