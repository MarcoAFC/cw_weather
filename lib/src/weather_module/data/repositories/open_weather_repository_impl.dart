import 'package:cw_weather/src/core/exceptions/failure.dart';
import 'package:cw_weather/src/weather_module/data/datasources/open_weather_local_datasource.dart';
import 'package:cw_weather/src/weather_module/data/datasources/open_weather_remote_datasource.dart';
import 'package:cw_weather/src/weather_module/data/models/city_model.dart';
import 'package:cw_weather/src/weather_module/data/models/weather_model.dart';
import 'package:cw_weather/src/weather_module/domain/entities/city.dart';
import 'package:cw_weather/src/weather_module/domain/entities/weather.dart';
import 'package:cw_weather/src/weather_module/domain/repositories/open_weather_repository.dart';

class OpenWeatherRepositoryImpl implements OpenWeatherRepository {
  final OpenWeatherLocalDatasource local;
  final OpenWeatherRemoteDatasource remote;

  OpenWeatherRepositoryImpl({required this.local, required this.remote});

  @override
  Future<(Failure?, List<City>?)> getCities(
      {required bool hasConnection, String? query}) async {
    if (hasConnection && query != null) {
      var cities = await remote.getCoordinatesByName(query: query);
      return cities;
    } else {
      return local.getAllCities();
    }
  }

  @override
  Future<(Failure?, List<Weather>?)> getForecast(
      {required bool hasConnection, required City city}) async {
    if (hasConnection) {
      var forecast = await remote.getForecast(
          latitude: city.latitude, longitude: city.longitude);
      if (forecast.$2 != null) {
        local.storeData(map: {
          "forecast":
              (forecast.$2 as List<WeatherModel>).map((e) => e.toMap()).toList()
        }, name: "${city.name},${city.countryCode}");
      }
      return forecast;
    } else {
      return local.getForecast(cityId: "${city.name},${city.countryCode}");
    }
  }

  Future<void> saveCity(City city) async {
    await local.storeData(
        map: (city as CityModel).toMap(),
        name: "${city.name},${city.countryCode}");
  }

  @override
  Future<(Failure?, Weather?)> getWeather(
      {required bool hasConnection, required City city}) async {
    if (hasConnection) {
      await saveCity(city);
      var weather = await remote.getWeather(
          latitude: city.latitude, longitude: city.longitude);
      if (weather.$2 != null) {
        local.storeData(
            map: {"weather": (weather.$2 as WeatherModel).toMap()},
            name: "${city.name},${city.countryCode}");
      }
      return weather;
    } else {
      return local.getWeather(cityId: "${city.name},${city.countryCode}");
    }
  }
}
