import 'package:flutter_test/flutter_test.dart';
import 'package:walkingen/profile/profile.dart';

void main() {
  group('Profile.create', () {
    test('normalizes a valid profile without changing its meaning', () {
      final profile = Profile.create(
        displayName: '  Utku   Demir  ',
        heightCm: 180,
        weightKg: 82.5,
        birthYear: 1990,
        currentYear: 2026,
      );

      expect(profile.displayName, 'Utku Demir');
      expect(profile.heightCm, 180);
      expect(profile.weightKg, 82.5);
      expect(profile.birthYear, 1990);
    });

    test('parses the localized decimal separator for weight', () {
      final profile = Profile.fromInput(
        displayName: 'Utku',
        height: '180',
        weight: '82,5',
        birthYear: '1990',
        currentYear: 2026,
      );

      expect(profile.weightKg, 82.5);
    });

    test('accepts profile boundaries and rejects values outside them', () {
      expect(
        () => Profile.create(
          displayName: 'A',
          heightCm: 80,
          weightKg: 20.0,
          birthYear: 1900,
          currentYear: 2026,
        ),
        returnsNormally,
      );
      expect(
        () => Profile.create(
          displayName: 'A',
          heightCm: 250,
          weightKg: 300.0,
          birthYear: 2026,
          currentYear: 2026,
        ),
        returnsNormally,
      );
      expect(
        () => Profile.create(
          displayName: 'A',
          heightCm: 79,
          weightKg: 20.0,
          birthYear: 1900,
          currentYear: 2026,
        ),
        throwsA(isA<ProfileValidationException>()),
      );
      expect(
        () => Profile.create(
          displayName: 'A',
          heightCm: 80,
          weightKg: 20.05,
          birthYear: 1900,
          currentYear: 2026,
        ),
        throwsA(isA<ProfileValidationException>()),
      );
    });

    test('counts grapheme clusters instead of UTF-16 code units', () {
      final profile = Profile.create(
        displayName: '👨‍👩‍👧‍👦',
        heightCm: 180,
        weightKg: 82.5,
        birthYear: 1990,
        currentYear: 2026,
      );

      expect(profile.displayName, '👨‍👩‍👧‍👦');
    });

    test('rejects an integer that cannot be represented', () {
      expect(
        () => Profile.fromInput(
          displayName: 'A',
          height: '9' * 100,
          weight: '20.0',
          birthYear: '1900',
          currentYear: 2026,
        ),
        throwsA(isA<ProfileValidationException>()),
      );
    });
  });
}
