import 'package:cw_weather/src/core/local_storage/hive/hive_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';

class MockBox extends Mock implements Box {}

void main() {
  var box = MockBox();
  var list = <Map<dynamic, dynamic>>[];

  late HiveService service;

  group('Hive service tests', () {
    setUpAll(() {
      // write
      when(() => box.put(any(), any())).thenAnswer((invocation) async {
        list.add({
          invocation.positionalArguments[0]: invocation.positionalArguments[1]
        });
      });
      [
        {
          'aa': {},
        },
        {'bb': {}}
      ];

      //read
      when(() => box.get(any())).thenAnswer((invocation) async {
        return list.cast<Map<dynamic, dynamic>?>().firstWhere(
            (element) =>
                element?.keys.first == invocation.positionalArguments.first,
            orElse: () => null);
      });

      when(() => box.values).thenAnswer((invocation) {
        return list;
      });

      when(() => box.isEmpty).thenAnswer((invocation) {
        return list.isEmpty;
      });
      service = HiveService(box: box);
    });
    test('Check if init runs properly', () {
      expect(service.initialized.isCompleted, true);
    });

    test('Check if initial values were added', () async {
      var response = await service.getAll();
      expect(response.length, 4);
      expect(response, list);
    });

    test('Check if readkey returns valid data', () async {
      var response = await service.readKey(key: 'Silverstone,GB');
      expect(response, {
        'Silverstone,GB': {
          'name': 'Silverstone',
          'lat': 52.0877287,
          'lon': -1.0241177,
          'country': 'GB',
          'state': 'England'
        }
      });
    });

  });
}
