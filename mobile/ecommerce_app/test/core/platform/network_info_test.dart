import 'package:ecommerce_app/core/platform/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_info_test.mocks.dart'; 

@GenerateMocks([InternetConnectionChecker]) 
void main() {
  late NetworkInfoImpl networkInfo;
  late MockInternetConnectionChecker mockChecker;

  setUp(() {
    mockChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(mockChecker);
  });

  test('should forward the call to InternetConnectionChecker.hasConnection', () async {
    // arrange
    when(mockChecker.hasConnection).thenAnswer((_) async => true);
    // act
    final result = await networkInfo.isConnected;
    // assert
    verify(mockChecker.hasConnection);
    expect(result, true);
  });
}
