import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:my_favorite_games/app/core/network/network_info.dart';

class NetworkInfoImplementation implements NetworkInfo {
  final internetConnectionChecker = InternetConnectionChecker();

  @override
  Future<bool> get hasInternetConnection async {
    return await internetConnectionChecker.hasConnection;
  }
}
