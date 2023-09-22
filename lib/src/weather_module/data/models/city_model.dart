import 'dart:convert';

import 'package:cw_weather/src/weather_module/entities/city.dart';

class CityModel extends City {
  CityModel(
      {required super.latitude,
      required super.longitude,
      required super.name,
      required super.countryCode,
      required super.state});

  factory CityModel.fromMap(Map<String, dynamic> map) {
    return CityModel(
      latitude: map['lat'] as double,
      longitude: map['lon'] as double,
      name: map['name'] as String,
      countryCode: map['country'] as String,
      state: map['state'] as String,
    );
  }

  factory CityModel.fromJson(String source) =>
      CityModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
