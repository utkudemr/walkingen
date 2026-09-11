import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart' show Value;
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

  test(
    'filters completed history by the requested local calendar day',
    () async {
      final database = AppDatabase.inMemory();
      addTearDown(database.close);
      final repository = WalkingSessionRepository(database);
      final startedAt = DateTime.now().toUtc().subtract(
        const Duration(days: 2),
      );

      await repository.startSession(id: 'session-old', startedAt: startedAt);
      await repository.finishSession(
        sessionId: 'session-old',
        expectedRevision: 0,
        confirmed: true,
      );
      final now = DateTime.now();
      final oldCompletedAt = DateTime(
        now.year,
        now.month,
        now.day - 2,
        12,
      ).toUtc();
      await (database.update(database.walkingSessionRows)
            ..where((row) => row.id.equals('session-old')))
          .write(WalkingSessionRowsCompanion(updatedAt: Value(oldCompletedAt)));
      await repository.startSession(
        id: 'session-target',
        startedAt: DateTime.now().toUtc().subtract(const Duration(days: 1)),
      );
      await repository.finishSession(
        sessionId: 'session-target',
        expectedRevision: 0,
        confirmed: true,
      );
      final targetCompletedAt = DateTime(
        now.year,
        now.month,
        now.day - 1,
        12,
      ).toUtc();
      await (database.update(
        database.walkingSessionRows,
      )..where((row) => row.id.equals('session-target'))).write(
        WalkingSessionRowsCompanion(updatedAt: Value(targetCompletedAt)),
      );

      final targetDay = DateTime(now.year, now.month, now.day - 1);
      final history = await repository.loadCompletedHistory(day: targetDay);

      expect(history.map((entry) => entry.id), ['session-target']);
    },
  );

  test(
    'loads completed history detail with ordered disconnected segments',
    () async {
      final database = AppDatabase.inMemory();
      addTearDown(database.close);
      final repository = WalkingSessionRepository(database);
      final startedAt = DateTime.utc(2026, 8, 29, 20);

      await repository.startSession(id: 'session-detail', startedAt: startedAt);
      await repository.acceptPoint(
        sessionId: 'session-detail',
        expectedRevision: 0,
        observation: LocationObservation(
          id: 'point-1',
          observedAt: startedAt.add(const Duration(minutes: 1)),
          latitude: 41,
          longitude: 29,
          accuracyMeters: 5,
        ),
      );
      await repository.markInterrupted(
        sessionId: 'session-detail',
        expectedRevision: 1,
      );
      await repository.resumeInterrupted(
        sessionId: 'session-detail',
        expectedRevision: 2,
        confirmed: true,
        resumedAt: startedAt.add(const Duration(hours: 1)),
      );
      await repository.acceptPoint(
        sessionId: 'session-detail',
        expectedRevision: 3,
        observation: LocationObservation(
          id: 'point-2',
          observedAt: startedAt.add(const Duration(hours: 1, minutes: 1)),
          latitude: 42,
          longitude: 30,
          accuracyMeters: 5,
        ),
      );
      await repository.finishSession(
        sessionId: 'session-detail',
        expectedRevision: 4,
        confirmed: true,
      );

      final detail = await repository.loadCompletedHistoryDetail(
        'session-detail',
      );

      expect(detail, isNotNull);
      final loaded = detail!;
      expect(loaded.entry.id, 'session-detail');
      expect(loaded.segments, hasLength(2));
      expect(loaded.segments[0].points.map((point) => point.id), ['point-1']);
      expect(loaded.segments[1].points.map((point) => point.id), ['point-2']);
    },
  );

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
