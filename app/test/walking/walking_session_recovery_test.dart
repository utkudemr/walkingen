import 'package:flutter_test/flutter_test.dart';
import 'package:walkingen/database/app_database.dart';
import 'package:walkingen/walking/walking_session.dart';
import 'package:walkingen/walking/walking_session_repository.dart';

void main() {
  test('marks service loss interrupted and resumes in a new segment', () async {
    final database = AppDatabase.inMemory();
    addTearDown(database.close);
    final repository = WalkingSessionRepository(database);
    await repository.startSession(
      id: 'session-1',
      startedAt: DateTime.utc(2026, 8, 29, 20),
    );

    final interrupted = await repository.markInterrupted(
      sessionId: 'session-1',
      expectedRevision: 0,
    );
    expect(interrupted.state, WalkingSessionState.interrupted);
    expect(interrupted.revision, 1);
    expect(await repository.loadOpenSession(), isNull);

    final resumed = await repository.resumeInterrupted(
      sessionId: 'session-1',
      expectedRevision: 1,
      confirmed: true,
      resumedAt: DateTime.utc(2026, 8, 29, 21),
    );
    expect(resumed.state, WalkingSessionState.active);
    expect(resumed.revision, 2);
    expect(resumed.segments, hasLength(2));
    expect(resumed.segments.last.id, 'session-1-segment-2');
    expect(resumed.segments.last.startedAt, DateTime.utc(2026, 8, 29, 21));
  });
}
