import 'package:cw_weather/src/core/exceptions/failure.dart';
import 'package:cw_weather/src/weather_module/data/datasources/open_weather_local_datasource.dart';
import 'package:cw_weather/src/weather_module/data/datasources/open_weather_remote_datasource.dart';
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
    if(hasConnection && query != null){
      return await remote.getCoordinatesByName(query: query);
    }
    else{
      return local.getAllCities();
    }
  }

  @override
  Future<(Failure?, List<Weather>?)> getForecast(
      {required bool hasConnection, required City city}) async {
    if(hasConnection){
      return await remote.getForecast(latitude: city.latitude, longitude: city.longitude);
    }
    else{
      return local.getForecast(cityId: "${city.name},${city.countryCode}");
    }
  }

  @override
  Future<(Failure?, Weather?)> getWeather(
      {required bool hasConnection, required City city}) async {
    if(hasConnection){
      return await remote.getWeather(latitude: city.latitude, longitude: city.longitude);
    }
    else{
      return local.getWeather(cityId: city.name);
    }
  }
}
