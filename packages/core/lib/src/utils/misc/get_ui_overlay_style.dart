import 'package:flutter/services.dart';

import '../../../core.dart';

SystemUiOverlayStyle getUiOverlayStyle({required bool isDarkMode}) {
  if (isDarkMode) {
    return SystemUiOverlayStyle.light.copyWith(
      statusBarColor: _getUiOverlayColor(isDarkMode: isDarkMode),
      systemNavigationBarColor: AppMisc.darkBg,
    );
  }

  return SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: _getUiOverlayColor(isDarkMode: isDarkMode),
    systemNavigationBarColor: AppMisc.lightBg,
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
