import 'dart:io';

import 'package:core/core.dart';
import 'package:database/database.dart';
import 'package:eikyusho_extensions/extensions.dart';
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
  const ExtensionsLocalDataProvider(this._db, this._compiler);

  final EikyushoDatabase _db;
  final EikyushoCompiler _compiler;

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

  Future<void> saveExtension(
    RBytes response,
    AvailableExtension extension,
  ) async {
    try {
      final directory = await StorageManager.appDirectory;

      final data = response.body.data!;

      final savePath = Path.join(
        directory.path,
        AppConstants.sourcesPath,
        extension.uuid,
      );

      Directory(savePath).createSync(recursive: true);

      await _compiler.decode(savePath, data);
    } catch (e) {
      throw StorageException(e.toString());
    }
  }

  Future<void> storeExtension(AvailableExtension extension) async {
    try {
      final directory = await StorageManager.appDirectory;

      final savePath = Path.joinAll([
        directory.path,
        AppConstants.sourcesPath,
        extension.uuid,
        Constants.xmlFile,
      ]);

      final source = File(savePath);

      final parser = EikyushoParser(source.readAsStringSync());

      final dbExtension = Extension.create(
        uuid: extension.uuid,
        name: extension.name,
        icon: extension.icon,
        version: extension.version,
        language: extension.language,
        baseUrl: parser.baseUrl,
        isEnabled: true,
        discover: true,
        isObsolete: false,
        hasUpdate: false,
      );

      await _db.exec(
        (isar) async {
          await isar.extensions.put(dbExtension);
        },
      );
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  Future<void> changeExtensionState(int id, {required bool isEnabled}) async {
    try {
      await _db.exec(
        (isar) async {
          final extension = await isar.extensions.get(id);

          if (extension == null) return;

          extension.isEnabled = isEnabled;

          await isar.extensions.put(extension);
        },
      );
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  Future<void> toggleExtensionDiscover(int id, {required bool discover}) async {
    try {
      await _db.exec(
        (isar) async {
          final extension = await isar.extensions.get(id);

          if (extension == null) return;

          extension.discover = discover;

          await isar.extensions.put(extension);
        },
      );
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  Future<void> deleteExtension(int id) async {
    try {
      await _db.exec(
        (isar) async {
          await isar.extensions.delete(id);
        },
      );
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  Future<void> removeExtension(InstalledExtension extension) async {
    try {
      final directory = await StorageManager.appDirectory;

      final savePath = Path.join(
        directory.path,
        AppConstants.sourcesPath,
        extension.uuid,
      );

      Directory(savePath).deleteSync(recursive: true);
    } catch (e) {
      throw StorageException(e.toString());
    }
  }
}
