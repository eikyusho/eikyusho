import 'package:core/core.dart';
import 'package:database/database.dart' hide Extension;
import 'package:injectable/injectable.dart';

import 'package:app/src/browse/data/models/extension.dart';
import 'package:app/src/browse/data/models/installed_extension.dart';

enum SourcesFilter {
  none,
  onlyEnabled,
  onlyDiscover,
  onlyDisabled,
}

@lazySingleton
class ExtensionsLocalDataProvider {
  const ExtensionsLocalDataProvider(this._db);

  final EikyushoDatabase _db;

  Future<List<InstalledExtension>> getInstalledExtensions(
    SourcesFilter filter,
  ) async {
    try {
      final extensions = await _db.readOnly(
        (isar) async {
          final query = isar.extensions.where();

          if (filter == SourcesFilter.none) return query.findAll();

          final result = switch (filter) {
            SourcesFilter.onlyEnabled => query.filter().isEnabledEqualTo(true),
            SourcesFilter.onlyDiscover => query.filter().discoverEqualTo(true),
            SourcesFilter.onlyDisabled =>
              query.filter().isEnabledEqualTo(false),
            SourcesFilter.none => query.filter().not().uuidIsEmpty(),
          };

          return result.sortByName().findAll();
        },
      );

      return extensions.map(InstalledExtension.fromDatabase).toList();
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  Future<List<InstalledExtension>> setOutdatedExtensions(
    List<AvailableExtension> extensions,
  ) async {
    try {
      final outdatedExtensions = await _db.exec(
        (isar) async {
          final query = isar.extensions.where();

          for (final extension in extensions) {
            final element = await query.uuidEqualTo(extension.uuid).findFirst();

            if (element == null) continue;

            if (element.version == extension.version) continue;

            element
              ..hasUpdate = true
              ..updateVersion = extension.version;

            await isar.extensions.put(element);
          }

          return query.findAll();
        },
      );

      return outdatedExtensions.map(InstalledExtension.fromDatabase).toList();
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
