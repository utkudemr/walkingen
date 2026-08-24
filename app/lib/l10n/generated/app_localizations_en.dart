// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Walkingen';

  @override
  String get homeTitle => 'Home';

  @override
  String get homeEmpty => 'Your walking overview will appear here.';

  @override
  String get historyTitle => 'History';

  @override
  String get historyEmpty => 'Your completed walks will appear here.';

  @override
  String get profileTab => 'Profile';

  @override
  String get profileSettingsTitle => 'Profile and Settings';

  @override
  String get profileSettingsEmpty =>
      'Profile and settings options will appear here.';
}
