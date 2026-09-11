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
  String get historyFilterDate => 'Filter by date';

  @override
  String get historyClearFilter => 'Clear date filter';

  @override
  String historySelectedDate(Object date) {
    return 'Showing walks for $date';
  }

  @override
  String get historyNoWalksForDate => 'No completed walks on this date.';

  @override
  String get historyDetailTitle => 'Walk details';

  @override
  String get historyRouteTitle => 'Route';

  @override
  String get historyRouteUnavailable =>
      'No GPS route was recorded for this walk.';

  @override
  String get historyDetailLoadFailed => 'Walk details could not be loaded.';

  @override
  String get historyDetailUnavailable =>
      'This completed walk is no longer available.';

  @override
  String get historyRouteAttribution => '© OpenStreetMap contributors';

  @override
  String get profileTab => 'Profile';

  @override
  String get profileSettingsTitle => 'Profile and Settings';

  @override
  String get profileSettingsEmpty =>
      'Profile and settings options will appear here.';

  @override
  String get profileDisplayName => 'Name';

  @override
  String get profileHeight => 'Height (cm)';

  @override
  String get profileWeight => 'Weight (kg)';

  @override
  String get profileBirthYear => 'Birth year';

  @override
  String get profileSave => 'Save profile';

  @override
  String get profileSaved => 'Profile saved.';

  @override
  String get profileRequired => 'Please enter a valid value.';

  @override
  String get profileLoadFailed => 'Profile could not be loaded.';

  @override
  String get profileSaveFailed => 'Profile could not be saved.';

  @override
  String get walkStart => 'Start walking';

  @override
  String get walkActive => 'Walk in progress';

  @override
  String get walkPause => 'Pause walking';

  @override
  String get walkPaused => 'Walk paused';

  @override
  String get walkResume => 'Resume walking';

  @override
  String get walkFinish => 'Finish walk';

  @override
  String get walkFinishTitle => 'Finish this walk?';

  @override
  String get walkFinishCancel => 'Cancel';

  @override
  String get walkFinishConfirm => 'Finish';

  @override
  String get walkActionFailed => 'The walking action could not be completed.';

  @override
  String get walkInterrupted => 'The walk was interrupted.';

  @override
  String get walkNotificationText => 'Walking is active.';

  @override
  String walkDistance(Object kilometers) {
    return 'Distance: $kilometers km';
  }

  @override
  String walkSteps(Object steps) {
    return 'Steps: $steps';
  }

  @override
  String historyDuration(Object duration) {
    return 'Duration: $duration';
  }

  @override
  String get historyCompleted => 'Completed';
}
