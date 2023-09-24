import 'package:cw_weather/src/core/exceptions/failure.dart';
import 'package:cw_weather/src/core/network/http_service.dart';
import 'package:cw_weather/src/core/network/response/base_response.dart';
import 'package:cw_weather/src/weather_module/data/datasources/open_weather_datasource.dart';
import 'package:cw_weather/src/weather_module/data/models/city_model.dart';
import 'package:cw_weather/src/weather_module/data/models/weather_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHttp extends Mock implements HttpService {}

void main() {
  group('Open weather datasource', () {
    late HttpService http;
    late OpenWeatherDatasource datasource;
    late Map<String, dynamic> weatherJson;
    late Map<String, dynamic> forecastJson;
    late List<Map<String, dynamic>> geocodingJson;
    setUpAll(() {
      http = MockHttp();
      datasource = OpenWeatherDatasource(http: http);
    });

    test('Get current weather returns a valid model for valid data', () async {
      when(
        () => http.get(
            path: '/data/2.5/weather',
            queryParameters: {'lat': 1, 'lon': 2, 'units': 'metric'}),
      ).thenAnswer(
          (invocation) async => (null, BaseResponse(data: weatherJson)));

      var data = await datasource.getWeather(latitude: 1, longitude: 2);
      expect(data.$1, null);
      expect(data.$2, isA<WeatherModel>());
      expect(data.$2!.weather, "Rain");
      expect(data.$2!.temperature, 298.48);
      expect(data.$2!.id, 501);
      expect(data.$2!.description, 'moderate rain');
      expect(data.$2!.icon, '10d');
    });

    test('Get current weather returns failure for invalid data', () async {
      when(
        () => http.get(
            path: '/data/2.5/weather',
            queryParameters: {'lat': 1, 'lon': 2, 'units': 'metric'}),
      ).thenAnswer((invocation) async => (null, BaseResponse(data: {})));

      var data = await datasource.getWeather(latitude: 1, longitude: 2);
      expect(data.$1, isA<Failure>());
      expect(data.$2, null);
    });

    test('Get forecast returns a valid model for valid data', () async {
      when(
        () => http.get(
            path: '/data/2.5/forecast',
            queryParameters: {'lat': 1, 'lon': 2, 'units': 'metric', 'cnt': 5}),
      ).thenAnswer(
          (invocation) async => (null, BaseResponse(data: forecastJson)));

      var data = await datasource.getForecast(latitude: 1, longitude: 2);
      expect(data.$1, null);
      expect(data.$2, isA<List<WeatherModel>>());
      expect(data.$2!.length, 4);
    });

    test('Get forecast returns failure for invalid data', () async {
      when(
        () => http.get(
            path: '/data/2.5/forecast',
            queryParameters: {'lat': 1, 'lon': 2, 'units': 'metric'}),
      ).thenAnswer((invocation) async => (null, BaseResponse(data: {})));

      var data = await datasource.getForecast(latitude: 1, longitude: 2);
      expect(data.$1, isA<Failure>());
      expect(data.$2, null);
    });

    test('Get coordinatesbyname returns a list of valid models for valid data', () async {
      when(
        () => http.get(
            path: '/geo/1.0/direct',
            queryParameters: {'q': 'natal'}),
      ).thenAnswer(
          (invocation) async => (null, BaseResponse(data: geocodingJson)));

      var data = await datasource.getCoordinatesByName(query: 'natal');
      expect(data.$1, null);
      expect(data.$2, isA<List<CityModel>>());
      expect(data.$2!.length, 5);
      expect(data.$2!.first.latitude, -5.805398);
    });

    test('Get coordinatesbyname returns failure for invalid data', () async {
      when(
        () => http.get(
            path: '/geo/1.0/direct',
            queryParameters: {'q': 'natal'}),
      ).thenAnswer(
          (invocation) async => (null, BaseResponse(data: {})));

      var data = await datasource.getCoordinatesByName(query: 'natal');
      expect(data.$1, isA<Failure>());
      expect(data.$2, null);
    });

    geocodingJson = [
      {
        "name": "Natal",
        "local_names": {
          "hy": "Նատալ",
          "kk": "Натал",
          "ka": "ნატალი",
          "fa": "ناتال",
          "ru": "Натал",
          "ko": "나타우",
          "ar": "ناتال",
          "bg": "Натал",
          "tg": "Натал",
          "be": "Натал",
          "sr": "Натал",
          "en": "Natal",
          "lt": "Natalis",
          "th": "นาตาล",
          "la": "Natalis",
          "he": "נאטאל",
          "ja": "ナタール",
          "pt": "Natal",
          "el": "Νατάλ",
          "de": "Natal",
          "pl": "Natal",
          "ce": "Νατάλ",
          "lv": "Natala",
          "mr": "नाताल",
          "zh": "纳塔尔",
          "uk": "Натал",
          "mk": "Натал",
          "eo": "Natalo"
        },
        "lat": -5.805398,
        "lon": -35.2080905,
        "country": "BR",
        "state": "Rio Grande do Norte"
      },
      {
        "name": "Natal",
        "lat": 36.9868073,
        "lon": -79.2672444,
        "country": "US",
        "state": "Virginia"
      },
      {
        "name": "Natal",
        "lat": -5.060415600000001,
        "lon": -41.87421791866078,
        "country": "BR",
        "state": "Piauí"
      },
      {
        "name": "Natal",
        "lat": 0.5566449,
        "lon": 99.1134353,
        "country": "ID",
        "state": "North Sumatra"
      },
      {
        "name": "Natal",
        "lat": -18.9893051,
        "lon": -49.4713826,
        "country": "BR",
        "state": "Minas Gerais"
      }
    ];

    weatherJson = {
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

    forecastJson = {
      "cod": "200",
      "message": 0,
      "cnt": 40,
      "list": [
        {
          "dt": 1661871600,
          "main": {
            "temp": 296.76,
            "feels_like": 296.98,
            "temp_min": 296.76,
            "temp_max": 297.87,
            "pressure": 1015,
            "sea_level": 1015,
            "grnd_level": 933,
            "humidity": 69,
            "temp_kf": -1.11
          },
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10d"
            }
          ],
          "clouds": {"all": 100},
          "wind": {"speed": 0.62, "deg": 349, "gust": 1.18},
          "visibility": 10000,
          "pop": 0.32,
          "rain": {"3h": 0.26},
          "sys": {"pod": "d"},
          "dt_txt": "2022-08-30 15:00:00"
        },
        {
          "dt": 1661882400,
          "main": {
            "temp": 295.45,
            "feels_like": 295.59,
            "temp_min": 292.84,
            "temp_max": 295.45,
            "pressure": 1015,
            "sea_level": 1015,
            "grnd_level": 931,
            "humidity": 71,
            "temp_kf": 2.61
          },
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10n"
            }
          ],
          "clouds": {"all": 96},
          "wind": {"speed": 1.97, "deg": 157, "gust": 3.39},
          "visibility": 10000,
          "pop": 0.33,
          "rain": {"3h": 0.57},
          "sys": {"pod": "n"},
          "dt_txt": "2022-08-30 18:00:00"
        },
        {
          "dt": 1661893200,
          "main": {
            "temp": 292.46,
            "feels_like": 292.54,
            "temp_min": 290.31,
            "temp_max": 292.46,
            "pressure": 1015,
            "sea_level": 1015,
            "grnd_level": 931,
            "humidity": 80,
            "temp_kf": 2.15
          },
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10n"
            }
          ],
          "clouds": {"all": 68},
          "wind": {"speed": 2.66, "deg": 210, "gust": 3.58},
          "visibility": 10000,
          "pop": 0.7,
          "rain": {"3h": 0.49},
          "sys": {"pod": "n"},
          "dt_txt": "2022-08-30 21:00:00"
        },
        {
          "dt": 1662292800,
          "main": {
            "temp": 294.93,
            "feels_like": 294.83,
            "temp_min": 294.93,
            "temp_max": 294.93,
            "pressure": 1018,
            "sea_level": 1018,
            "grnd_level": 935,
            "humidity": 64,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 804,
              "main": "Clouds",
              "description": "overcast clouds",
              "icon": "04d"
            }
          ],
          "clouds": {"all": 88},
          "wind": {"speed": 1.14, "deg": 17, "gust": 1.57},
          "visibility": 10000,
          "pop": 0,
          "sys": {"pod": "d"},
          "dt_txt": "2022-09-04 12:00:00"
        }
      ],
      "city": {
        "id": 3163858,
        "name": "Zocca",
        "coord": {"lat": 44.34, "lon": 10.99},
        "country": "IT",
        "population": 4593,
        "timezone": 7200,
        "sunrise": 1661834187,
        "sunset": 1661882248
      }
    };
  });
}
