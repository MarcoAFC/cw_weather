import 'package:cw_weather/src/weather_module/data/models/weather_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Weather model tests', () {
    var json = {
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
    test('City model properly renders json', () {
      var model = WeatherModel.fromMap(json);

      expect(model.description, "moderate rain");
      expect(model.dt, DateTime.fromMillisecondsSinceEpoch(1661870592*1000));
      expect(model.icon, '10d');
      expect(model.temperature, 298.48);
      expect(model.weather, "Rain");
    });
  });
}
