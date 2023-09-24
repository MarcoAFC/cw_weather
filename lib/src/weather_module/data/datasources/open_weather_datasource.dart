import 'package:cw_weather/src/core/exceptions/failure.dart';
import 'package:cw_weather/src/core/network/http_service.dart';
import 'package:cw_weather/src/weather_module/data/models/city_model.dart';
import 'package:cw_weather/src/weather_module/entities/city.dart';
import 'package:cw_weather/src/weather_module/entities/weather.dart';
import 'package:cw_weather/src/weather_module/data/models/weather_model.dart';

class OpenWeatherDatasource{
  final HttpService http;

  OpenWeatherDatasource({required this.http});
  
  Future<(Failure?, Weather?)> getWeather({required double latitude, required double longitude})async{
    try{
      var response = await http.get(path: '/data/2.5/weather', queryParameters: {'lat': latitude, 'lon': longitude, 'units': 'metric'});
      if(response.$1 != null){
        // check if an error has ocurred
        return (response.$1, null);
      }
      else{
        return (null, WeatherModel.fromMap(response.$2?.data as Map<String, dynamic>));
      }
    } catch(e){
      return (Failure.generic, null);
    } 
  }

  Future<(Failure?, List<City>?)> getCoordinatesByName({required String query})async {
    try{
      var response = await http.get(path: '/geo/1.0/direct', queryParameters: {'q': query});
      if(response.$1 != null){
        // check if an error has ocurred
        return (response.$1, null);
      }
      else{
        var list = (response.$2!.data as List).map((e) => CityModel.fromMap(e as Map<String, dynamic>)).toList();
        return (null, list);
      }
    } catch(e){
      return (Failure.generic, null);
    } 
  }

  Future<(Failure?, List<Weather>?)> getForecast({required double latitude, required double longitude})async{
    try{
      var response = await http.get(path: '/data/2.5/forecast', queryParameters: {'lat': latitude, 'lon': longitude, 'units': 'metric', 'cnt': 35});
      if(response.$1 != null){
        // check if an error has ocurred
        return (response.$1, null);
      }
      else{
        List<WeatherModel> list = [

        ];
        var data = (response.$2!.data['list'] as List);
        for(int i = 0; i < data.length; i = i+7){
          list.add(WeatherModel.fromMap(data[i]));
        }
        return (null, list);
      }
    } catch(e){
      return (Failure.generic, null);
    } 
  }
}