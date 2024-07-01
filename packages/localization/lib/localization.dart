/// Eikyusho Localization
library localization;

import 'package:flutter/material.dart';

import 'src/localization.dart';

export 'package:flutter_localizations/flutter_localizations.dart';

export 'src/localization.dart';

extension LocalizationExtension on BuildContext {
  AppLocalizations get translate => AppLocalizations.of(this);
}
