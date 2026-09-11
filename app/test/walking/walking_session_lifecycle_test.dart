import 'package:flutter_test/flutter_test.dart';
import 'package:walkingen/database/app_database.dart';
import 'package:walkingen/walking/location_observation.dart';
import 'package:walkingen/walking/walking_session.dart';
import 'package:walkingen/walking/walking_session_repository.dart';

void main() {
  test(
    'pauses, resumes, and finishes a session with explicit confirmation',
    () async {
      final database = AppDatabase.inMemory();
      addTearDown(database.close);
      final repository = WalkingSessionRepository(database);
      await repository.startSession(
        id: 'session-1',
        startedAt: DateTime.utc(2026, 8, 29, 20),
      );

      final paused = await repository.pauseSession(
        sessionId: 'session-1',
        expectedRevision: 0,
      );
      expect(paused.state, WalkingSessionState.paused);
      expect(paused.revision, 1);

      final pausedPoint = await repository.acceptPoint(
        sessionId: 'session-1',
        expectedRevision: 1,
        observation: LocationObservation(
          id: 'paused-point',
          observedAt: DateTime.utc(2026, 8, 29, 20, 1),
          latitude: 41,
          longitude: 29,
          accuracyMeters: 5,
        ),
      );
      expect(pausedPoint, WalkingPointAcceptance.rejected);

      final resumed = await repository.resumeSession(
        sessionId: 'session-1',
        expectedRevision: 1,
      );
      expect(resumed.state, WalkingSessionState.active);
      expect(resumed.revision, 2);

      expect(
        () => repository.finishSession(
          sessionId: 'session-1',
          expectedRevision: 2,
          confirmed: false,
        ),
        throwsA(isA<FinishConfirmationRequiredException>()),
      );

      final completed = await repository.finishSession(
        sessionId: 'session-1',
        expectedRevision: 2,
        confirmed: true,
      );
      expect(completed.state, WalkingSessionState.completed);
      expect(await repository.loadOpenSession(), isNull);
    },
  );
}
