import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import 'package:app/src/browse/data/models/extension.dart';
import 'package:app/src/browse/data/models/installed_extension.dart';
import 'package:app/src/browse/data/providers/extensions_local_data_provider.dart';
import 'package:app/src/browse/data/providers/extensions_remote_data_provider.dart';

typedef ExtensionsAndSources = (
  List<AvailableExtension>,
  List<InstalledExtension>
);

@injectable
class ExtensionsRepository {
  const ExtensionsRepository(this._remoteDataProvider, this._localDataProvider);

  final ExtensionsRemoteDataProvider _remoteDataProvider;
  final ExtensionsLocalDataProvider _localDataProvider;

  Future<List<InstalledExtension>> getSources({
    required SourcesFilter filter,
  }) async {
    return _localDataProvider.getInstalledExtensions(filter);
  }

  Future<ExtensionsAndSources> getExtensionsAndSources() async {
    final availableExtensions = await _remoteDataProvider.fetchExtensions();

    final dbExtensions = await _localDataProvider.setOutdatedExtensions(
      availableExtensions,
    );

    final outdatedExtensions = dbExtensions.where((element) {
      return availableExtensions.any(
        (e) => e.uuid == element.uuid && element.hasUpdate,
      );
    }).toList();

    availableExtensions.removeWhere((element) {
      return dbExtensions.any(
        (e) => e.uuid == element.uuid && e.language == element.language,
      );
    });

    return (availableExtensions, outdatedExtensions);
  }

  Future<void> installExtension({
    required AvailableExtension extension,
    required ProgressGetter progressCallback,
    required CancelToken cancelToken,
  }) async {
    final response = await _remoteDataProvider.downloadExtension(
      extension: extension,
      progressCallback: progressCallback,
      cancelToken: cancelToken,
    );

    await _localDataProvider.saveExtension(response, extension);
    await _localDataProvider.storeExtension(extension);
  }

  Future<void> enableExtension(int id) async {
    await _localDataProvider.changeExtensionState(id, isEnabled: true);
  }

  Future<void> disableExtension(int id) async {
    await _localDataProvider.changeExtensionState(id, isEnabled: false);
  }
}
