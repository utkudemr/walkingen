import 'dart:math' as math;

import 'package:drift/drift.dart';
import 'package:walkingen/database/app_database.dart';
import 'package:walkingen/walking/location_observation.dart';
import 'package:walkingen/walking/walking_session.dart';

class WalkingHistoryEntry {
  const WalkingHistoryEntry({
    required this.id,
    required this.startedAt,
    required this.completedAt,
    required this.duration,
    required this.distanceMeters,
    required this.state,
  });

  final String id;
  final DateTime startedAt;
  final DateTime completedAt;
  final Duration duration;
  final double distanceMeters;
  final WalkingSessionState state;
}

class WalkingHistoryDetail {
  const WalkingHistoryDetail({required this.entry, required this.segments});

  final WalkingHistoryEntry entry;
  final List<WalkingSegment> segments;
}

class OpenWalkingSessionException implements Exception {
  const OpenWalkingSessionException();
}

class FinishConfirmationRequiredException implements Exception {
  const FinishConfirmationRequiredException();
}

class ResumeConfirmationRequiredException implements Exception {
  const ResumeConfirmationRequiredException();
}

class WalkingSessionRepository {
  const WalkingSessionRepository(this._database);

  final AppDatabase _database;

  Future<WalkingSession> startSession({
    required String id,
    required DateTime startedAt,
  }) async {
    return _database.transaction(() async {
      final open =
          await (_database.select(_database.walkingSessionRows)
                ..where(
                  (row) => row.state.isIn([
                    WalkingSessionState.active.name,
                    WalkingSessionState.paused.name,
                  ]),
                )
                ..limit(1))
              .getSingleOrNull();
      if (open != null) throw const OpenWalkingSessionException();

      final segmentId = '$id-segment-1';
      await _database
          .into(_database.walkingSessionRows)
          .insert(
            WalkingSessionRowsCompanion.insert(
              id: id,
              startedAt: startedAt,
              state: WalkingSessionState.active.name,
              inclusion: WalkingInclusion.needsReview.name,
              revision: 0,
              currentSegmentId: Value(segmentId),
            ),
          );
      await _database
          .into(_database.walkingSegmentRows)
          .insert(
            WalkingSegmentRowsCompanion.insert(
              id: segmentId,
              sessionId: id,
              startedAt: startedAt,
            ),
          );
      return WalkingSession.start(id: id, startedAt: startedAt);
    });
  }

  Future<WalkingSession?> loadRecoverableSession() async {
    final rows =
        await (_database.select(_database.walkingSessionRows)..where(
              (table) => table.state.isIn([
                WalkingSessionState.active.name,
                WalkingSessionState.paused.name,
                WalkingSessionState.interrupted.name,
              ]),
            ))
            .get();
    rows.sort((a, b) {
      int statePriority(String state) =>
          state == WalkingSessionState.active.name ||
              state == WalkingSessionState.paused.name
          ? 0
          : 1;
      final priority = statePriority(a.state).compareTo(statePriority(b.state));
      if (priority != 0) return priority;
      final updated = b.updatedAt.compareTo(a.updatedAt);
      if (updated != 0) return updated;
      final started = b.startedAt.compareTo(a.startedAt);
      if (started != 0) return started;
      return a.id.compareTo(b.id);
    });
    final row = rows.isEmpty ? null : rows.first;
    if (row == null) return null;
    return _loadSession(row);
  }

  Future<List<WalkingHistoryEntry>> loadCompletedHistory({
    DateTime? day,
  }) async {
    final query = _database.select(
      _database.walkingSessionRows,
    )..where((table) => table.state.equals(WalkingSessionState.completed.name));
    if (day != null) {
      final localStart = DateTime(day.year, day.month, day.day);
      final localEnd = DateTime(day.year, day.month, day.day + 1);
      final startUtc = localStart.toUtc();
      final endUtc = localEnd.toUtc();
      query.where(
        (table) =>
            table.updatedAt.isBiggerOrEqualValue(startUtc) &
            table.updatedAt.isSmallerThanValue(endUtc),
      );
    }
    final rows =
        await (query..orderBy([(table) => OrderingTerm.desc(table.updatedAt)]))
            .get();
    final entries = <WalkingHistoryEntry>[];
    for (final row in rows) {
      final session = await _loadSession(row);
      final completedAt = row.updatedAt.toUtc();
      final duration = completedAt.difference(session.startedAt);
      entries.add(
        WalkingHistoryEntry(
          id: session.id,
          startedAt: session.startedAt,
          completedAt: completedAt,
          duration: duration.isNegative ? Duration.zero : duration,
          distanceMeters: _sessionDistance(session),
          state: session.state,
        ),
      );
    }
    return List.unmodifiable(entries);
  }

  Future<WalkingHistoryDetail?> loadCompletedHistoryDetail(String id) async {
    final row =
        await (_database.select(_database.walkingSessionRows)..where(
              (table) =>
                  table.id.equals(id) &
                  table.state.equals(WalkingSessionState.completed.name),
            ))
            .getSingleOrNull();
    if (row == null) return null;
    final session = await _loadSession(row);
    final completedAt = row.updatedAt.toUtc();
    final duration = completedAt.difference(session.startedAt);
    final entry = WalkingHistoryEntry(
      id: session.id,
      startedAt: session.startedAt,
      completedAt: completedAt,
      duration: duration.isNegative ? Duration.zero : duration,
      distanceMeters: _sessionDistance(session),
      state: session.state,
    );
    return WalkingHistoryDetail(entry: entry, segments: session.segments);
  }

  double _sessionDistance(WalkingSession session) {
    const earthRadiusMeters = 6371000.0;
    double distance = 0;
    for (final segment in session.segments) {
      for (var index = 1; index < segment.points.length; index++) {
        final first = segment.points[index - 1];
        final second = segment.points[index];
        final latitudeDelta =
            (second.latitude - first.latitude) * math.pi / 180;
        final longitudeDelta =
            (second.longitude - first.longitude) * math.pi / 180;
        final firstLatitude = first.latitude * math.pi / 180;
        final secondLatitude = second.latitude * math.pi / 180;
        final haversine =
            math.pow(math.sin(latitudeDelta / 2), 2) +
            math.cos(firstLatitude) *
                math.cos(secondLatitude) *
                math.pow(math.sin(longitudeDelta / 2), 2);
        distance +=
            earthRadiusMeters *
            2 *
            math.atan2(math.sqrt(haversine), math.sqrt(1 - haversine));
      }
    }
    return distance;
  }

  Future<WalkingSession?> loadOpenSession() async {
    final row =
        await (_database.select(_database.walkingSessionRows)
              ..where(
                (table) => table.state.isIn([
                  WalkingSessionState.active.name,
                  WalkingSessionState.paused.name,
                ]),
              )
              ..limit(1))
            .getSingleOrNull();
    if (row == null) return null;
    return _loadSession(row);
  }

  Future<WalkingSession> _loadSession(WalkingSessionRow row) async {
    final segmentRows =
        await (_database.select(_database.walkingSegmentRows)
              ..where((table) => table.sessionId.equals(row.id))
              ..orderBy([(table) => OrderingTerm.asc(table.startedAt)]))
            .get();
    final pointRows =
        await (_database.select(_database.walkingPointRows)
              ..where((table) => table.sessionId.equals(row.id))
              ..orderBy([(table) => OrderingTerm.asc(table.observedAt)]))
            .get();
    final pointsBySegment = <String, List<WalkingTrackPoint>>{};
    for (final point in pointRows) {
      pointsBySegment
          .putIfAbsent(point.segmentId, () => [])
          .add(
            WalkingTrackPoint(
              id: point.id,
              observedAt: point.observedAt.toUtc(),
              latitude: point.latitude,
              longitude: point.longitude,
              accuracyMeters: point.accuracyMeters,
            ),
          );
    }
    return WalkingSession.fromPersistence(
      id: row.id,
      startedAt: row.startedAt.toUtc(),
      state: WalkingSessionState.values.byName(row.state),
      inclusion: WalkingInclusion.values.byName(row.inclusion),
      revision: row.revision,
      segments: [
        for (final segment in segmentRows)
          WalkingSegment(
            id: segment.id,
            startedAt: segment.startedAt.toUtc(),
            points: List.unmodifiable(pointsBySegment[segment.id] ?? const []),
          ),
      ],
    );
  }

  Future<void> deleteSession({required String id}) async {
    await _database.transaction(() async {
      await (_database.delete(
        _database.walkingPointRows,
      )..where((table) => table.sessionId.equals(id))).go();
      await (_database.delete(
        _database.walkingSegmentRows,
      )..where((table) => table.sessionId.equals(id))).go();
      await (_database.delete(
        _database.walkingSessionRows,
      )..where((table) => table.id.equals(id))).go();
    });
  }

  Future<WalkingPointAcceptance> acceptPoint({
    required String sessionId,
    required int expectedRevision,
    required LocationObservation observation,
  }) async {
    return _database.transaction(() async {
      final session = await (_database.select(
        _database.walkingSessionRows,
      )..where((table) => table.id.equals(sessionId))).getSingleOrNull();
      if (session == null) {
        throw StateError('Walking session was not found.');
      }
      if (session.revision != expectedRevision) {
        throw StateError('Walking session revision is stale.');
      }
      if (session.state == WalkingSessionState.paused.name) {
        return WalkingPointAcceptance.rejected;
      }
      if (session.state != WalkingSessionState.active.name) {
        throw StateError('Walking session is not active.');
      }
      if (!observation.latitude.isFinite ||
          !observation.longitude.isFinite ||
          observation.latitude < -90 ||
          observation.latitude > 90 ||
          observation.longitude < -180 ||
          observation.longitude > 180 ||
          !observation.accuracyMeters.isFinite ||
          observation.accuracyMeters < 0) {
        return WalkingPointAcceptance.rejected;
      }
      final existing =
          await (_database.select(_database.walkingPointRows)..where(
                (table) =>
                    table.sessionId.equals(sessionId) &
                    (table.id.equals(observation.id) |
                        (table.observedAt.equals(observation.observedAt) &
                            table.latitude.equals(observation.latitude) &
                            table.longitude.equals(observation.longitude) &
                            table.accuracyMeters.equals(
                              observation.accuracyMeters,
                            ))),
              ))
              .getSingleOrNull();
      if (existing != null) return WalkingPointAcceptance.duplicate;
      final segmentPoints =
          await (_database.select(_database.walkingPointRows)
                ..where(
                  (table) =>
                      table.sessionId.equals(sessionId) &
                      table.segmentId.equals(session.currentSegmentId),
                )
                ..orderBy([(table) => OrderingTerm.desc(table.observedAt)])
                ..limit(1))
              .getSingleOrNull();
      if (segmentPoints != null &&
          observation.observedAt.isBefore(segmentPoints.observedAt)) {
        return WalkingPointAcceptance.rejected;
      }
      await _database
          .into(_database.walkingPointRows)
          .insert(
            WalkingPointRowsCompanion.insert(
              id: observation.id,
              sessionId: sessionId,
              segmentId: session.currentSegmentId,
              observedAt: observation.observedAt,
              latitude: observation.latitude,
              longitude: observation.longitude,
              accuracyMeters: observation.accuracyMeters,
            ),
          );
      await (_database.update(
        _database.walkingSessionRows,
      )..where((table) => table.id.equals(sessionId))).write(
        WalkingSessionRowsCompanion(
          revision: Value(expectedRevision + 1),
          lastPointId: Value(observation.id),
          lastObservedAt: Value(observation.observedAt),
          lastLatitude: Value(observation.latitude),
          lastLongitude: Value(observation.longitude),
          lastAccuracyMeters: Value(observation.accuracyMeters),
          updatedAt: Value(DateTime.now().toUtc()),
        ),
      );
      return WalkingPointAcceptance.accepted;
    });
  }

  Future<WalkingSession> pauseSession({
    required String sessionId,
    required int expectedRevision,
  }) async {
    final row = await (_database.select(
      _database.walkingSessionRows,
    )..where((table) => table.id.equals(sessionId))).getSingle();
    if (row.state == WalkingSessionState.paused.name &&
        row.revision == expectedRevision) {
      return _loadSession(row);
    }
    return _changeState(
      sessionId: sessionId,
      expectedRevision: expectedRevision,
      from: WalkingSessionState.active,
      to: WalkingSessionState.paused,
    );
  }

  Future<WalkingSession> resumeSession({
    required String sessionId,
    required int expectedRevision,
  }) => _changeState(
    sessionId: sessionId,
    expectedRevision: expectedRevision,
    from: WalkingSessionState.paused,
    to: WalkingSessionState.active,
  );

  Future<WalkingSession> finishSession({
    required String sessionId,
    required int expectedRevision,
    required bool confirmed,
  }) async {
    if (!confirmed) throw const FinishConfirmationRequiredException();
    return _database.transaction(() async {
      final row = await (_database.select(
        _database.walkingSessionRows,
      )..where((table) => table.id.equals(sessionId))).getSingle();
      if (row.revision != expectedRevision) {
        throw StateError('Walking session revision is stale.');
      }
      if (row.state != WalkingSessionState.active.name &&
          row.state != WalkingSessionState.paused.name &&
          row.state != WalkingSessionState.interrupted.name) {
        throw StateError('Walking session is not open.');
      }
      await (_database.update(
        _database.walkingSegmentRows,
      )..where((table) => table.id.equals(row.currentSegmentId))).write(
        WalkingSegmentRowsCompanion(endedAt: Value(DateTime.now().toUtc())),
      );
      await (_database.update(
        _database.walkingSessionRows,
      )..where((table) => table.id.equals(sessionId))).write(
        WalkingSessionRowsCompanion(
          state: const Value('completed'),
          revision: Value(expectedRevision + 1),
          updatedAt: Value(DateTime.now().toUtc()),
        ),
      );
      return _loadSession(
        (await (_database.select(
          _database.walkingSessionRows,
        )..where((table) => table.id.equals(sessionId))).getSingle()),
      );
    });
  }

  Future<WalkingSession> markInterrupted({
    required String sessionId,
    required int expectedRevision,
  }) => _changeState(
    sessionId: sessionId,
    expectedRevision: expectedRevision,
    from: null,
    to: WalkingSessionState.interrupted,
  );

  Future<WalkingSession> resumeInterrupted({
    required String sessionId,
    required int expectedRevision,
    required bool confirmed,
    required DateTime resumedAt,
  }) async {
    if (!confirmed) throw const ResumeConfirmationRequiredException();
    return _database.transaction(() async {
      final row = await (_database.select(
        _database.walkingSessionRows,
      )..where((table) => table.id.equals(sessionId))).getSingle();
      if (row.state != WalkingSessionState.interrupted.name) {
        throw StateError('Walking session is not interrupted.');
      }
      if (row.revision != expectedRevision) {
        throw StateError('Walking session revision is stale.');
      }
      final segmentId = '$sessionId-segment-${row.revision + 1}';
      await _database
          .into(_database.walkingSegmentRows)
          .insert(
            WalkingSegmentRowsCompanion.insert(
              id: segmentId,
              sessionId: sessionId,
              startedAt: resumedAt,
            ),
          );
      await (_database.update(
        _database.walkingSessionRows,
      )..where((table) => table.id.equals(sessionId))).write(
        WalkingSessionRowsCompanion(
          state: const Value('active'),
          revision: Value(expectedRevision + 1),
          currentSegmentId: Value(segmentId),
          updatedAt: Value(DateTime.now().toUtc()),
        ),
      );
      return _loadSession(
        (await (_database.select(
          _database.walkingSessionRows,
        )..where((table) => table.id.equals(sessionId))).getSingle()),
      );
    });
  }

  Future<WalkingSession> _changeState({
    required String sessionId,
    required int expectedRevision,
    required WalkingSessionState? from,
    required WalkingSessionState to,
  }) async {
    return _database.transaction(() async {
      final row = await (_database.select(
        _database.walkingSessionRows,
      )..where((table) => table.id.equals(sessionId))).getSingle();
      if ((from != null && row.state != from.name) ||
          (from == null &&
              row.state != WalkingSessionState.active.name &&
              row.state != WalkingSessionState.paused.name)) {
        throw StateError('Walking session is not in the expected state.');
      }
      if (row.revision != expectedRevision) {
        throw StateError('Walking session revision is stale.');
      }
      if (to == WalkingSessionState.interrupted) {
        await (_database.update(
          _database.walkingSegmentRows,
        )..where((table) => table.id.equals(row.currentSegmentId))).write(
          WalkingSegmentRowsCompanion(endedAt: Value(DateTime.now().toUtc())),
        );
      }
      await (_database.update(
        _database.walkingSessionRows,
      )..where((table) => table.id.equals(sessionId))).write(
        WalkingSessionRowsCompanion(
          state: Value(to.name),
          revision: Value(expectedRevision + 1),
          recoveryBoundaryPointId: to == WalkingSessionState.interrupted
              ? Value(row.lastPointId)
              : const Value.absent(),
          updatedAt: Value(DateTime.now().toUtc()),
        ),
      );
      return _loadSession(
        (await (_database.select(
          _database.walkingSessionRows,
        )..where((table) => table.id.equals(sessionId))).getSingle()),
      );
    });
  }
}

enum WalkingPointAcceptance { accepted, duplicate, rejected }
