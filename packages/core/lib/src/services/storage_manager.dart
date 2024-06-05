import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../utils/helpers/path.dart';

class StorageManager {
  const StorageManager();

  static Future<Directory> get appDirectory async {
    if (Platform.isIOS) {
      return getLibraryDirectory();
    }
    return getApplicationDocumentsDirectory();
  }

  static Future<Directory> get supportDirectory async {
    return getApplicationSupportDirectory();
  }

  static Future<Directory> get cacheDirectory async {
    return getApplicationCacheDirectory();
  }

  static Future<Directory> get tempDirectory async {
    return getTemporaryDirectory();
  }

  Future<void> saveFile(
    String path,
    String data, {
    required bool encode,
  }) async {
    await _ensureDirectory(path);

    if (!encode) await File(path).writeAsString(data);

    final List<int> bytes = utf8.encode(data);
    await File(path).writeAsBytes(bytes);
  }

  Future<String> readFile(String path, {required bool decode}) async {
    if (!decode) return File(path).readAsString();

    final List<int> bytes = await File(path).readAsBytes();
    return utf8.decode(bytes);
  }

  Future<bool> fileExists(String path) async {
    return File(path).existsSync();
  }

  Future<void> deleteFile(String path) async {
    await File(path).delete();
  }

  Future<void> _ensureDirectory(String path) async {
    final directory = Directory(Path.getDirectory(path));
    if (!directory.existsSync()) {
      await directory.create(recursive: true);
    }
  }
}
