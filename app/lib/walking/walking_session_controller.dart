import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:walkingen/walking/walking_session.dart';
import 'package:walkingen/walking/walking_tracking.dart';

enum WalkingUiStatus {
  idle,
  starting,
  active,
  paused,
  interrupted,
  finishing,
  completed,
  failure,
}

@immutable
class WalkingUiState {
  const WalkingUiState({
    required this.status,
    required this.distanceMeters,
    required this.elapsed,
    this.steps = 0,
    this.error,
  });

  const WalkingUiState.idle()
    : status = WalkingUiStatus.idle,
      distanceMeters = 0,
      elapsed = Duration.zero,
      steps = 0,
      error = null;

  final WalkingUiStatus status;
  final double distanceMeters;
  final Duration elapsed;
  final int steps;
  final Object? error;

  WalkingUiState copyWith({
    WalkingUiStatus? status,
    double? distanceMeters,
    Duration? elapsed,
    int? steps,
    Object? error = _missing,
  }) {
    return WalkingUiState(
      status: status ?? this.status,
      distanceMeters: distanceMeters ?? this.distanceMeters,
      elapsed: elapsed ?? this.elapsed,
      steps: steps ?? this.steps,
      error: identical(error, _missing) ? this.error : error,
    );
  }

  static const _missing = Object();
}

class WalkingSessionController extends ChangeNotifier {
  WalkingSessionController(this._coordinator) {
    _stateSubscription = _coordinator.stateChanges.listen(
      _handleCoordinatorState,
    );
  }

  final WalkingTrackingCoordinator _coordinator;
  late final StreamSubscription<WalkingSessionState> _stateSubscription;

  bool _disposed = false;
  bool _transitionInFlight = false;
  Future<void>? _initialization;
  Timer? _elapsedTimer;
  DateTime? _sessionStartedAt;
  WalkingUiState _state = const WalkingUiState.idle();
  WalkingUiState get state => _state;

  bool get canStart =>
      _state.status == WalkingUiStatus.idle ||
      _state.status == WalkingUiStatus.completed;

  Future<void> initialize() => _initialization ??= _restore();

  Future<void> _restore() async {
    try {
      final session = await _coordinator.restore();
      if (session == null) return;
      _sessionStartedAt = session.startedAt;
      _startElapsedTimer();
      _setState(_stateForSession(session));
    } catch (error) {
      _setState(_state.copyWith(status: WalkingUiStatus.failure, error: error));
    }
  }

  Future<void> start({required DateTime startedAt}) async {
    await initialize();
    if (!canStart || _transitionInFlight) return;
    _transitionInFlight = true;
    _setState(_state.copyWith(status: WalkingUiStatus.starting, error: null));
    _sessionStartedAt = startedAt;
    _startElapsedTimer();
    try {
      await _coordinator.start(
        sessionId:
            'session-${DateTime.now().microsecondsSinceEpoch}-${Random.secure().nextInt(1 << 32)}',
        startedAt: startedAt,
      );
      _setState(_state.copyWith(status: WalkingUiStatus.active));
    } catch (error) {
      _elapsedTimer?.cancel();
      _sessionStartedAt = null;
      _setState(
        _state.copyWith(
          status: WalkingUiStatus.idle,
          elapsed: Duration.zero,
          error: error,
        ),
      );
    } finally {
      _transitionInFlight = false;
    }
  }

  Future<void> pause() =>
      _run(action: _coordinator.pause, status: WalkingUiStatus.paused);

  Future<void> resume() =>
      _run(action: _coordinator.resume, status: WalkingUiStatus.active);

  Future<void> resumeInterrupted() => _run(
    action: _coordinator.resumeInterrupted,
    status: WalkingUiStatus.active,
  );

  Future<void> finish() async {
    if (!_isOpen || _transitionInFlight) return;
    _transitionInFlight = true;
    _setState(_state.copyWith(status: WalkingUiStatus.finishing));
    try {
      await _coordinator.finish();
      _elapsedTimer?.cancel();
      _setState(_state.copyWith(status: WalkingUiStatus.completed));
    } catch (error) {
      await _recoverAfterTransitionFailure(error);
    } finally {
      _transitionInFlight = false;
    }
  }

  Future<void> _recoverAfterTransitionFailure(Object error) async {
    try {
      final session = await _coordinator.restore();
      if (session != null) {
        _sessionStartedAt = session.startedAt;
        _startElapsedTimer();
        _setState(_stateForSession(session).copyWith(error: error));
        return;
      }
    } catch (_) {}
    _setState(
      _state.copyWith(status: WalkingUiStatus.interrupted, error: error),
    );
  }

  bool get _isOpen =>
      _state.status == WalkingUiStatus.active ||
      _state.status == WalkingUiStatus.paused ||
      _state.status == WalkingUiStatus.interrupted;

  Future<void> _run({
    required Future<void> Function() action,
    required WalkingUiStatus status,
  }) async {
    if (!_isOpen || _transitionInFlight) return;
    _transitionInFlight = true;
    _setState(_state.copyWith(status: WalkingUiStatus.starting));
    try {
      await action();
      _setState(_state.copyWith(status: status));
    } catch (error) {
      await _recoverAfterTransitionFailure(error);
    } finally {
      _transitionInFlight = false;
    }
  }

  void _startElapsedTimer() {
    _elapsedTimer?.cancel();
    _tickElapsed();
    _elapsedTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _tickElapsed(),
    );
  }

  void _tickElapsed() {
    final startedAt = _sessionStartedAt;
    if (startedAt == null) return;
    _setState(
      _state.copyWith(elapsed: DateTime.now().toUtc().difference(startedAt)),
    );
  }

  Duration _elapsedSinceStart() {
    final startedAt = _sessionStartedAt;
    return startedAt == null
        ? Duration.zero
        : DateTime.now().toUtc().difference(startedAt);
  }

  void _handleCoordinatorState(WalkingSessionState status) {
    final uiStatus = switch (status) {
      WalkingSessionState.active => WalkingUiStatus.active,
      WalkingSessionState.paused => WalkingUiStatus.paused,
      WalkingSessionState.interrupted => WalkingUiStatus.interrupted,
      WalkingSessionState.completed => WalkingUiStatus.completed,
    };
    _setState(
      _state.copyWith(
        status: uiStatus,
        distanceMeters: _coordinator.distanceMeters,
        steps: _coordinator.steps,
        elapsed: _elapsedSinceStart(),
        error: null,
      ),
    );
  }

  WalkingUiState _stateForSession(WalkingSession session) {
    final status = switch (session.state) {
      WalkingSessionState.active => WalkingUiStatus.active,
      WalkingSessionState.paused => WalkingUiStatus.paused,
      WalkingSessionState.interrupted => WalkingUiStatus.interrupted,
      WalkingSessionState.completed => WalkingUiStatus.completed,
    };
    return WalkingUiState(
      status: status,
      distanceMeters: _coordinator.distanceMeters,
      steps: _coordinator.steps,
      elapsed: _elapsedSinceStart(),
    );
  }

  void _setState(WalkingUiState state) {
    if (_disposed) return;
    _state = state;
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _elapsedTimer?.cancel();
    unawaited(_stateSubscription.cancel());
    super.dispose();
  }
}
