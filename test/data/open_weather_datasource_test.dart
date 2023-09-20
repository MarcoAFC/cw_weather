import 'package:cw_weather/src/weather/data/open_weather_datasource.dart';
import 'package:cw_weather/src/services/network/impl/dio_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Open weather datasource tests', () {

    late DioService dio;
    late OpenWeatherDatasource datasource;

    setUpAll((){
      dio = DioService();
      datasource = OpenWeatherDatasource(dio: dio);
    });

    test('Test if data is received properly', () async {
      var data = await datasource.getCoordinatesByName(query: 'Natal');
      print(data);
    });
  });
}
