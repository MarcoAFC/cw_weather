import 'dart:convert';

import 'package:cw_weather/src/weather_module/domain/entities/city.dart';

class CityModel extends City {
  CityModel(
      {required super.latitude,
      required super.longitude,
      required super.name,
      required super.countryCode,
      required super.state});

  factory CityModel.fromMap(Map<dynamic, dynamic> map) {
    return CityModel(
      latitude: map['lat'] as double,
      longitude: map['lon'] as double,
      name: map['name'] as String,
      countryCode: map['country'] as String,
      state: map['state'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lat': latitude,
      'lon': longitude,
      'name': name,
      'country': countryCode,
      'state': state,
    };
  }

  factory CityModel.fromJson(String source) =>
      CityModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
