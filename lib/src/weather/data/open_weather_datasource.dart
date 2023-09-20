import 'package:cw_weather/src/core/exceptions/failure.dart';
import 'package:cw_weather/src/services/network/impl/dio_service.dart';

class OpenWeatherDatasource{
  final DioService dio;

  OpenWeatherDatasource({required this.dio});
  
  Future<(Failure?, dynamic)> getCurrentWeather({required String latitude, required String longitude})async{
    return await dio.get(path: '/data/2.5/weather');
  }

  Future<dynamic> getCoordinatesByName({required String query})async {
    return await dio.get(path: '/geo/1.0/direct', queryParameters: {'q': query});
  }

  Future<dynamic> getForecast({required String latitude, required String longitude})async {
    return await dio.get(path: '/data/2.5/forecast');
  }
}