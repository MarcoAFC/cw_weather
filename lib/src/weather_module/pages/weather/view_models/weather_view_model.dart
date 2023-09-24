import 'package:cw_weather/src/core/exceptions/failure.dart';
import 'package:cw_weather/src/weather_module/domain/entities/city.dart';
import 'package:cw_weather/src/weather_module/domain/entities/weather.dart';
import 'package:cw_weather/src/weather_module/domain/repositories/open_weather_repository.dart';
import 'package:flutter/material.dart';

class WeatherViewModel{
  final OpenWeatherRepository repository;
  final ValueNotifier<Weather?> weatherNotifier= ValueNotifier(null);
  final ValueNotifier<Failure?> errorNotifier = ValueNotifier(null);

  WeatherViewModel({required this.repository});


  Future<void> fetchData(City city) async {
    weatherNotifier.value = null;
    errorNotifier.value = null;
    var data = await repository.getWeather(city: city, hasConnection: true);

    if(data.$2 != null){
      weatherNotifier.value = data.$2!;
    }
    else if(data.$1 != null){
      errorNotifier.value = data.$1;
    }
  }
}