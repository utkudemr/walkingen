import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:walkingen/database/app_database.dart';
import 'package:walkingen/walking/location_observation.dart';
import 'package:walkingen/walking/walking_session.dart';
import 'package:walkingen/walking/pedometer_step_source.dart';
import 'package:walkingen/walking/walking_session_repository.dart';
import 'package:walkingen/walking/walking_tracking.dart';

void main() {
  test('restarts steps and notification after interrupted resume', () async {
    final database = AppDatabase.inMemory();
    addTearDown(database.close);
    final repository = WalkingSessionRepository(database);
    await repository.startSession(
      id: 'session-interrupted',
      startedAt: DateTime.utc(2026, 8, 29, 20),
    );
    await repository.markInterrupted(
      sessionId: 'session-interrupted',
      expectedRevision: 0,
    );
    final source = FakeLocationTrackingSource();
    final steps = FakeStepSource();
    final notification = FakeNotificationSink();
    final coordinator = WalkingTrackingCoordinator(
      repository,
      source,
      stepSource: steps,
      notificationSink: notification,
    );
    addTearDown(coordinator.dispose);

    await coordinator.restore();
    await coordinator.resumeInterrupted();
    await pumpEventQueue();

    expect(steps.startCount, 1);
    expect(notification.updateCount, 1);
  });

  test('keeps GPS tracking when the optional step source fails', () async {
    final database = AppDatabase.inMemory();
    addTearDown(database.close);
    final repository = WalkingSessionRepository(database);
    final source = FakeLocationTrackingSource();
    final steps = FakeStepSource();
    final coordinator = WalkingTrackingCoordinator(
      repository,
      source,
      stepSource: steps,
    );
    addTearDown(coordinator.dispose);

    final startedAt = DateTime.utc(2026, 8, 29, 20);
    await coordinator.start(
      sessionId: 'session-gps-only',
      startedAt: startedAt,
    );
    steps.emitError(StateError('step sensor unavailable'));
    await pumpEventQueue();
    source.emit(
      LocationObservation(
        id: 'gps-after-step-error',
        observedAt: startedAt.add(const Duration(seconds: 5)),
        latitude: 41,
        longitude: 29,
        accuracyMeters: 5,
      ),
    );
    await pumpEventQueue();

    final session = await repository.loadOpenSession();
    expect(session?.state, WalkingSessionState.active);
    expect(session?.segments.single.points.single.id, 'gps-after-step-error');
    expect(source.stopCount, 0);
  });
  test('keeps GPS tracking when the step source cannot start', () async {
    final database = AppDatabase.inMemory();
    addTearDown(database.close);
    final repository = WalkingSessionRepository(database);
    final source = FakeLocationTrackingSource();
    final steps = FakeStepSource(startError: StateError('sensor unavailable'));
    final coordinator = WalkingTrackingCoordinator(
      repository,
      source,
      stepSource: steps,
    );
    addTearDown(coordinator.dispose);

    final startedAt = DateTime.utc(2026, 8, 29, 20);
    await coordinator.start(
      sessionId: 'session-gps-only-start',
      startedAt: startedAt,
    );
    source.emit(
      LocationObservation(
        id: 'gps-after-step-start-error',
        observedAt: startedAt.add(const Duration(seconds: 5)),
        latitude: 41,
        longitude: 29,
        accuracyMeters: 5,
      ),
    );
    await pumpEventQueue();

    final session = await repository.loadOpenSession();
    expect(session?.state, WalkingSessionState.active);
    expect(
      session?.segments.single.points.single.id,
      'gps-after-step-start-error',
    );
  });
  test('updates the notification when a session starts', () async {
    final database = AppDatabase.inMemory();
    addTearDown(database.close);
    final repository = WalkingSessionRepository(database);
    final source = FakeLocationTrackingSource();
    final notification = FakeNotificationSink();
    final coordinator = WalkingTrackingCoordinator(
      repository,
      source,
      notificationSink: notification,
    );
    addTearDown(coordinator.dispose);

    await coordinator.start(
      sessionId: 'session-notification',
      startedAt: DateTime.now().toUtc(),
    );
    await pumpEventQueue();

    expect(notification.updateCount, 1);
  });

  test(
    'starts source and persists streamed points through the coordinator',
    () async {
      final database = AppDatabase.inMemory();
      addTearDown(database.close);
      final repository = WalkingSessionRepository(database);
      final source = FakeLocationTrackingSource();
      final coordinator = WalkingTrackingCoordinator(repository, source);
      final startedAt = DateTime.utc(2026, 8, 29, 20);

      addTearDown(coordinator.dispose);
      await coordinator.start(sessionId: 'session-1', startedAt: startedAt);
      source.emit(
        LocationObservation(
          id: 'point-1',
          observedAt: startedAt.add(const Duration(seconds: 5)),
          latitude: 41,
          longitude: 29,
          accuracyMeters: 5,
        ),
      );
      await pumpEventQueue();

      final session = await repository.loadOpenSession();
      expect(source.startCount, 1);
      expect(session?.revision, 1);
      expect(session?.segments.single.points.single.id, 'point-1');
    },
  );
}

class FakeLocationTrackingSource implements LocationTrackingSource {
  final _controller = StreamController<LocationObservation>.broadcast();
  int startCount = 0;
  int stopCount = 0;
  @override
  Stream<LocationObservation> get observations => _controller.stream;

  @override
  Future<void> start() async => startCount++;

  @override
  Future<void> stop() async => stopCount++;

  void emit(LocationObservation observation) => _controller.add(observation);
}

class FakeStepSource implements StepTrackingSource {
  FakeStepSource({this.startError});

  final Object? startError;
  final _controller = StreamController<int>.broadcast();
  int startCount = 0;

  @override
  Stream<int> get steps => _controller.stream;

  void emitError(Object error) => _controller.addError(error);

  @override
  Future<void> start() async {
    startCount++;
    final error = startError;
    if (error != null) throw error;
  }

  @override
  Future<void> stop() async {}
}

class FakeNotificationSink implements WalkingNotificationSink {
  int updateCount = 0;
  int clearCount = 0;

  @override
  Future<void> update({
    required WalkingSessionState state,
    required Duration elapsed,
    required double distanceMeters,
    required int steps,
  }) async {
    updateCount++;
  }

  @override
  Future<void> clear() async => clearCount++;
}
