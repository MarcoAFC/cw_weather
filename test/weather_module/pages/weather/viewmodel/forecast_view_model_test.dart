import 'package:cw_weather/src/weather_module/data/models/city_model.dart';
import 'package:cw_weather/src/weather_module/domain/entities/weather.dart';
import 'package:cw_weather/src/weather_module/domain/repositories/connectivity_repository.dart';
import 'package:cw_weather/src/weather_module/domain/repositories/open_weather_repository.dart';
import 'package:cw_weather/src/weather_module/pages/weather/view_models/forecast_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRepo extends Mock implements OpenWeatherRepository {}

class MockConnectivity extends Mock implements ConnectivityRepository {}

void main() {
  group('Forecast viewmodel tests', () {
    var json = {
      "name": "Natal",
      "lat": -5.805398,
      "lon": -35.2080905,
      "country": "BR",
      "state": "Rio Grande do Norte"
    };
    var city = CityModel.fromMap(json);
    var repository = MockRepo();
    var connectivity = MockConnectivity();
    var vm =
        ForecastViewModel(repository: repository, connectivity: connectivity);
    setUp(() => vm =
        ForecastViewModel(repository: repository, connectivity: connectivity));

    test('Forecast view model fetches data when searching', () {
      when(() => connectivity.checkConnectivity())
          .thenAnswer((invocation) async => true);
      when(() => repository.getForecast(hasConnection: true, city: city))
          .thenAnswer((invocation) async => (null, <Weather>[]));
      vm.forecastNotifier.addListener(() {
        expect(vm.forecastNotifier.value, []);
      });
      vm.fetchData(city);
    });

    test('Forecast view model fetches data when searching with no connection',
        () {
      when(() => connectivity.checkConnectivity())
          .thenAnswer((invocation) async => false);
      when(() => repository.getForecast(hasConnection: false, city: city))
          .thenAnswer((invocation) async => (null, <Weather>[]));
      vm.forecastNotifier.addListener(() {
        expect(vm.forecastNotifier.value, []);
      });
      vm.fetchData(city);
    });
  });
}
