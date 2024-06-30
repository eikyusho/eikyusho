import 'package:core/core.dart';
import 'package:database/database.dart';
import 'package:eikyusho_web_scraper/eikyusho_web_scraper.dart';
import 'package:injectable/injectable.dart';

import 'package:app/common/common.dart';

@lazySingleton
class SearchLocalDataProvider {
  const SearchLocalDataProvider(this._db);

  final EikyushoDatabase _db;

  Future<(List<EikyushoSource>, List<Extension>)> getSources() async {
    try {
      final dbSources = await _db.readOnly(
        (isar) async {
          return isar.extensions.where().findAll();
        },
      );

      final sourcesFutures = dbSources.map((source) async {
        return loadSource(source.uuid);
      }).toList();

      final sources = await Future.wait(sourcesFutures);

      return (sources, dbSources);
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
