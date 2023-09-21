import 'dart:convert';

import 'package:cw_weather/src/weather/entities/current_weather.dart';

class CurrentWeatherModel extends CurrentWeather {
  CurrentWeatherModel(
      {required super.id,
      required super.weather,
      required super.description,
      required super.icon,
      required super.temperature});

  factory CurrentWeatherModel.fromMap(Map<String, dynamic> map) {
    return CurrentWeatherModel(
      id: (map['weather'] as List).first['id'] as int,
      weather: (map['weather'] as List).first['main'] as String,
      description:(map['weather'] as List).first['description'] as String,
      icon:(map['weather'] as List).first['icon'] as String,
      temperature: map['main']['temp'] as double,
    );
  }

  factory CurrentWeatherModel.fromJson(String source) =>
      CurrentWeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
