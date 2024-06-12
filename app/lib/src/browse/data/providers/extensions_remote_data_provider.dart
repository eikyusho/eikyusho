import 'dart:async';
import 'dart:convert';

import 'package:core/core.dart';
import 'package:eikyusho_extensions/extensions.dart';
import 'package:injectable/injectable.dart';

import 'package:app/src/browse/data/models/extension.dart';

@lazySingleton
class ExtensionsRemoteDataProvider {
  const ExtensionsRemoteDataProvider(this._client);

  final DioClient _client;

  Future<List<AvailableExtension>> fetchExtensions() async {
    try {
      final response = await _client.get<String>(AppEndpoints.extensionsList);

      final data = response.body.data!;

      return List<DataMap>.from(jsonDecode(data) as List)
          .map(AvailableExtension.fromMap)
          .toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException.fromException(e);
    }
  }

  Future<RBytes> downloadExtension({
    required AvailableExtension extension,
    required ProgressGetter progressCallback,
    required CancelToken cancelToken,
  }) async {
    try {
      var milliseconds = 0;

      final response = await _client.get<Bytes>(
        urlParser([
          AppEndpoints.extensionsBinaries,
          extension.uuid,
          Constants.eksFile,
        ]),
        options: HttpRequestOptions(
          responseType: ResponseType.bytes,
          cancelToken: cancelToken,
          onReceiveProgress: (received, total) {
            milliseconds += 10;
            Timer(Duration(milliseconds: milliseconds), () {
              progressCallback(received, total);
            });
          },
          cachePolicy: CachePolicy.noCache,
        ),
      );

      return response;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException.fromException(e);
    }
  }
}
