import 'dart:async';

import 'package:cw_weather/src/core/local_storage/local_storage_service.dart';
import 'package:hive/hive.dart';

class HiveService implements LocalStorageService {
  late final Box _box;
  final Completer initialized = Completer();
  HiveService({Box? box}) {
    init(box: box);
  }

  Future<void> init({Box? box}) async {
    await _openBox(box: box);
    if (_box.isEmpty) {
      for (var element in initialData) {
        await write(key: element.key, value: element.value);
      }
    }
    initialized.complete();
  }

  @override
  Future<Map<dynamic, dynamic>?> readKey({required String key}) async {
    return await _box.get(key);
  }

  @override
  Future<void> write(
      {required String key, required Map<String, dynamic> value}) async {
    var currentValue = await readKey(key: key);
    if (currentValue != null) {
      // if data already exists, update it instead of overwriting
      currentValue.addAll(value);
      await _box.put(key, currentValue);
    } else {
      await _box.put(key, value);
    }
  }

  Future<void> _openBox({Box? box}) async {
    if(box != null){
      //this is used to allow properly mocking box in tests while allowing easier access to non-default boxes
      _box = box;
    }
    else if (!Hive.isBoxOpen('storage')) {
      _box = await Hive.openBox('storage');
    }
  }

  @override
  Future<List<dynamic>> getAll() async {
    await initialized.future;
    final result = _box.values.toList();
    return result;
  }

  var initialData = [
    const MapEntry("São Paulo,BR", {
      "name": "São Paulo",
      "lat": -23.5506507,
      "lon": -46.6333824,
      "country": "BR",
      "state": "São Paulo"
    }),
    const MapEntry("Silverstone,GB", {
      "name": "Silverstone",
      "lat": 52.0877287,
      "lon": -1.0241177,
      "country": "GB",
      "state": "England"
    }),
    const MapEntry("Melbourne,AU", {
      "name": "Melbourne",
      "lat": -37.8142176,
      "lon": 144.9631608,
      "country": "AU",
      "state": "Victoria"
    }),
    const MapEntry("Monte-Carlo,MC", {
      "name": "Monte-Carlo",
      "lat": 43.7402961,
      "lon": 7.426559,
      "country": "MC"
    })
  ];
}
