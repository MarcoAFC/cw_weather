import 'package:cw_weather/src/core/local_storage/local_storage_service.dart';
import 'package:hive/hive.dart';

class HiveService implements LocalStorageService {
  late final Box _box;

  Future<void> init() async {
    if (_box.isEmpty) {
      for (var element in initialData) {
        await write(key: element.key, value: element.value);
      }
    }
  }

  @override
  Future<Map<String, dynamic>> readKey({required String key}) async {
    await _openBox();
    return _box.get(key);
  }

  @override
  Future<void> write(
      {required String key, required Map<String, dynamic> value}) async {
    await _openBox();
    await _box.put(key, value);
  }

  Future<void> _openBox() async {
    if (!Hive.isBoxOpen('storage')) {
      _box = await Hive.openBox('storage');
    }
  }

  @override
  Future<List<MapEntry>> getAll() async {
    await _openBox();
    return _box.toMap().entries.toList();
  }

  var initialData = [
    const MapEntry("Natal,BR", {
      "name": "Natal",
      "lat": -5.805398,
      "lon": -35.2080905,
      "country": "BR",
      "state": "Rio Grande do Norte"
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
