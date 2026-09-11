import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Walkingen'**
  String get appTitle;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTitle;

  /// No description provided for @homeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your walking overview will appear here.'**
  String get homeEmpty;

  /// No description provided for @historyTitle.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get historyTitle;

  /// No description provided for @historyEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your completed walks will appear here.'**
  String get historyEmpty;

  /// No description provided for @historyFilterDate.
  ///
  /// In en, this message translates to:
  /// **'Filter by date'**
  String get historyFilterDate;

  /// No description provided for @historyClearFilter.
  ///
  /// In en, this message translates to:
  /// **'Clear date filter'**
  String get historyClearFilter;

  /// No description provided for @historySelectedDate.
  ///
  /// In en, this message translates to:
  /// **'Showing walks for {date}'**
  String historySelectedDate(Object date);

  /// No description provided for @historyNoWalksForDate.
  ///
  /// In en, this message translates to:
  /// **'No completed walks on this date.'**
  String get historyNoWalksForDate;

  /// No description provided for @historyDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Walk details'**
  String get historyDetailTitle;

  /// No description provided for @historyRouteTitle.
  ///
  /// In en, this message translates to:
  /// **'Route'**
  String get historyRouteTitle;

  /// No description provided for @historyRouteUnavailable.
  ///
  /// In en, this message translates to:
  /// **'No GPS route was recorded for this walk.'**
  String get historyRouteUnavailable;

  /// No description provided for @historyDetailLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Walk details could not be loaded.'**
  String get historyDetailLoadFailed;

  /// No description provided for @historyDetailUnavailable.
  ///
  /// In en, this message translates to:
  /// **'This completed walk is no longer available.'**
  String get historyDetailUnavailable;

  /// No description provided for @historyRouteAttribution.
  ///
  /// In en, this message translates to:
  /// **'© OpenStreetMap contributors'**
  String get historyRouteAttribution;

  /// No description provided for @profileTab.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTab;

  /// No description provided for @profileSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile and Settings'**
  String get profileSettingsTitle;

  /// No description provided for @profileSettingsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Profile and settings options will appear here.'**
  String get profileSettingsEmpty;

  /// No description provided for @profileDisplayName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get profileDisplayName;

  /// No description provided for @profileHeight.
  ///
  /// In en, this message translates to:
  /// **'Height (cm)'**
  String get profileHeight;

  /// No description provided for @profileWeight.
  ///
  /// In en, this message translates to:
  /// **'Weight (kg)'**
  String get profileWeight;

  /// No description provided for @profileBirthYear.
  ///
  /// In en, this message translates to:
  /// **'Birth year'**
  String get profileBirthYear;

  /// No description provided for @profileSave.
  ///
  /// In en, this message translates to:
  /// **'Save profile'**
  String get profileSave;

  /// No description provided for @profileSaved.
  ///
  /// In en, this message translates to:
  /// **'Profile saved.'**
  String get profileSaved;

  /// No description provided for @profileRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid value.'**
  String get profileRequired;

  /// No description provided for @profileLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Profile could not be loaded.'**
  String get profileLoadFailed;

  /// No description provided for @profileSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Profile could not be saved.'**
  String get profileSaveFailed;

  /// No description provided for @walkStart.
  ///
  /// In en, this message translates to:
  /// **'Start walking'**
  String get walkStart;

  /// No description provided for @walkActive.
  ///
  /// In en, this message translates to:
  /// **'Walk in progress'**
  String get walkActive;

  /// No description provided for @walkPause.
  ///
  /// In en, this message translates to:
  /// **'Pause walking'**
  String get walkPause;

  /// No description provided for @walkPaused.
  ///
  /// In en, this message translates to:
  /// **'Walk paused'**
  String get walkPaused;

  /// No description provided for @walkResume.
  ///
  /// In en, this message translates to:
  /// **'Resume walking'**
  String get walkResume;

  /// No description provided for @walkFinish.
  ///
  /// In en, this message translates to:
  /// **'Finish walk'**
  String get walkFinish;

  /// No description provided for @walkFinishTitle.
  ///
  /// In en, this message translates to:
  /// **'Finish this walk?'**
  String get walkFinishTitle;

  /// No description provided for @walkFinishCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get walkFinishCancel;

  /// No description provided for @walkFinishConfirm.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get walkFinishConfirm;

  /// No description provided for @walkActionFailed.
  ///
  /// In en, this message translates to:
  /// **'The walking action could not be completed.'**
  String get walkActionFailed;

  /// No description provided for @walkInterrupted.
  ///
  /// In en, this message translates to:
  /// **'The walk was interrupted.'**
  String get walkInterrupted;

  /// No description provided for @walkNotificationText.
  ///
  /// In en, this message translates to:
  /// **'Walking is active.'**
  String get walkNotificationText;

  /// No description provided for @walkDistance.
  ///
  /// In en, this message translates to:
  /// **'Distance: {kilometers} km'**
  String walkDistance(Object kilometers);

  /// No description provided for @walkSteps.
  ///
  /// In en, this message translates to:
  /// **'Steps: {steps}'**
  String walkSteps(Object steps);

  /// No description provided for @historyDuration.
  ///
  /// In en, this message translates to:
  /// **'Duration: {duration}'**
  String historyDuration(Object duration);

  /// No description provided for @historyCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get historyCompleted;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
