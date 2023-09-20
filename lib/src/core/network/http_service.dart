import 'package:cw_weather/src/core/exceptions/failure.dart';
import 'package:cw_weather/src/core/network/response/base_response.dart';

abstract interface class HttpService{
  Future<(Failure?, BaseResponse?)> get({required String path, Map<String, dynamic>? queryParameters});
}