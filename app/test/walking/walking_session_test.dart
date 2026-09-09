import 'package:flutter_test/flutter_test.dart';
import 'package:walkingen/walking/walking_session.dart';

void main() {
  test('starts a session in active state with a provisional segment', () {
    final session = WalkingSession.start(
      id: 'session-1',
      startedAt: DateTime.utc(2026, 8, 29, 20),
    );

    expect(session.id, 'session-1');
    expect(session.state, WalkingSessionState.active);
    expect(session.inclusion, WalkingInclusion.needsReview);
    expect(session.revision, 0);
    expect(session.segments, hasLength(1));
    expect(session.segments.single.id, 'session-1-segment-1');
    expect(session.segments.single.points, isEmpty);
  });
}
