import 'dart:io';

import 'package:core/core.dart';
import 'package:database/database.dart';
import 'package:eikyusho_extensions/extensions.dart';
import 'package:eikyusho_web_scraper/eikyusho_web_scraper.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DiscoverLocalDataProvider {
  DiscoverLocalDataProvider(this._prefsManager, this._db);

  final SharedPrefsManager _prefsManager;
  final EikyushoDatabase _db;

  Future<void> setDiscoverSource(String uuid) async {
    try {
      await _prefsManager.save(StorageKeys.discoverSelectedSource, uuid);
    } catch (e) {
      throw PreferencesException(e.toString());
    }
  }

  Future<String?> getSelectedSourceIdentifier() async {
    try {
      return await _prefsManager.read<String>(
        StorageKeys.discoverSelectedSource,
      );
    } catch (e) {
      throw PreferencesException(e.toString());
    }
  }

  Future<Extension?> getSourceFromDatabase(String uuid) async {
    try {
      final source = await _db.readOnly(
        (isar) => isar.extensions.getByUuid(uuid),
      );

      if (source == null) return null;

      if (!source.discover || !source.isEnabled) return null;

      return source;
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  Future<EikyushoSource?> getDiscoverSource(String uuid) async {
    try {
      final sourcePath = await getSourcePath(uuid);
      final sourceFile = Path.join(sourcePath, Constants.xmlFile);

      final sourceData = File(sourceFile);

      final parser = EikyushoParser(sourceData.readAsStringSync());

      return EikyushoSource(parser, uuid);
    } catch (e) {
      throw StorageException(e.toString());
    }
  }
}
