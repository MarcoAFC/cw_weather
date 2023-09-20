import 'package:cw_weather/src/core/exceptions/failure.dart';

class HttpFailure extends Failure{
  final int? statusCode;

  HttpFailure({required super.message, required this.statusCode});

}