abstract interface class LocalStorageService{
  Future<Map<String, dynamic>> readKey({required String key});
  Future<void> write({required String key, required Map<String, dynamic> value});
  Future<List<MapEntry>> getAll();
}