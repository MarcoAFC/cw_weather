class BaseResponse{
  final int? statusCode;
  final Object data;

  BaseResponse({this.statusCode, required this.data});
}