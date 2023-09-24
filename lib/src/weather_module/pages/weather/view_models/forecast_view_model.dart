import 'package:cw_weather/src/core/exceptions/failure.dart';
import 'package:cw_weather/src/weather_module/domain/entities/city.dart';
import 'package:cw_weather/src/weather_module/domain/entities/weather.dart';
import 'package:cw_weather/src/weather_module/domain/repositories/connectivity_repository.dart';
import 'package:cw_weather/src/weather_module/domain/repositories/open_weather_repository.dart';
import 'package:flutter/material.dart';

class ForecastViewModel {
  final OpenWeatherRepository repository;
  final ValueNotifier<List<Weather>?> forecastNotifier = ValueNotifier(null);
  final ValueNotifier<Failure?> errorNotifier = ValueNotifier(null);
  final ConnectivityRepository connectivity;

  ForecastViewModel({required this.repository, required this.connectivity});

  Future<void> fetchData(City city) async {
    forecastNotifier.value = null;
    errorNotifier.value = null;
    bool connection = await connectivity.checkConnectivity();

    var data =
        await repository.getForecast(city: city, hasConnection: connection);

    if (data.$2 != null) {
      forecastNotifier.value = data.$2!;
    } else if (data.$1 != null) {
      errorNotifier.value = data.$1;
    }
  }
}
