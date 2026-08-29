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

  @override
  String get profileDisplayName => 'İsim';

  @override
  String get profileHeight => 'Boy (cm)';

  @override
  String get profileWeight => 'Kilo (kg)';

  @override
  String get profileBirthYear => 'Doğum yılı';

  @override
  String get profileSave => 'Profili kaydet';

  @override
  String get profileSaved => 'Profil kaydedildi.';

  @override
  String get profileRequired => 'Lütfen geçerli bir değer gir.';

  @override
  String get profileLoadFailed => 'Profil yüklenemedi.';

  @override
  String get profileSaveFailed => 'Profil kaydedilemedi.';
}
