import 'package:cw_weather/src/core/connectivity/connectivity_service.dart';

import 'dart:io';

class ConnectivityServiceImpl implements ConnectivityService {
  @override
  Future<bool> checkConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } on SocketException catch (_) {
      return false;
    }
  }
}
