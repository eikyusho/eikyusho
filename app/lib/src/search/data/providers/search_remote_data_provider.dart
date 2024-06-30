import 'dart:async';

import 'package:core/core.dart';
import 'package:database/database.dart';
import 'package:eikyusho_web_scraper/eikyusho_web_scraper.dart';
import 'package:injectable/injectable.dart';

import 'package:app/common/common.dart';
import 'package:app/src/browse/data/data.dart';

@lazySingleton
class SearchRemoteDataProvider {
  Stream<List<Novel>> searchNovels(
    List<EikyushoSource> sources,
    List<Extension> extensions,
    String query,
  ) async* {
    try {
      for (final source in sources) {
        final extension = extensions.firstWhere(
          (extension) => extension.uuid == source.uuid,
        );

        final novels = await source.searchNovels(query);

        final availableSource = InstalledExtension.fromDatabase(extension);

        final mappedNovels = novels.map((novel) {
          return Novel(
            source,
            title: novel.title,
            cover: novel.cover,
            additionalInfo: novel.additionalInfo,
            link: novel.link,
            extension: availableSource,
          );
        }).toList();

        yield mappedNovels;
      }
    } catch (e) {
      throw ServerException.fromException(e);
    }
  }
}
