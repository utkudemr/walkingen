import 'package:flutter_test/flutter_test.dart';
import 'package:walkingen/profile/profile_draft.dart';

void main() {
  test('preserves a partial draft through serialization and restore', () {
    final draft = ProfileDraft.fromForm(
      displayName: '  Utku  ',
      height: '',
      weight: '',
      birthYear: '',
    );

    final restored = ProfileDraft.fromJson(draft.toJson());

    expect(restored.displayName, '  Utku  ');
    expect(restored.height, '');
    expect(restored.hasMeaningfulValue, isTrue);
    expect(restored.isDisplayNamePresent, isTrue);
    expect(restored.isHeightPresent, isTrue);
  });
}
