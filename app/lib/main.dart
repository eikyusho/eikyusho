import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';

import 'package:core/core.dart';

import 'package:app/bootstrap.dart';
import 'package:app/config/app.dart';

void main() {
  runZonedGuarded(() async {
    await bootstrap(MainApp.new);
  }, (error, stack) {
    if (kDebugMode) {
      return AppLogger.error(error.toString(), error, stack);
    }

    log(error.toString(), stackTrace: stack);
  });
}
