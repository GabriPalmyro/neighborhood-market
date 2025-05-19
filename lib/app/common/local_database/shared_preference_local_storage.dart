import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/local_database/local_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Singleton(as: LocalStorage)
class SharedPreferencesDatabase implements LocalStorage {
  SharedPreferencesDatabase() {
    _init();
  }

  late SharedPreferences _preferences;

  Future<void> _init() async {
    log('Initializing SharedPreferences');
    _preferences = await SharedPreferences.getInstance();
  }

  @override
  Future<void> saveData<T>(String key, T value) async {
    if (value is String) {
      await _preferences.setString(key, value);
    } else if (value is int) {
      await _preferences.setInt(key, value);
    } else if (value is double) {
      await _preferences.setDouble(key, value);
    } else if (value is bool) {
      await _preferences.setBool(key, value);
    } else if (value is List<String>) {
      await _preferences.setStringList(key, value);
    } else {
      throw Exception('Unsupported data type');
    }
  }

  @override
  Future<T> getData<T>(String key) async {
    return _preferences.get(key) as T;
  }

  @override
  Future<void> removeData(String key) async {
    await _preferences.remove(key);
  }
}
