import 'package:injectable/injectable.dart';

import 'package:app/common/common.dart';
import 'package:app/src/reader/data/providers/novel_remote_data_provider.dart';

@injectable
class NovelRepository {
  NovelRepository(this._remoteDataProvider);

  final NovelRemoteDataProvider _remoteDataProvider;

  Future<NovelDetails> getNovelDetails(Novel novel) async {
    return _remoteDataProvider.getNovelDetails(novel);
  }

  Future<List<Chapter>> getNovelChapters(NovelDetails novel) async {
    return _remoteDataProvider.getNovelChapters(novel);
  }

  Future<String> getChapter(Chapter chapter) async {
    return _remoteDataProvider.getChapter(chapter);
  }
}
