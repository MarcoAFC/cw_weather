import 'package:cw_weather/src/core/exceptions/failure.dart';
import 'package:cw_weather/src/weather_module/domain/entities/city.dart';
import 'package:cw_weather/src/weather_module/domain/entities/weather.dart';

abstract interface class OpenWeatherRepository{
  Future<(Failure?, List<City>?)> getCities({required bool hasConnection, String? query});

  Future<(Failure?, Weather?)> getWeather({required bool hasConnection, required City city});

  Future<(Failure?, List<Weather>?)> getForecast({required bool hasConnection, required City city});
}