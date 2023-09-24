import 'package:cw_weather/src/core/exceptions/failure.dart';
import 'package:cw_weather/src/core/local_storage/local_storage_service.dart';
import 'package:cw_weather/src/weather_module/data/datasources/open_weather_local_datasource.dart';
import 'package:cw_weather/src/weather_module/data/models/city_model.dart';
import 'package:cw_weather/src/weather_module/data/models/weather_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockStorage extends Mock implements LocalStorageService {}

void main() {
  group('Open weather local datasource', () {
    late LocalStorageService storage;
    late OpenWeatherLocalDatasource datasource;
    late List<Map<String, dynamic>> cityJson;

    setUpAll(() {
      storage = MockStorage();
      datasource = OpenWeatherLocalDatasource(storage: storage);
    });

    test('Get current weather returns a valid model for valid data', () async {
      when(() => storage.readKey(key: 'key'))
          .thenAnswer((invocation) async => cityJson[0]);

      var data = await datasource.getWeather(cityId: 'key');
      expect(data.$1, null);
      expect(data.$2, isA<WeatherModel>());
      expect(data.$2!.weather, "Clear");
      expect(data.$2!.temperature, 17.28);
      expect(data.$2!.id, 800);
      expect(data.$2!.description, 'clear sky');
      expect(data.$2!.icon, '01d');
    });
    test('Get current weather returns failure for invalid data', () async {
      when(() => storage.readKey(key: 'key'))
          .thenAnswer((invocation) async => {});

      var data = await datasource.getWeather(cityId: 'key');
      expect(data.$1, isA<Failure>());
      expect(data.$2, null);
    });

    test('Get forecast returns a valid model for valid data', () async {
      when(() => storage.readKey(key: 'key'))
          .thenAnswer((invocation) async => cityJson[0]);

      var data = await datasource.getForecast(cityId: 'key');
      expect(data.$1, null);
      expect(data.$2, isA<List<WeatherModel>>());
      expect(data.$2!.length, 5);
    });

    test('Get forecast returns failure for invalid data', () async {
      when(() => storage.readKey(key: 'key'))
          .thenAnswer((invocation) async => {});

      var data = await datasource.getForecast(cityId: 'key');
      expect(data.$1, isA<Failure>());
      expect(data.$2, null);
    });

    test('Get coordinatesbyname returns a list of valid models for valid data',
        () async {
      when(() => storage.getAll())
          .thenAnswer((invocation) async => cityJson);

      var data = await datasource.getAllCities();
      expect(data.$1, null);
      expect(data.$2, isA<List<CityModel>>());
      expect(data.$2!.length, 1);
      expect(data.$2!.first.latitude, -37.8142176);
    });

    test('Get coordinatesbyname returns failure for invalid data', () async {
      when(() => storage.getAll())
          .thenThrow(Exception());

      var data = await datasource.getAllCities();
      expect(data.$1, isA<Failure>());
      expect(data.$2, null);
    });

    
    cityJson = [
      {
        "name": "Melbourne",
        "lat": -37.8142176,
        "lon": 144.9631608,
        "country": "AU",
        "state": "Victoria",
        "weather": {
          "weather": [
            {
              "id": 800,
              "main": "Clear",
              "description": "clear sky",
              "icon": "01d"
            }
          ],
          "main": {"temp": 17.28},
          "dt": 1695594116
        },
        "forecast": [
          {
            "weather": [
              {
                "id": 802,
                "main": "Clouds",
                "description": "scattered clouds",
                "icon": "03d"
              }
            ],
            "main": {"temp": 18.24},
            "dt": 1695600000
          },
          {
            "weather": [
              {
                "id": 800,
                "main": "Clear",
                "description": "clear sky",
                "icon": "01d"
              }
            ],
            "main": {"temp": 9.81},
            "dt": 1695675600
          },
          {
            "weather": [
              {
                "id": 804,
                "main": "Clouds",
                "description": "overcast clouds",
                "icon": "04n"
              }
            ],
            "main": {"temp": 10.1},
            "dt": 1695751200
          },
          {
            "weather": [
              {
                "id": 800,
                "main": "Clear",
                "description": "clear sky",
                "icon": "01n"
              }
            ],
            "main": {"temp": 8.8},
            "dt": 1695826800
          },
          {
            "weather": [
              {
                "id": 800,
                "main": "Clear",
                "description": "clear sky",
                "icon": "01n"
              }
            ],
            "main": {"temp": 12.79},
            "dt": 1695902400
          }
        ]
      }
    ];
  });
}
