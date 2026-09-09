enum WalkingSessionState { active, paused, completed, interrupted }

enum WalkingInclusion { valid, excluded, needsReview }

class WalkingSession {
  WalkingSession._({
    required this.id,
    required this.startedAt,
    required this.state,
    required this.inclusion,
    required this.revision,
    required this.segments,
  });

  factory WalkingSession.fromPersistence({
    required String id,
    required DateTime startedAt,
    required WalkingSessionState state,
    required WalkingInclusion inclusion,
    required int revision,
    required List<WalkingSegment> segments,
  }) {
    return WalkingSession._(
      id: id,
      startedAt: startedAt,
      state: state,
      inclusion: inclusion,
      revision: revision,
      segments: List.unmodifiable(segments),
    );
  }

  factory WalkingSession.start({
    required String id,
    required DateTime startedAt,
  }) {
    return WalkingSession._(
      id: id,
      startedAt: startedAt,
      state: WalkingSessionState.active,
      inclusion: WalkingInclusion.needsReview,
      revision: 0,
      segments: [
        WalkingSegment(
          id: '$id-segment-1',
          startedAt: startedAt,
          points: const [],
        ),
      ],
    );
  }

  final String id;
  final DateTime startedAt;
  final WalkingSessionState state;
  final WalkingInclusion inclusion;
  final int revision;
  final List<WalkingSegment> segments;
}

class WalkingSegment {
  const WalkingSegment({
    required this.id,
    required this.startedAt,
    required this.points,
  });

  final String id;
  final DateTime startedAt;
  final List<WalkingTrackPoint> points;
}

class WalkingTrackPoint {
  const WalkingTrackPoint({
    required this.id,
    required this.observedAt,
    required this.latitude,
    required this.longitude,
    required this.accuracyMeters,
  });

  final String id;
  final DateTime observedAt;
  final double latitude;
  final double longitude;
  final double accuracyMeters;
}
