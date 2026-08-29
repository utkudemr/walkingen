import 'package:flutter_test/flutter_test.dart';

import 'dart:io';

import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:walkingen/database/app_database.dart';
import 'package:walkingen/profile/profile.dart';
import 'package:walkingen/profile/profile_draft.dart';
import 'package:walkingen/profile/profile_repository.dart';
import 'package:walkingen/profile/local_settings.dart';

void main() {
  test('saves and reloads the profile while clearing its draft', () async {
    final repository = await ProfileRepository.inMemory();
    addTearDown(repository.close);

    final profile = Profile.create(
      displayName: 'Utku Demir',
      heightCm: 180,
      weightKg: 82.5,
      birthYear: 1990,
      currentYear: 2026,
    );
    final draft = ProfileDraft.fromForm(
      displayName: 'Utku Demir',
      height: '180',
      weight: '82,5',
      birthYear: '1990',
    );

    await repository.saveDraft(draft);
    await repository.saveProfile(profile);

    final reloaded = await repository.loadProfile();
    expect(reloaded?.displayName, 'Utku Demir');
    expect(reloaded?.heightCm, 180);
    expect(reloaded?.weightKg, 82.5);
    expect(reloaded?.birthYear, 1990);
    expect(await repository.loadDraft(), isNull);
  });

  test('clears a meaningful draft when the user abandons the form', () async {
    final repository = await ProfileRepository.inMemory();
    addTearDown(repository.close);

    await repository.saveDraft(
      ProfileDraft.fromForm(
        displayName: 'Utku',
        height: '',
        weight: '',
        birthYear: '',
      ),
    );

    await repository.clearDraft();

    expect(await repository.loadDraft(), isNull);
  });

  test(
    'validates the stored birth year against the injected current year',
    () async {
      final repository = ProfileRepository(
        AppDatabase.inMemory(),
        now: () => DateTime(2026),
      );
      addTearDown(repository.close);

      await repository.saveProfile(
        Profile.create(
          displayName: 'Utku',
          heightCm: 180,
          weightKg: 82.5,
          birthYear: 2026,
          currentYear: 2026,
        ),
      );

      expect((await repository.loadProfile())?.birthYear, 2026);
    },
  );

  test('reloads profile and settings from a file database', () async {
    final file = File(
      p.join(Directory.systemTemp.path, 'walkingen-test.sqlite'),
    );
    await file.parent.create(recursive: true);
    if (await file.exists()) await file.delete();

    final first = ProfileRepository(
      AppDatabase(NativeDatabase(file)),
      now: () => DateTime(2026),
    );
    await first.saveProfile(
      Profile.create(
        displayName: 'Utku',
        heightCm: 180,
        weightKg: 82.5,
        birthYear: 1990,
        currentYear: 2026,
      ),
    );
    await first.saveSettings(const LocalSettings(themeMode: 'dark'));
    await first.close();

    final second = ProfileRepository(
      AppDatabase(NativeDatabase(file)),
      now: () => DateTime(2026),
    );
    addTearDown(() async {
      await second.close();
      if (await file.exists()) await file.delete();
    });
    expect((await second.loadProfile())?.displayName, 'Utku');
    expect((await second.loadSettings()).themeMode, 'dark');
  });
}
