import 'dart:async';

import 'package:injectable/injectable.dart';

import 'package:app/common/common.dart';
import 'package:app/src/search/data/providers/search_local_data_provider.dart';
import 'package:app/src/search/data/providers/search_remote_data_provider.dart';

@injectable
class SearchRepository {
  const SearchRepository(this._localDataProvider, this._remoteDataProvider);

  final SearchLocalDataProvider _localDataProvider;
  final SearchRemoteDataProvider _remoteDataProvider;

  Future<Stream<List<Novel>>> searchNovels(String query) async {
    final (sources, extensions) = await _localDataProvider.getSources();

    return _remoteDataProvider.searchNovels(sources, extensions, query);
  }
}
