import 'package:flutter_test/flutter_test.dart';
import 'package:walkingen/database/app_database.dart';
import 'package:walkingen/profile/local_settings.dart';
import 'package:walkingen/profile/profile_repository.dart';

void main() {
  test('settings use defaults and survive repository reload', () async {
    final database = AppDatabase.inMemory();
    final repository = ProfileRepository(database);
    addTearDown(repository.close);

    expect(await repository.loadSettings(), const LocalSettings());

    await repository.saveSettings(
      const LocalSettings(
        localeOverride: 'tr',
        themeMode: 'dark',
        weeklyActiveDayTarget: 5,
      ),
    );

    final reloaded = await repository.loadSettings();
    expect(reloaded.localeOverride, 'tr');
    expect(reloaded.themeMode, 'dark');
    expect(reloaded.weeklyActiveDayTarget, 5);
  });

  test('settings reject unsupported values', () {
    expect(
      () => LocalSettings.validate(
        localeOverride: 'de',
        themeMode: 'system',
        weeklyActiveDayTarget: 3,
      ),
      throwsA(isA<SettingsValidationException>()),
    );
    expect(
      () => LocalSettings.validate(
        localeOverride: 'system',
        themeMode: 'system',
        weeklyActiveDayTarget: 8,
      ),
      throwsA(isA<SettingsValidationException>()),
    );
  });
}
