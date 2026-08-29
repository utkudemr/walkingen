import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class ProfileRows extends Table {
  IntColumn get id => integer().customConstraint('NOT NULL CHECK (id = 1)')();
  TextColumn get displayName => text()();
  IntColumn get heightCm => integer()();
  RealColumn get weightKg => real()();
  IntColumn get birthYear => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class ProfileDraftRows extends Table {
  IntColumn get id => integer().customConstraint('NOT NULL CHECK (id = 1)')();
  TextColumn get displayName => text()();
  TextColumn get height => text()();
  TextColumn get weight => text()();
  TextColumn get birthYear => text()();
  BoolColumn get isDisplayNamePresent =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get isHeightPresent =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get isWeightPresent =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get isBirthYearPresent =>
      boolean().withDefault(const Constant(true))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class SettingsRows extends Table {
  IntColumn get id => integer().customConstraint('NOT NULL CHECK (id = 1)')();
  TextColumn get localeOverride =>
      text().withDefault(const Constant('system'))();
  TextColumn get themeMode => text().withDefault(const Constant('system'))();
  IntColumn get weeklyActiveDayTarget =>
      integer().withDefault(const Constant(3))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(tables: [ProfileRows, ProfileDraftRows, SettingsRows])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  AppDatabase.inMemory() : this(NativeDatabase.memory());

  static Future<AppDatabase> open() async {
    final directory = await getApplicationSupportDirectory();
    return AppDatabase(
      NativeDatabase(File(p.join(directory.path, 'walkingen.sqlite'))),
    );
  }

  @override
  int get schemaVersion => 1;
}
