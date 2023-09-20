import 'package:dio/dio.dart';

class DioService {
  final Dio _dio = Dio(BaseOptions(
      baseUrl: 'https://api.openweathermap.org',
      queryParameters: {'appid': '0013ee27aafdb175b28331a5da0eef78'}));

  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters}) {
    return _dio.get(path, queryParameters: queryParameters);
  }
}
