import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:walkingen/database/app_database.dart';
import 'package:walkingen/walking/location_observation.dart';
import 'package:walkingen/walking/pedometer_step_source.dart';
import 'package:walkingen/walking/walking_session_controller.dart';
import 'package:walkingen/walking/walking_session_repository.dart';
import 'package:walkingen/walking/walking_tracking.dart';

void main() {
  test(
    'controller publishes live step changes without navigation rebuild',
    () async {
      final database = AppDatabase.inMemory();
      addTearDown(database.close);
      final repository = WalkingSessionRepository(database);
      final location = FakeLocationSource();
      final steps = FakeStepSource();
      final coordinator = WalkingTrackingCoordinator(
        repository,
        location,
        stepSource: steps,
      );
      addTearDown(coordinator.dispose);
      final controller = WalkingSessionController(coordinator);
      addTearDown(controller.dispose);

      await controller.start(startedAt: DateTime.utc(2026, 9, 6));
      steps.emit(1);
      steps.emit(2);
      await pumpEventQueue();

      expect(controller.state.steps, 1);
    },
  );
}

class FakeLocationSource implements LocationTrackingSource {
  final _controller = StreamController<LocationObservation>.broadcast();

  @override
  Stream<LocationObservation> get observations => _controller.stream;

  @override
  Future<void> start() async {}

  @override
  Future<void> stop() async {}
}

class FakeStepSource implements StepTrackingSource {
  final _controller = StreamController<int>.broadcast();

  @override
  Stream<int> get steps => _controller.stream;

  @override
  Future<void> start() async {}

  @override
  Future<void> stop() async {}

  void emit(int value) => _controller.add(value);
}
