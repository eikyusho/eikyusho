import 'package:core/core.dart';
import 'package:database/database.dart';
import 'package:eikyusho_web_scraper/eikyusho_web_scraper.dart';
import 'package:injectable/injectable.dart';

import 'package:app/common/common.dart';

@lazySingleton
class NovelLocalDataProvider {
  const NovelLocalDataProvider(this._db);

  final EikyushoDatabase _db;

  Future<bool> isNovelInLibrary(String link) async {
    try {
      final novel = await _db.readOnly(
        (isar) => isar.libraryNovels.getByLink(link),
      );

      return novel != null;
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  Future<NovelDetails> getNovelDetails(String link) async {
    try {
      final novel = await _db.readOnly(
        (isar) => isar.libraryNovels.getByLink(link),
      );

      await novel!.source.load();

      final source = await getNovelSource(novel.source.value!.uuid);

      return NovelDetails(
        source!,
        title: novel.title,
        cover: novel.cover,
        link: novel.link,
        author: novel.author,
        chapterCount: novel.chapterCount,
        status: novel.status,
        views: novel.views,
        description: novel.description,
        genres: novel.genres,
      );
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  Future<List<Chapter>> getNovelChapters(Novel novel) async {
    try {
      final dbNovel = await _db.readOnly(
        (isar) => isar.libraryNovels.getByLink(novel.link),
      );

      if (dbNovel == null) {
        throw Exception(AppStrings.novelNotFound);
      }

      return dbNovel.chapters
          .map(
            (chapter) => Chapter(
              novel,
              title: chapter.title,
              link: chapter.link,
              number: chapter.number,
              date: chapter.date,
            ),
          )
          .toList();
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  Future<void> addToLibrary(NovelDetails novel, List<Chapter> chapters) async {
    try {
      final dbChapters = chapters.map((chapter) {
        return NovelChapter.create(
          link: chapter.link,
          title: chapter.title,
          date: chapter.date,
          number: chapter.number,
        );
      }).toList();

      final dbNovel = LibraryNovel.create(
        title: novel.title,
        link: novel.link,
        cover: novel.cover,
        author: novel.author,
        chapterCount: novel.chapterCount,
        status: novel.status,
        views: novel.views,
        description: novel.description,
        genres: novel.genres,
        chapters: dbChapters,
      );

      final extension = await _db.readOnly(
        (isar) => isar.extensions.getByUuid(novel.source.uuid),
      );

      if (extension == null) {
        throw Exception(AppStrings.extensionNotFound);
      }

      dbNovel.source.value = extension;

      await _db.exec((isar) async {
        await isar.libraryNovels.put(dbNovel);
        await dbNovel.source.save();
      });
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  Future<void> removeFromLibrary(Novel novel) async {
    try {
      await _db.exec((isar) async {
        await isar.libraryNovels.deleteByLink(novel.link);
      });
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  Future<EikyushoSource?> getNovelSource(String uuid) async {
    try {
      return loadSource(uuid);
    } catch (e) {
      throw StorageException(e.toString());
    }
  }
}
