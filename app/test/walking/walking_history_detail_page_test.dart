import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:walkingen/database/app_database.dart';
import 'package:walkingen/l10n/generated/app_localizations.dart';
import 'package:walkingen/walking/location_observation.dart';
import 'package:walkingen/walking/walking_history_detail_page.dart';
import 'package:walkingen/walking/walking_session_repository.dart';

void main() {
  testWidgets('completed route displays a map before its walk timestamps', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final database = AppDatabase.inMemory();
    addTearDown(database.close);
    final repository = WalkingSessionRepository(database);
    final startedAt = DateTime.now().subtract(const Duration(minutes: 2));
    await repository.startSession(id: 'synthetic-route', startedAt: startedAt);
    for (var index = 0; index < 2; index++) {
      await repository.acceptPoint(
        sessionId: 'synthetic-route',
        expectedRevision: index,
        observation: LocationObservation(
          id: 'synthetic-point-$index',
          observedAt: startedAt.add(Duration(seconds: index + 1)),
          latitude: 41.0082 + index * 0.0001,
          longitude: 28.9785 + index * 0.0001,
          accuracyMeters: 8,
        ),
      );
    }
    await repository.finishSession(
      sessionId: 'synthetic-route',
      expectedRevision: 2,
      confirmed: true,
    );
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: WalkingHistoryDetailPage(
          repository: repository,
          sessionId: 'synthetic-route',
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byType(FlutterMap), findsOneWidget);
    final mapTop = tester.getTopLeft(find.byType(FlutterMap)).dy;
    final startTop = tester.getTopLeft(find.textContaining('Start:')).dy;
    expect(mapTop, lessThan(startTop));
    expect(find.textContaining('End:'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
  testWidgets('dark detail without GPS keeps an honest route placeholder', (
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
      id: 'synthetic-no-route',
      startedAt: DateTime.now().subtract(const Duration(minutes: 2)),
    );
    await repository.finishSession(
      sessionId: 'synthetic-no-route',
      expectedRevision: 0,
      confirmed: true,
    );
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.dark(),
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(2)),
          child: child!,
        ),
        home: WalkingHistoryDetailPage(
          repository: repository,
          sessionId: 'synthetic-no-route',
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(FlutterMap), findsNothing);
    expect(
      find.text('No GPS route was recorded for this walk.'),
      findsOneWidget,
    );
    expect(
      tester.widget<Scaffold>(find.byType(Scaffold)).backgroundColor,
      const Color(0xFF1D282B),
    );
    expect(tester.takeException(), isNull);
  });
  testWidgets(
    'missing completed walk shows unavailable instead of loading forever',
    (tester) async {
      final database = AppDatabase.inMemory();
      addTearDown(database.close);

      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('tr'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: WalkingHistoryDetailPage(
            repository: WalkingSessionRepository(database),
            sessionId: 'missing-session',
          ),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(
        find.text('Bu tamamlanmış yürüyüş artık kullanılamıyor.'),
        findsOneWidget,
      );
      expect(find.byType(CircularProgressIndicator), findsNothing);
    },
  );
}
