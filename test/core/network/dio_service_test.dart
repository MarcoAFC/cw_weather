import 'package:cw_weather/src/core/network/exceptions/http_failure.dart';
import 'package:cw_weather/src/core/network/impl/dio_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late DioService service;

  final dio = Dio(BaseOptions());
  final dioAdapter = DioAdapter(dio: dio);

  group('Dio service tests', () {
    setUpAll(() {
      service = DioService(dio: dio);
    });
    test('Check if get returns valid data with valid http response', () async {
      const route = '/route';
      dioAdapter.onGet(
          route,
          (server) => server.reply(
                200,
                {"data": "this is data"},
                delay: const Duration(seconds: 1),
              ));
      
      var response = await service.get(path: route);

      expect(response.$1, null);
      expect(response.$2?.statusCode, 200);
      expect(response.$2?.data, {"data": "this is data"});
    });

    test('Check if get returns valid failure with invalid http response', () async {
      const route = '/route';
      dioAdapter.onGet(
          route,
          (server) => server.reply(
                400,
                null,
                statusMessage: "failure",
                delay: const Duration(seconds: 1),
              ));
      
      var response = await service.get(path: route);

      expect(response.$2, null);
      expect(response.$1?.message, "failure");
      expect((response.$1 as HttpFailure).statusCode, 400);
    });
  });
}
