import 'package:flutter/services.dart';

import '../../constants/app_misc.dart';

SystemUiOverlayStyle getUiOverlayStyle({required bool isDarkMode}) {
  if (isDarkMode) {
    return SystemUiOverlayStyle.light.copyWith(
      statusBarColor: AppMisc.darkBg.withOpacity(
        AppMisc.blurBgOpacity,
      ),
      systemNavigationBarColor: AppMisc.darkBg,
    );
  }

  return SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: AppMisc.lightBg.withOpacity(
      AppMisc.blurBgOpacity,
    ),
    systemNavigationBarColor: AppMisc.lightBg,
  );
}
