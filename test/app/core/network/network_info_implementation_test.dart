import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_favorite_games/app/core/network/network_info_implementation.dart';

import 'network_info_implementation_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker])
void main() {
  final mockInternetConnectionChecker = MockInternetConnectionChecker();
  final networkInfo = NetworkInfoImplementation(
    internetConnectionChecker: mockInternetConnectionChecker,
  );

  group('connection checking', () {
    test(
        'should forward a call to check internet connection to InternetConnectionChecker',
        () async {
      when(mockInternetConnectionChecker.hasConnection)
          .thenAnswer((_) async => true);

      final result = await networkInfo.hasInternetConnection;
      verify(mockInternetConnectionChecker.hasConnection);
      expect(result, true);
    });
  });
}
