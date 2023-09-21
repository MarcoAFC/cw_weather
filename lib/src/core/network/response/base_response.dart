class BaseResponse{
  final int? statusCode;
  final dynamic data;

  BaseResponse({this.statusCode, required this.data});
}