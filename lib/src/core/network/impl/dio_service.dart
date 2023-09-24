import 'package:cw_weather/src/core/exceptions/failure.dart';
import 'package:cw_weather/src/core/network/exceptions/http_failure.dart';
import 'package:cw_weather/src/core/network/http_service.dart';
import 'package:cw_weather/src/core/network/response/base_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioService implements HttpService {
  final Dio _dio = Dio(BaseOptions(
      baseUrl: dotenv.env['BASE_URL']!,
      queryParameters: {'appid': dotenv.env['API_KEY']}));

  @override
  Future<(Failure?, BaseResponse?)> get(
      {required String path, Map<String, dynamic>? queryParameters}) async {
    try {
      var response = (await _dio.get(path, queryParameters: queryParameters));
      return (
        null,
        BaseResponse(data: response.data, statusCode: response.statusCode)
      );
    } on DioException catch (e) {
      return (
        HttpFailure(
            message: e.message ??
                "We are currently unable to reach our servers, please check your connectivity and try again.",
            statusCode: e.response?.statusCode),
        null
      );
    } catch (e) {
      return (Failure.generic, null);
    }
  }
}
