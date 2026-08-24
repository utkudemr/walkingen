// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Walkingen';

  @override
  String get homeTitle => 'Ana Sayfa';

  @override
  String get homeEmpty => 'Yürüyüşlerin burada başlayacak.';

  @override
  String get historyTitle => 'Geçmiş';

  @override
  String get historyEmpty => 'Tamamlanan yürüyüşlerin burada görünecek.';

  @override
  String get profileTab => 'Profil';

  @override
  String get profileSettingsTitle => 'Profil ve Ayarlar';

  @override
  String get profileSettingsEmpty =>
      'Profil ve ayar seçenekleri burada görünecek.';
}
