import 'package:cw_weather/src/weather_module/data/datasources/open_weather_datasource.dart';
import 'package:cw_weather/src/weather_module/entities/city.dart';
import 'package:cw_weather/src/weather_module/entities/weather.dart';
import 'package:flutter/material.dart';

class WeatherViewModel{
  final OpenWeatherDatasource datasource;
  final ValueNotifier<Weather> weatherNotifier;

  WeatherViewModel({required this.datasource, required this.weatherNotifier});


  Future<void> fetchData(City city) async {
    var data = await datasource.getWeather(latitude: city.latitude, longitude: city.longitude);

    if(data.$2 != null){
      weatherNotifier.value = data.$2!;
    }
    else if(data.$1 != null){
      //TODO: handle error
    }
  }
}