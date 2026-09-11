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
  String get historyFilterDate => 'Tarihe göre filtrele';

  @override
  String get historyClearFilter => 'Tarih filtresini temizle';

  @override
  String historySelectedDate(Object date) {
    return '$date tarihindeki yürüyüşler';
  }

  @override
  String get historyNoWalksForDate => 'Bu tarihte tamamlanan yürüyüş yok.';

  @override
  String get historyDetailTitle => 'Yürüyüş detayı';

  @override
  String get historyRouteTitle => 'Rota';

  @override
  String get historyRouteUnavailable =>
      'Bu yürüyüş için GPS rotası kaydedilmedi.';

  @override
  String get historyDetailLoadFailed => 'Yürüyüş detayı yüklenemedi.';

  @override
  String get historyDetailUnavailable =>
      'Bu tamamlanmış yürüyüş artık kullanılamıyor.';

  @override
  String get historyRouteAttribution => '© OpenStreetMap katkıcıları';

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

  @override
  String get walkStart => 'Yürüyüşü başlat';

  @override
  String get walkActive => 'Yürüyüş devam ediyor';

  @override
  String get walkPause => 'Yürüyüşü duraklat';

  @override
  String get walkPaused => 'Yürüyüş duraklatıldı';

  @override
  String get walkResume => 'Yürüyüşe devam et';

  @override
  String get walkFinish => 'Yürüyüşü bitir';

  @override
  String get walkFinishTitle => 'Yürüyüşü bitirmek istiyor musun?';

  @override
  String get walkFinishCancel => 'Vazgeç';

  @override
  String get walkFinishConfirm => 'Bitir';

  @override
  String get walkActionFailed => 'Yürüyüş işlemi tamamlanamadı.';

  @override
  String get walkInterrupted => 'Yürüyüş kesintiye uğradı.';

  @override
  String get walkNotificationText => 'Yürüyüş devam ediyor.';

  @override
  String walkDistance(Object kilometers) {
    return 'Mesafe: $kilometers km';
  }

  @override
  String walkSteps(Object steps) {
    return 'Adım: $steps';
  }

  @override
  String historyDuration(Object duration) {
    return 'Süre: $duration';
  }

  @override
  String get historyCompleted => 'Tamamlandı';
}
