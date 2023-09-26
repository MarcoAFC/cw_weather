import 'dart:async';

import 'package:cw_weather/src/core/exceptions/failure.dart';
import 'package:cw_weather/src/core/local_storage/local_storage_service.dart';
import 'package:hive/hive.dart';

class HiveService implements LocalStorageService {
  late final Box _box;
  final Completer initialized = Completer();
  HiveService({Box? box}) {
    init(box: box);
  }

  Future<void> init({Box? box}) async {
    try {
      await _openBox(box: box);
      if (_box.isEmpty) {
        for (var element in initialData) {
          await write(key: element.key, value: element.value);
        }
      }
      initialized.complete();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, Map<dynamic, dynamic>?)> readKey({required String key}) async {
    try {
      return (null, await _box.get(key) as Map);
    } catch (e) {
      return (Failure.generic, null);
    }
  }

  @override
  Future<(Failure?, void)> write(
      {required String key, required Map<dynamic, dynamic> value}) async {
    try {
      var currentValue = await readKey(key: key);
      if (currentValue.$2 != null) {
        // if data already exists, update it instead of overwriting
        currentValue.$2!.addAll(value);
        await _box.put(key, currentValue);
      } else {
        await _box.put(key, value);
      }
      return (null, null);
    } catch (e) {
      return (Failure.generic, null);
    }
  }

  Future<(Failure?, void)> _openBox({Box? box}) async {
    try {
      if (box != null) {
        //this is used to allow properly mocking box in tests while allowing easier access to non-default boxes
        _box = box;
      } else if (!Hive.isBoxOpen('storage')) {
        _box = await Hive.openBox('storage');
      }
      return (null, null);
    } catch (e) {
      return (Failure.generic, null);
    }
  }

  @override
  Future<(Failure?, List<dynamic>?)> getAll() async {
    try {
      await initialized.future;
      final result = _box.values.toList();
      return (null, result);
    } catch (e) {
      return (Failure.generic, null);
    }
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
