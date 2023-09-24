import 'package:cw_weather/src/weather_module/data/models/city_model.dart';
import 'package:cw_weather/src/weather_module/data/models/weather_model.dart';
import 'package:cw_weather/src/weather_module/domain/repositories/connectivity_repository.dart';
import 'package:cw_weather/src/weather_module/domain/repositories/open_weather_repository.dart';
import 'package:cw_weather/src/weather_module/pages/weather/view_models/weather_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRepo extends Mock implements OpenWeatherRepository {}

class MockConnectivity extends Mock implements ConnectivityRepository {}

void main() {
  group('Weather viewmodel tests', () {
    var json = {
      "name": "Natal",
      "lat": -5.805398,
      "lon": -35.2080905,
      "country": "BR",
      "state": "Rio Grande do Norte"
    };
    var weatherJson = {
      "coord": {"lon": 10.99, "lat": 44.34},
      "weather": [
        {
          "id": 501,
          "main": "Rain",
          "description": "moderate rain",
          "icon": "10d"
        }
      ],
      "base": "stations",
      "main": {
        "temp": 298.48,
        "feels_like": 298.74,
        "temp_min": 297.56,
        "temp_max": 300.05,
        "pressure": 1015,
        "humidity": 64,
        "sea_level": 1015,
        "grnd_level": 933
      },
      "visibility": 10000,
      "wind": {"speed": 0.62, "deg": 349, "gust": 1.18},
      "rain": {"1h": 3.16},
      "clouds": {"all": 100},
      "dt": 1661870592,
      "sys": {
        "type": 2,
        "id": 2075663,
        "country": "IT",
        "sunrise": 1661834187,
        "sunset": 1661882248
      },
      "timezone": 7200,
      "id": 3163858,
      "name": "Zocca",
      "cod": 200
    };
    var weather = WeatherModel.fromMap(weatherJson);
    var city = CityModel.fromMap(json);
    var repository = MockRepo();
    var connectivity = MockConnectivity();
    var vm =
        WeatherViewModel(repository: repository, connectivity: connectivity);
    setUp(() => vm =
        WeatherViewModel(repository: repository, connectivity: connectivity));

    test('Weather view model fetches data when searching', () {
      when(() => connectivity.checkConnectivity())
          .thenAnswer((invocation) async => true);
      when(() => repository.getWeather(hasConnection: true, city: city))
          .thenAnswer((invocation) async => (null, weather));
      vm.weatherNotifier.addListener(() {
        expect(vm.weatherNotifier.value, weather);
      });
      vm.fetchData(city);
    });

    test('Weather view model fetches data when searching with no connection',
        () {
      when(() => connectivity.checkConnectivity())
          .thenAnswer((invocation) async => false);
      when(() => repository.getWeather(hasConnection: false, city: city))
          .thenAnswer((invocation) async => (null, weather));
      vm.weatherNotifier.addListener(() {
        expect(vm.weatherNotifier.value, weather);
      });
      vm.fetchData(city);
    });
  });
}
