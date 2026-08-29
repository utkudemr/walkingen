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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProfileRowsTable profileRows = $ProfileRowsTable(this);
  late final $ProfileDraftRowsTable profileDraftRows = $ProfileDraftRowsTable(
    this,
  );
  late final $SettingsRowsTable settingsRows = $SettingsRowsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    profileRows,
    profileDraftRows,
    settingsRows,
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

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProfileRowsTableTableManager get profileRows =>
      $$ProfileRowsTableTableManager(_db, _db.profileRows);
  $$ProfileDraftRowsTableTableManager get profileDraftRows =>
      $$ProfileDraftRowsTableTableManager(_db, _db.profileDraftRows);
  $$SettingsRowsTableTableManager get settingsRows =>
      $$SettingsRowsTableTableManager(_db, _db.settingsRows);
}
