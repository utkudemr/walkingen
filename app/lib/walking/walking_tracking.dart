import 'dart:async';
import 'dart:math' as math;

import 'package:walkingen/walking/location_observation.dart';
import 'package:walkingen/walking/pedometer_step_source.dart';
import 'package:walkingen/walking/walking_session.dart';
import 'package:walkingen/walking/walking_session_repository.dart';

abstract interface class LocationTrackingSource {
  Stream<LocationObservation> get observations;
  Future<void> start();
  Future<void> stop();
}

abstract interface class WalkingNotificationSink {
  Future<void> update({
    required WalkingSessionState state,
    required Duration elapsed,
    required double distanceMeters,
    required int steps,
  });

  Future<void> clear();
}

class WalkingTrackingCoordinator {
  WalkingTrackingCoordinator(
    this._repository,
    this._source, {
    this._stepSource,
    this._notificationSink,
  });

  final WalkingSessionRepository _repository;
  final LocationTrackingSource _source;
  final StepTrackingSource? _stepSource;
  final WalkingNotificationSink? _notificationSink;
  final StreamController<WalkingSessionState> _stateChanges =
      StreamController<WalkingSessionState>.broadcast();

  Stream<WalkingSessionState> get stateChanges => _stateChanges.stream;
  StreamSubscription<LocationObservation>? _subscription;
  Future<void> _pointWrite = Future<void>.value();
  Future<void> _notificationWrite = Future<void>.value();
  String? _sessionId;
  int _revision = 0;
  bool _acceptObservations = false;
  bool _handlingSourceError = false;
  double _distanceMeters = 0;
  WalkingTrackPoint? _lastAcceptedPoint;
  StreamSubscription<int>? _stepSubscription;
  int? _stepBaseline;
  int _steps = 0;
  Timer? _notificationTimer;
  DateTime? _startedAt;

  int get steps =>
      _stepBaseline == null ? 0 : (_steps - _stepBaseline!).clamp(0, 1 << 30);

  double get distanceMeters {
    final stepDistance = _stepBaseline == null
        ? 0.0
        : (_steps - _stepBaseline!).clamp(0, 1 << 30) * 0.72;
    // Keep the live metric monotonic when GPS becomes reliable. The step
    // estimate is approximate, so it remains a fallback until GPS catches up.
    return math.max(_distanceMeters, stepDistance);
  }

  void _startNotificationUpdates({required WalkingSessionState state}) {
    final sink = _notificationSink;
    final startedAt = _startedAt;
    if (sink == null || startedAt == null) return;
    _notificationTimer?.cancel();
    Future<void> update() async {
      _notificationWrite = _notificationWrite
          .catchError((_) {})
          .then(
            (_) => sink.update(
              state: state,
              elapsed: DateTime.now().toUtc().difference(startedAt),
              distanceMeters: distanceMeters,
              steps: steps,
            ),
          );
      await _notificationWrite;
    }

    unawaited(update());
    _notificationTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => unawaited(update()),
    );
  }

  Future<void> _detachSourceSafely() async {
    _acceptObservations = false;
    final subscription = _subscription;
    _subscription = null;
    try {
      await subscription?.cancel().timeout(
        const Duration(seconds: 1),
        onTimeout: () {},
      );
    } catch (_) {}
  }

  Future<void> _stopSourceSafely() async {
    try {
      await _source.stop();
    } catch (_) {
      // Cleanup must continue even if the platform source is already stopped.
    }
  }

  Future<void> _stopNotificationUpdates() async {
    _notificationTimer?.cancel();
    _notificationTimer = null;
    try {
      await _notificationWrite.catchError((_) {});
    } catch (_) {}
    try {
      await _notificationSink?.clear();
    } catch (_) {}
  }

  Future<void> _startSteps() async {
    final source = _stepSource;
    if (source == null) return;
    await _stepSubscription?.cancel();
    late final StreamSubscription<int> subscription;
    subscription = source.steps.listen(
      (steps) {
        _stepBaseline ??= steps;
        _steps = steps;
        if (!_acceptObservations) return;
        _stateChanges.add(WalkingSessionState.active);
      },
      onError: (Object error, StackTrace stack) {
        unawaited(_handleStepError(subscription));
      },
    );
    _stepSubscription = subscription;
    try {
      await source.start();
    } catch (_) {
      await _handleStepError(subscription);
    }
  }

  Future<void> _handleStepError(
    StreamSubscription<int> failedSubscription,
  ) async {
    if (!identical(_stepSubscription, failedSubscription)) return;
    _stepSubscription = null;
    try {
      await failedSubscription.cancel();
    } catch (_) {}
    try {
      await _stepSource?.stop();
    } catch (_) {}
  }

  Future<void> _stopSteps() async {
    final subscription = _stepSubscription;
    _stepSubscription = null;
    try {
      await subscription?.cancel();
    } catch (_) {}
    try {
      await _stepSource?.stop();
    } catch (_) {}
  }

  double _distanceBetween(WalkingTrackPoint first, WalkingTrackPoint second) {
    const earthRadiusMeters = 6371000.0;
    final latitudeDelta = (second.latitude - first.latitude) * math.pi / 180;
    final longitudeDelta = (second.longitude - first.longitude) * math.pi / 180;
    final firstLatitude = first.latitude * math.pi / 180;
    final secondLatitude = second.latitude * math.pi / 180;
    final haversine =
        math.pow(math.sin(latitudeDelta / 2), 2) +
        math.cos(firstLatitude) *
            math.cos(secondLatitude) *
            math.pow(math.sin(longitudeDelta / 2), 2);
    return earthRadiusMeters *
        2 *
        math.atan2(math.sqrt(haversine), math.sqrt(1 - haversine));
  }

  void _rebuildDistance(WalkingSession session) {
    _distanceMeters = 0;
    _lastAcceptedPoint = null;
    for (final segment in session.segments) {
      WalkingTrackPoint? previous;
      for (final point in segment.points) {
        if (previous != null) {
          _distanceMeters += _distanceBetween(previous, point);
        }
        previous = point;
      }
      _lastAcceptedPoint = previous;
    }
  }

  Future<void> _attachSource({required bool startSource}) async {
    await _subscription?.cancel();
    late final StreamSubscription<LocationObservation> subscription;
    subscription = _source.observations.listen(
      _handleObservation,
      onError: (Object error, StackTrace stack) {
        unawaited(_handleSourceError(failedSubscription: subscription));
      },
    );
    _subscription = subscription;
    if (startSource) await _source.start();
    _acceptObservations = startSource;
  }

  Future<void> _handleSourceError({
    StreamSubscription<LocationObservation>? failedSubscription,
    String? failedSessionId,
  }) async {
    if (failedSubscription != null &&
        !identical(_subscription, failedSubscription)) {
      return;
    }
    if (failedSessionId != null && _sessionId != failedSessionId) return;
    final sessionId = _sessionId;
    if (sessionId == null || _handlingSourceError) return;
    _handlingSourceError = true;
    _acceptObservations = false;
    try {
      await _detachSourceSafely();
      await _stopSteps();
      await _stopNotificationUpdates();
      await _stopSourceSafely();
      await _pointWrite;
      final session = await _repository.loadRecoverableSession();
      if (session != null && session.id == sessionId) {
        final interrupted = await _repository.markInterrupted(
          sessionId: sessionId,
          expectedRevision: _revision,
        );
        _revision = interrupted.revision;
        _stateChanges.add(WalkingSessionState.interrupted);
      }
    } catch (_) {
      await _stopNotificationUpdates();
      await _stopSourceSafely();
      try {
        final session = await _repository.loadRecoverableSession();
        if (session != null && session.id == sessionId) {
          final interrupted = await _repository.markInterrupted(
            sessionId: sessionId,
            expectedRevision: _revision,
          );
          _revision = interrupted.revision;
          _stateChanges.add(WalkingSessionState.interrupted);
        }
      } catch (_) {}
    } finally {
      _handlingSourceError = false;
    }
  }

  Future<WalkingSession?> restore() async {
    final session = await _repository.loadRecoverableSession();
    if (session == null) return null;
    _sessionId = session.id;
    _revision = session.revision;
    _startedAt = session.startedAt;
    _rebuildDistance(session);
    if (session.state == WalkingSessionState.interrupted) {
      _lastAcceptedPoint = null;
      return session;
    }
    try {
      // Pause suspends metric acceptance, not the foreground source/service.
      // Restore keeps that ownership alive while the persisted state stays paused.
      await _attachSource(
        startSource:
            session.state == WalkingSessionState.active ||
            session.state == WalkingSessionState.paused,
      );
      _acceptObservations = session.state == WalkingSessionState.active;
      if (session.state == WalkingSessionState.active) {
        await _startSteps();
      }
      _startNotificationUpdates(state: session.state);
    } catch (_) {
      await _detachSourceSafely();
      await _stopNotificationUpdates();
      await _stopSourceSafely();
      final interrupted = await _repository.markInterrupted(
        sessionId: session.id,
        expectedRevision: _revision,
      );
      _revision = interrupted.revision;
      await _subscription?.cancel().timeout(
        const Duration(seconds: 1),
        onTimeout: () {},
      );
      _subscription = null;
      return interrupted;
    }
    return session;
  }

  Future<void> resumeInterrupted() async {
    final sessionId = _sessionId;
    if (sessionId == null) return;
    final session = await _repository.resumeInterrupted(
      sessionId: sessionId,
      expectedRevision: _revision,
      confirmed: true,
      resumedAt: DateTime.now().toUtc(),
    );
    _revision = session.revision;
    _handlingSourceError = false;
    try {
      await _attachSource(startSource: true);
      _lastAcceptedPoint = null;
      await _startSteps();
      _startNotificationUpdates(state: WalkingSessionState.active);
    } catch (_) {
      await _detachSourceSafely();
      await _stopNotificationUpdates();
      await _stopSourceSafely();
      final interrupted = await _repository.markInterrupted(
        sessionId: sessionId,
        expectedRevision: _revision,
      );
      _revision = interrupted.revision;
      _stateChanges.add(WalkingSessionState.interrupted);
      rethrow;
    }
  }

  Future<void> start({
    required String sessionId,
    required DateTime startedAt,
  }) async {
    await _repository.startSession(id: sessionId, startedAt: startedAt);
    _sessionId = sessionId;
    _revision = 0;
    _startedAt = startedAt;
    _distanceMeters = 0;
    _lastAcceptedPoint = null;
    _stepBaseline = null;
    _steps = 0;
    _handlingSourceError = false;
    await _subscription?.cancel();
    late final StreamSubscription<LocationObservation> subscription;
    subscription = _source.observations.listen(
      _handleObservation,
      onError: (Object error, StackTrace stack) {
        unawaited(_handleSourceError(failedSubscription: subscription));
      },
    );
    _subscription = subscription;
    try {
      await _source.start();
      _acceptObservations = true;
      await _startSteps();
      _startNotificationUpdates(state: WalkingSessionState.active);
    } catch (_) {
      await _detachSourceSafely();
      await _stopSteps();
      await _stopNotificationUpdates();
      await _stopSourceSafely();
      _sessionId = null;
      await _subscription?.cancel();
      _subscription = null;
      await _repository.deleteSession(id: sessionId);
      rethrow;
    }
  }

  void _handleObservation(LocationObservation observation) {
    final sessionId = _sessionId;
    if (sessionId == null || !_acceptObservations) return;
    _pointWrite = _pointWrite
        .catchError((_) {})
        .then((_) async {
          if (_sessionId != sessionId) return;
          final result = await _repository.acceptPoint(
            sessionId: sessionId,
            expectedRevision: _revision,
            observation: observation,
          );
          if (result == WalkingPointAcceptance.accepted) {
            final point = WalkingTrackPoint(
              id: observation.id,
              observedAt: observation.observedAt,
              latitude: observation.latitude,
              longitude: observation.longitude,
              accuracyMeters: observation.accuracyMeters,
            );
            if (_lastAcceptedPoint != null) {
              _distanceMeters += _distanceBetween(_lastAcceptedPoint!, point);
            }
            _lastAcceptedPoint = point;
            _revision++;
            _stateChanges.add(WalkingSessionState.active);
          }
        })
        .catchError((Object error, StackTrace stack) {
          unawaited(_handleSourceError(failedSessionId: sessionId));
        });
  }

  Future<void> pause() async {
    final sessionId = _sessionId;
    if (sessionId == null) return;
    _acceptObservations = false;
    await _stopSteps();
    await _pointWrite;
    final session = await _repository.pauseSession(
      sessionId: sessionId,
      expectedRevision: _revision,
    );
    _revision = session.revision;
    _startNotificationUpdates(state: WalkingSessionState.paused);
  }

  Future<void> resume() async {
    final sessionId = _sessionId;
    if (sessionId == null) return;
    final session = await _repository.resumeSession(
      sessionId: sessionId,
      expectedRevision: _revision,
    );
    _revision = session.revision;
    try {
      await _source.start();
      _acceptObservations = true;
      await _startSteps();
      _startNotificationUpdates(state: WalkingSessionState.active);
    } catch (_) {
      await _detachSourceSafely();
      await _stopSteps();
      await _stopNotificationUpdates();
      await _stopSourceSafely();
      final interrupted = await _repository.markInterrupted(
        sessionId: sessionId,
        expectedRevision: _revision,
      );
      _revision = interrupted.revision;
      _stateChanges.add(WalkingSessionState.interrupted);
      rethrow;
    }
  }

  Future<void> finish() async {
    final sessionId = _sessionId;
    if (sessionId == null) return;
    _acceptObservations = false;
    await _stopSteps();
    await _stopNotificationUpdates();
    await _stopSourceSafely();
    await _pointWrite;
    await _repository.finishSession(
      sessionId: sessionId,
      expectedRevision: _revision,
      confirmed: true,
    );
    _stateChanges.add(WalkingSessionState.completed);
    await dispose();
    _sessionId = null;
  }

  Future<void> dispose() async {
    final subscription = _subscription;
    _subscription = null;
    _acceptObservations = false;
    await _stopSteps();
    await subscription?.cancel().timeout(
      const Duration(seconds: 1),
      onTimeout: () {},
    );
    await _stopNotificationUpdates();
    await _stopSourceSafely();
    await _pointWrite;
    _sessionId = null;
  }
}
