import 'package:cw_weather/src/weather_module/data/datasources/open_weather_local_datasource.dart';
import 'package:cw_weather/src/weather_module/data/datasources/open_weather_remote_datasource.dart';
import 'package:cw_weather/src/weather_module/data/models/city_model.dart';
import 'package:cw_weather/src/weather_module/data/models/weather_model.dart';
import 'package:cw_weather/src/weather_module/data/repositories/open_weather_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemote extends Mock implements OpenWeatherRemoteDatasource {}

class MockLocal extends Mock implements OpenWeatherLocalDatasource {}

void main() {
  group('Open weather repository tests', () {
    var remote = MockRemote();
    var local = MockLocal();
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
    OpenWeatherRepositoryImpl repository =
        OpenWeatherRepositoryImpl(local: local, remote: remote);
    test('Repository calls local on getcities without connection', () async {
      when(() => local.getAllCities())
          .thenAnswer((invocation) async => (null, <CityModel>[]));
      var data = await repository.getCities(hasConnection: false);

      expect(data.$1, null);
      expect(data.$2, isA<List<CityModel>>());
      expect(data.$2!.length, 0);
    });

    test('Repository calls local on getcities with connection and no query',
        () async {
      when(() => local.getAllCities())
          .thenAnswer((invocation) async => (null, <CityModel>[]));
      var data = await repository.getCities(hasConnection: true);

      expect(data.$1, null);
      expect(data.$2, isA<List<CityModel>>());
      expect(data.$2!.length, 0);
    });

    test('Repository calls remote on getcities with connection', () async {
      when(() => remote.getCoordinatesByName(query: 'a'))
          .thenAnswer((invocation) async => (null, <CityModel>[]));
      var data = await repository.getCities(hasConnection: true, query: 'a');

      expect(data.$1, null);
      expect(data.$2, isA<List<CityModel>>());
      expect(data.$2!.length, 0);
    });

    test(
        'Repository calls remote on getforecast with connection, and stores data in local',
        () async {
      when(() => remote.getForecast(
              latitude: city.latitude, longitude: city.longitude))
          .thenAnswer((invocation) async => (null, <WeatherModel>[weather]));

      when(() => local.storeData(map: {
                "forecast": [weather].map((e) => e.toMap()).toList()
              }, name: '${city.name},${city.countryCode}'))
          .thenAnswer((invocation) async {});
      var data = await repository.getForecast(hasConnection: true, city: city);

      expect(data.$1, null);
      expect(data.$2, isA<List<WeatherModel>>());
      expect(data.$2!.length, 1);
    });

    test(
        'Repository calls local on getforecast without connection',
        () async {
      when(() => local.getForecast(
              cityId: '${city.name},${city.countryCode}'))
          .thenAnswer((invocation) async => (null, <WeatherModel>[weather]));

      
      var data = await repository.getForecast(hasConnection: false, city: city);

      expect(data.$1, null);
      expect(data.$2, isA<List<WeatherModel>>());
      expect(data.$2!.length, 1);
    });

    test(
        'Repository calls remote on getWeather with connection, and stores data in local',
        () async {
      when(() => remote.getWeather(
              latitude: city.latitude, longitude: city.longitude))
          .thenAnswer((invocation) async => (null, weather));

      when(() => local.storeData(map: {
                "weather": weather.toMap()
              }, name: '${city.name},${city.countryCode}'))
          .thenAnswer((invocation) async {});
      when(() => local.storeData(map: city.toMap(), name: '${city.name},${city.countryCode}'))
          .thenAnswer((invocation) async {});
      var data = await repository.getWeather(hasConnection: true, city: city);

      expect(data.$1, null);
      expect(data.$2, isA<WeatherModel>());
      expect(data.$2!.id, 501);
    });

    test(
        'Repository calls local on getWeather without connection',
        () async {
      when(() => local.getWeather(
              cityId: '${city.name},${city.countryCode}'))
          .thenAnswer((invocation) async => (null, weather));

      
      var data = await repository.getWeather(hasConnection: false, city: city);

      expect(data.$1, null);
      expect(data.$2, isA<WeatherModel>());
      expect(data.$2!.id, 501);
    });
  });
}
