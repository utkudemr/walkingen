import 'dart:async';

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:walkingen/walking/location_observation.dart';
import 'package:walkingen/walking/walking_session.dart';
import 'package:walkingen/walking/walking_tracking.dart';

class GeolocatorLocationSource implements LocationTrackingSource {
  static const _platform = MethodChannel('walkingen/location');
  GeolocatorLocationSource({
    required this.notificationTitle,
    required this.notificationText,
    this.interval = const Duration(seconds: 5),
  });

  final String notificationTitle;
  final String notificationText;
  final Duration interval;
  final StreamController<LocationObservation> _controller =
      StreamController<LocationObservation>.broadcast();
  StreamSubscription<Position>? _subscription;

  @override
  Stream<LocationObservation> get observations => _controller.stream;

  @override
  Future<void> start() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw const LocationServiceDisabledException();
    }
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw PermissionDeniedException('Location permission denied.');
    }

    await _subscription?.cancel();
    _subscription =
        Geolocator.getPositionStream(
          locationSettings: AndroidSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 0,
            intervalDuration: interval,
            foregroundNotificationConfig: ForegroundNotificationConfig(
              notificationTitle: notificationTitle,
              notificationText: notificationText,
              enableWakeLock: true,
              enableWifiLock: true,
              setOngoing: true,
            ),
          ),
        ).listen(
          (position) => _controller.add(
            LocationObservation(
              id: '${position.timestamp.microsecondsSinceEpoch}:$position',
              observedAt: position.timestamp,
              latitude: position.latitude,
              longitude: position.longitude,
              accuracyMeters: position.accuracy,
            ),
          ),
          onError: _controller.addError,
        );
  }

  @override
  Future<void> stop() async {
    await _subscription?.cancel();
    _subscription = null;
    await _platform.invokeMethod<void>('stopForegroundService');
  }
}

class GeolocatorNotificationSink implements WalkingNotificationSink {
  GeolocatorNotificationSink({
    required this.title,
    required this.channelName,
    required this.activeText,
    required this.pausedText,
  });

  static const _platform = MethodChannel('walkingen/location');
  final String title;
  final String channelName;
  final String Function(Duration, double, int) activeText;
  final String Function(Duration, double, int) pausedText;

  @override
  Future<void> update({
    required WalkingSessionState state,
    required Duration elapsed,
    required double distanceMeters,
    required int steps,
  }) {
    final text = (state == WalkingSessionState.paused
        ? pausedText
        : activeText)(elapsed, distanceMeters, steps);
    return _platform.invokeMethod<void>('updateForegroundNotification', {
      'title': title,
      'channelName': channelName,
      'text': text,
    });
  }

  @override
  Future<void> clear() =>
      _platform.invokeMethod<void>('clearForegroundNotification');
}
