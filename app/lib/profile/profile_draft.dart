class ProfileDraft {
  const ProfileDraft({
    required this.displayName,
    required this.height,
    required this.weight,
    required this.birthYear,
    this.isDisplayNamePresent = true,
    this.isHeightPresent = true,
    this.isWeightPresent = true,
    this.isBirthYearPresent = true,
  });

  final String displayName;
  final String height;
  final String weight;
  final String birthYear;
  final bool isDisplayNamePresent;
  final bool isHeightPresent;
  final bool isWeightPresent;
  final bool isBirthYearPresent;

  factory ProfileDraft.fromForm({
    required String displayName,
    required String height,
    required String weight,
    required String birthYear,
    bool isDisplayNamePresent = true,
    bool isHeightPresent = true,
    bool isWeightPresent = true,
    bool isBirthYearPresent = true,
  }) {
    return ProfileDraft(
      displayName: displayName,
      height: height,
      weight: weight,
      birthYear: birthYear,
      isDisplayNamePresent: isDisplayNamePresent,
      isHeightPresent: isHeightPresent,
      isWeightPresent: isWeightPresent,
      isBirthYearPresent: isBirthYearPresent,
    );
  }

  factory ProfileDraft.fromJson(Map<String, Object?> json) {
    return ProfileDraft(
      displayName: json['displayName']! as String,
      height: json['height']! as String,
      weight: json['weight']! as String,
      birthYear: json['birthYear']! as String,
      isDisplayNamePresent: json['isDisplayNamePresent'] as bool? ?? true,
      isHeightPresent: json['isHeightPresent'] as bool? ?? true,
      isWeightPresent: json['isWeightPresent'] as bool? ?? true,
      isBirthYearPresent: json['isBirthYearPresent'] as bool? ?? true,
    );
  }

  bool get hasMeaningfulValue => [
    if (isDisplayNamePresent) displayName,
    if (isHeightPresent) height,
    if (isWeightPresent) weight,
    if (isBirthYearPresent) birthYear,
  ].any((value) => value.trim().isNotEmpty);

  Map<String, Object?> toJson() => {
    'displayName': displayName,
    'height': height,
    'weight': weight,
    'birthYear': birthYear,
    'isDisplayNamePresent': isDisplayNamePresent,
    'isHeightPresent': isHeightPresent,
    'isWeightPresent': isWeightPresent,
    'isBirthYearPresent': isBirthYearPresent,
  };
}
