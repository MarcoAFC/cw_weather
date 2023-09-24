import 'package:cw_weather/src/weather_module/data/models/city_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('City model tests', () {
    var json = {
      "name": "Natal",
      "lat": -5.805398,
      "lon": -35.2080905,
      "country": "BR",
      "state": "Rio Grande do Norte"
    };
    test('City model properly renders json', () {
      var model = CityModel.fromMap(json);

      expect(model.name, 'Natal');
      expect(model.latitude, -5.805398);
      expect(model.longitude, -35.2080905);
      expect(model.countryCode, 'BR');
      expect(model.state, "Rio Grande do Norte");
    });
  });
}
