import 'dart:convert';

import 'package:cw_weather/src/weather_module/domain/entities/weather.dart';

class WeatherModel extends Weather {
  WeatherModel(
      {required super.id,
      required super.weather,
      required super.description,
      required super.icon,
      required super.temperature,
      required super.dt});

  factory WeatherModel.fromMap(Map<dynamic, dynamic> map) {
    return WeatherModel(
        id: (map['weather'] as List).first['id'] as int,
        weather: (map['weather'] as List).first['main'] as String,
        description: (map['weather'] as List).first['description'] as String,
        icon: (map['weather'] as List).first['icon'] as String,
        temperature: map['main']['temp'],
        dt: DateTime.fromMillisecondsSinceEpoch((map['dt'] as int) * 1000));
  }

  factory WeatherModel.fromJson(String source) =>
      WeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  Map<String, dynamic> toMap() {
    return {
      'weather': [
        {
          'id': id,
          'main': weather,
          'description': description,
          'icon': icon
        }
      ],
      'main': {
        'temp': temperature
      },
      'dt': dt.millisecondsSinceEpoch~/1000,
    };
  }
}
