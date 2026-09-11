import 'package:flutter/material.dart';
import 'package:walkingen/l10n/generated/app_localizations.dart';
import 'package:walkingen/walking/walking_session_repository.dart';

class WalkingHistoryPage extends StatelessWidget {
  const WalkingHistoryPage({super.key, required this.repository});

  final WalkingSessionRepository repository;

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
    return FutureBuilder<List<WalkingHistoryEntry>>(
      future: repository.loadCompletedHistory(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final entries = snapshot.data!;
        if (entries.isEmpty) return Center(child: Text(l10n.historyEmpty));
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: entries.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final entry = entries[index];
            return Card(
              child: ListTile(
                leading: const Icon(Icons.check_circle_outline),
                title: Text(_formatDate(entry.completedAt)),
                subtitle: Text(
                  '${l10n.historyDuration(_formatDuration(entry.duration))} · '
                  '${l10n.walkDistance((entry.distanceMeters / 1000).toStringAsFixed(2))}',
                ),
                trailing: Text(l10n.historyCompleted),
              ),
            );
          },
        );
      },
    );
  }
}
