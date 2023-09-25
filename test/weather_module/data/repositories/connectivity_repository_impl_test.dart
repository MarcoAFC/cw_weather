import 'package:cw_weather/src/core/connectivity/connectivity_service.dart';
import 'package:cw_weather/src/weather_module/data/repositories/connectivity_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockConnectivityService extends Mock implements ConnectivityService{}

void main() {
  group('Connectivity repository tests', () {
    var service = MockConnectivityService();
    var repository = ConnectivityRepositoryImpl(service: service);
    test('returns valid response when connectivity is available', () async {
      when(() => service.checkConnectivity()).thenAnswer((invocation) async => true);

      var data = await repository.checkConnectivity();

      expect(data, true);

    });

    test('returns valid response when connectivity is unavailable', () async {
      when(() => service.checkConnectivity()).thenAnswer((invocation) async => false);

      var data = await repository.checkConnectivity();

      expect(data, false);

    });
  });
}
