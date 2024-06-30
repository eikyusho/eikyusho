import 'dart:io';

import 'package:core/core.dart';
import 'package:eikyusho_extensions/extensions.dart';
import 'package:eikyusho_web_scraper/eikyusho_web_scraper.dart';

Future<EikyushoSource> loadSource(String uuid) async {
  try {
    final sourcePath = await getSourcePath(uuid);
    final sourceFile = Path.join(sourcePath, Constants.xmlFile);

    final sourceData = File(sourceFile);

    final parser = EikyushoParser(sourceData.readAsStringSync());

    return EikyushoSource(parser, uuid);
  } catch (e) {
    throw StorageException(e.toString());
  }
}
