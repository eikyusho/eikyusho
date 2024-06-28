import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import 'package:app/common/common.dart';

@lazySingleton
class NovelRemoteDataProvider {
  Future<NovelDetails> getNovelDetails(Novel novel) async {
    final novelDetails = await novel.source.getNovelDetails(novel.link);

    return NovelDetails(
      novel.source,
      title: novelDetails.title,
      cover: novel.cover,
      link: novel.link,
      author: novelDetails.author,
      chapterCount: novelDetails.chapters,
      status: novelDetails.status,
      viewCount: novelDetails.views,
      description: novelDetails.description,
      genres: novelDetails.genres,
    );
  }

  Future<List<Chapter>> getNovelChapters(NovelDetails novel) async {
    final chapters = await novel.source.getNovelChapters(novel.link);

    AppLogger.debug(chapters.toString());

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
  }
}
