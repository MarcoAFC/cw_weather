import 'package:cw_weather/src/weather_module/data/datasources/open_weather_datasource.dart';
import 'package:cw_weather/src/weather_module/entities/city.dart';
import 'package:flutter/material.dart';

class CitiesViewModel{
  final OpenWeatherDatasource datasource;
  final ValueNotifier<List<City>> citiesNotifier;

  CitiesViewModel({required this.datasource, required this.citiesNotifier});


  Future<void> fetchData(String query) async {
    var data = await datasource.getCoordinatesByName(query: query);

    if(data.$2 != null){
      citiesNotifier.value = data.$2!;
    }
    else if(data.$1 != null){
      //TODO: handle error
    }
  }

}