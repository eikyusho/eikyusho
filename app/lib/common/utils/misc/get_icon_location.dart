import 'dart:io';

import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:eikyusho_extensions/extensions.dart';

import 'package:app/src/browse/data/data.dart';

Future<ImageProvider<Object>> getIconLocation(
  PixelDensity density,
  AvailableExtension extension,
) async {
  if (extension is! InstalledExtension) {
    return NetworkImage(_getRemotePath(extension));
  }

  final sourcePath = await _getLocalPath(extension);
  final iconPath = _getIconFilename(density);

  final path = Path.join(sourcePath, iconPath);

  return FileImage(File(path));
}

Future<String> _getLocalPath(InstalledExtension extension) async {
  final directory = await StorageManager.appDirectory;
  final uuid = extension.uuid;

  return Path.join(directory.path, AppConstants.sourcesPath, uuid);
}

String _getRemotePath(AvailableExtension extension) {
  final uuid = extension.uuid;

  return Path.join(AppEndpoints.extensions, uuid, Constants.imgPreviewFile);
}

String _getIconFilename(PixelDensity density) {
  return switch (density) {
    PixelDensity.x1 => Constants.img1xFile,
    PixelDensity.x2 => Constants.img2xFile,
    PixelDensity.x3 => Constants.img3xFile,
  };
}
