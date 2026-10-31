import 'package:flutter/material.dart';
import 'package:walkingen/l10n/generated/app_localizations.dart';
import 'package:walkingen/walking/walking_history_detail_page.dart';
import 'package:walkingen/walking/walking_session_repository.dart';

class WalkingHistoryPage extends StatefulWidget {
  const WalkingHistoryPage({
    super.key,
    required this.repository,
    this.refreshToken = 0,
  });

  final WalkingSessionRepository repository;
  final int refreshToken;

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

  @override
  void didUpdateWidget(covariant WalkingHistoryPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.refreshToken != widget.refreshToken ||
        oldWidget.repository != widget.repository) {
      _historyFuture = widget.repository.loadCompletedHistory(
        day: _selectedDay,
      );
    }
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

  String _keepFinalUnitWithNumber(String duration) {
    final separator = duration.lastIndexOf(' ');
    if (separator < 0) return duration;
    return '${duration.substring(0, separator)}\u00a0${duration.substring(separator + 1)}';
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

    return ColoredBox(
      color: background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              22,
              MediaQuery.viewPaddingOf(context).top + 16,
              22,
              12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: OutlinedButton.icon(
                        onPressed: _selectDay,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: accent,
                          side: BorderSide(color: outline),
                          minimumSize: const Size(48, 48),
                        ),
                        icon: const Icon(
                          Icons.calendar_today_outlined,
                          size: 18,
                        ),
                        label: Text(
                          _selectedDay == null
                              ? l10n.historyFilterDate
                              : _formatDay(_selectedDay!),
                        ),
                      ),
                    ),
                    if (_selectedDay != null) ...[
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: _clearFilter,
                        tooltip: l10n.historyClearFilter,
                        color: accent,
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<WalkingHistoryEntry>>(
              future: _historyFuture,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text(l10n.historyLoadFailed));
                }
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final entries = snapshot.data!;
                if (entries.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        _selectedDay == null
                            ? l10n.historyEmpty
                            : l10n.historyNoWalksForDate,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: secondaryText),
                      ),
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(22, 4, 22, 24),
                  itemCount: entries.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final entry = entries[index];
                    return Material(
                      color: cardColor,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: outline),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => WalkingHistoryDetailPage(
                              repository: widget.repository,
                              sessionId: entry.id,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Container(
                                width: 76,
                                height: 76,
                                decoration: BoxDecoration(
                                  color: background,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Icon(
                                  Icons.route_outlined,
                                  color: accent,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      l10n.historyStart(
                                        _formatDate(entry.startedAt),
                                      ),
                                      style: TextStyle(
                                        color: primaryText,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      l10n.walkDistance(
                                        (entry.distanceMeters / 1000)
                                            .toStringAsFixed(2),
                                      ),
                                      style: TextStyle(color: secondaryText),
                                    ),
                                    Text(
                                      _keepFinalUnitWithNumber(
                                        l10n.historyDurationValue(
                                          entry.duration.inHours,
                                          entry.duration.inMinutes % 60,
                                          entry.duration.inSeconds % 60,
                                        ),
                                      ),
                                      style: TextStyle(color: secondaryText),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(Icons.chevron_right, color: secondaryText),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
