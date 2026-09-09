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

class WalkingSessionRows extends Table {
  TextColumn get id => text()();
  DateTimeColumn get startedAt => dateTime()();
  TextColumn get state => text()();
  TextColumn get inclusion => text()();
  IntColumn get revision => integer()();
  TextColumn get currentSegmentId => text().withDefault(const Constant(''))();
  TextColumn get lastPointId => text().nullable()();
  DateTimeColumn get lastObservedAt => dateTime().nullable()();
  RealColumn get lastLatitude => real().nullable()();
  RealColumn get lastLongitude => real().nullable()();
  RealColumn get lastAccuracyMeters => real().nullable()();
  TextColumn get recoveryBoundaryPointId => text().nullable()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class WalkingSegmentRows extends Table {
  TextColumn get id => text()();
  TextColumn get sessionId => text()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class WalkingPointRows extends Table {
  TextColumn get id => text()();
  TextColumn get sessionId => text()();
  TextColumn get segmentId => text()();
  DateTimeColumn get observedAt => dateTime()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  RealColumn get accuracyMeters => real()();

  @override
  Set<Column<Object>> get primaryKey => {sessionId, id};
}

@DriftDatabase(
  tables: [
    ProfileRows,
    ProfileDraftRows,
    SettingsRows,
    WalkingSessionRows,
    WalkingSegmentRows,
    WalkingPointRows,
  ],
)
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
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
      await m.database.customStatement(
        "CREATE UNIQUE INDEX IF NOT EXISTS walking_one_open_session ON walking_session_rows (CASE WHEN state IN ('active', 'paused') THEN 1 ELSE NULL END)",
      );
    },
    onUpgrade: (Migrator m, int from, int to) async {
      Future<bool> hasColumn(String table, String column) async {
        final rows = await m.database
            .customSelect('PRAGMA table_info("$table")')
            .get();
        return rows.any((row) => row.data['name'] == column);
      }

      Future<void> addColumnIfMissing(
        String table,
        String column,
        TableInfo<Table, dynamic> tableDefinition,
        GeneratedColumn<Object> definition,
      ) async {
        if (!await hasColumn(table, column)) {
          await m.addColumn(tableDefinition, definition);
        }
      }

      if (from < 2) {
        await m.createTable(walkingSessionRows);
        await m.createTable(walkingSegmentRows);
        await m.createTable(walkingPointRows);
      } else {
        if (from < 3) {
          await addColumnIfMissing(
            'walking_session_rows',
            'current_segment_id',
            walkingSessionRows,
            walkingSessionRows.currentSegmentId,
          );
          await addColumnIfMissing(
            'walking_session_rows',
            'last_point_id',
            walkingSessionRows,
            walkingSessionRows.lastPointId,
          );
          await addColumnIfMissing(
            'walking_session_rows',
            'last_observed_at',
            walkingSessionRows,
            walkingSessionRows.lastObservedAt,
          );
        }
        if (from < 4) {
          await addColumnIfMissing(
            'walking_session_rows',
            'recovery_boundary_point_id',
            walkingSessionRows,
            walkingSessionRows.recoveryBoundaryPointId,
          );
          await addColumnIfMissing(
            'walking_session_rows',
            'updated_at',
            walkingSessionRows,
            walkingSessionRows.updatedAt,
          );
          await addColumnIfMissing(
            'walking_segment_rows',
            'ended_at',
            walkingSegmentRows,
            walkingSegmentRows.endedAt,
          );
        }
        if (from < 5) {
          await addColumnIfMissing(
            'walking_session_rows',
            'last_latitude',
            walkingSessionRows,
            walkingSessionRows.lastLatitude,
          );
          await addColumnIfMissing(
            'walking_session_rows',
            'last_longitude',
            walkingSessionRows,
            walkingSessionRows.lastLongitude,
          );
          await addColumnIfMissing(
            'walking_session_rows',
            'last_accuracy_meters',
            walkingSessionRows,
            walkingSessionRows.lastAccuracyMeters,
          );
        }
      }
      await m.database.customStatement(
        "INSERT OR IGNORE INTO walking_segment_rows (id, session_id, started_at, ended_at) SELECT id || '-segment-0', id, started_at, NULL FROM walking_session_rows WHERE (current_segment_id IS NULL OR current_segment_id = '') AND NOT EXISTS (SELECT 1 FROM walking_segment_rows WHERE session_id = walking_session_rows.id)",
      );
      await m.database.customStatement(
        "UPDATE walking_session_rows SET current_segment_id = (SELECT id FROM walking_segment_rows WHERE session_id = walking_session_rows.id ORDER BY started_at DESC LIMIT 1) WHERE current_segment_id IS NULL OR current_segment_id = ''",
      );
      await m.database.customStatement(
        "UPDATE walking_session_rows SET state = 'interrupted' WHERE state IN ('active', 'paused') AND id NOT IN (SELECT id FROM walking_session_rows WHERE state IN ('active', 'paused') ORDER BY started_at LIMIT 1)",
      );
      await m.database.customStatement(
        "CREATE UNIQUE INDEX IF NOT EXISTS walking_one_open_session ON walking_session_rows (CASE WHEN state IN ('active', 'paused') THEN 1 ELSE NULL END)",
      );
    },
  );
}
