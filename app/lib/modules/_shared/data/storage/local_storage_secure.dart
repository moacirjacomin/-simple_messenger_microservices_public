import 'package:shared_preferences/shared_preferences.dart';

import 'base_storage.dart';

class LocalStorage implements BaseStorage {
  LocalStorage._();
  static final LocalStorage _instance = LocalStorage._();

  late SharedPreferences  prefs;

  Future<void> init() async {
    // Gets async settings
    prefs = await SharedPreferences.getInstance(); 
  }

  static LocalStorage getInstance() {
    return _instance;
  }

  // Setters 
  @override
  Future<void> setString(String key, String value) async {
    await prefs.setString(key, value);
  }

  @override
  Future<void> setStringList(String key, List<String> value) async {
    await prefs.setStringList(key, value);
  }

  @override
  Future<void> setDouble(String key, double value) async {
    await prefs.setDouble(key, value);
  }

  @override
  Future<void> setBool(String key, bool value) async {
    await prefs.setBool(key, value);
  }

  @override
  Future<void> setInt(String key, int value) async {
    await prefs.setInt(key, value);
  }

  // Getters
  @override
  int? getInt(String key) => prefs.getInt(key);

  @override
  bool? getBool(String key) => prefs.getBool(key);

  @override
  double? getDouble(String key) => prefs.getDouble(key);

  @override
  String? getString(String key) => prefs.getString(key);

  @override
  List<String>? getStringList(String key) => prefs.getStringList(key);

  // Others
  @override
  void clear() =>  prefs.clear();
  @override
  void remove(String key) => prefs.remove(key);
 
}

 