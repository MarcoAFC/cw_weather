import 'dart:convert';

import 'package:cw_weather/src/weather/entities/weather.dart';

class WeatherModel extends Weather {
  WeatherModel(
      {required super.id,
      required super.weather,
      required super.description,
      required super.icon,
      required super.temperature});

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    return WeatherModel(
      id: (map['weather'] as List).first['id'] as int,
      weather: (map['weather'] as List).first['main'] as String,
      description:(map['weather'] as List).first['description'] as String,
      icon:(map['weather'] as List).first['icon'] as String,
      temperature: map['main']['temp'] as double,
    );
  }

  factory WeatherModel.fromJson(String source) =>
      WeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
