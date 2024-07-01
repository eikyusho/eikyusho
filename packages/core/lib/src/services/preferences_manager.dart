import 'package:hive/hive.dart';

/// Abstract class for managing preferences
abstract class PreferencesManager<Manager> {
  const PreferencesManager(this.manager);

  final Manager manager;

  Future<void> save<T>(String key, T value);

  Future<T?> read<T>(String key);

  Future<void> delete(String key);

  Future<void> clearAll();
}

/// Implementation of [PreferencesManager] using [Hive]
class HivePrefsManager extends PreferencesManager<HiveInterface> {
  const HivePrefsManager(super.manager, this._box);

  final Box<Object> _box;

  @override
  Future<void> save<T>(String key, T value) async {
    await _box.put(key, value as Object);
  }

  @override
  Future<T?> read<T>(String key) async {
    return _box.get(key) as T?;
  }

  @override
  Future<void> delete(String key) async {
    await _box.delete(key);
  }

  @override
  Future<void> clearAll() async {
    await _box.clear();
  }
}
