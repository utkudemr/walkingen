import 'package:flutter_test/flutter_test.dart';
import 'package:walkingen/database/app_database.dart';
import 'package:walkingen/walking/location_observation.dart';
import 'package:walkingen/walking/walking_session_repository.dart';

void main() {
  test('accepts a point and reloads it with an advanced checkpoint', () async {
    final database = AppDatabase.inMemory();
    addTearDown(database.close);
    final repository = WalkingSessionRepository(database);
    final startedAt = DateTime.utc(2026, 8, 29, 20);
    await repository.startSession(id: 'session-1', startedAt: startedAt);

    final result = await repository.acceptPoint(
      sessionId: 'session-1',
      expectedRevision: 0,
      observation: LocationObservation(
        id: 'provider-point-1',
        observedAt: startedAt.add(const Duration(seconds: 5)),
        latitude: 41.015,
        longitude: 28.979,
        accuracyMeters: 8,
      ),
    );
    final reloaded = await repository.loadOpenSession();

    expect(result, WalkingPointAcceptance.accepted);
    expect(reloaded?.revision, 1);
    expect(reloaded?.segments.single.points, hasLength(1));
    expect(reloaded?.segments.single.points.single.id, 'provider-point-1');
    expect(reloaded?.segments.single.points.single.latitude, 41.015);
  });
}
