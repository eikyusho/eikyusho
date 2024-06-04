import 'dart:async';
import 'dart:developer';

import 'package:core/core.dart';
import 'package:flutter/foundation.dart';

import 'bootstrap.dart';
import 'config/app.dart';

void main() {
  runZonedGuarded(
    () => bootstrap(MainApp.new),
    (error, stack) {
      if (kDebugMode) {
        return AppLogger.error(error.toString(), error, stack);
      }

      log(error.toString(), stackTrace: stack);
    },
  );
}
