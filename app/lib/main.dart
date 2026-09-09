import 'package:flutter/material.dart';
import 'package:walkingen/database/app_database.dart';
import 'package:walkingen/l10n/generated/app_localizations.dart';
import 'package:walkingen/profile/local_settings.dart';
import 'package:walkingen/profile/profile_page.dart';
import 'package:walkingen/profile/profile_repository.dart';
import 'package:walkingen/walking/geolocator_location_source.dart';
import 'package:walkingen/walking/pedometer_step_source.dart';
import 'package:walkingen/walking/walking_history_page.dart';
import 'package:walkingen/walking/walking_home_page.dart';
import 'package:walkingen/walking/walking_session_repository.dart';
import 'package:walkingen/walking/walking_tracking.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await AppDatabase.open();
  final repository = ProfileRepository(database);
  final settings = await repository.loadSettings();
  final notificationLocale = settings.localeOverride == 'en'
      ? const Locale('en')
      : const Locale('tr');
  final notificationL10n = await AppLocalizations.delegate.load(
    notificationLocale,
  );
  String formatDuration(Duration value) {
    final hours = value.inHours.toString().padLeft(2, '0');
    final minutes = (value.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (value.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  String notificationMetrics(Duration elapsed, double distance, int steps) =>
      '${formatDuration(elapsed)} · '
      '${notificationL10n.walkDistance((distance / 1000).toStringAsFixed(2))} · '
      '${notificationL10n.walkSteps(steps)}';
  final walkingRepository = WalkingSessionRepository(database);
  final notificationSink = GeolocatorNotificationSink(
    title: notificationL10n.appTitle,
    channelName: notificationL10n.appTitle,
    activeText: notificationMetrics,
    pausedText: notificationMetrics,
  );
  final source = GeolocatorLocationSource(
    notificationTitle: notificationL10n.appTitle,
    notificationText: notificationL10n.walkNotificationText,
  );
  final stepSource = PedometerStepSource();
  final coordinator = WalkingTrackingCoordinator(
    walkingRepository,
    source,
    stepSource: stepSource,
    notificationSink: notificationSink,
  );
  runApp(
    WalkingenApp(
      repository: repository,
      settings: settings,
      walkingCoordinator: coordinator,
      walkingRepository: walkingRepository,
    ),
  );
}

class WalkingenApp extends StatelessWidget {
  const WalkingenApp({
    super.key,
    this.locale,
    this.repository,
    this.settings,
    this.walkingCoordinator,
    this.walkingRepository,
  });

  static const seedColor = Color(0xFF4F6F52);

  final Locale? locale;
  final ProfileRepository? repository;
  final LocalSettings? settings;
  final WalkingTrackingCoordinator? walkingCoordinator;
  final WalkingSessionRepository? walkingRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: locale ?? _localeFromSettings(settings),
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: _themeModeFromSettings(settings),
      home: AppShell(
        repository: repository,
        walkingCoordinator: walkingCoordinator,
        walkingRepository: walkingRepository,
      ),
    );
  }

  static Locale? _localeFromSettings(LocalSettings? settings) {
    switch (settings?.localeOverride) {
      case 'tr':
        return const Locale('tr');
      case 'en':
        return const Locale('en');
      default:
        return null;
    }
  }

  static ThemeMode _themeModeFromSettings(LocalSettings? settings) {
    switch (settings?.themeMode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}

class AppShell extends StatefulWidget {
  const AppShell({
    super.key,
    this.repository,
    this.walkingCoordinator,
    this.walkingRepository,
  });

  final ProfileRepository? repository;
  final WalkingTrackingCoordinator? walkingCoordinator;
  final WalkingSessionRepository? walkingRepository;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final messages = [
      localizations.homeEmpty,
      localizations.historyEmpty,
      localizations.profileSettingsEmpty,
    ];

    return Scaffold(
      body: _selectedIndex == 0 && widget.walkingCoordinator != null
          ? WalkingHomePage(coordinator: widget.walkingCoordinator!)
          : _selectedIndex == 1 && widget.walkingRepository != null
          ? WalkingHistoryPage(repository: widget.walkingRepository!)
          : _selectedIndex == 2 && widget.repository != null
          ? ProfilePage(repository: widget.repository!)
          : Center(child: Text(messages[_selectedIndex])),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: localizations.homeTitle,
            tooltip: localizations.homeTitle,
          ),
          NavigationDestination(
            icon: const Icon(Icons.history_outlined),
            selectedIcon: const Icon(Icons.history),
            label: localizations.historyTitle,
            tooltip: localizations.historyTitle,
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(Icons.person),
            label: localizations.profileTab,
            tooltip: localizations.profileTab,
          ),
        ],
      ),
    );
  }
}
