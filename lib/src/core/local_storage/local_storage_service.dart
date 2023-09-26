import 'package:cw_weather/src/core/exceptions/failure.dart';

abstract interface class LocalStorageService {
  Future<(Failure?, Map<dynamic, dynamic>?)> readKey({required String key});
  Future<(Failure?, void)> write(
      {required String key, required Map<dynamic, dynamic> value});
  Future<(Failure?, List<dynamic>?)> getAll();
}
