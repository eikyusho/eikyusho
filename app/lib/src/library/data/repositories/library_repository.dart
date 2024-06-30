import 'package:injectable/injectable.dart';

import 'package:app/common/common.dart';
import 'package:app/src/library/data/providers/library_local_data_provider.dart';

@injectable
class LibraryRepository {
  const LibraryRepository(this._localDataProvider);

  final LibraryLocalDataProvider _localDataProvider;

  Future<List<Novel>> getNovels() async {
    return _localDataProvider.getNovels();
  }
}
