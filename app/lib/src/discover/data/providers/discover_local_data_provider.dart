import 'package:core/core.dart';
import 'package:database/database.dart';
import 'package:eikyusho_web_scraper/eikyusho_web_scraper.dart';
import 'package:injectable/injectable.dart';

import 'package:app/common/utils/utils.dart';

@lazySingleton
class DiscoverLocalDataProvider {
  const DiscoverLocalDataProvider(this._prefsManager, this._db);

  final HivePrefsManager _prefsManager;
  final EikyushoDatabase _db;

  Future<void> setDiscoverSource(String uuid) async {
    try {
      await _prefsManager.save(PreferencesKeys.discoverSelectedSource, uuid);
    } catch (e) {
      throw PreferencesException(e.toString());
    }
  }

  Future<String?> getSelectedSourceIdentifier() async {
    try {
      return await _prefsManager.read<String>(
        PreferencesKeys.discoverSelectedSource,
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
    return loadSource(uuid);
  }
}
