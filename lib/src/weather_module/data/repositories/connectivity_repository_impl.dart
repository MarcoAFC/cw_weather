import 'package:cw_weather/src/core/connectivity/connectivity_service.dart';
import 'package:cw_weather/src/weather_module/domain/repositories/connectivity_repository.dart';

class ConnectivityRepositoryImpl implements ConnectivityRepository{
  final ConnectivityService service;

  ConnectivityRepositoryImpl({required this.service});

  @override
  Future<bool> checkConnectivity() {
    return service.checkConnectivity();
  }

}