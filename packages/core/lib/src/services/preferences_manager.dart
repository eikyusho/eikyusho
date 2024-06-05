import 'package:shared_preferences/shared_preferences.dart';

/// Abstract class for managing preferences
abstract class PreferencesManager<Manager> {
  const PreferencesManager(this.manager);

  final Manager manager;

  Future<void> save<T>(String key, T value);

  Future<T?> read<T>(String key);

  Future<void> delete(String key);

  Future<void> clearAll();
}

/// Implementation of [PreferencesManager] using [SharedPreferences]
class SharedPrefsManager extends PreferencesManager<SharedPreferences> {
  const SharedPrefsManager(super.manager);

  @override
  Future<void> save<T>(String key, T value) async {
    switch (value) {
      case int():
        await manager.setInt(key, value);
      case double():
        await manager.setDouble(key, value);
      case bool():
        await manager.setBool(key, value);
      case String():
        await manager.setString(key, value);
      case List<String>():
        await manager.setStringList(key, value);
      default:
        throw Exception('Type not supported');
    }
  }

  @override
  Future<T?> read<T>(String key) async {
    if (T == List<String>) return manager.getStringList(key) as T?;

    return switch (T) {
      int => manager.getInt(key),
      double => manager.getDouble(key),
      bool => manager.getBool(key),
      String => manager.getString(key),
      _ => throw Exception('Type not supported'),
    } as T?;
  }

  @override
  Future<void> delete(String key) async {
    await manager.remove(key);
  }

  @override
  Future<void> clearAll() async {
    await manager.clear();
  }
}
