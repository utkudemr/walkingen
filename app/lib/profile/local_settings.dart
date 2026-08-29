class LocalSettings {
  const LocalSettings({
    this.localeOverride = 'system',
    this.themeMode = 'system',
    this.weeklyActiveDayTarget = 3,
  });

  final String localeOverride;
  final String themeMode;
  final int weeklyActiveDayTarget;

  LocalSettings copyWith({
    String? localeOverride,
    String? themeMode,
    int? weeklyActiveDayTarget,
  }) {
    return LocalSettings(
      localeOverride: localeOverride ?? this.localeOverride,
      themeMode: themeMode ?? this.themeMode,
      weeklyActiveDayTarget:
          weeklyActiveDayTarget ?? this.weeklyActiveDayTarget,
    );
  }

  static LocalSettings validate({
    required String localeOverride,
    required String themeMode,
    required int weeklyActiveDayTarget,
  }) {
    if (!{'system', 'tr', 'en'}.contains(localeOverride)) {
      throw const SettingsValidationException('localeOverride');
    }
    if (!{'system', 'light', 'dark'}.contains(themeMode)) {
      throw const SettingsValidationException('themeMode');
    }
    if (weeklyActiveDayTarget < 1 || weeklyActiveDayTarget > 7) {
      throw const SettingsValidationException('weeklyActiveDayTarget');
    }
    return LocalSettings(
      localeOverride: localeOverride,
      themeMode: themeMode,
      weeklyActiveDayTarget: weeklyActiveDayTarget,
    );
  }
}

class SettingsValidationException implements Exception {
  const SettingsValidationException(this.field);

  final String field;
}
