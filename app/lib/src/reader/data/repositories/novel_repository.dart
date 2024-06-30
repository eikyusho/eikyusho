import 'package:injectable/injectable.dart';

import 'package:app/common/common.dart';
import 'package:app/src/reader/data/providers/novel_local_data_provider.dart';
import 'package:app/src/reader/data/providers/novel_remote_data_provider.dart';

@injectable
class NovelRepository {
  const NovelRepository(this._remoteDataProvider, this._localDataProvider);

  final NovelRemoteDataProvider _remoteDataProvider;
  final NovelLocalDataProvider _localDataProvider;

  Future<(NovelDetails, bool)> getNovelDetails(Novel novel) async {
    final isLibrary = await _localDataProvider.isNovelInLibrary(novel.link);

    return switch (isLibrary) {
      true => (await _localDataProvider.getNovelDetails(novel.link), true),
      false => (
          await _remoteDataProvider.getNovelDetails(novel.source, novel.link),
          false
        ),
    };
  }

  Future<List<Chapter>> getNovelChapters(
    NovelDetails novel, {
    required bool isLocal,
  }) async {
    if (isLocal) return _localDataProvider.getNovelChapters(novel);

    return _remoteDataProvider.getNovelChapters(novel);
  }

  Future<String> getChapter(Chapter chapter) async {
    return _remoteDataProvider.getChapter(chapter);
  }

  Future<void> addToLibrary(NovelDetails novel, List<Chapter> chapters) async {
    return _localDataProvider.addToLibrary(novel, chapters);
  }

  Future<void> removeFromLibrary(Novel novel) async {
    return _localDataProvider.removeFromLibrary(novel);
  }
}
