import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:weather_forecast_app/app/core/errors/exceptions.dart';

abstract class LocalStorage {
  Future<T?> read<T>(String key);
  Future<void> write(String key, dynamic value);
  Future<void> delete(String key);
  Future<void> deleteAll();
  Future<bool> contains(String key);
}

class LocalStorageImpl implements LocalStorage {
  final FlutterSecureStorage _storage;

  LocalStorageImpl(this._storage);

  @override
  Future<T?> read<T>(String key) async {
    switch (T) {
      case const (String):
        return await _readString(key) as T?;
      case const (bool):
        return await _readBool(key) as T?;
      case const (int):
        return await _readInt(key) as T?;
      case const (double):
        return await _readDouble(key) as T?;
      case const (Map<String, dynamic>):
        return await _readMap(key) as T?;
      default:
        throw UnsupportedStorageTypeException('Type $T is not supported');
    }
  }

  Future<String?> _readString(String key) async {
    return await _storage.read(key: key);
  }

  Future<bool?> _readBool(String key) async {
    final value = await _storage.read(key: key);

    switch (value) {
      case 'true':
        return true;
      case 'false':
        return false;
      case null:
        return null;
      default:
        await _storage.delete(key: key);
        throw InvalidStorageTypeException('Value read is not a boolean');
    }
  }

  Future<int?> _readInt(String key) async {
    try {
      final value = await _storage.read(key: key);
      if (value == null) return null;

      return int.parse(value);
    } catch (error) {
      await _storage.delete(key: key);
      throw InvalidStorageTypeException(error.toString());
    }
  }

  Future<double?> _readDouble(String key) async {
    try {
      final value = await _storage.read(key: key);
      if (value == null) return null;

      return double.parse(value);
    } catch (error) {
      await _storage.delete(key: key);
      throw InvalidStorageTypeException(error.toString());
    }
  }

  Future<Map<String, dynamic>?> _readMap(String key) async {
    try {
      final value = await _storage.read(key: key);
      if (value == null) return null;

      return json.decode(value);
    } catch (error) {
      await _storage.delete(key: key);
      throw InvalidStorageTypeException(error.toString());
    }
  }

  @override
  Future<void> write(String key, dynamic value) async {
    if (value is Map<String, dynamic>) {
      final encoded = jsonEncode(value);
      await _storage.write(key: key, value: encoded);
    } else if ([String, bool, int, double].contains(value.runtimeType)) {
      await _storage.write(key: key, value: value.toString());
    } else {
      throw UnsupportedStorageTypeException('Type ${value.runtimeType} is not supported');
    }
  }

  @override
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  @override
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }

  @override
  Future<bool> contains(String key) async {
    return await _storage.containsKey(key: key);
  }
}
