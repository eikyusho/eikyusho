import 'dart:convert';

import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import 'package:app/src/browse/data/models/extension.dart';

@lazySingleton
class ExtensionsRemoteDataProvider {
  const ExtensionsRemoteDataProvider(this._client);

  final DioClient _client;

  Future<List<Extension>> fetchExtensions() async {
    try {
      final response = await _client.get<String>(AppEndpoints.extensionsList);

      final data = response.body.data!;

      final parsedData = List<DataMap>.from(json.decode(data) as List);

      return parsedData.map(Extension.fromMap).toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(
        e.toString(),
        type: ServerExceptionType.unknown,
        statusCode: 999,
      );
    }
  }
}
