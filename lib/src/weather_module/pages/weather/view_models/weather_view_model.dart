import 'package:cw_weather/src/core/exceptions/failure.dart';
import 'package:cw_weather/src/weather_module/domain/entities/city.dart';
import 'package:cw_weather/src/weather_module/domain/entities/weather.dart';
import 'package:cw_weather/src/weather_module/domain/repositories/connectivity_repository.dart';
import 'package:cw_weather/src/weather_module/domain/repositories/open_weather_repository.dart';
import 'package:flutter/material.dart';

class WeatherViewModel {
  final OpenWeatherRepository repository;
  final ValueNotifier<Weather?> weatherNotifier = ValueNotifier(null);
  final ValueNotifier<Failure?> errorNotifier = ValueNotifier(null);
  final ConnectivityRepository connectivity;

  WeatherViewModel({required this.repository, required this.connectivity});

  Future<void> fetchData(City city) async {
    weatherNotifier.value = null;
    errorNotifier.value = null;
    bool connection = await connectivity.checkConnectivity();

    var data =
        await repository.getWeather(city: city, hasConnection: connection);

    if (data.$2 != null) {
      weatherNotifier.value = data.$2!;
    } else if (data.$1 != null) {
      errorNotifier.value = data.$1;
    }
  }

  void dispose(){
    weatherNotifier.dispose();
    errorNotifier.dispose();
  }
}
