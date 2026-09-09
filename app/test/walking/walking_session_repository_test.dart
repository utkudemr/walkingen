import 'package:flutter_test/flutter_test.dart';
import 'package:walkingen/database/app_database.dart';
import 'package:walkingen/walking/location_observation.dart';
import 'package:walkingen/walking/walking_session.dart';
import 'package:walkingen/walking/walking_session_repository.dart';

void main() {
  test('starts and reloads one active walking session', () async {
    final database = AppDatabase.inMemory();
    addTearDown(database.close);
    final repository = WalkingSessionRepository(database);
    final startedAt = DateTime.utc(2026, 8, 29, 20);

    final created = await repository.startSession(
      id: 'session-1',
      startedAt: startedAt,
    );
    final reloaded = await repository.loadOpenSession();

    expect(created.id, 'session-1');
    expect(reloaded?.id, 'session-1');
    expect(reloaded?.state, WalkingSessionState.active);
    expect(reloaded?.startedAt, startedAt);
    expect(reloaded?.revision, 0);
    expect(reloaded?.segments.single.id, 'session-1-segment-1');
  });

  test('lists completed walks with duration and distance', () async {
    final database = AppDatabase.inMemory();
    addTearDown(database.close);
    final repository = WalkingSessionRepository(database);
    final startedAt = DateTime.utc(2026, 8, 29, 20);

    await repository.startSession(id: 'session-1', startedAt: startedAt);
    await repository.acceptPoint(
      sessionId: 'session-1',
      expectedRevision: 0,
      observation: LocationObservation(
        id: 'point-1',
        observedAt: startedAt.add(const Duration(minutes: 1)),
        latitude: 41,
        longitude: 29,
        accuracyMeters: 5,
      ),
    );
    await repository.finishSession(
      sessionId: 'session-1',
      expectedRevision: 1,
      confirmed: true,
    );

    final history = await repository.loadCompletedHistory();

    expect(history, hasLength(1));
    expect(history.single.id, 'session-1');
    expect(history.single.duration, isA<Duration>());
    expect(history.single.distanceMeters, 0);
    expect(history.single.completedAt.isAfter(startedAt), isTrue);
  });
  test('rejects a second open walking session', () async {
    final database = AppDatabase.inMemory();
    addTearDown(database.close);
    final repository = WalkingSessionRepository(database);

    await repository.startSession(
      id: 'session-1',
      startedAt: DateTime.utc(2026, 8, 29, 20),
    );

    expect(
      () => repository.startSession(
        id: 'session-2',
        startedAt: DateTime.utc(2026, 8, 29, 21),
      ),
      throwsA(isA<OpenWalkingSessionException>()),
    );
  });
}
