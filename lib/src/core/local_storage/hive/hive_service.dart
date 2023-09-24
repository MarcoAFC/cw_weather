import 'package:cw_weather/src/core/local_storage/local_storage_service.dart';
import 'package:hive/hive.dart';

class HiveService implements LocalStorageService {
  late final Box _box;

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
}

