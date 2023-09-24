import 'package:cw_weather/src/core/exceptions/failure.dart';
import 'package:cw_weather/src/core/local_storage/local_storage_service.dart';
import 'package:cw_weather/src/weather_module/data/models/city_model.dart';
import 'package:cw_weather/src/weather_module/data/models/weather_model.dart';
import 'package:cw_weather/src/weather_module/domain/entities/city.dart';
import 'package:cw_weather/src/weather_module/domain/entities/weather.dart';

class OpenWeatherLocalDatasource {
  final LocalStorageService storage;

  OpenWeatherLocalDatasource({required this.storage});

  Future<(Failure?, List<City>?)> getAllCities() async {
    try {
      var data = await storage.getAll();

      var list = data
          .map((e) => CityModel.fromMap(e))
          .toList();
      return (null, list);
    } catch (e) {
      return (Failure.generic, null);
    }
  }

  Future<(Failure?, Weather?)> getWeather({required String cityId}) async {
    try {
      var data = await storage.readKey(key: cityId);

      var list = WeatherModel.fromMap(data['weather']);
      return (null, list);
    } catch (e) {
      return (Failure.generic, null);
    }
  }

  Future<(Failure?, List<Weather>?)> getForecast(
      {required String cityId}) async {
    try {
      var data = await storage.readKey(key: cityId);

      var list = data['forecast']
          .map((e) => CityModel.fromMap(e.value as Map<String, dynamic>))
          .toList();
      return list;
    } catch (e) {
      return (Failure.generic, null);
    }
  }
}
