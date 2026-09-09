// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProfileRowsTable extends ProfileRows
    with TableInfo<$ProfileRowsTable, ProfileRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfileRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL CHECK (id = 1)',
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _heightCmMeta = const VerificationMeta(
    'heightCm',
  );
  @override
  late final GeneratedColumn<int> heightCm = GeneratedColumn<int>(
    'height_cm',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _birthYearMeta = const VerificationMeta(
    'birthYear',
  );
  @override
  late final GeneratedColumn<int> birthYear = GeneratedColumn<int>(
    'birth_year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    displayName,
    heightCm,
    weightKg,
    birthYear,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profile_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProfileRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('height_cm')) {
      context.handle(
        _heightCmMeta,
        heightCm.isAcceptableOrUnknown(data['height_cm']!, _heightCmMeta),
      );
    } else if (isInserting) {
      context.missing(_heightCmMeta);
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    } else if (isInserting) {
      context.missing(_weightKgMeta);
    }
    if (data.containsKey('birth_year')) {
      context.handle(
        _birthYearMeta,
        birthYear.isAcceptableOrUnknown(data['birth_year']!, _birthYearMeta),
      );
    } else if (isInserting) {
      context.missing(_birthYearMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProfileRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      heightCm: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}height_cm'],
      )!,
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      )!,
      birthYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}birth_year'],
      )!,
    );
  }

  @override
  $ProfileRowsTable createAlias(String alias) {
    return $ProfileRowsTable(attachedDatabase, alias);
  }
}

class ProfileRow extends DataClass implements Insertable<ProfileRow> {
  final int id;
  final String displayName;
  final int heightCm;
  final double weightKg;
  final int birthYear;
  const ProfileRow({
    required this.id,
    required this.displayName,
    required this.heightCm,
    required this.weightKg,
    required this.birthYear,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['display_name'] = Variable<String>(displayName);
    map['height_cm'] = Variable<int>(heightCm);
    map['weight_kg'] = Variable<double>(weightKg);
    map['birth_year'] = Variable<int>(birthYear);
    return map;
  }

  ProfileRowsCompanion toCompanion(bool nullToAbsent) {
    return ProfileRowsCompanion(
      id: Value(id),
      displayName: Value(displayName),
      heightCm: Value(heightCm),
      weightKg: Value(weightKg),
      birthYear: Value(birthYear),
    );
  }

  factory ProfileRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileRow(
      id: serializer.fromJson<int>(json['id']),
      displayName: serializer.fromJson<String>(json['displayName']),
      heightCm: serializer.fromJson<int>(json['heightCm']),
      weightKg: serializer.fromJson<double>(json['weightKg']),
      birthYear: serializer.fromJson<int>(json['birthYear']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'displayName': serializer.toJson<String>(displayName),
      'heightCm': serializer.toJson<int>(heightCm),
      'weightKg': serializer.toJson<double>(weightKg),
      'birthYear': serializer.toJson<int>(birthYear),
    };
  }

  ProfileRow copyWith({
    int? id,
    String? displayName,
    int? heightCm,
    double? weightKg,
    int? birthYear,
  }) => ProfileRow(
    id: id ?? this.id,
    displayName: displayName ?? this.displayName,
    heightCm: heightCm ?? this.heightCm,
    weightKg: weightKg ?? this.weightKg,
    birthYear: birthYear ?? this.birthYear,
  );
  ProfileRow copyWithCompanion(ProfileRowsCompanion data) {
    return ProfileRow(
      id: data.id.present ? data.id.value : this.id,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      heightCm: data.heightCm.present ? data.heightCm.value : this.heightCm,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      birthYear: data.birthYear.present ? data.birthYear.value : this.birthYear,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileRow(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('heightCm: $heightCm, ')
          ..write('weightKg: $weightKg, ')
          ..write('birthYear: $birthYear')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, displayName, heightCm, weightKg, birthYear);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileRow &&
          other.id == this.id &&
          other.displayName == this.displayName &&
          other.heightCm == this.heightCm &&
          other.weightKg == this.weightKg &&
          other.birthYear == this.birthYear);
}

class ProfileRowsCompanion extends UpdateCompanion<ProfileRow> {
  final Value<int> id;
  final Value<String> displayName;
  final Value<int> heightCm;
  final Value<double> weightKg;
  final Value<int> birthYear;
  const ProfileRowsCompanion({
    this.id = const Value.absent(),
    this.displayName = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.birthYear = const Value.absent(),
  });
  ProfileRowsCompanion.insert({
    this.id = const Value.absent(),
    required String displayName,
    required int heightCm,
    required double weightKg,
    required int birthYear,
  }) : displayName = Value(displayName),
       heightCm = Value(heightCm),
       weightKg = Value(weightKg),
       birthYear = Value(birthYear);
  static Insertable<ProfileRow> custom({
    Expression<int>? id,
    Expression<String>? displayName,
    Expression<int>? heightCm,
    Expression<double>? weightKg,
    Expression<int>? birthYear,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (displayName != null) 'display_name': displayName,
      if (heightCm != null) 'height_cm': heightCm,
      if (weightKg != null) 'weight_kg': weightKg,
      if (birthYear != null) 'birth_year': birthYear,
    });
  }

  ProfileRowsCompanion copyWith({
    Value<int>? id,
    Value<String>? displayName,
    Value<int>? heightCm,
    Value<double>? weightKg,
    Value<int>? birthYear,
  }) {
    return ProfileRowsCompanion(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      birthYear: birthYear ?? this.birthYear,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (heightCm.present) {
      map['height_cm'] = Variable<int>(heightCm.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (birthYear.present) {
      map['birth_year'] = Variable<int>(birthYear.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfileRowsCompanion(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('heightCm: $heightCm, ')
          ..write('weightKg: $weightKg, ')
          ..write('birthYear: $birthYear')
          ..write(')'))
        .toString();
  }
}

class $ProfileDraftRowsTable extends ProfileDraftRows
    with TableInfo<$ProfileDraftRowsTable, ProfileDraftRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfileDraftRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL CHECK (id = 1)',
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<String> height = GeneratedColumn<String>(
    'height',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<String> weight = GeneratedColumn<String>(
    'weight',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _birthYearMeta = const VerificationMeta(
    'birthYear',
  );
  @override
  late final GeneratedColumn<String> birthYear = GeneratedColumn<String>(
    'birth_year',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDisplayNamePresentMeta =
      const VerificationMeta('isDisplayNamePresent');
  @override
  late final GeneratedColumn<bool> isDisplayNamePresent = GeneratedColumn<bool>(
    'is_display_name_present',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_display_name_present" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isHeightPresentMeta = const VerificationMeta(
    'isHeightPresent',
  );
  @override
  late final GeneratedColumn<bool> isHeightPresent = GeneratedColumn<bool>(
    'is_height_present',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_height_present" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isWeightPresentMeta = const VerificationMeta(
    'isWeightPresent',
  );
  @override
  late final GeneratedColumn<bool> isWeightPresent = GeneratedColumn<bool>(
    'is_weight_present',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_weight_present" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isBirthYearPresentMeta =
      const VerificationMeta('isBirthYearPresent');
  @override
  late final GeneratedColumn<bool> isBirthYearPresent = GeneratedColumn<bool>(
    'is_birth_year_present',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_birth_year_present" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    displayName,
    height,
    weight,
    birthYear,
    isDisplayNamePresent,
    isHeightPresent,
    isWeightPresent,
    isBirthYearPresent,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profile_draft_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProfileDraftRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('height')) {
      context.handle(
        _heightMeta,
        height.isAcceptableOrUnknown(data['height']!, _heightMeta),
      );
    } else if (isInserting) {
      context.missing(_heightMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    if (data.containsKey('birth_year')) {
      context.handle(
        _birthYearMeta,
        birthYear.isAcceptableOrUnknown(data['birth_year']!, _birthYearMeta),
      );
    } else if (isInserting) {
      context.missing(_birthYearMeta);
    }
    if (data.containsKey('is_display_name_present')) {
      context.handle(
        _isDisplayNamePresentMeta,
        isDisplayNamePresent.isAcceptableOrUnknown(
          data['is_display_name_present']!,
          _isDisplayNamePresentMeta,
        ),
      );
    }
    if (data.containsKey('is_height_present')) {
      context.handle(
        _isHeightPresentMeta,
        isHeightPresent.isAcceptableOrUnknown(
          data['is_height_present']!,
          _isHeightPresentMeta,
        ),
      );
    }
    if (data.containsKey('is_weight_present')) {
      context.handle(
        _isWeightPresentMeta,
        isWeightPresent.isAcceptableOrUnknown(
          data['is_weight_present']!,
          _isWeightPresentMeta,
        ),
      );
    }
    if (data.containsKey('is_birth_year_present')) {
      context.handle(
        _isBirthYearPresentMeta,
        isBirthYearPresent.isAcceptableOrUnknown(
          data['is_birth_year_present']!,
          _isBirthYearPresentMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProfileDraftRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileDraftRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      height: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}height'],
      )!,
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}weight'],
      )!,
      birthYear: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}birth_year'],
      )!,
      isDisplayNamePresent: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_display_name_present'],
      )!,
      isHeightPresent: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_height_present'],
      )!,
      isWeightPresent: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_weight_present'],
      )!,
      isBirthYearPresent: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_birth_year_present'],
      )!,
    );
  }

  @override
  $ProfileDraftRowsTable createAlias(String alias) {
    return $ProfileDraftRowsTable(attachedDatabase, alias);
  }
}

class ProfileDraftRow extends DataClass implements Insertable<ProfileDraftRow> {
  final int id;
  final String displayName;
  final String height;
  final String weight;
  final String birthYear;
  final bool isDisplayNamePresent;
  final bool isHeightPresent;
  final bool isWeightPresent;
  final bool isBirthYearPresent;
  const ProfileDraftRow({
    required this.id,
    required this.displayName,
    required this.height,
    required this.weight,
    required this.birthYear,
    required this.isDisplayNamePresent,
    required this.isHeightPresent,
    required this.isWeightPresent,
    required this.isBirthYearPresent,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['display_name'] = Variable<String>(displayName);
    map['height'] = Variable<String>(height);
    map['weight'] = Variable<String>(weight);
    map['birth_year'] = Variable<String>(birthYear);
    map['is_display_name_present'] = Variable<bool>(isDisplayNamePresent);
    map['is_height_present'] = Variable<bool>(isHeightPresent);
    map['is_weight_present'] = Variable<bool>(isWeightPresent);
    map['is_birth_year_present'] = Variable<bool>(isBirthYearPresent);
    return map;
  }

  ProfileDraftRowsCompanion toCompanion(bool nullToAbsent) {
    return ProfileDraftRowsCompanion(
      id: Value(id),
      displayName: Value(displayName),
      height: Value(height),
      weight: Value(weight),
      birthYear: Value(birthYear),
      isDisplayNamePresent: Value(isDisplayNamePresent),
      isHeightPresent: Value(isHeightPresent),
      isWeightPresent: Value(isWeightPresent),
      isBirthYearPresent: Value(isBirthYearPresent),
    );
  }

  factory ProfileDraftRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileDraftRow(
      id: serializer.fromJson<int>(json['id']),
      displayName: serializer.fromJson<String>(json['displayName']),
      height: serializer.fromJson<String>(json['height']),
      weight: serializer.fromJson<String>(json['weight']),
      birthYear: serializer.fromJson<String>(json['birthYear']),
      isDisplayNamePresent: serializer.fromJson<bool>(
        json['isDisplayNamePresent'],
      ),
      isHeightPresent: serializer.fromJson<bool>(json['isHeightPresent']),
      isWeightPresent: serializer.fromJson<bool>(json['isWeightPresent']),
      isBirthYearPresent: serializer.fromJson<bool>(json['isBirthYearPresent']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'displayName': serializer.toJson<String>(displayName),
      'height': serializer.toJson<String>(height),
      'weight': serializer.toJson<String>(weight),
      'birthYear': serializer.toJson<String>(birthYear),
      'isDisplayNamePresent': serializer.toJson<bool>(isDisplayNamePresent),
      'isHeightPresent': serializer.toJson<bool>(isHeightPresent),
      'isWeightPresent': serializer.toJson<bool>(isWeightPresent),
      'isBirthYearPresent': serializer.toJson<bool>(isBirthYearPresent),
    };
  }

  ProfileDraftRow copyWith({
    int? id,
    String? displayName,
    String? height,
    String? weight,
    String? birthYear,
    bool? isDisplayNamePresent,
    bool? isHeightPresent,
    bool? isWeightPresent,
    bool? isBirthYearPresent,
  }) => ProfileDraftRow(
    id: id ?? this.id,
    displayName: displayName ?? this.displayName,
    height: height ?? this.height,
    weight: weight ?? this.weight,
    birthYear: birthYear ?? this.birthYear,
    isDisplayNamePresent: isDisplayNamePresent ?? this.isDisplayNamePresent,
    isHeightPresent: isHeightPresent ?? this.isHeightPresent,
    isWeightPresent: isWeightPresent ?? this.isWeightPresent,
    isBirthYearPresent: isBirthYearPresent ?? this.isBirthYearPresent,
  );
  ProfileDraftRow copyWithCompanion(ProfileDraftRowsCompanion data) {
    return ProfileDraftRow(
      id: data.id.present ? data.id.value : this.id,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      height: data.height.present ? data.height.value : this.height,
      weight: data.weight.present ? data.weight.value : this.weight,
      birthYear: data.birthYear.present ? data.birthYear.value : this.birthYear,
      isDisplayNamePresent: data.isDisplayNamePresent.present
          ? data.isDisplayNamePresent.value
          : this.isDisplayNamePresent,
      isHeightPresent: data.isHeightPresent.present
          ? data.isHeightPresent.value
          : this.isHeightPresent,
      isWeightPresent: data.isWeightPresent.present
          ? data.isWeightPresent.value
          : this.isWeightPresent,
      isBirthYearPresent: data.isBirthYearPresent.present
          ? data.isBirthYearPresent.value
          : this.isBirthYearPresent,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileDraftRow(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('height: $height, ')
          ..write('weight: $weight, ')
          ..write('birthYear: $birthYear, ')
          ..write('isDisplayNamePresent: $isDisplayNamePresent, ')
          ..write('isHeightPresent: $isHeightPresent, ')
          ..write('isWeightPresent: $isWeightPresent, ')
          ..write('isBirthYearPresent: $isBirthYearPresent')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    displayName,
    height,
    weight,
    birthYear,
    isDisplayNamePresent,
    isHeightPresent,
    isWeightPresent,
    isBirthYearPresent,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileDraftRow &&
          other.id == this.id &&
          other.displayName == this.displayName &&
          other.height == this.height &&
          other.weight == this.weight &&
          other.birthYear == this.birthYear &&
          other.isDisplayNamePresent == this.isDisplayNamePresent &&
          other.isHeightPresent == this.isHeightPresent &&
          other.isWeightPresent == this.isWeightPresent &&
          other.isBirthYearPresent == this.isBirthYearPresent);
}

class ProfileDraftRowsCompanion extends UpdateCompanion<ProfileDraftRow> {
  final Value<int> id;
  final Value<String> displayName;
  final Value<String> height;
  final Value<String> weight;
  final Value<String> birthYear;
  final Value<bool> isDisplayNamePresent;
  final Value<bool> isHeightPresent;
  final Value<bool> isWeightPresent;
  final Value<bool> isBirthYearPresent;
  const ProfileDraftRowsCompanion({
    this.id = const Value.absent(),
    this.displayName = const Value.absent(),
    this.height = const Value.absent(),
    this.weight = const Value.absent(),
    this.birthYear = const Value.absent(),
    this.isDisplayNamePresent = const Value.absent(),
    this.isHeightPresent = const Value.absent(),
    this.isWeightPresent = const Value.absent(),
    this.isBirthYearPresent = const Value.absent(),
  });
  ProfileDraftRowsCompanion.insert({
    this.id = const Value.absent(),
    required String displayName,
    required String height,
    required String weight,
    required String birthYear,
    this.isDisplayNamePresent = const Value.absent(),
    this.isHeightPresent = const Value.absent(),
    this.isWeightPresent = const Value.absent(),
    this.isBirthYearPresent = const Value.absent(),
  }) : displayName = Value(displayName),
       height = Value(height),
       weight = Value(weight),
       birthYear = Value(birthYear);
  static Insertable<ProfileDraftRow> custom({
    Expression<int>? id,
    Expression<String>? displayName,
    Expression<String>? height,
    Expression<String>? weight,
    Expression<String>? birthYear,
    Expression<bool>? isDisplayNamePresent,
    Expression<bool>? isHeightPresent,
    Expression<bool>? isWeightPresent,
    Expression<bool>? isBirthYearPresent,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (displayName != null) 'display_name': displayName,
      if (height != null) 'height': height,
      if (weight != null) 'weight': weight,
      if (birthYear != null) 'birth_year': birthYear,
      if (isDisplayNamePresent != null)
        'is_display_name_present': isDisplayNamePresent,
      if (isHeightPresent != null) 'is_height_present': isHeightPresent,
      if (isWeightPresent != null) 'is_weight_present': isWeightPresent,
      if (isBirthYearPresent != null)
        'is_birth_year_present': isBirthYearPresent,
    });
  }

  ProfileDraftRowsCompanion copyWith({
    Value<int>? id,
    Value<String>? displayName,
    Value<String>? height,
    Value<String>? weight,
    Value<String>? birthYear,
    Value<bool>? isDisplayNamePresent,
    Value<bool>? isHeightPresent,
    Value<bool>? isWeightPresent,
    Value<bool>? isBirthYearPresent,
  }) {
    return ProfileDraftRowsCompanion(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      birthYear: birthYear ?? this.birthYear,
      isDisplayNamePresent: isDisplayNamePresent ?? this.isDisplayNamePresent,
      isHeightPresent: isHeightPresent ?? this.isHeightPresent,
      isWeightPresent: isWeightPresent ?? this.isWeightPresent,
      isBirthYearPresent: isBirthYearPresent ?? this.isBirthYearPresent,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (height.present) {
      map['height'] = Variable<String>(height.value);
    }
    if (weight.present) {
      map['weight'] = Variable<String>(weight.value);
    }
    if (birthYear.present) {
      map['birth_year'] = Variable<String>(birthYear.value);
    }
    if (isDisplayNamePresent.present) {
      map['is_display_name_present'] = Variable<bool>(
        isDisplayNamePresent.value,
      );
    }
    if (isHeightPresent.present) {
      map['is_height_present'] = Variable<bool>(isHeightPresent.value);
    }
    if (isWeightPresent.present) {
      map['is_weight_present'] = Variable<bool>(isWeightPresent.value);
    }
    if (isBirthYearPresent.present) {
      map['is_birth_year_present'] = Variable<bool>(isBirthYearPresent.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfileDraftRowsCompanion(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('height: $height, ')
          ..write('weight: $weight, ')
          ..write('birthYear: $birthYear, ')
          ..write('isDisplayNamePresent: $isDisplayNamePresent, ')
          ..write('isHeightPresent: $isHeightPresent, ')
          ..write('isWeightPresent: $isWeightPresent, ')
          ..write('isBirthYearPresent: $isBirthYearPresent')
          ..write(')'))
        .toString();
  }
}

class $SettingsRowsTable extends SettingsRows
    with TableInfo<$SettingsRowsTable, SettingsRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL CHECK (id = 1)',
  );
  static const VerificationMeta _localeOverrideMeta = const VerificationMeta(
    'localeOverride',
  );
  @override
  late final GeneratedColumn<String> localeOverride = GeneratedColumn<String>(
    'locale_override',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('system'),
  );
  static const VerificationMeta _themeModeMeta = const VerificationMeta(
    'themeMode',
  );
  @override
  late final GeneratedColumn<String> themeMode = GeneratedColumn<String>(
    'theme_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('system'),
  );
  static const VerificationMeta _weeklyActiveDayTargetMeta =
      const VerificationMeta('weeklyActiveDayTarget');
  @override
  late final GeneratedColumn<int> weeklyActiveDayTarget = GeneratedColumn<int>(
    'weekly_active_day_target',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(3),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    localeOverride,
    themeMode,
    weeklyActiveDayTarget,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<SettingsRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('locale_override')) {
      context.handle(
        _localeOverrideMeta,
        localeOverride.isAcceptableOrUnknown(
          data['locale_override']!,
          _localeOverrideMeta,
        ),
      );
    }
    if (data.containsKey('theme_mode')) {
      context.handle(
        _themeModeMeta,
        themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta),
      );
    }
    if (data.containsKey('weekly_active_day_target')) {
      context.handle(
        _weeklyActiveDayTargetMeta,
        weeklyActiveDayTarget.isAcceptableOrUnknown(
          data['weekly_active_day_target']!,
          _weeklyActiveDayTargetMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SettingsRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingsRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      localeOverride: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}locale_override'],
      )!,
      themeMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_mode'],
      )!,
      weeklyActiveDayTarget: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weekly_active_day_target'],
      )!,
    );
  }

  @override
  $SettingsRowsTable createAlias(String alias) {
    return $SettingsRowsTable(attachedDatabase, alias);
  }
}

class SettingsRow extends DataClass implements Insertable<SettingsRow> {
  final int id;
  final String localeOverride;
  final String themeMode;
  final int weeklyActiveDayTarget;
  const SettingsRow({
    required this.id,
    required this.localeOverride,
    required this.themeMode,
    required this.weeklyActiveDayTarget,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['locale_override'] = Variable<String>(localeOverride);
    map['theme_mode'] = Variable<String>(themeMode);
    map['weekly_active_day_target'] = Variable<int>(weeklyActiveDayTarget);
    return map;
  }

  SettingsRowsCompanion toCompanion(bool nullToAbsent) {
    return SettingsRowsCompanion(
      id: Value(id),
      localeOverride: Value(localeOverride),
      themeMode: Value(themeMode),
      weeklyActiveDayTarget: Value(weeklyActiveDayTarget),
    );
  }

  factory SettingsRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingsRow(
      id: serializer.fromJson<int>(json['id']),
      localeOverride: serializer.fromJson<String>(json['localeOverride']),
      themeMode: serializer.fromJson<String>(json['themeMode']),
      weeklyActiveDayTarget: serializer.fromJson<int>(
        json['weeklyActiveDayTarget'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'localeOverride': serializer.toJson<String>(localeOverride),
      'themeMode': serializer.toJson<String>(themeMode),
      'weeklyActiveDayTarget': serializer.toJson<int>(weeklyActiveDayTarget),
    };
  }

  SettingsRow copyWith({
    int? id,
    String? localeOverride,
    String? themeMode,
    int? weeklyActiveDayTarget,
  }) => SettingsRow(
    id: id ?? this.id,
    localeOverride: localeOverride ?? this.localeOverride,
    themeMode: themeMode ?? this.themeMode,
    weeklyActiveDayTarget: weeklyActiveDayTarget ?? this.weeklyActiveDayTarget,
  );
  SettingsRow copyWithCompanion(SettingsRowsCompanion data) {
    return SettingsRow(
      id: data.id.present ? data.id.value : this.id,
      localeOverride: data.localeOverride.present
          ? data.localeOverride.value
          : this.localeOverride,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      weeklyActiveDayTarget: data.weeklyActiveDayTarget.present
          ? data.weeklyActiveDayTarget.value
          : this.weeklyActiveDayTarget,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SettingsRow(')
          ..write('id: $id, ')
          ..write('localeOverride: $localeOverride, ')
          ..write('themeMode: $themeMode, ')
          ..write('weeklyActiveDayTarget: $weeklyActiveDayTarget')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, localeOverride, themeMode, weeklyActiveDayTarget);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingsRow &&
          other.id == this.id &&
          other.localeOverride == this.localeOverride &&
          other.themeMode == this.themeMode &&
          other.weeklyActiveDayTarget == this.weeklyActiveDayTarget);
}

class SettingsRowsCompanion extends UpdateCompanion<SettingsRow> {
  final Value<int> id;
  final Value<String> localeOverride;
  final Value<String> themeMode;
  final Value<int> weeklyActiveDayTarget;
  const SettingsRowsCompanion({
    this.id = const Value.absent(),
    this.localeOverride = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.weeklyActiveDayTarget = const Value.absent(),
  });
  SettingsRowsCompanion.insert({
    this.id = const Value.absent(),
    this.localeOverride = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.weeklyActiveDayTarget = const Value.absent(),
  });
  static Insertable<SettingsRow> custom({
    Expression<int>? id,
    Expression<String>? localeOverride,
    Expression<String>? themeMode,
    Expression<int>? weeklyActiveDayTarget,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (localeOverride != null) 'locale_override': localeOverride,
      if (themeMode != null) 'theme_mode': themeMode,
      if (weeklyActiveDayTarget != null)
        'weekly_active_day_target': weeklyActiveDayTarget,
    });
  }

  SettingsRowsCompanion copyWith({
    Value<int>? id,
    Value<String>? localeOverride,
    Value<String>? themeMode,
    Value<int>? weeklyActiveDayTarget,
  }) {
    return SettingsRowsCompanion(
      id: id ?? this.id,
      localeOverride: localeOverride ?? this.localeOverride,
      themeMode: themeMode ?? this.themeMode,
      weeklyActiveDayTarget:
          weeklyActiveDayTarget ?? this.weeklyActiveDayTarget,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (localeOverride.present) {
      map['locale_override'] = Variable<String>(localeOverride.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(themeMode.value);
    }
    if (weeklyActiveDayTarget.present) {
      map['weekly_active_day_target'] = Variable<int>(
        weeklyActiveDayTarget.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsRowsCompanion(')
          ..write('id: $id, ')
          ..write('localeOverride: $localeOverride, ')
          ..write('themeMode: $themeMode, ')
          ..write('weeklyActiveDayTarget: $weeklyActiveDayTarget')
          ..write(')'))
        .toString();
  }
}

class $WalkingSessionRowsTable extends WalkingSessionRows
    with TableInfo<$WalkingSessionRowsTable, WalkingSessionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WalkingSessionRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
    'state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _inclusionMeta = const VerificationMeta(
    'inclusion',
  );
  @override
  late final GeneratedColumn<String> inclusion = GeneratedColumn<String>(
    'inclusion',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _revisionMeta = const VerificationMeta(
    'revision',
  );
  @override
  late final GeneratedColumn<int> revision = GeneratedColumn<int>(
    'revision',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentSegmentIdMeta = const VerificationMeta(
    'currentSegmentId',
  );
  @override
  late final GeneratedColumn<String> currentSegmentId = GeneratedColumn<String>(
    'current_segment_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _lastPointIdMeta = const VerificationMeta(
    'lastPointId',
  );
  @override
  late final GeneratedColumn<String> lastPointId = GeneratedColumn<String>(
    'last_point_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastObservedAtMeta = const VerificationMeta(
    'lastObservedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastObservedAt =
      GeneratedColumn<DateTime>(
        'last_observed_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastLatitudeMeta = const VerificationMeta(
    'lastLatitude',
  );
  @override
  late final GeneratedColumn<double> lastLatitude = GeneratedColumn<double>(
    'last_latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastLongitudeMeta = const VerificationMeta(
    'lastLongitude',
  );
  @override
  late final GeneratedColumn<double> lastLongitude = GeneratedColumn<double>(
    'last_longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastAccuracyMetersMeta =
      const VerificationMeta('lastAccuracyMeters');
  @override
  late final GeneratedColumn<double> lastAccuracyMeters =
      GeneratedColumn<double>(
        'last_accuracy_meters',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _recoveryBoundaryPointIdMeta =
      const VerificationMeta('recoveryBoundaryPointId');
  @override
  late final GeneratedColumn<String> recoveryBoundaryPointId =
      GeneratedColumn<String>(
        'recovery_boundary_point_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    startedAt,
    state,
    inclusion,
    revision,
    currentSegmentId,
    lastPointId,
    lastObservedAt,
    lastLatitude,
    lastLongitude,
    lastAccuracyMeters,
    recoveryBoundaryPointId,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'walking_session_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<WalkingSessionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
        _stateMeta,
        state.isAcceptableOrUnknown(data['state']!, _stateMeta),
      );
    } else if (isInserting) {
      context.missing(_stateMeta);
    }
    if (data.containsKey('inclusion')) {
      context.handle(
        _inclusionMeta,
        inclusion.isAcceptableOrUnknown(data['inclusion']!, _inclusionMeta),
      );
    } else if (isInserting) {
      context.missing(_inclusionMeta);
    }
    if (data.containsKey('revision')) {
      context.handle(
        _revisionMeta,
        revision.isAcceptableOrUnknown(data['revision']!, _revisionMeta),
      );
    } else if (isInserting) {
      context.missing(_revisionMeta);
    }
    if (data.containsKey('current_segment_id')) {
      context.handle(
        _currentSegmentIdMeta,
        currentSegmentId.isAcceptableOrUnknown(
          data['current_segment_id']!,
          _currentSegmentIdMeta,
        ),
      );
    }
    if (data.containsKey('last_point_id')) {
      context.handle(
        _lastPointIdMeta,
        lastPointId.isAcceptableOrUnknown(
          data['last_point_id']!,
          _lastPointIdMeta,
        ),
      );
    }
    if (data.containsKey('last_observed_at')) {
      context.handle(
        _lastObservedAtMeta,
        lastObservedAt.isAcceptableOrUnknown(
          data['last_observed_at']!,
          _lastObservedAtMeta,
        ),
      );
    }
    if (data.containsKey('last_latitude')) {
      context.handle(
        _lastLatitudeMeta,
        lastLatitude.isAcceptableOrUnknown(
          data['last_latitude']!,
          _lastLatitudeMeta,
        ),
      );
    }
    if (data.containsKey('last_longitude')) {
      context.handle(
        _lastLongitudeMeta,
        lastLongitude.isAcceptableOrUnknown(
          data['last_longitude']!,
          _lastLongitudeMeta,
        ),
      );
    }
    if (data.containsKey('last_accuracy_meters')) {
      context.handle(
        _lastAccuracyMetersMeta,
        lastAccuracyMeters.isAcceptableOrUnknown(
          data['last_accuracy_meters']!,
          _lastAccuracyMetersMeta,
        ),
      );
    }
    if (data.containsKey('recovery_boundary_point_id')) {
      context.handle(
        _recoveryBoundaryPointIdMeta,
        recoveryBoundaryPointId.isAcceptableOrUnknown(
          data['recovery_boundary_point_id']!,
          _recoveryBoundaryPointIdMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WalkingSessionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WalkingSessionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      state: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state'],
      )!,
      inclusion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}inclusion'],
      )!,
      revision: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}revision'],
      )!,
      currentSegmentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}current_segment_id'],
      )!,
      lastPointId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_point_id'],
      ),
      lastObservedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_observed_at'],
      ),
      lastLatitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}last_latitude'],
      ),
      lastLongitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}last_longitude'],
      ),
      lastAccuracyMeters: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}last_accuracy_meters'],
      ),
      recoveryBoundaryPointId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recovery_boundary_point_id'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $WalkingSessionRowsTable createAlias(String alias) {
    return $WalkingSessionRowsTable(attachedDatabase, alias);
  }
}

class WalkingSessionRow extends DataClass
    implements Insertable<WalkingSessionRow> {
  final String id;
  final DateTime startedAt;
  final String state;
  final String inclusion;
  final int revision;
  final String currentSegmentId;
  final String? lastPointId;
  final DateTime? lastObservedAt;
  final double? lastLatitude;
  final double? lastLongitude;
  final double? lastAccuracyMeters;
  final String? recoveryBoundaryPointId;
  final DateTime updatedAt;
  const WalkingSessionRow({
    required this.id,
    required this.startedAt,
    required this.state,
    required this.inclusion,
    required this.revision,
    required this.currentSegmentId,
    this.lastPointId,
    this.lastObservedAt,
    this.lastLatitude,
    this.lastLongitude,
    this.lastAccuracyMeters,
    this.recoveryBoundaryPointId,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['started_at'] = Variable<DateTime>(startedAt);
    map['state'] = Variable<String>(state);
    map['inclusion'] = Variable<String>(inclusion);
    map['revision'] = Variable<int>(revision);
    map['current_segment_id'] = Variable<String>(currentSegmentId);
    if (!nullToAbsent || lastPointId != null) {
      map['last_point_id'] = Variable<String>(lastPointId);
    }
    if (!nullToAbsent || lastObservedAt != null) {
      map['last_observed_at'] = Variable<DateTime>(lastObservedAt);
    }
    if (!nullToAbsent || lastLatitude != null) {
      map['last_latitude'] = Variable<double>(lastLatitude);
    }
    if (!nullToAbsent || lastLongitude != null) {
      map['last_longitude'] = Variable<double>(lastLongitude);
    }
    if (!nullToAbsent || lastAccuracyMeters != null) {
      map['last_accuracy_meters'] = Variable<double>(lastAccuracyMeters);
    }
    if (!nullToAbsent || recoveryBoundaryPointId != null) {
      map['recovery_boundary_point_id'] = Variable<String>(
        recoveryBoundaryPointId,
      );
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  WalkingSessionRowsCompanion toCompanion(bool nullToAbsent) {
    return WalkingSessionRowsCompanion(
      id: Value(id),
      startedAt: Value(startedAt),
      state: Value(state),
      inclusion: Value(inclusion),
      revision: Value(revision),
      currentSegmentId: Value(currentSegmentId),
      lastPointId: lastPointId == null && nullToAbsent
          ? const Value.absent()
          : Value(lastPointId),
      lastObservedAt: lastObservedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastObservedAt),
      lastLatitude: lastLatitude == null && nullToAbsent
          ? const Value.absent()
          : Value(lastLatitude),
      lastLongitude: lastLongitude == null && nullToAbsent
          ? const Value.absent()
          : Value(lastLongitude),
      lastAccuracyMeters: lastAccuracyMeters == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAccuracyMeters),
      recoveryBoundaryPointId: recoveryBoundaryPointId == null && nullToAbsent
          ? const Value.absent()
          : Value(recoveryBoundaryPointId),
      updatedAt: Value(updatedAt),
    );
  }

  factory WalkingSessionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WalkingSessionRow(
      id: serializer.fromJson<String>(json['id']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      state: serializer.fromJson<String>(json['state']),
      inclusion: serializer.fromJson<String>(json['inclusion']),
      revision: serializer.fromJson<int>(json['revision']),
      currentSegmentId: serializer.fromJson<String>(json['currentSegmentId']),
      lastPointId: serializer.fromJson<String?>(json['lastPointId']),
      lastObservedAt: serializer.fromJson<DateTime?>(json['lastObservedAt']),
      lastLatitude: serializer.fromJson<double?>(json['lastLatitude']),
      lastLongitude: serializer.fromJson<double?>(json['lastLongitude']),
      lastAccuracyMeters: serializer.fromJson<double?>(
        json['lastAccuracyMeters'],
      ),
      recoveryBoundaryPointId: serializer.fromJson<String?>(
        json['recoveryBoundaryPointId'],
      ),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'state': serializer.toJson<String>(state),
      'inclusion': serializer.toJson<String>(inclusion),
      'revision': serializer.toJson<int>(revision),
      'currentSegmentId': serializer.toJson<String>(currentSegmentId),
      'lastPointId': serializer.toJson<String?>(lastPointId),
      'lastObservedAt': serializer.toJson<DateTime?>(lastObservedAt),
      'lastLatitude': serializer.toJson<double?>(lastLatitude),
      'lastLongitude': serializer.toJson<double?>(lastLongitude),
      'lastAccuracyMeters': serializer.toJson<double?>(lastAccuracyMeters),
      'recoveryBoundaryPointId': serializer.toJson<String?>(
        recoveryBoundaryPointId,
      ),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  WalkingSessionRow copyWith({
    String? id,
    DateTime? startedAt,
    String? state,
    String? inclusion,
    int? revision,
    String? currentSegmentId,
    Value<String?> lastPointId = const Value.absent(),
    Value<DateTime?> lastObservedAt = const Value.absent(),
    Value<double?> lastLatitude = const Value.absent(),
    Value<double?> lastLongitude = const Value.absent(),
    Value<double?> lastAccuracyMeters = const Value.absent(),
    Value<String?> recoveryBoundaryPointId = const Value.absent(),
    DateTime? updatedAt,
  }) => WalkingSessionRow(
    id: id ?? this.id,
    startedAt: startedAt ?? this.startedAt,
    state: state ?? this.state,
    inclusion: inclusion ?? this.inclusion,
    revision: revision ?? this.revision,
    currentSegmentId: currentSegmentId ?? this.currentSegmentId,
    lastPointId: lastPointId.present ? lastPointId.value : this.lastPointId,
    lastObservedAt: lastObservedAt.present
        ? lastObservedAt.value
        : this.lastObservedAt,
    lastLatitude: lastLatitude.present ? lastLatitude.value : this.lastLatitude,
    lastLongitude: lastLongitude.present
        ? lastLongitude.value
        : this.lastLongitude,
    lastAccuracyMeters: lastAccuracyMeters.present
        ? lastAccuracyMeters.value
        : this.lastAccuracyMeters,
    recoveryBoundaryPointId: recoveryBoundaryPointId.present
        ? recoveryBoundaryPointId.value
        : this.recoveryBoundaryPointId,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  WalkingSessionRow copyWithCompanion(WalkingSessionRowsCompanion data) {
    return WalkingSessionRow(
      id: data.id.present ? data.id.value : this.id,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      state: data.state.present ? data.state.value : this.state,
      inclusion: data.inclusion.present ? data.inclusion.value : this.inclusion,
      revision: data.revision.present ? data.revision.value : this.revision,
      currentSegmentId: data.currentSegmentId.present
          ? data.currentSegmentId.value
          : this.currentSegmentId,
      lastPointId: data.lastPointId.present
          ? data.lastPointId.value
          : this.lastPointId,
      lastObservedAt: data.lastObservedAt.present
          ? data.lastObservedAt.value
          : this.lastObservedAt,
      lastLatitude: data.lastLatitude.present
          ? data.lastLatitude.value
          : this.lastLatitude,
      lastLongitude: data.lastLongitude.present
          ? data.lastLongitude.value
          : this.lastLongitude,
      lastAccuracyMeters: data.lastAccuracyMeters.present
          ? data.lastAccuracyMeters.value
          : this.lastAccuracyMeters,
      recoveryBoundaryPointId: data.recoveryBoundaryPointId.present
          ? data.recoveryBoundaryPointId.value
          : this.recoveryBoundaryPointId,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WalkingSessionRow(')
          ..write('id: $id, ')
          ..write('startedAt: $startedAt, ')
          ..write('state: $state, ')
          ..write('inclusion: $inclusion, ')
          ..write('revision: $revision, ')
          ..write('currentSegmentId: $currentSegmentId, ')
          ..write('lastPointId: $lastPointId, ')
          ..write('lastObservedAt: $lastObservedAt, ')
          ..write('lastLatitude: $lastLatitude, ')
          ..write('lastLongitude: $lastLongitude, ')
          ..write('lastAccuracyMeters: $lastAccuracyMeters, ')
          ..write('recoveryBoundaryPointId: $recoveryBoundaryPointId, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    startedAt,
    state,
    inclusion,
    revision,
    currentSegmentId,
    lastPointId,
    lastObservedAt,
    lastLatitude,
    lastLongitude,
    lastAccuracyMeters,
    recoveryBoundaryPointId,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WalkingSessionRow &&
          other.id == this.id &&
          other.startedAt == this.startedAt &&
          other.state == this.state &&
          other.inclusion == this.inclusion &&
          other.revision == this.revision &&
          other.currentSegmentId == this.currentSegmentId &&
          other.lastPointId == this.lastPointId &&
          other.lastObservedAt == this.lastObservedAt &&
          other.lastLatitude == this.lastLatitude &&
          other.lastLongitude == this.lastLongitude &&
          other.lastAccuracyMeters == this.lastAccuracyMeters &&
          other.recoveryBoundaryPointId == this.recoveryBoundaryPointId &&
          other.updatedAt == this.updatedAt);
}

class WalkingSessionRowsCompanion extends UpdateCompanion<WalkingSessionRow> {
  final Value<String> id;
  final Value<DateTime> startedAt;
  final Value<String> state;
  final Value<String> inclusion;
  final Value<int> revision;
  final Value<String> currentSegmentId;
  final Value<String?> lastPointId;
  final Value<DateTime?> lastObservedAt;
  final Value<double?> lastLatitude;
  final Value<double?> lastLongitude;
  final Value<double?> lastAccuracyMeters;
  final Value<String?> recoveryBoundaryPointId;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const WalkingSessionRowsCompanion({
    this.id = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.state = const Value.absent(),
    this.inclusion = const Value.absent(),
    this.revision = const Value.absent(),
    this.currentSegmentId = const Value.absent(),
    this.lastPointId = const Value.absent(),
    this.lastObservedAt = const Value.absent(),
    this.lastLatitude = const Value.absent(),
    this.lastLongitude = const Value.absent(),
    this.lastAccuracyMeters = const Value.absent(),
    this.recoveryBoundaryPointId = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WalkingSessionRowsCompanion.insert({
    required String id,
    required DateTime startedAt,
    required String state,
    required String inclusion,
    required int revision,
    this.currentSegmentId = const Value.absent(),
    this.lastPointId = const Value.absent(),
    this.lastObservedAt = const Value.absent(),
    this.lastLatitude = const Value.absent(),
    this.lastLongitude = const Value.absent(),
    this.lastAccuracyMeters = const Value.absent(),
    this.recoveryBoundaryPointId = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       startedAt = Value(startedAt),
       state = Value(state),
       inclusion = Value(inclusion),
       revision = Value(revision);
  static Insertable<WalkingSessionRow> custom({
    Expression<String>? id,
    Expression<DateTime>? startedAt,
    Expression<String>? state,
    Expression<String>? inclusion,
    Expression<int>? revision,
    Expression<String>? currentSegmentId,
    Expression<String>? lastPointId,
    Expression<DateTime>? lastObservedAt,
    Expression<double>? lastLatitude,
    Expression<double>? lastLongitude,
    Expression<double>? lastAccuracyMeters,
    Expression<String>? recoveryBoundaryPointId,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startedAt != null) 'started_at': startedAt,
      if (state != null) 'state': state,
      if (inclusion != null) 'inclusion': inclusion,
      if (revision != null) 'revision': revision,
      if (currentSegmentId != null) 'current_segment_id': currentSegmentId,
      if (lastPointId != null) 'last_point_id': lastPointId,
      if (lastObservedAt != null) 'last_observed_at': lastObservedAt,
      if (lastLatitude != null) 'last_latitude': lastLatitude,
      if (lastLongitude != null) 'last_longitude': lastLongitude,
      if (lastAccuracyMeters != null)
        'last_accuracy_meters': lastAccuracyMeters,
      if (recoveryBoundaryPointId != null)
        'recovery_boundary_point_id': recoveryBoundaryPointId,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WalkingSessionRowsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? startedAt,
    Value<String>? state,
    Value<String>? inclusion,
    Value<int>? revision,
    Value<String>? currentSegmentId,
    Value<String?>? lastPointId,
    Value<DateTime?>? lastObservedAt,
    Value<double?>? lastLatitude,
    Value<double?>? lastLongitude,
    Value<double?>? lastAccuracyMeters,
    Value<String?>? recoveryBoundaryPointId,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return WalkingSessionRowsCompanion(
      id: id ?? this.id,
      startedAt: startedAt ?? this.startedAt,
      state: state ?? this.state,
      inclusion: inclusion ?? this.inclusion,
      revision: revision ?? this.revision,
      currentSegmentId: currentSegmentId ?? this.currentSegmentId,
      lastPointId: lastPointId ?? this.lastPointId,
      lastObservedAt: lastObservedAt ?? this.lastObservedAt,
      lastLatitude: lastLatitude ?? this.lastLatitude,
      lastLongitude: lastLongitude ?? this.lastLongitude,
      lastAccuracyMeters: lastAccuracyMeters ?? this.lastAccuracyMeters,
      recoveryBoundaryPointId:
          recoveryBoundaryPointId ?? this.recoveryBoundaryPointId,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (inclusion.present) {
      map['inclusion'] = Variable<String>(inclusion.value);
    }
    if (revision.present) {
      map['revision'] = Variable<int>(revision.value);
    }
    if (currentSegmentId.present) {
      map['current_segment_id'] = Variable<String>(currentSegmentId.value);
    }
    if (lastPointId.present) {
      map['last_point_id'] = Variable<String>(lastPointId.value);
    }
    if (lastObservedAt.present) {
      map['last_observed_at'] = Variable<DateTime>(lastObservedAt.value);
    }
    if (lastLatitude.present) {
      map['last_latitude'] = Variable<double>(lastLatitude.value);
    }
    if (lastLongitude.present) {
      map['last_longitude'] = Variable<double>(lastLongitude.value);
    }
    if (lastAccuracyMeters.present) {
      map['last_accuracy_meters'] = Variable<double>(lastAccuracyMeters.value);
    }
    if (recoveryBoundaryPointId.present) {
      map['recovery_boundary_point_id'] = Variable<String>(
        recoveryBoundaryPointId.value,
      );
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WalkingSessionRowsCompanion(')
          ..write('id: $id, ')
          ..write('startedAt: $startedAt, ')
          ..write('state: $state, ')
          ..write('inclusion: $inclusion, ')
          ..write('revision: $revision, ')
          ..write('currentSegmentId: $currentSegmentId, ')
          ..write('lastPointId: $lastPointId, ')
          ..write('lastObservedAt: $lastObservedAt, ')
          ..write('lastLatitude: $lastLatitude, ')
          ..write('lastLongitude: $lastLongitude, ')
          ..write('lastAccuracyMeters: $lastAccuracyMeters, ')
          ..write('recoveryBoundaryPointId: $recoveryBoundaryPointId, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WalkingSegmentRowsTable extends WalkingSegmentRows
    with TableInfo<$WalkingSegmentRowsTable, WalkingSegmentRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WalkingSegmentRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, sessionId, startedAt, endedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'walking_segment_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<WalkingSegmentRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WalkingSegmentRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WalkingSegmentRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      ),
    );
  }

  @override
  $WalkingSegmentRowsTable createAlias(String alias) {
    return $WalkingSegmentRowsTable(attachedDatabase, alias);
  }
}

class WalkingSegmentRow extends DataClass
    implements Insertable<WalkingSegmentRow> {
  final String id;
  final String sessionId;
  final DateTime startedAt;
  final DateTime? endedAt;
  const WalkingSegmentRow({
    required this.id,
    required this.sessionId,
    required this.startedAt,
    this.endedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    return map;
  }

  WalkingSegmentRowsCompanion toCompanion(bool nullToAbsent) {
    return WalkingSegmentRowsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      startedAt: Value(startedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
    );
  }

  factory WalkingSegmentRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WalkingSegmentRow(
      id: serializer.fromJson<String>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
    };
  }

  WalkingSegmentRow copyWith({
    String? id,
    String? sessionId,
    DateTime? startedAt,
    Value<DateTime?> endedAt = const Value.absent(),
  }) => WalkingSegmentRow(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
  );
  WalkingSegmentRow copyWithCompanion(WalkingSegmentRowsCompanion data) {
    return WalkingSegmentRow(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WalkingSegmentRow(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sessionId, startedAt, endedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WalkingSegmentRow &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt);
}

class WalkingSegmentRowsCompanion extends UpdateCompanion<WalkingSegmentRow> {
  final Value<String> id;
  final Value<String> sessionId;
  final Value<DateTime> startedAt;
  final Value<DateTime?> endedAt;
  final Value<int> rowid;
  const WalkingSegmentRowsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WalkingSegmentRowsCompanion.insert({
    required String id,
    required String sessionId,
    required DateTime startedAt,
    this.endedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sessionId = Value(sessionId),
       startedAt = Value(startedAt);
  static Insertable<WalkingSegmentRow> custom({
    Expression<String>? id,
    Expression<String>? sessionId,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WalkingSegmentRowsCompanion copyWith({
    Value<String>? id,
    Value<String>? sessionId,
    Value<DateTime>? startedAt,
    Value<DateTime?>? endedAt,
    Value<int>? rowid,
  }) {
    return WalkingSegmentRowsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WalkingSegmentRowsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WalkingPointRowsTable extends WalkingPointRows
    with TableInfo<$WalkingPointRowsTable, WalkingPointRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WalkingPointRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _segmentIdMeta = const VerificationMeta(
    'segmentId',
  );
  @override
  late final GeneratedColumn<String> segmentId = GeneratedColumn<String>(
    'segment_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _observedAtMeta = const VerificationMeta(
    'observedAt',
  );
  @override
  late final GeneratedColumn<DateTime> observedAt = GeneratedColumn<DateTime>(
    'observed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accuracyMetersMeta = const VerificationMeta(
    'accuracyMeters',
  );
  @override
  late final GeneratedColumn<double> accuracyMeters = GeneratedColumn<double>(
    'accuracy_meters',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    segmentId,
    observedAt,
    latitude,
    longitude,
    accuracyMeters,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'walking_point_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<WalkingPointRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('segment_id')) {
      context.handle(
        _segmentIdMeta,
        segmentId.isAcceptableOrUnknown(data['segment_id']!, _segmentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_segmentIdMeta);
    }
    if (data.containsKey('observed_at')) {
      context.handle(
        _observedAtMeta,
        observedAt.isAcceptableOrUnknown(data['observed_at']!, _observedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_observedAtMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('accuracy_meters')) {
      context.handle(
        _accuracyMetersMeta,
        accuracyMeters.isAcceptableOrUnknown(
          data['accuracy_meters']!,
          _accuracyMetersMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_accuracyMetersMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {sessionId, id};
  @override
  WalkingPointRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WalkingPointRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      segmentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}segment_id'],
      )!,
      observedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}observed_at'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      )!,
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      )!,
      accuracyMeters: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}accuracy_meters'],
      )!,
    );
  }

  @override
  $WalkingPointRowsTable createAlias(String alias) {
    return $WalkingPointRowsTable(attachedDatabase, alias);
  }
}

class WalkingPointRow extends DataClass implements Insertable<WalkingPointRow> {
  final String id;
  final String sessionId;
  final String segmentId;
  final DateTime observedAt;
  final double latitude;
  final double longitude;
  final double accuracyMeters;
  const WalkingPointRow({
    required this.id,
    required this.sessionId,
    required this.segmentId,
    required this.observedAt,
    required this.latitude,
    required this.longitude,
    required this.accuracyMeters,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['segment_id'] = Variable<String>(segmentId);
    map['observed_at'] = Variable<DateTime>(observedAt);
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    map['accuracy_meters'] = Variable<double>(accuracyMeters);
    return map;
  }

  WalkingPointRowsCompanion toCompanion(bool nullToAbsent) {
    return WalkingPointRowsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      segmentId: Value(segmentId),
      observedAt: Value(observedAt),
      latitude: Value(latitude),
      longitude: Value(longitude),
      accuracyMeters: Value(accuracyMeters),
    );
  }

  factory WalkingPointRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WalkingPointRow(
      id: serializer.fromJson<String>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      segmentId: serializer.fromJson<String>(json['segmentId']),
      observedAt: serializer.fromJson<DateTime>(json['observedAt']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      accuracyMeters: serializer.fromJson<double>(json['accuracyMeters']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'segmentId': serializer.toJson<String>(segmentId),
      'observedAt': serializer.toJson<DateTime>(observedAt),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'accuracyMeters': serializer.toJson<double>(accuracyMeters),
    };
  }

  WalkingPointRow copyWith({
    String? id,
    String? sessionId,
    String? segmentId,
    DateTime? observedAt,
    double? latitude,
    double? longitude,
    double? accuracyMeters,
  }) => WalkingPointRow(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    segmentId: segmentId ?? this.segmentId,
    observedAt: observedAt ?? this.observedAt,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    accuracyMeters: accuracyMeters ?? this.accuracyMeters,
  );
  WalkingPointRow copyWithCompanion(WalkingPointRowsCompanion data) {
    return WalkingPointRow(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      segmentId: data.segmentId.present ? data.segmentId.value : this.segmentId,
      observedAt: data.observedAt.present
          ? data.observedAt.value
          : this.observedAt,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      accuracyMeters: data.accuracyMeters.present
          ? data.accuracyMeters.value
          : this.accuracyMeters,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WalkingPointRow(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('segmentId: $segmentId, ')
          ..write('observedAt: $observedAt, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('accuracyMeters: $accuracyMeters')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sessionId,
    segmentId,
    observedAt,
    latitude,
    longitude,
    accuracyMeters,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WalkingPointRow &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.segmentId == this.segmentId &&
          other.observedAt == this.observedAt &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.accuracyMeters == this.accuracyMeters);
}

class WalkingPointRowsCompanion extends UpdateCompanion<WalkingPointRow> {
  final Value<String> id;
  final Value<String> sessionId;
  final Value<String> segmentId;
  final Value<DateTime> observedAt;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<double> accuracyMeters;
  final Value<int> rowid;
  const WalkingPointRowsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.segmentId = const Value.absent(),
    this.observedAt = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.accuracyMeters = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WalkingPointRowsCompanion.insert({
    required String id,
    required String sessionId,
    required String segmentId,
    required DateTime observedAt,
    required double latitude,
    required double longitude,
    required double accuracyMeters,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sessionId = Value(sessionId),
       segmentId = Value(segmentId),
       observedAt = Value(observedAt),
       latitude = Value(latitude),
       longitude = Value(longitude),
       accuracyMeters = Value(accuracyMeters);
  static Insertable<WalkingPointRow> custom({
    Expression<String>? id,
    Expression<String>? sessionId,
    Expression<String>? segmentId,
    Expression<DateTime>? observedAt,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<double>? accuracyMeters,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (segmentId != null) 'segment_id': segmentId,
      if (observedAt != null) 'observed_at': observedAt,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (accuracyMeters != null) 'accuracy_meters': accuracyMeters,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WalkingPointRowsCompanion copyWith({
    Value<String>? id,
    Value<String>? sessionId,
    Value<String>? segmentId,
    Value<DateTime>? observedAt,
    Value<double>? latitude,
    Value<double>? longitude,
    Value<double>? accuracyMeters,
    Value<int>? rowid,
  }) {
    return WalkingPointRowsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      segmentId: segmentId ?? this.segmentId,
      observedAt: observedAt ?? this.observedAt,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      accuracyMeters: accuracyMeters ?? this.accuracyMeters,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (segmentId.present) {
      map['segment_id'] = Variable<String>(segmentId.value);
    }
    if (observedAt.present) {
      map['observed_at'] = Variable<DateTime>(observedAt.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (accuracyMeters.present) {
      map['accuracy_meters'] = Variable<double>(accuracyMeters.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WalkingPointRowsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('segmentId: $segmentId, ')
          ..write('observedAt: $observedAt, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('accuracyMeters: $accuracyMeters, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProfileRowsTable profileRows = $ProfileRowsTable(this);
  late final $ProfileDraftRowsTable profileDraftRows = $ProfileDraftRowsTable(
    this,
  );
  late final $SettingsRowsTable settingsRows = $SettingsRowsTable(this);
  late final $WalkingSessionRowsTable walkingSessionRows =
      $WalkingSessionRowsTable(this);
  late final $WalkingSegmentRowsTable walkingSegmentRows =
      $WalkingSegmentRowsTable(this);
  late final $WalkingPointRowsTable walkingPointRows = $WalkingPointRowsTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    profileRows,
    profileDraftRows,
    settingsRows,
    walkingSessionRows,
    walkingSegmentRows,
    walkingPointRows,
  ];
}

typedef $$ProfileRowsTableCreateCompanionBuilder =
    ProfileRowsCompanion Function({
      Value<int> id,
      required String displayName,
      required int heightCm,
      required double weightKg,
      required int birthYear,
    });
typedef $$ProfileRowsTableUpdateCompanionBuilder =
    ProfileRowsCompanion Function({
      Value<int> id,
      Value<String> displayName,
      Value<int> heightCm,
      Value<double> weightKg,
      Value<int> birthYear,
    });

class $$ProfileRowsTableFilterComposer
    extends Composer<_$AppDatabase, $ProfileRowsTable> {
  $$ProfileRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get birthYear => $composableBuilder(
    column: $table.birthYear,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProfileRowsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProfileRowsTable> {
  $$ProfileRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get birthYear => $composableBuilder(
    column: $table.birthYear,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProfileRowsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProfileRowsTable> {
  $$ProfileRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get heightCm =>
      $composableBuilder(column: $table.heightCm, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<int> get birthYear =>
      $composableBuilder(column: $table.birthYear, builder: (column) => column);
}

class $$ProfileRowsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProfileRowsTable,
          ProfileRow,
          $$ProfileRowsTableFilterComposer,
          $$ProfileRowsTableOrderingComposer,
          $$ProfileRowsTableAnnotationComposer,
          $$ProfileRowsTableCreateCompanionBuilder,
          $$ProfileRowsTableUpdateCompanionBuilder,
          (
            ProfileRow,
            BaseReferences<_$AppDatabase, $ProfileRowsTable, ProfileRow>,
          ),
          ProfileRow,
          PrefetchHooks Function()
        > {
  $$ProfileRowsTableTableManager(_$AppDatabase db, $ProfileRowsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfileRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfileRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfileRowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<int> heightCm = const Value.absent(),
                Value<double> weightKg = const Value.absent(),
                Value<int> birthYear = const Value.absent(),
              }) => ProfileRowsCompanion(
                id: id,
                displayName: displayName,
                heightCm: heightCm,
                weightKg: weightKg,
                birthYear: birthYear,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String displayName,
                required int heightCm,
                required double weightKg,
                required int birthYear,
              }) => ProfileRowsCompanion.insert(
                id: id,
                displayName: displayName,
                heightCm: heightCm,
                weightKg: weightKg,
                birthYear: birthYear,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProfileRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProfileRowsTable,
      ProfileRow,
      $$ProfileRowsTableFilterComposer,
      $$ProfileRowsTableOrderingComposer,
      $$ProfileRowsTableAnnotationComposer,
      $$ProfileRowsTableCreateCompanionBuilder,
      $$ProfileRowsTableUpdateCompanionBuilder,
      (
        ProfileRow,
        BaseReferences<_$AppDatabase, $ProfileRowsTable, ProfileRow>,
      ),
      ProfileRow,
      PrefetchHooks Function()
    >;
typedef $$ProfileDraftRowsTableCreateCompanionBuilder =
    ProfileDraftRowsCompanion Function({
      Value<int> id,
      required String displayName,
      required String height,
      required String weight,
      required String birthYear,
      Value<bool> isDisplayNamePresent,
      Value<bool> isHeightPresent,
      Value<bool> isWeightPresent,
      Value<bool> isBirthYearPresent,
    });
typedef $$ProfileDraftRowsTableUpdateCompanionBuilder =
    ProfileDraftRowsCompanion Function({
      Value<int> id,
      Value<String> displayName,
      Value<String> height,
      Value<String> weight,
      Value<String> birthYear,
      Value<bool> isDisplayNamePresent,
      Value<bool> isHeightPresent,
      Value<bool> isWeightPresent,
      Value<bool> isBirthYearPresent,
    });

class $$ProfileDraftRowsTableFilterComposer
    extends Composer<_$AppDatabase, $ProfileDraftRowsTable> {
  $$ProfileDraftRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get birthYear => $composableBuilder(
    column: $table.birthYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDisplayNamePresent => $composableBuilder(
    column: $table.isDisplayNamePresent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isHeightPresent => $composableBuilder(
    column: $table.isHeightPresent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isWeightPresent => $composableBuilder(
    column: $table.isWeightPresent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBirthYearPresent => $composableBuilder(
    column: $table.isBirthYearPresent,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProfileDraftRowsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProfileDraftRowsTable> {
  $$ProfileDraftRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get birthYear => $composableBuilder(
    column: $table.birthYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDisplayNamePresent => $composableBuilder(
    column: $table.isDisplayNamePresent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isHeightPresent => $composableBuilder(
    column: $table.isHeightPresent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isWeightPresent => $composableBuilder(
    column: $table.isWeightPresent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBirthYearPresent => $composableBuilder(
    column: $table.isBirthYearPresent,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProfileDraftRowsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProfileDraftRowsTable> {
  $$ProfileDraftRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<String> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<String> get birthYear =>
      $composableBuilder(column: $table.birthYear, builder: (column) => column);

  GeneratedColumn<bool> get isDisplayNamePresent => $composableBuilder(
    column: $table.isDisplayNamePresent,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isHeightPresent => $composableBuilder(
    column: $table.isHeightPresent,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isWeightPresent => $composableBuilder(
    column: $table.isWeightPresent,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isBirthYearPresent => $composableBuilder(
    column: $table.isBirthYearPresent,
    builder: (column) => column,
  );
}

class $$ProfileDraftRowsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProfileDraftRowsTable,
          ProfileDraftRow,
          $$ProfileDraftRowsTableFilterComposer,
          $$ProfileDraftRowsTableOrderingComposer,
          $$ProfileDraftRowsTableAnnotationComposer,
          $$ProfileDraftRowsTableCreateCompanionBuilder,
          $$ProfileDraftRowsTableUpdateCompanionBuilder,
          (
            ProfileDraftRow,
            BaseReferences<
              _$AppDatabase,
              $ProfileDraftRowsTable,
              ProfileDraftRow
            >,
          ),
          ProfileDraftRow,
          PrefetchHooks Function()
        > {
  $$ProfileDraftRowsTableTableManager(
    _$AppDatabase db,
    $ProfileDraftRowsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfileDraftRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfileDraftRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfileDraftRowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String> height = const Value.absent(),
                Value<String> weight = const Value.absent(),
                Value<String> birthYear = const Value.absent(),
                Value<bool> isDisplayNamePresent = const Value.absent(),
                Value<bool> isHeightPresent = const Value.absent(),
                Value<bool> isWeightPresent = const Value.absent(),
                Value<bool> isBirthYearPresent = const Value.absent(),
              }) => ProfileDraftRowsCompanion(
                id: id,
                displayName: displayName,
                height: height,
                weight: weight,
                birthYear: birthYear,
                isDisplayNamePresent: isDisplayNamePresent,
                isHeightPresent: isHeightPresent,
                isWeightPresent: isWeightPresent,
                isBirthYearPresent: isBirthYearPresent,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String displayName,
                required String height,
                required String weight,
                required String birthYear,
                Value<bool> isDisplayNamePresent = const Value.absent(),
                Value<bool> isHeightPresent = const Value.absent(),
                Value<bool> isWeightPresent = const Value.absent(),
                Value<bool> isBirthYearPresent = const Value.absent(),
              }) => ProfileDraftRowsCompanion.insert(
                id: id,
                displayName: displayName,
                height: height,
                weight: weight,
                birthYear: birthYear,
                isDisplayNamePresent: isDisplayNamePresent,
                isHeightPresent: isHeightPresent,
                isWeightPresent: isWeightPresent,
                isBirthYearPresent: isBirthYearPresent,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProfileDraftRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProfileDraftRowsTable,
      ProfileDraftRow,
      $$ProfileDraftRowsTableFilterComposer,
      $$ProfileDraftRowsTableOrderingComposer,
      $$ProfileDraftRowsTableAnnotationComposer,
      $$ProfileDraftRowsTableCreateCompanionBuilder,
      $$ProfileDraftRowsTableUpdateCompanionBuilder,
      (
        ProfileDraftRow,
        BaseReferences<_$AppDatabase, $ProfileDraftRowsTable, ProfileDraftRow>,
      ),
      ProfileDraftRow,
      PrefetchHooks Function()
    >;
typedef $$SettingsRowsTableCreateCompanionBuilder =
    SettingsRowsCompanion Function({
      Value<int> id,
      Value<String> localeOverride,
      Value<String> themeMode,
      Value<int> weeklyActiveDayTarget,
    });
typedef $$SettingsRowsTableUpdateCompanionBuilder =
    SettingsRowsCompanion Function({
      Value<int> id,
      Value<String> localeOverride,
      Value<String> themeMode,
      Value<int> weeklyActiveDayTarget,
    });

class $$SettingsRowsTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsRowsTable> {
  $$SettingsRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localeOverride => $composableBuilder(
    column: $table.localeOverride,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weeklyActiveDayTarget => $composableBuilder(
    column: $table.weeklyActiveDayTarget,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SettingsRowsTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsRowsTable> {
  $$SettingsRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localeOverride => $composableBuilder(
    column: $table.localeOverride,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weeklyActiveDayTarget => $composableBuilder(
    column: $table.weeklyActiveDayTarget,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SettingsRowsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsRowsTable> {
  $$SettingsRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get localeOverride => $composableBuilder(
    column: $table.localeOverride,
    builder: (column) => column,
  );

  GeneratedColumn<String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<int> get weeklyActiveDayTarget => $composableBuilder(
    column: $table.weeklyActiveDayTarget,
    builder: (column) => column,
  );
}

class $$SettingsRowsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingsRowsTable,
          SettingsRow,
          $$SettingsRowsTableFilterComposer,
          $$SettingsRowsTableOrderingComposer,
          $$SettingsRowsTableAnnotationComposer,
          $$SettingsRowsTableCreateCompanionBuilder,
          $$SettingsRowsTableUpdateCompanionBuilder,
          (
            SettingsRow,
            BaseReferences<_$AppDatabase, $SettingsRowsTable, SettingsRow>,
          ),
          SettingsRow,
          PrefetchHooks Function()
        > {
  $$SettingsRowsTableTableManager(_$AppDatabase db, $SettingsRowsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsRowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> localeOverride = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<int> weeklyActiveDayTarget = const Value.absent(),
              }) => SettingsRowsCompanion(
                id: id,
                localeOverride: localeOverride,
                themeMode: themeMode,
                weeklyActiveDayTarget: weeklyActiveDayTarget,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> localeOverride = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<int> weeklyActiveDayTarget = const Value.absent(),
              }) => SettingsRowsCompanion.insert(
                id: id,
                localeOverride: localeOverride,
                themeMode: themeMode,
                weeklyActiveDayTarget: weeklyActiveDayTarget,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingsRowsTable,
      SettingsRow,
      $$SettingsRowsTableFilterComposer,
      $$SettingsRowsTableOrderingComposer,
      $$SettingsRowsTableAnnotationComposer,
      $$SettingsRowsTableCreateCompanionBuilder,
      $$SettingsRowsTableUpdateCompanionBuilder,
      (
        SettingsRow,
        BaseReferences<_$AppDatabase, $SettingsRowsTable, SettingsRow>,
      ),
      SettingsRow,
      PrefetchHooks Function()
    >;
typedef $$WalkingSessionRowsTableCreateCompanionBuilder =
    WalkingSessionRowsCompanion Function({
      required String id,
      required DateTime startedAt,
      required String state,
      required String inclusion,
      required int revision,
      Value<String> currentSegmentId,
      Value<String?> lastPointId,
      Value<DateTime?> lastObservedAt,
      Value<double?> lastLatitude,
      Value<double?> lastLongitude,
      Value<double?> lastAccuracyMeters,
      Value<String?> recoveryBoundaryPointId,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$WalkingSessionRowsTableUpdateCompanionBuilder =
    WalkingSessionRowsCompanion Function({
      Value<String> id,
      Value<DateTime> startedAt,
      Value<String> state,
      Value<String> inclusion,
      Value<int> revision,
      Value<String> currentSegmentId,
      Value<String?> lastPointId,
      Value<DateTime?> lastObservedAt,
      Value<double?> lastLatitude,
      Value<double?> lastLongitude,
      Value<double?> lastAccuracyMeters,
      Value<String?> recoveryBoundaryPointId,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$WalkingSessionRowsTableFilterComposer
    extends Composer<_$AppDatabase, $WalkingSessionRowsTable> {
  $$WalkingSessionRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get inclusion => $composableBuilder(
    column: $table.inclusion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currentSegmentId => $composableBuilder(
    column: $table.currentSegmentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastPointId => $composableBuilder(
    column: $table.lastPointId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastObservedAt => $composableBuilder(
    column: $table.lastObservedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lastLatitude => $composableBuilder(
    column: $table.lastLatitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lastLongitude => $composableBuilder(
    column: $table.lastLongitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lastAccuracyMeters => $composableBuilder(
    column: $table.lastAccuracyMeters,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recoveryBoundaryPointId => $composableBuilder(
    column: $table.recoveryBoundaryPointId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WalkingSessionRowsTableOrderingComposer
    extends Composer<_$AppDatabase, $WalkingSessionRowsTable> {
  $$WalkingSessionRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get inclusion => $composableBuilder(
    column: $table.inclusion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currentSegmentId => $composableBuilder(
    column: $table.currentSegmentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastPointId => $composableBuilder(
    column: $table.lastPointId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastObservedAt => $composableBuilder(
    column: $table.lastObservedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lastLatitude => $composableBuilder(
    column: $table.lastLatitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lastLongitude => $composableBuilder(
    column: $table.lastLongitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lastAccuracyMeters => $composableBuilder(
    column: $table.lastAccuracyMeters,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recoveryBoundaryPointId => $composableBuilder(
    column: $table.recoveryBoundaryPointId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WalkingSessionRowsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WalkingSessionRowsTable> {
  $$WalkingSessionRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<String> get inclusion =>
      $composableBuilder(column: $table.inclusion, builder: (column) => column);

  GeneratedColumn<int> get revision =>
      $composableBuilder(column: $table.revision, builder: (column) => column);

  GeneratedColumn<String> get currentSegmentId => $composableBuilder(
    column: $table.currentSegmentId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastPointId => $composableBuilder(
    column: $table.lastPointId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastObservedAt => $composableBuilder(
    column: $table.lastObservedAt,
    builder: (column) => column,
  );

  GeneratedColumn<double> get lastLatitude => $composableBuilder(
    column: $table.lastLatitude,
    builder: (column) => column,
  );

  GeneratedColumn<double> get lastLongitude => $composableBuilder(
    column: $table.lastLongitude,
    builder: (column) => column,
  );

  GeneratedColumn<double> get lastAccuracyMeters => $composableBuilder(
    column: $table.lastAccuracyMeters,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recoveryBoundaryPointId => $composableBuilder(
    column: $table.recoveryBoundaryPointId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$WalkingSessionRowsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WalkingSessionRowsTable,
          WalkingSessionRow,
          $$WalkingSessionRowsTableFilterComposer,
          $$WalkingSessionRowsTableOrderingComposer,
          $$WalkingSessionRowsTableAnnotationComposer,
          $$WalkingSessionRowsTableCreateCompanionBuilder,
          $$WalkingSessionRowsTableUpdateCompanionBuilder,
          (
            WalkingSessionRow,
            BaseReferences<
              _$AppDatabase,
              $WalkingSessionRowsTable,
              WalkingSessionRow
            >,
          ),
          WalkingSessionRow,
          PrefetchHooks Function()
        > {
  $$WalkingSessionRowsTableTableManager(
    _$AppDatabase db,
    $WalkingSessionRowsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WalkingSessionRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WalkingSessionRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WalkingSessionRowsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<String> state = const Value.absent(),
                Value<String> inclusion = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<String> currentSegmentId = const Value.absent(),
                Value<String?> lastPointId = const Value.absent(),
                Value<DateTime?> lastObservedAt = const Value.absent(),
                Value<double?> lastLatitude = const Value.absent(),
                Value<double?> lastLongitude = const Value.absent(),
                Value<double?> lastAccuracyMeters = const Value.absent(),
                Value<String?> recoveryBoundaryPointId = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WalkingSessionRowsCompanion(
                id: id,
                startedAt: startedAt,
                state: state,
                inclusion: inclusion,
                revision: revision,
                currentSegmentId: currentSegmentId,
                lastPointId: lastPointId,
                lastObservedAt: lastObservedAt,
                lastLatitude: lastLatitude,
                lastLongitude: lastLongitude,
                lastAccuracyMeters: lastAccuracyMeters,
                recoveryBoundaryPointId: recoveryBoundaryPointId,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime startedAt,
                required String state,
                required String inclusion,
                required int revision,
                Value<String> currentSegmentId = const Value.absent(),
                Value<String?> lastPointId = const Value.absent(),
                Value<DateTime?> lastObservedAt = const Value.absent(),
                Value<double?> lastLatitude = const Value.absent(),
                Value<double?> lastLongitude = const Value.absent(),
                Value<double?> lastAccuracyMeters = const Value.absent(),
                Value<String?> recoveryBoundaryPointId = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WalkingSessionRowsCompanion.insert(
                id: id,
                startedAt: startedAt,
                state: state,
                inclusion: inclusion,
                revision: revision,
                currentSegmentId: currentSegmentId,
                lastPointId: lastPointId,
                lastObservedAt: lastObservedAt,
                lastLatitude: lastLatitude,
                lastLongitude: lastLongitude,
                lastAccuracyMeters: lastAccuracyMeters,
                recoveryBoundaryPointId: recoveryBoundaryPointId,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WalkingSessionRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WalkingSessionRowsTable,
      WalkingSessionRow,
      $$WalkingSessionRowsTableFilterComposer,
      $$WalkingSessionRowsTableOrderingComposer,
      $$WalkingSessionRowsTableAnnotationComposer,
      $$WalkingSessionRowsTableCreateCompanionBuilder,
      $$WalkingSessionRowsTableUpdateCompanionBuilder,
      (
        WalkingSessionRow,
        BaseReferences<
          _$AppDatabase,
          $WalkingSessionRowsTable,
          WalkingSessionRow
        >,
      ),
      WalkingSessionRow,
      PrefetchHooks Function()
    >;
typedef $$WalkingSegmentRowsTableCreateCompanionBuilder =
    WalkingSegmentRowsCompanion Function({
      required String id,
      required String sessionId,
      required DateTime startedAt,
      Value<DateTime?> endedAt,
      Value<int> rowid,
    });
typedef $$WalkingSegmentRowsTableUpdateCompanionBuilder =
    WalkingSegmentRowsCompanion Function({
      Value<String> id,
      Value<String> sessionId,
      Value<DateTime> startedAt,
      Value<DateTime?> endedAt,
      Value<int> rowid,
    });

class $$WalkingSegmentRowsTableFilterComposer
    extends Composer<_$AppDatabase, $WalkingSegmentRowsTable> {
  $$WalkingSegmentRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WalkingSegmentRowsTableOrderingComposer
    extends Composer<_$AppDatabase, $WalkingSegmentRowsTable> {
  $$WalkingSegmentRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WalkingSegmentRowsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WalkingSegmentRowsTable> {
  $$WalkingSegmentRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);
}

class $$WalkingSegmentRowsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WalkingSegmentRowsTable,
          WalkingSegmentRow,
          $$WalkingSegmentRowsTableFilterComposer,
          $$WalkingSegmentRowsTableOrderingComposer,
          $$WalkingSegmentRowsTableAnnotationComposer,
          $$WalkingSegmentRowsTableCreateCompanionBuilder,
          $$WalkingSegmentRowsTableUpdateCompanionBuilder,
          (
            WalkingSegmentRow,
            BaseReferences<
              _$AppDatabase,
              $WalkingSegmentRowsTable,
              WalkingSegmentRow
            >,
          ),
          WalkingSegmentRow,
          PrefetchHooks Function()
        > {
  $$WalkingSegmentRowsTableTableManager(
    _$AppDatabase db,
    $WalkingSegmentRowsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WalkingSegmentRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WalkingSegmentRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WalkingSegmentRowsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WalkingSegmentRowsCompanion(
                id: id,
                sessionId: sessionId,
                startedAt: startedAt,
                endedAt: endedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sessionId,
                required DateTime startedAt,
                Value<DateTime?> endedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WalkingSegmentRowsCompanion.insert(
                id: id,
                sessionId: sessionId,
                startedAt: startedAt,
                endedAt: endedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WalkingSegmentRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WalkingSegmentRowsTable,
      WalkingSegmentRow,
      $$WalkingSegmentRowsTableFilterComposer,
      $$WalkingSegmentRowsTableOrderingComposer,
      $$WalkingSegmentRowsTableAnnotationComposer,
      $$WalkingSegmentRowsTableCreateCompanionBuilder,
      $$WalkingSegmentRowsTableUpdateCompanionBuilder,
      (
        WalkingSegmentRow,
        BaseReferences<
          _$AppDatabase,
          $WalkingSegmentRowsTable,
          WalkingSegmentRow
        >,
      ),
      WalkingSegmentRow,
      PrefetchHooks Function()
    >;
typedef $$WalkingPointRowsTableCreateCompanionBuilder =
    WalkingPointRowsCompanion Function({
      required String id,
      required String sessionId,
      required String segmentId,
      required DateTime observedAt,
      required double latitude,
      required double longitude,
      required double accuracyMeters,
      Value<int> rowid,
    });
typedef $$WalkingPointRowsTableUpdateCompanionBuilder =
    WalkingPointRowsCompanion Function({
      Value<String> id,
      Value<String> sessionId,
      Value<String> segmentId,
      Value<DateTime> observedAt,
      Value<double> latitude,
      Value<double> longitude,
      Value<double> accuracyMeters,
      Value<int> rowid,
    });

class $$WalkingPointRowsTableFilterComposer
    extends Composer<_$AppDatabase, $WalkingPointRowsTable> {
  $$WalkingPointRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get segmentId => $composableBuilder(
    column: $table.segmentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get observedAt => $composableBuilder(
    column: $table.observedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get accuracyMeters => $composableBuilder(
    column: $table.accuracyMeters,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WalkingPointRowsTableOrderingComposer
    extends Composer<_$AppDatabase, $WalkingPointRowsTable> {
  $$WalkingPointRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get segmentId => $composableBuilder(
    column: $table.segmentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get observedAt => $composableBuilder(
    column: $table.observedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get accuracyMeters => $composableBuilder(
    column: $table.accuracyMeters,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WalkingPointRowsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WalkingPointRowsTable> {
  $$WalkingPointRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<String> get segmentId =>
      $composableBuilder(column: $table.segmentId, builder: (column) => column);

  GeneratedColumn<DateTime> get observedAt => $composableBuilder(
    column: $table.observedAt,
    builder: (column) => column,
  );

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<double> get accuracyMeters => $composableBuilder(
    column: $table.accuracyMeters,
    builder: (column) => column,
  );
}

class $$WalkingPointRowsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WalkingPointRowsTable,
          WalkingPointRow,
          $$WalkingPointRowsTableFilterComposer,
          $$WalkingPointRowsTableOrderingComposer,
          $$WalkingPointRowsTableAnnotationComposer,
          $$WalkingPointRowsTableCreateCompanionBuilder,
          $$WalkingPointRowsTableUpdateCompanionBuilder,
          (
            WalkingPointRow,
            BaseReferences<
              _$AppDatabase,
              $WalkingPointRowsTable,
              WalkingPointRow
            >,
          ),
          WalkingPointRow,
          PrefetchHooks Function()
        > {
  $$WalkingPointRowsTableTableManager(
    _$AppDatabase db,
    $WalkingPointRowsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WalkingPointRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WalkingPointRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WalkingPointRowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<String> segmentId = const Value.absent(),
                Value<DateTime> observedAt = const Value.absent(),
                Value<double> latitude = const Value.absent(),
                Value<double> longitude = const Value.absent(),
                Value<double> accuracyMeters = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WalkingPointRowsCompanion(
                id: id,
                sessionId: sessionId,
                segmentId: segmentId,
                observedAt: observedAt,
                latitude: latitude,
                longitude: longitude,
                accuracyMeters: accuracyMeters,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sessionId,
                required String segmentId,
                required DateTime observedAt,
                required double latitude,
                required double longitude,
                required double accuracyMeters,
                Value<int> rowid = const Value.absent(),
              }) => WalkingPointRowsCompanion.insert(
                id: id,
                sessionId: sessionId,
                segmentId: segmentId,
                observedAt: observedAt,
                latitude: latitude,
                longitude: longitude,
                accuracyMeters: accuracyMeters,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WalkingPointRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WalkingPointRowsTable,
      WalkingPointRow,
      $$WalkingPointRowsTableFilterComposer,
      $$WalkingPointRowsTableOrderingComposer,
      $$WalkingPointRowsTableAnnotationComposer,
      $$WalkingPointRowsTableCreateCompanionBuilder,
      $$WalkingPointRowsTableUpdateCompanionBuilder,
      (
        WalkingPointRow,
        BaseReferences<_$AppDatabase, $WalkingPointRowsTable, WalkingPointRow>,
      ),
      WalkingPointRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProfileRowsTableTableManager get profileRows =>
      $$ProfileRowsTableTableManager(_db, _db.profileRows);
  $$ProfileDraftRowsTableTableManager get profileDraftRows =>
      $$ProfileDraftRowsTableTableManager(_db, _db.profileDraftRows);
  $$SettingsRowsTableTableManager get settingsRows =>
      $$SettingsRowsTableTableManager(_db, _db.settingsRows);
  $$WalkingSessionRowsTableTableManager get walkingSessionRows =>
      $$WalkingSessionRowsTableTableManager(_db, _db.walkingSessionRows);
  $$WalkingSegmentRowsTableTableManager get walkingSegmentRows =>
      $$WalkingSegmentRowsTableTableManager(_db, _db.walkingSegmentRows);
  $$WalkingPointRowsTableTableManager get walkingPointRows =>
      $$WalkingPointRowsTableTableManager(_db, _db.walkingPointRows);
}
