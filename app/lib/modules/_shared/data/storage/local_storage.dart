import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'base_storage.dart';

class LocalStorageSecure implements BaseStorage {
  LocalStorageSecure._();
  static final LocalStorageSecure _instance = LocalStorageSecure._();
  final prefs = const FlutterSecureStorage();

  Future<void> init() async {}

  static LocalStorageSecure getInstance() {
    return _instance;
  }

  // Setters
  @override
  Future<void> setString(String key, String value) async {
    await prefs.write(key: key, value: value);
  }

  @override
  Future<void> setStringList(String key, List<String> value) async {
    await prefs.write(key: key, value: value.toString());
  }

  @override
  Future<void> setDouble(String key, double value) async {
    await prefs.write(key: key, value: value.toString());
  }

  @override
  Future<void> setBool(String key, bool value) async {
    await prefs.write(key: key, value: value.toString());
  }

  @override
  Future<void> setInt(String key, int value) async {
    await prefs.write(key: key, value: value.toString());
  }

  // Getters
  @override
  int? getInt(String key) => prefs.read(key: key) as int?;

  @override
  bool? getBool(String key) => prefs.read(key: key) as bool?;

  @override
  double? getDouble(String key) => prefs.read(key: key) as double?;

  @override
  String? getString(String key) => prefs.read(key: key) as String?;

  @override
  List<String>? getStringList(String key) => prefs.read(key: key) as List<String>;

  // Others
  Future<void> delete(String key) async => await prefs.delete(key: key);

  @override
  Future<void> clear() async => await prefs.deleteAll();

  Future<Map<String, String>> getAll() async => await prefs.readAll();

  Future<bool> contains(String key)  async => await prefs.containsKey(key: key);
  
  @override
  void remove(String key) => prefs.delete(key: key);

}
