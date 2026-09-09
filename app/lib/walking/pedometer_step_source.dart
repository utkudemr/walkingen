import 'dart:async';

import 'package:flutter/services.dart';

abstract interface class StepTrackingSource {
  Stream<int> get steps;
  Future<void> start();
  Future<void> stop();
}

class PedometerStepSource implements StepTrackingSource {
  static const _stepChannel = EventChannel('step_detection');

  StreamSubscription<dynamic>? _subscription;
  final StreamController<int> _steps = StreamController<int>.broadcast();
  int _count = 0;

  @override
  Stream<int> get steps => _steps.stream;

  @override
  Future<void> start() async {
    await _subscription?.cancel();
    _subscription = _stepChannel.receiveBroadcastStream().listen(
      (_) {
        _count++;
        _steps.add(_count);
      },
      onError: _steps.addError,
    );
  }

  @override
  Future<void> stop() async {
    await _subscription?.cancel();
    _subscription = null;
  }

  Future<void> dispose() async {
    await stop();
    await _steps.close();
  }
}
