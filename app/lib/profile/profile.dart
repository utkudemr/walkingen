import 'package:characters/characters.dart';

class Profile {
  const Profile._({
    required this.displayName,
    required this.heightCm,
    required this.weightKg,
    required this.birthYear,
  });

  final String displayName;
  final int heightCm;
  final double weightKg;
  final int birthYear;

  static Profile fromInput({
    required String displayName,
    required String height,
    required String weight,
    required String birthYear,
    required int currentYear,
  }) {
    return create(
      displayName: displayName,
      heightCm: _parseInteger(height, 'heightCm'),
      weightKg: _parseWeight(weight),
      birthYear: _parseInteger(birthYear, 'birthYear'),
      currentYear: currentYear,
    );
  }

  static Profile create({
    required String displayName,
    required int heightCm,
    required double weightKg,
    required int birthYear,
    required int currentYear,
  }) {
    final normalizedName = _normalizeDisplayName(displayName);
    if (normalizedName.characters.isEmpty ||
        normalizedName.characters.length > 80) {
      throw const ProfileValidationException('displayName');
    }
    if (heightCm < 80 || heightCm > 250) {
      throw const ProfileValidationException('heightCm');
    }
    if (weightKg < 20 ||
        weightKg > 300 ||
        (weightKg * 10).roundToDouble() != weightKg * 10) {
      throw const ProfileValidationException('weightKg');
    }
    if (currentYear < 1900 || birthYear < 1900 || birthYear > currentYear) {
      throw const ProfileValidationException('birthYear');
    }

    return Profile._(
      displayName: normalizedName,
      heightCm: heightCm,
      weightKg: weightKg,
      birthYear: birthYear,
    );
  }

  static int _parseInteger(String input, String field) {
    final value = input.trim();
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      throw ProfileValidationException(field);
    }
    try {
      return int.parse(value);
    } on FormatException {
      throw ProfileValidationException(field);
    }
  }

  static double _parseWeight(String input) {
    final value = input.trim();
    if (!RegExp(r'^[0-9]+([,.][0-9])?$').hasMatch(value)) {
      throw const ProfileValidationException('weightKg');
    }
    return double.parse(value.replaceFirst(',', '.'));
  }

  static String _normalizeDisplayName(String value) {
    final buffer = StringBuffer();
    var pendingWhitespace = false;
    for (final codePoint in value.runes) {
      if (_isUnicodeWhitespace(codePoint)) {
        if (buffer.isNotEmpty) pendingWhitespace = true;
        continue;
      }
      if (pendingWhitespace) buffer.write(' ');
      buffer.write(String.fromCharCode(codePoint));
      pendingWhitespace = false;
    }
    return buffer.toString();
  }

  static bool _isUnicodeWhitespace(int codePoint) {
    return (codePoint >= 0x0009 && codePoint <= 0x000D) ||
        codePoint == 0x0020 ||
        codePoint == 0x0085 ||
        codePoint == 0x00A0 ||
        codePoint == 0x1680 ||
        (codePoint >= 0x2000 && codePoint <= 0x200A) ||
        codePoint == 0x2028 ||
        codePoint == 0x2029 ||
        codePoint == 0x202F ||
        codePoint == 0x205F ||
        codePoint == 0x3000;
  }
}

class ProfileValidationException implements Exception {
  const ProfileValidationException(this.field);

  final String field;

  @override
  String toString() => 'Invalid profile field: $field';
}
