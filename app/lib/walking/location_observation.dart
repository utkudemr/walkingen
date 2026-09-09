class LocationObservation {
  const LocationObservation({
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
