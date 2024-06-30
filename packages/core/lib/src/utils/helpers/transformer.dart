import 'dart:async';

import 'package:flutter/foundation.dart';

sealed class Transformer {
  Transformer({required this.milliseconds});

  factory Transformer.debounce({required int milliseconds}) = Debouncer;

  factory Transformer.throttle({required int milliseconds}) = Throttle;

  final int milliseconds;
  Timer? _timer;

  void run(VoidCallback action);
}

class Debouncer extends Transformer {
  Debouncer({required super.milliseconds});

  @override
  void run(VoidCallback action) {
    if (_timer?.isActive ?? false) _timer!.cancel();

    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class Throttle extends Transformer {
  Throttle({required super.milliseconds});

  bool _isRunning = false;

  @override
  void run(VoidCallback action) {
    if (_isRunning) return;

    _isRunning = true;

    action();

    _timer = Timer(Duration(milliseconds: milliseconds), () {
      _isRunning = false;
    });
  }
}
