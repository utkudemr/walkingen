import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:walkingen/l10n/generated/app_localizations.dart';
import 'package:walkingen/walking/walking_session_repository.dart';

class WalkingHistoryDetailPage extends StatefulWidget {
  const WalkingHistoryDetailPage({
    super.key,
    required this.repository,
    required this.sessionId,
  });

  final WalkingSessionRepository repository;
  final String sessionId;

  @override
  State<WalkingHistoryDetailPage> createState() =>
      _WalkingHistoryDetailPageState();
}

class _WalkingHistoryDetailPageState extends State<WalkingHistoryDetailPage> {
  late final Future<WalkingHistoryDetail?> _detailFuture;

  @override
  void initState() {
    super.initState();
    _detailFuture = widget.repository.loadCompletedHistoryDetail(
      widget.sessionId,
    );
  }

  String _formatDate(DateTime date) {
    final local = date.toLocal();
    final day = local.day.toString().padLeft(2, '0');
    final month = local.month.toString().padLeft(2, '0');
    final hour = local.hour.toString().padLeft(2, '0');
    final minute = local.minute.toString().padLeft(2, '0');
    return '$day.$month.${local.year} $hour:$minute';
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.historyDetailTitle)),
      body: FutureBuilder<WalkingHistoryDetail?>(
        future: _detailFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(l10n.historyDetailLoadFailed));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final detail = snapshot.data;
          if (detail == null) {
            return Center(child: Text(l10n.historyDetailUnavailable));
          }
          return _DetailBody(
            detail: detail,
            formatDate: _formatDate,
            formatDuration: _formatDuration,
            routeTitle: l10n.historyRouteTitle,
            routeUnavailable: l10n.historyRouteUnavailable,
            attribution: l10n.historyRouteAttribution,
            durationLabel: l10n.historyDuration,
            distanceLabel: l10n.walkDistance,
          );
        },
      ),
    );
  }
}

class _DetailBody extends StatelessWidget {
  const _DetailBody({
    required this.detail,
    required this.formatDate,
    required this.formatDuration,
    required this.routeTitle,
    required this.routeUnavailable,
    required this.attribution,
    required this.durationLabel,
    required this.distanceLabel,
  });

  final WalkingHistoryDetail detail;
  final String Function(DateTime) formatDate;
  final String Function(Duration) formatDuration;
  final String routeTitle;
  final String routeUnavailable;
  final String attribution;
  final String Function(String) durationLabel;
  final String Function(String) distanceLabel;

  @override
  Widget build(BuildContext context) {
    final points = [
      for (final segment in detail.segments)
        for (final point in segment.points)
          LatLng(point.latitude, point.longitude),
    ];
    final polylines = [
      for (final segment in detail.segments)
        if (segment.points.length >= 2)
          Polyline(
            points: [
              for (final point in segment.points)
                LatLng(point.latitude, point.longitude),
            ],
            color: Theme.of(context).colorScheme.primary,
            strokeWidth: 5,
          ),
    ];

    final hasDistinctCoordinates =
        points.length > 1 &&
        points
            .skip(1)
            .any(
              (point) =>
                  point.latitude != points.first.latitude ||
                  point.longitude != points.first.longitude,
            );
    final mapOptions = !hasDistinctCoordinates
        ? MapOptions(
            initialCenter: points.isEmpty ? const LatLng(0, 0) : points.first,
            initialZoom: points.isEmpty ? 2 : 15,
          )
        : MapOptions(
            initialCameraFit: CameraFit.bounds(
              bounds: LatLngBounds.fromPoints(points),
              padding: const EdgeInsets.all(32),
            ),
          );

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          formatDate(detail.entry.completedAt),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: [
            Chip(
              label: Text(durationLabel(formatDuration(detail.entry.duration))),
            ),
            Chip(
              label: Text(
                distanceLabel(
                  (detail.entry.distanceMeters / 1000).toStringAsFixed(2),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(routeTitle, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        if (points.isEmpty)
          SizedBox(height: 180, child: Center(child: Text(routeUnavailable)))
        else
          SizedBox(
            height: 360,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: FlutterMap(
                options: mapOptions,
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.utkudemir.walkingen',
                  ),
                  if (polylines.isNotEmpty) PolylineLayer(polylines: polylines),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: points.first,
                        width: 40,
                        height: 40,
                        child: const Icon(Icons.trip_origin),
                      ),
                      Marker(
                        point: points.last,
                        width: 40,
                        height: 40,
                        child: const Icon(Icons.flag),
                      ),
                    ],
                  ),
                  RichAttributionWidget(
                    attributions: [TextSourceAttribution(attribution)],
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
