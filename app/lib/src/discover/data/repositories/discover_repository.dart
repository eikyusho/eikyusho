import 'package:eikyusho_web_scraper/eikyusho_web_scraper.dart';
import 'package:injectable/injectable.dart';

import 'package:app/src/browse/data/data.dart';
import 'package:app/src/discover/data/providers/discover_local_data_provider.dart';

typedef ExtensionsAndSources = (
  List<AvailableExtension>,
  List<InstalledExtension>
);

@injectable
class DiscoverRepository {
  const DiscoverRepository(this._localDataProvider);

  final DiscoverLocalDataProvider _localDataProvider;

  Future<void> setDiscoverSource(String uuid) async {
    await _localDataProvider.setDiscoverSource(uuid);
  }

  Future<EikyushoSource?> getDiscoverSource() async {
    final sourceUuid = await _localDataProvider.getSelectedSourceIdentifier();

    if (sourceUuid == null) return null;

    final source = await _localDataProvider.getSourceFromDatabase(sourceUuid);

    if (source == null) return null;

    return _localDataProvider.getDiscoverSource(sourceUuid);
  }
}
