import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:walkingen/database/app_database.dart';
import 'package:walkingen/main.dart';
import 'package:walkingen/profile/profile_repository.dart';

void main() {
  testWidgets('renders localized Home by default', (tester) async {
    await tester.pumpWidget(const WalkingenApp(locale: Locale('tr')));

    expect(find.text('Yürüyüşlerin burada başlayacak.'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsNothing);
  });

  testWidgets('tapping History shows localized History content', (
    tester,
  ) async {
    await tester.pumpWidget(const WalkingenApp(locale: Locale('tr')));

    await tester.tap(find.byTooltip('Geçmiş'));
    await tester.pumpAndSettle();

    expect(
      find.text('Tamamlanan yürüyüşlerin burada görünecek.'),
      findsOneWidget,
    );
  });

  testWidgets('tapping Profile and Settings shows localized content', (
    tester,
  ) async {
    await tester.pumpWidget(const WalkingenApp(locale: Locale('tr')));

    await tester.tap(find.byTooltip('Profil'));
    await tester.pumpAndSettle();

    expect(
      find.text('Profil ve ayar seçenekleri burada görünecek.'),
      findsOneWidget,
    );
  });

  testWidgets('English locale renders English labels and content', (
    tester,
  ) async {
    await tester.pumpWidget(const WalkingenApp(locale: Locale('en')));

    expect(
      find.text('Your walking overview will appear here.'),
      findsOneWidget,
    );
    expect(find.text('Ana Sayfa'), findsNothing);
  });

  testWidgets('follows system brightness with fixed light and dark themes', (
    tester,
  ) async {
    const seedColor = Color(0xFF4F6F52);
    addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);

    tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
    await tester.pumpWidget(const WalkingenApp(locale: Locale('en')));

    var theme = Theme.of(tester.element(find.byType(Scaffold)));
    expect(theme.brightness, Brightness.dark);
    expect(
      theme.colorScheme.primary,
      ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.dark,
      ).primary,
    );

    tester.platformDispatcher.platformBrightnessTestValue = Brightness.light;
    await tester.pumpAndSettle();

    theme = Theme.of(tester.element(find.byType(Scaffold)));
    expect(theme.brightness, Brightness.light);
    expect(
      theme.colorScheme.primary,
      ColorScheme.fromSeed(seedColor: seedColor).primary,
    );
  });

  testWidgets('navigation remains usable with large text on a narrow screen', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(textScaler: TextScaler.linear(2)),
        child: const WalkingenApp(locale: Locale('en')),
      ),
    );

    expect(tester.takeException(), isNull);
    expect(
      find.text('Your walking overview will appear here.'),
      findsOneWidget,
    );
  });

  testWidgets('navigation has localized semantics and 48dp targets', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    try {
      await tester.pumpWidget(const WalkingenApp(locale: Locale('tr')));

      for (final label in ['Ana Sayfa', 'Geçmiş', 'Profil']) {
        final destination = find.byTooltip(label);
        expect(destination, findsOneWidget);
        final size = tester.getSize(destination);
        expect(size.width, greaterThanOrEqualTo(48));
        expect(size.height, greaterThanOrEqualTo(48));
      }
    } finally {
      semantics.dispose();
    }
  });

  testWidgets('profile form loads and saves a local profile', (tester) async {
    final repository = ProfileRepository(AppDatabase.inMemory());
    addTearDown(repository.close);
    await tester.pumpWidget(
      WalkingenApp(locale: const Locale('tr'), repository: repository),
    );
    await tester.tap(find.byTooltip('Profil'));
    await tester.pumpAndSettle();

    expect(find.text('İsim'), findsOneWidget);
    await tester.enterText(find.widgetWithText(TextFormField, 'İsim'), 'Utku');
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Boy (cm)'),
      '180',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Kilo (kg)'),
      '82,5',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Doğum yılı'),
      '1990',
    );
    await tester.tap(find.text('Profili kaydet'));
    await tester.pumpAndSettle();

    expect((await repository.loadProfile())?.displayName, 'Utku');
    expect(find.text('Profil kaydedildi.'), findsOneWidget);
  });
}
