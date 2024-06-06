import 'package:flutter/services.dart';

import '../../../core.dart';

SystemUiOverlayStyle getUiOverlayStyle({required bool isDarkMode}) {
  if (isDarkMode) {
    return SystemUiOverlayStyle.light.copyWith(
      statusBarColor: _getUiOverlayColor(isDarkMode: isDarkMode),
      systemNavigationBarColor: _getUiOverlayColor(isDarkMode: isDarkMode),
    );
  }

  return SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: _getUiOverlayColor(isDarkMode: isDarkMode),
    systemNavigationBarColor: _getUiOverlayColor(isDarkMode: isDarkMode),
  );
}

Color _getUiOverlayColor({required bool isDarkMode}) {
  if (isDarkMode) {
    return AppMisc.darkBg.withOpacity(
      AppMisc.blurBgOpacity,
    );
  }

  return AppMisc.lightBg.withOpacity(
    AppMisc.blurBgOpacity,
  );
}
