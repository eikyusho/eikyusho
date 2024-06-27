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
      chapterCount: novelDetails.chapterCount,
      status: novelDetails.status,
      viewCount: novelDetails.views,
      description: novelDetails.description,
      genres: novelDetails.genres,
    );
  }
}
