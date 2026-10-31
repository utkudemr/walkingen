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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final dark = Theme.of(context).brightness == Brightness.dark;
    final background = dark ? const Color(0xFF1D282B) : const Color(0xFFE6EBE6);
    final cardColor = dark ? const Color(0xFF283538) : const Color(0xFFF2F5EF);
    final accent = dark ? const Color(0xFFA4C4AF) : const Color(0xFF416B60);
    final primaryText = dark
        ? const Color(0xFFE4E8E3)
        : const Color(0xFF202F2C);
    final secondaryText = dark
        ? const Color(0xFFB0C1B7)
        : const Color(0xFF50655B);
    final outline = dark ? const Color(0xFF41504C) : const Color(0xFFBCCAC1);
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text(l10n.historyDetailTitle),
        backgroundColor: background,
        foregroundColor: primaryText,
        elevation: 0,
      ),
      body: FutureBuilder<WalkingHistoryDetail?>(
        future: _detailFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(l10n.historyDetailLoadFailed));
          }
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final detail = snapshot.data;
          if (detail == null) {
            return Center(child: Text(l10n.historyDetailUnavailable));
          }
          return _DetailBody(
            detail: detail,
            cardColor: cardColor,
            accent: accent,
            primaryText: primaryText,
            secondaryText: secondaryText,
            outline: outline,
            formatDate: _formatDate,
            formatDuration: (duration) => l10n.historyDurationValue(
              duration.inHours,
              duration.inMinutes % 60,
              duration.inSeconds % 60,
            ),
            routeTitle: l10n.historyRouteTitle,
            routeUnavailable: l10n.historyRouteUnavailable,
            attribution: l10n.historyRouteAttribution,
            durationLabel: l10n.historyDuration,
            startLabel: l10n.historyStart,
            endLabel: l10n.historyEnd,
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
    required this.cardColor,
    required this.accent,
    required this.primaryText,
    required this.secondaryText,
    required this.outline,
    required this.formatDate,
    required this.formatDuration,
    required this.routeTitle,
    required this.routeUnavailable,
    required this.attribution,
    required this.durationLabel,
    required this.startLabel,
    required this.endLabel,
    required this.distanceLabel,
  });

  final WalkingHistoryDetail detail;
  final Color cardColor;
  final Color accent;
  final Color primaryText;
  final Color secondaryText;
  final Color outline;
  final String Function(DateTime) formatDate;
  final String Function(Duration) formatDuration;
  final String routeTitle;
  final String routeUnavailable;
  final String attribution;
  final String Function(String) durationLabel;
  final String Function(String) startLabel;
  final String Function(String) endLabel;
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
      padding: const EdgeInsets.fromLTRB(22, 16, 22, 32),
      children: [
        Text(
          formatDate(detail.entry.startedAt),
          style: TextStyle(color: accent, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _MetricCard(
              label: distanceLabel(
                (detail.entry.distanceMeters / 1000).toStringAsFixed(2),
              ),
              cardColor: cardColor,
              outline: outline,
              foreground: primaryText,
            ),
            _MetricCard(
              label: durationLabel(formatDuration(detail.entry.duration)),
              cardColor: cardColor,
              outline: outline,
              foreground: primaryText,
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          routeTitle,
          style: Theme.of(context).textTheme.titleMedium
              ?.copyWith(color: primaryText, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        if (points.isEmpty)
          Container(
            constraints: const BoxConstraints(minHeight: 240),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: outline),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.route_outlined, color: accent, size: 32),
                    const SizedBox(height: 12),
                    Text(
                      routeUnavailable,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: secondaryText),
                    ),
                  ],
                ),
              ),
            ),
          )
        else
          SizedBox(
            height: 360,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
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
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: outline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                startLabel(formatDate(detail.entry.startedAt)),
                style: TextStyle(color: secondaryText),
              ),
              const SizedBox(height: 8),
              Text(
                endLabel(formatDate(detail.entry.completedAt)),
                style: TextStyle(color: secondaryText),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.label,
    required this.cardColor,
    required this.outline,
    required this.foreground,
  });

  final String label;
  final Color cardColor;
  final Color outline;
  final Color foreground;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: BoxDecoration(
      color: cardColor,
      border: Border.all(color: outline),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Text(
      label,
      style: TextStyle(color: foreground, fontWeight: FontWeight.w600),
    ),
  );
}
