import 'dart:async';

import 'package:flutter/material.dart';
import 'package:walkingen/l10n/generated/app_localizations.dart';
import 'package:walkingen/walking/walking_action_button.dart';
import 'package:walkingen/walking/walking_session_controller.dart';
import 'package:walkingen/walking/walking_tracking.dart';

class WalkingHomePage extends StatefulWidget {
  const WalkingHomePage({
    super.key,
    required this.coordinator,
    this.sessionId,
    this.now = DateTime.now,
  });

  final WalkingTrackingCoordinator coordinator;
  final String? sessionId;
  final DateTime Function() now;

  @override
  State<WalkingHomePage> createState() => _WalkingHomePageState();
}

class _WalkingHomePageState extends State<WalkingHomePage> {
  late final WalkingSessionController _controller = WalkingSessionController(
    widget.coordinator,
  );

  @override
  void initState() {
    super.initState();
    unawaited(_controller.initialize());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _resumeInterrupted() async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.walkResume),
        content: Text(l10n.walkInterrupted),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.walkFinishCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.walkResume),
          ),
        ],
      ),
    );
    if (confirmed == true) await _controller.resumeInterrupted();
  }

  Future<void> _finish() async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.walkFinishTitle),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.walkFinishCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.walkFinishConfirm),
          ),
        ],
      ),
    );
    if (confirmed == true) await _controller.finish();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) => _WalkingHomeContent(
        state: _controller.state,
        now: widget.now,
        onStart: () => _controller.start(startedAt: widget.now()),
        onPause: _controller.pause,
        onResume: _controller.resume,
        onResumeInterrupted: _resumeInterrupted,
        onFinish: _finish,
      ),
    );
  }
}

class _WalkingHomeContent extends StatelessWidget {
  const _WalkingHomeContent({
    required this.state,
    required this.now,
    required this.onStart,
    required this.onPause,
    required this.onResume,
    required this.onResumeInterrupted,
    required this.onFinish,
  });

  final WalkingUiState state;
  final DateTime Function() now;
  final VoidCallback onStart;
  final Future<void> Function() onPause;
  final Future<void> Function() onResume;
  final Future<void> Function() onResumeInterrupted;
  final Future<void> Function() onFinish;

  bool get isOpen => switch (state.status) {
    WalkingUiStatus.active ||
    WalkingUiStatus.paused ||
    WalkingUiStatus.interrupted => true,
    _ => false,
  };

  String _formatDuration(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final kilometers = (state.distanceMeters / 1000).toStringAsFixed(2);
    final elapsed = _formatDuration(state.elapsed);
    final status = switch (state.status) {
      WalkingUiStatus.active => l10n.walkActive,
      WalkingUiStatus.paused => l10n.walkPaused,
      WalkingUiStatus.interrupted => l10n.walkInterrupted,
      WalkingUiStatus.completed => l10n.walkDistance(kilometers),
      WalkingUiStatus.starting => l10n.walkActive,
      WalkingUiStatus.finishing => l10n.walkActive,
      WalkingUiStatus.failure => l10n.walkActionFailed,
      WalkingUiStatus.idle => l10n.homeEmpty,
    };
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (isOpen || state.status == WalkingUiStatus.completed) ...[
                Text(
                  status,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                Text(
                  elapsed,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 8),
              ],
              Text(
                l10n.walkDistance(kilometers),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              if (isOpen || state.status == WalkingUiStatus.completed)
                Text(
                  l10n.walkSteps(state.steps),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              if (state.error != null) ...[
                const SizedBox(height: 12),
                Semantics(
                  liveRegion: true,
                  child: Text(
                    l10n.walkActionFailed,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
              if (!isOpen &&
                  state.status != WalkingUiStatus.starting &&
                  state.status != WalkingUiStatus.finishing)
                Center(
                  child: WalkingActionButton(
                    tooltip: l10n.walkStart,
                    icon: Icons.directions_walk,
                    onPressed: onStart,
                    filled: true,
                    width: 184,
                    height: 184,
                    borderRadius: 56,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(36)),
                      child: Image.asset(
                        'assets/running_person.gif',
                        width: 112,
                        height: 112,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              if (isOpen)
                Row(
                  children: [
                    Expanded(
                      child: WalkingActionButton(
                        tooltip:
                            state.status == WalkingUiStatus.paused ||
                                state.status == WalkingUiStatus.interrupted
                            ? l10n.walkResume
                            : l10n.walkPause,
                        icon:
                            state.status == WalkingUiStatus.paused ||
                                state.status == WalkingUiStatus.interrupted
                            ? Icons.play_arrow
                            : Icons.pause,
                        onPressed: state.status == WalkingUiStatus.interrupted
                            ? onResumeInterrupted
                            : state.status == WalkingUiStatus.paused
                            ? onResume
                            : onPause,
                        height: 128,
                        borderRadius: 40,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: WalkingActionButton(
                        tooltip: l10n.walkFinish,
                        icon: Icons.stop,
                        onPressed: onFinish,
                        height: 128,
                        borderRadius: 40,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
