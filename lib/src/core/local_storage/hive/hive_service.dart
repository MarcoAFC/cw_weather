import 'dart:async';

import 'package:cw_weather/src/core/local_storage/local_storage_service.dart';
import 'package:hive/hive.dart';

class HiveService implements LocalStorageService {
  late Box _box;
  final Completer initialized = Completer();
  HiveService() {
    init();
  }

  Future<void> init() async {
    await _openBox();
    if (_box.isEmpty) {
      for (var element in initialData) {
        await write(key: element.key, value: element.value);
      }
    }
    initialized.complete();
  }

  @override
  Future<Map<String, dynamic>> readKey({required String key}) async {
    return _box.get(key);
  }

  @override
  Future<void> write(
      {required String key, required Map<String, dynamic> value}) async {
    await _box.put(key, value);
  }

  Future<void> _openBox() async {
    if (!Hive.isBoxOpen('storage')) {
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
