import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:walkingen/database/app_database.dart';
import 'package:walkingen/main.dart' show AppShell;
import 'package:walkingen/l10n/generated/app_localizations.dart';
import 'package:walkingen/walking/walking_history_page.dart';
import 'package:walkingen/walking/walking_session_repository.dart';

class _FailingHistoryRepository extends WalkingSessionRepository {
  const _FailingHistoryRepository(super.database);

  @override
  Future<List<WalkingHistoryEntry>> loadCompletedHistory({DateTime? day}) =>
      Future.error(StateError('synthetic load failure'));
}

void main() {
  testWidgets('opens on all completed walks, including previous days', (
    tester,
  ) async {
    final database = AppDatabase.inMemory();
    addTearDown(database.close);
    final repository = WalkingSessionRepository(database);
    final startedAt = DateTime.now().subtract(const Duration(days: 2));
    await repository.startSession(
      id: 'synthetic-old-session',
      startedAt: startedAt,
    );
    await repository.finishSession(
      sessionId: 'synthetic-old-session',
      expectedRevision: 0,
      confirmed: true,
    );
    await (database.update(
      database.walkingSessionRows,
    )..where((row) => row.id.equals('synthetic-old-session'))).write(
      WalkingSessionRowsCompanion(
        updatedAt: Value(startedAt.add(const Duration(minutes: 30)).toUtc()),
      ),
    );
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('tr'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: WalkingHistoryPage(repository: repository)),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('Başlangıç:'), findsOneWidget);
    expect(find.text('Geçmiş'), findsNothing);
    expect(find.text('Tarihe göre filtrele'), findsOneWidget);
    expect(find.text('Bu tarihte tamamlanan yürüyüş yok.'), findsNothing);

    await tester.tap(find.text('Tarihe göre filtrele'));
    await tester.pumpAndSettle();
    expect(find.byType(DatePickerDialog), findsOneWidget);
    await tester.tap(find.byType(TextButton).last);
    await tester.pumpAndSettle();
    expect(find.textContaining('Başlangıç:'), findsNothing);
    expect(find.text('Bu tarihte tamamlanan yürüyüş yok.'), findsOneWidget);
    await tester.tap(find.byTooltip('Tarih filtresini temizle'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Başlangıç:'), findsOneWidget);
  });
  testWidgets('English history keeps distance and duration on separate lines', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(640, 1280);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final database = AppDatabase.inMemory();
    addTearDown(database.close);
    final repository = WalkingSessionRepository(database);
    await repository.startSession(
      id: 'synthetic-english-card',
      startedAt: DateTime.now().subtract(const Duration(minutes: 2)),
    );
    await repository.finishSession(
      sessionId: 'synthetic-english-card',
      expectedRevision: 0,
      confirmed: true,
    );
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(2)),
          child: child!,
        ),
        home: Scaffold(body: WalkingHistoryPage(repository: repository)),
      ),
    );
    await tester.pumpAndSettle();

    final distance = find.text('Distance: 0.00 km');
    final duration = find.textContaining('hr');
    expect(distance, findsOneWidget);
    expect(duration, findsOneWidget);
    expect(
      tester.getTopLeft(duration).dy,
      greaterThan(tester.getTopLeft(distance).dy),
    );
    final durationString = tester.widget<Text>(duration).data!;
    final secIndex = durationString.lastIndexOf('sec');
    expect(secIndex, greaterThan(1));
    final paragraph = tester.renderObject<RenderParagraph>(duration);
    final numberBox = paragraph
        .getBoxesForSelection(
          TextSelection(baseOffset: secIndex - 2, extentOffset: secIndex - 1),
        )
        .single;
    final unitBox = paragraph
        .getBoxesForSelection(
          TextSelection(baseOffset: secIndex, extentOffset: secIndex + 1),
        )
        .single;
    expect(unitBox.top, numberBox.top, reason: 'sec must stay with its number');
    expect(tester.takeException(), isNull);
  });
  testWidgets('refreshes history when returning from Home', (tester) async {
    final database = AppDatabase.inMemory();
    addTearDown(database.close);
    final repository = WalkingSessionRepository(database);
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('tr'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: AppShell(walkingRepository: repository),
      ),
    );
    await tester.tap(find.text('Geçmiş'));
    await tester.pumpAndSettle();
    expect(
      find.text('Tamamlanan yürüyüşlerin burada görünecek.'),
      findsOneWidget,
    );

    await tester.tap(find.text('Ana Sayfa'));
    await tester.pumpAndSettle();
    await repository.startSession(
      id: 'synthetic-later-session',
      startedAt: DateTime.now().subtract(const Duration(minutes: 15)),
    );
    await repository.finishSession(
      sessionId: 'synthetic-later-session',
      expectedRevision: 0,
      confirmed: true,
    );
    await tester.tap(find.text('Geçmiş'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Başlangıç:'), findsOneWidget);
  });

  testWidgets('history remains usable at 320dp and double text scale', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(640, 1280);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final database = AppDatabase.inMemory();
    addTearDown(database.close);
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('tr'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(2)),
          child: child!,
        ),
        home: Scaffold(
          body: WalkingHistoryPage(
            repository: WalkingSessionRepository(database),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.text('Tarihe göre filtrele'), findsOneWidget);
  });

  testWidgets('date filter stays below the system status bar', (tester) async {
    final database = AppDatabase.inMemory();
    addTearDown(database.close);
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('tr'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(
            padding: const EdgeInsets.only(top: 24),
            viewPadding: const EdgeInsets.only(top: 24),
          ),
          child: child!,
        ),
        home: Scaffold(
          body: WalkingHistoryPage(
            repository: WalkingSessionRepository(database),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      tester.getTopLeft(find.byType(OutlinedButton)).dy,
      greaterThanOrEqualTo(40),
    );
  });

  testWidgets('reports history load failure instead of claiming no walks', (
    tester,
  ) async {
    final database = AppDatabase.inMemory();
    addTearDown(database.close);
    final repository = _FailingHistoryRepository(database);
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('tr'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: WalkingHistoryPage(repository: repository)),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Yürüyüş geçmişi yüklenemedi.'), findsOneWidget);
    expect(
      find.text('Tamamlanan yürüyüşlerin burada görünecek.'),
      findsNothing,
    );
  });
}
