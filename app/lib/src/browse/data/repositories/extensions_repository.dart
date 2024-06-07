import 'package:injectable/injectable.dart';

import 'package:app/src/browse/data/models/extension.dart';
import 'package:app/src/browse/data/models/installed_extension.dart';
import 'package:app/src/browse/data/providers/extensions_local_data_provider.dart';
import 'package:app/src/browse/data/providers/extensions_remote_data_provider.dart';

typedef ExtensionsAndSources = (List<Extension>, List<InstalledExtension>);

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

    final outdatedExtensions = await _localDataProvider.setOutdatedExtensions(
      availableExtensions,
    );

    availableExtensions.removeWhere(outdatedExtensions.contains);

    return (availableExtensions, outdatedExtensions);
  }
}
