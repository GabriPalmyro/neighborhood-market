import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/local_database/local_database.dart';

@Singleton(as: LocalStorage)
@Named('SecurePreferencesLocalStorage')
class SecurePreferencesLocalStorage implements LocalStorage {
  SecurePreferencesLocalStorage() {
    _init();
  }

  late FlutterSecureStorage _storage;

  Future<void> _init() async {
    log('Initializing SecurePreferencesLocalStorage');
    _storage = const FlutterSecureStorage();
  }

  @override
  Future<void> saveData<T>(String key, T value) async {
    await _storage.write(key: key, value: value.toString());
  }

  @override
  Future<T> getData<T>(String key) async {
    final value = await _storage.read(key: key);

    if (value == null) {
      throw Exception('No value found for key $key');
    }

    if (T == String) {
      return value as T;
    } else if (T == int) {
      return int.parse(value) as T;
    } else if (T == double) {
      return double.parse(value) as T;
    } else if (T == bool) {
      return (value.toLowerCase() == 'true') as T;
    } else {
      return value as T;
    }
  }

  @override
  Future<void> removeData(String key) async {
    await _storage.delete(key: key);
  }
}
