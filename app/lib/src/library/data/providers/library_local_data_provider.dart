import 'package:app/src/browse/data/data.dart';
import 'package:core/core.dart';
import 'package:database/database.dart';
import 'package:eikyusho_web_scraper/eikyusho_web_scraper.dart';
import 'package:injectable/injectable.dart';

import 'package:app/common/common.dart';

@lazySingleton
class LibraryLocalDataProvider {
  const LibraryLocalDataProvider(this._db);

  final EikyushoDatabase _db;

  Future<List<Novel>> getNovels() async {
    final sources = <EikyushoSource>[];

    try {
      final novels = await _db.readOnly(
        (isar) => isar.libraryNovels.where().findAll(),
      );

      final extensions = await _db.readOnly(
        (isar) => isar.extensions.where().findAll(),
      );

      await _db.readOnly(
        (isar) async {
          for (final novel in novels) {
            await novel.source.load();

            final uuid = novel.source.value!.uuid;

            sources.add(await getNovelSource(uuid));
          }
        },
      );

      return novels.map((e) {
        final source = sources.firstWhere(
          (source) => source.uuid == e.source.value!.uuid,
        );

        final dbExtension = extensions.firstWhere(
          (extension) => extension.uuid == source.uuid,
        );

        final extension = InstalledExtension.fromDatabase(dbExtension);

        return Novel(
          source,
          title: e.title,
          cover: e.cover,
          link: e.link,
          isCompleted: e.completed,
          extension: extension,
        );
      }).toList();
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  Future<List<Novel>> getCollection() async {
    return [];
  }

  Future<EikyushoSource> getNovelSource(String uuid) async {
    try {
      return loadSource(uuid);
    } catch (e) {
      throw StorageException(e.toString());
    }
  }
}
