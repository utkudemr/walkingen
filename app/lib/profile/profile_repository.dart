import 'package:drift/drift.dart';
import 'package:walkingen/database/app_database.dart';
import 'package:walkingen/profile/profile.dart';
import 'package:walkingen/profile/profile_draft.dart';
import 'package:walkingen/profile/local_settings.dart';

class ProfileRepository {
  ProfileRepository(this._database, {DateTime Function()? now})
    : _now = now ?? DateTime.now;

  final AppDatabase _database;
  final DateTime Function() _now;

  static Future<ProfileRepository> inMemory() async {
    return ProfileRepository(AppDatabase.inMemory());
  }

  Future<Profile?> loadProfile() async {
    final row = await (_database.select(
      _database.profileRows,
    )..where((table) => table.id.equals(1))).getSingleOrNull();
    if (row == null) return null;
    return Profile.create(
      displayName: row.displayName,
      heightCm: row.heightCm,
      weightKg: row.weightKg,
      birthYear: row.birthYear,
      currentYear: _now().year,
    );
  }

  Future<ProfileDraft?> loadDraft() async {
    final row = await (_database.select(
      _database.profileDraftRows,
    )..where((table) => table.id.equals(1))).getSingleOrNull();
    if (row == null) return null;
    return ProfileDraft.fromForm(
      displayName: row.displayName,
      height: row.height,
      weight: row.weight,
      birthYear: row.birthYear,
      isDisplayNamePresent: row.isDisplayNamePresent,
      isHeightPresent: row.isHeightPresent,
      isWeightPresent: row.isWeightPresent,
      isBirthYearPresent: row.isBirthYearPresent,
    );
  }

  Future<void> saveDraft(ProfileDraft draft) async {
    if (!draft.hasMeaningfulValue) {
      await (_database.delete(
        _database.profileDraftRows,
      )..where((table) => table.id.equals(1))).go();
      return;
    }
    await _database
        .into(_database.profileDraftRows)
        .insertOnConflictUpdate(
          ProfileDraftRowsCompanion.insert(
            id: const Value(1),
            displayName: draft.displayName,
            height: draft.height,
            weight: draft.weight,
            birthYear: draft.birthYear,
            isDisplayNamePresent: Value(draft.isDisplayNamePresent),
            isHeightPresent: Value(draft.isHeightPresent),
            isWeightPresent: Value(draft.isWeightPresent),
            isBirthYearPresent: Value(draft.isBirthYearPresent),
          ),
        );
  }

  Future<void> clearDraft() async {
    await (_database.delete(
      _database.profileDraftRows,
    )..where((table) => table.id.equals(1))).go();
  }

  Future<LocalSettings> loadSettings() async {
    final row = await (_database.select(
      _database.settingsRows,
    )..where((table) => table.id.equals(1))).getSingleOrNull();
    if (row == null) return const LocalSettings();
    return LocalSettings.validate(
      localeOverride: row.localeOverride,
      themeMode: row.themeMode,
      weeklyActiveDayTarget: row.weeklyActiveDayTarget,
    );
  }

  Future<void> saveSettings(LocalSettings settings) async {
    final valid = LocalSettings.validate(
      localeOverride: settings.localeOverride,
      themeMode: settings.themeMode,
      weeklyActiveDayTarget: settings.weeklyActiveDayTarget,
    );
    await _database
        .into(_database.settingsRows)
        .insertOnConflictUpdate(
          SettingsRowsCompanion.insert(
            id: const Value(1),
            localeOverride: Value(valid.localeOverride),
            themeMode: Value(valid.themeMode),
            weeklyActiveDayTarget: Value(valid.weeklyActiveDayTarget),
          ),
        );
  }

  Future<void> saveProfile(Profile profile) async {
    await _database.transaction(() async {
      await _database
          .into(_database.profileRows)
          .insertOnConflictUpdate(
            ProfileRowsCompanion.insert(
              id: const Value(1),
              displayName: profile.displayName,
              heightCm: profile.heightCm,
              weightKg: profile.weightKg,
              birthYear: profile.birthYear,
            ),
          );
      await (_database.delete(
        _database.profileDraftRows,
      )..where((table) => table.id.equals(1))).go();
    });
  }

  Future<void> close() => _database.close();
}
