import 'package:flutter/material.dart';
import 'package:walkingen/l10n/generated/app_localizations.dart';

void main() {
  runApp(const WalkingenApp());
}

class WalkingenApp extends StatelessWidget {
  const WalkingenApp({super.key, this.locale});

  static const seedColor = Color(0xFF4F6F52);

  final Locale? locale;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: locale,
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
      themeMode: ThemeMode.system,
      home: const AppShell(),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final titles = [
      localizations.homeTitle,
      localizations.historyTitle,
      localizations.profileSettingsTitle,
    ];
    final messages = [
      localizations.homeEmpty,
      localizations.historyEmpty,
      localizations.profileSettingsEmpty,
    ];

    return Scaffold(
      appBar: AppBar(title: Text(titles[_selectedIndex])),
      body: Center(child: Text(messages[_selectedIndex])),
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
          ),
          NavigationDestination(
            icon: const Icon(Icons.history_outlined),
            selectedIcon: const Icon(Icons.history),
            label: localizations.historyTitle,
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(Icons.person),
            label: localizations.profileTab,
          ),
        ],
      ),
    );
  }
}
