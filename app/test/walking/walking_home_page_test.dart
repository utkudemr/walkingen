import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:walkingen/database/app_database.dart';
import 'package:walkingen/l10n/generated/app_localizations.dart';
import 'package:walkingen/walking/location_observation.dart';
import 'package:walkingen/walking/walking_session_repository.dart';
import 'package:walkingen/walking/walking_tracking.dart';
import 'package:walkingen/walking/walking_home_page.dart';

void main() {
  testWidgets('starts a walking session from the Home action', (tester) async {
    final database = AppDatabase.inMemory();
    // Cleanup is explicit below so a hanging resource is observable.
    final repository = WalkingSessionRepository(database);
    final source = FakeLocationTrackingSource();
    final coordinator = WalkingTrackingCoordinator(repository, source);

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('tr'),
        home: WalkingHomePage(
          coordinator: coordinator,
          now: () => DateTime.utc(2026, 8, 29, 20),
        ),
      ),
    );

    await tester.tap(find.bySemanticsLabel('Yürüyüşü başlat'));
    await tester.pump();

    expect(source.startCount, 1);
    expect((await repository.loadOpenSession())?.state.name, 'active');
    expect(find.text('Yürüyüş devam ediyor'), findsOneWidget);
    await coordinator.finish();
    await database.close();
  });

  testWidgets('pauses and resumes an active walking session', (tester) async {
    final database = AppDatabase.inMemory();
    final repository = WalkingSessionRepository(database);
    final source = FakeLocationTrackingSource();
    final coordinator = WalkingTrackingCoordinator(repository, source);

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('tr'),
        home: WalkingHomePage(
          coordinator: coordinator,
          now: () => DateTime.utc(2026, 8, 29, 20),
        ),
      ),
    );

    await tester.tap(find.bySemanticsLabel('Yürüyüşü başlat'));
    await tester.pump();
    await tester.tap(find.bySemanticsLabel('Yürüyüşü duraklat'));
    await tester.pump();

    expect(find.text('Yürüyüş duraklatıldı'), findsOneWidget);

    await tester.tap(find.bySemanticsLabel('Yürüyüşe devam et'));
    await tester.pump();

    expect(find.text('Yürüyüş devam ediyor'), findsOneWidget);
    await coordinator.finish();
    await database.close();
  });

  testWidgets('requires confirmation before finishing a walk', (tester) async {
    final database = AppDatabase.inMemory();
    final repository = WalkingSessionRepository(database);
    final source = FakeLocationTrackingSource();
    final coordinator = WalkingTrackingCoordinator(repository, source);

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('tr'),
        home: WalkingHomePage(
          coordinator: coordinator,
          now: () => DateTime.utc(2026, 8, 29, 20),
        ),
      ),
    );

    await tester.tap(find.bySemanticsLabel('Yürüyüşü başlat'));
    await tester.pump();
    await tester.tap(find.bySemanticsLabel('Yürüyüşü bitir'));
    await tester.pump();

    expect(find.text('Yürüyüşü bitirmek istiyor musun?'), findsOneWidget);
    await tester.tap(find.text('Vazgeç'));
    await tester.pump();
    expect((await repository.loadOpenSession())?.state.name, 'active');

    await tester.tap(find.bySemanticsLabel('Yürüyüşü bitir'));
    await tester.pump();
    await tester.tap(find.text('Bitir'));
    await tester.pump();

    expect(await repository.loadOpenSession(), isNull);
    await coordinator.dispose();
    await database.close();
  });

  testWidgets('restores an existing open session on Home', (tester) async {
    final database = AppDatabase.inMemory();
    final repository = WalkingSessionRepository(database);
    await repository.startSession(
      id: 'persisted-session',
      startedAt: DateTime.utc(2026, 8, 29, 20),
    );
    final source = FakeLocationTrackingSource();
    final coordinator = WalkingTrackingCoordinator(repository, source);

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('tr'),
        home: WalkingHomePage(
          coordinator: coordinator,
          sessionId: 'new-session',
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Yürüyüş devam ediyor'), findsOneWidget);
    expect(find.bySemanticsLabel('Yürüyüşü duraklat'), findsOneWidget);
    await coordinator.finish();
    await database.close();
  });
}

class FakeLocationTrackingSource implements LocationTrackingSource {
  final _controller = StreamController<LocationObservation>.broadcast();

  @override
  Stream<LocationObservation> get observations => _controller.stream;

  @override
  Future<void> start() async => _startCount++;

  @override
  Future<void> stop() async {}

  int get startCount => _startCount;
  int _startCount = 0;
}
