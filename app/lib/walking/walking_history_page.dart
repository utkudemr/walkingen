import 'package:flutter/material.dart';
import 'package:walkingen/l10n/generated/app_localizations.dart';
import 'package:walkingen/walking/walking_history_detail_page.dart';
import 'package:walkingen/walking/walking_session_repository.dart';

class WalkingHistoryPage extends StatefulWidget {
  const WalkingHistoryPage({super.key, required this.repository});

  final WalkingSessionRepository repository;

  @override
  State<WalkingHistoryPage> createState() => _WalkingHistoryPageState();
}

class _WalkingHistoryPageState extends State<WalkingHistoryPage> {
  DateTime? _selectedDay;
  late Future<List<WalkingHistoryEntry>> _historyFuture;

  @override
  void initState() {
    super.initState();
    _historyFuture = widget.repository.loadCompletedHistory();
  }

  String _formatDate(DateTime date) {
    final local = date.toLocal();
    final day = local.day.toString().padLeft(2, '0');
    final month = local.month.toString().padLeft(2, '0');
    final hour = local.hour.toString().padLeft(2, '0');
    final minute = local.minute.toString().padLeft(2, '0');
    return '$day.$month.${local.year} $hour:$minute';
  }

  String _formatDay(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day.$month.${date.year}';
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  Future<void> _selectDay() async {
    final now = DateTime.now();
    final selected = await showDatePicker(
      context: context,
      initialDate: _selectedDay ?? now,
      firstDate: DateTime(2020),
      lastDate: DateTime(now.year, now.month, now.day),
    );
    if (!mounted || selected == null) return;
    setState(() {
      _selectedDay = selected;
      _historyFuture = widget.repository.loadCompletedHistory(day: selected);
    });
  }

  void _clearFilter() {
    setState(() {
      _selectedDay = null;
      _historyFuture = widget.repository.loadCompletedHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _selectDay,
                  icon: const Icon(Icons.calendar_today),
                  label: Text(
                    _selectedDay == null
                        ? l10n.historyFilterDate
                        : l10n.historySelectedDate(_formatDay(_selectedDay!)),
                  ),
                ),
              ),
              if (_selectedDay != null) ...[
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _clearFilter,
                  tooltip: l10n.historyClearFilter,
                  icon: const Icon(Icons.clear),
                ),
              ],
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder<List<WalkingHistoryEntry>>(
            future: _historyFuture,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final entries = snapshot.data!;
              if (entries.isEmpty) {
                return Center(
                  child: Text(
                    _selectedDay == null
                        ? l10n.historyEmpty
                        : l10n.historyNoWalksForDate,
                  ),
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: entries.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final entry = entries[index];
                  return Card(
                    child: ListTile(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => WalkingHistoryDetailPage(
                            repository: widget.repository,
                            sessionId: entry.id,
                          ),
                        ),
                      ),
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
          ),
        ),
      ],
    );
  }
}
