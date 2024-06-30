import 'package:core/core.dart';
import 'package:eikyusho_web_scraper/eikyusho_web_scraper.dart';
import 'package:injectable/injectable.dart';

import 'package:app/common/common.dart';

@lazySingleton
class NovelRemoteDataProvider {
  const NovelRemoteDataProvider();

  Future<NovelDetails> getNovelDetails(
    EikyushoSource source,
    String link,
  ) async {
    try {
      final novelDetails = await source.getNovelDetails(link);

      return NovelDetails(
        source,
        title: novelDetails.title,
        cover: novelDetails.cover,
        link: novelDetails.link,
        author: novelDetails.author,
        chapterCount: novelDetails.chapters,
        status: novelDetails.status,
        views: novelDetails.views,
        description: novelDetails.description,
        genres: novelDetails.genres,
      );
    } catch (e) {
      throw ServerException.fromException(e);
    }
  }

  Future<List<Chapter>> getNovelChapters(NovelDetails novel) async {
    try {
      final chapters = await novel.source.getNovelChapters(novel.link);

      return chapters
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
      throw ServerException.fromException(e);
    }
  }

  Future<String> getChapter(Chapter chapter) async {
    try {
      return await chapter.novel.source.getChapterContent(chapter.link);
    } catch (e) {
      throw ServerException.fromException(e);
    }
  }
}
