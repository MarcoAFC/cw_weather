import 'package:cw_weather/src/services/dio_service.dart';

class OpenWeatherDatasource{
  final DioService dio;

  OpenWeatherDatasource({required this.dio});
  
  Future<dynamic> getCurrentWeather({required String latitude, required String longitude})async{
    return await dio.get('/data/2.5/weather');
  }

  Future<dynamic> getCoordinatesByName({required String zipCode, required countryCode})async {
    return await dio.get('/geo/1.0/zip', queryParameters: {'zip': '$zipCode,$countryCode', });
  }

  Future<dynamic> getForecast({required String latitude, required String longitude})async {
    return await dio.get('/data/2.5/forecast');
  }
}