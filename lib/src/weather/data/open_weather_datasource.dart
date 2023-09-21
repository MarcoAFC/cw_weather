import 'package:cw_weather/src/core/exceptions/failure.dart';
import 'package:cw_weather/src/core/network/http_service.dart';
import 'package:cw_weather/src/weather/entities/weather.dart';
import 'package:cw_weather/src/weather/models/weather_model.dart';

class OpenWeatherDatasource{
  final HttpService http;

  OpenWeatherDatasource({required this.http});
  
  Future<(Failure?, Weather?)> getWeather({required String latitude, required String longitude})async{
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

  Future<dynamic> getCoordinatesByName({required String query})async {
    return await http.get(path: '/geo/1.0/direct', queryParameters: {'q': query});
  }

  Future<(Failure?, List<Weather>?)> getForecast({required String latitude, required String longitude})async{
    try{
      var response = await http.get(path: '/data/2.5/forecast', queryParameters: {'lat': latitude, 'lon': longitude, 'units': 'metric'});
      if(response.$1 != null){
        // check if an error has ocurred
        return (response.$1, null);
      }
      else{
        var list = (response.$2!.data['list'] as List).map((e) => WeatherModel.fromMap(e as Map<String, dynamic>)).toList();
        return (null, list);
      }
    } catch(e){
      return (Failure.generic, null);
    } 
  }
}