import 'package:cw_weather/src/core/exceptions/failure.dart';
import 'package:cw_weather/src/services/network/exceptions/http_failure.dart';
import 'package:cw_weather/src/services/network/http_service.dart';
import 'package:cw_weather/src/services/network/response/base_response.dart';
import 'package:dio/dio.dart';

class DioService implements HttpService {
  final Dio _dio = Dio(BaseOptions(
      baseUrl: 'https://api.openweathermap.org',
      queryParameters: {'appid': '0013ee27aafdb175b28331a5da0eef78'}));

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
      return (
        Failure(
            message: "An internal error has ocurred, please try again later."),
        null
      );
    }
  }
}
