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

      var list = data.$2!
          .map((e) => CityModel.fromMap(e))
          .toList();
      return (null, list);
    } catch (e) {
      return (Failure.generic, null);
    }
  }

  Future<void> storeData({required Map<String, dynamic> map, required String name})async{
    await storage.write(key: name, value: map);
  }

  Future<(Failure?, Weather?)> getWeather({required String cityId}) async {
    try {
      var data = await storage.readKey(key: cityId);
      if(data.$2!['weather'] == null){
        return (Failure.noDataAndConnectivity, null);
      }
      var list = WeatherModel.fromMap(data.$2!['weather']);
      return (null, list);
    } catch (e) {
      return (Failure.generic, null);
    }
  }

  Future<(Failure?, List<Weather>?)> getForecast(
      {required String cityId}) async {
    try {
      var data = await storage.readKey(key: cityId);
      if(data.$2!['forecast'] == null){
        return (Failure.noDataAndConnectivity, null);
      }
      List<WeatherModel> list = data.$2!['forecast']
          .map<WeatherModel>((e) => WeatherModel.fromMap(e))
          .toList();
      return (null, list);
    } catch (e) {
      return (Failure.generic, null);
    }
  }
}
