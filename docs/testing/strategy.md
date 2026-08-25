# Test Strategy

## Test layers

- Unit tests cover pure domain rules and calculations.
- Widget tests cover visible behavior, localization, theme behavior, semantics, and navigation.
- Integration tests cover Drift persistence and Android-facing flows where practical.
- Emulator evidence covers installation, launch, navigation, rendering, and simulated location flows.
- Samsung Galaxy S23 evidence is mandatory for background location, screen-off tracking, process/recent-app behavior, reboot recovery, battery optimization, and the physical step sensor.

## Required local gates

Run from `app/`:

```bash
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
flutter build apk --debug
```

## Foundation acceptance tests

1. The app renders the localized Home destination by default.
2. Tapping History displays the localized History destination.
3. Tapping Profile/Settings displays the localized Profile/Settings destination.
4. Pumping the app with a Turkish locale renders Turkish navigation and page text.
5. Pumping the app with an English locale renders English navigation and page text.
6. The root application is configured with light and dark themes and starts with
   `ThemeMode.system`; a widget test observes light and dark platform brightness
   without relying on private implementation fields.
7. Primary navigation destinations expose localized semantic labels and meet the
   Material navigation component's minimum 48dp interactive size.

## CI acceptance criteria

The initial workflow must:

1. Run for pull requests and pushes to `main`.
2. Check formatting without changing files.
3. Run `flutter analyze` and the full Flutter test suite.
4. Produce a debug Android APK.
5. Use the pinned Flutter 3.47.1 stable toolchain.
6. Declare read-only `contents` permission and use no application secrets.
7. Fail the workflow when any required command fails.
8. Run Gitleaks for pull requests and pushes to `main`; GitHub secret scanning
   and push protection remain enabled for the public repository.
9. Pin third-party workflow actions to reviewed commit SHAs.

## Android tracking lifecycle matrix

A production change that starts or owns Android location tracking must provide evidence for:

1. Visible user action starts one location foreground service and an ongoing localized notification.
2. Accepted points/checkpoints continue after Home/background.
3. Accepted points/checkpoints continue while the screen is off.
4. Removing the recent-apps card does not stop an active walk.
5. UI navigation or widget disposal does not own or cancel the tracking stream.
6. Force Stop halts the process and service; reopening detects the persisted unfinished session.
7. Reboot does not auto-resume tracking; persisted active/paused state becomes `interrupted`.
8. User-confirmed resume begins a new continuity segment without fabricating the missing interval.
9. Emulator synthetic-location evidence is supplemented by the documented Samsung Galaxy S23 scenarios before production completion.

## TDD evidence

Each production behavior starts with a focused failing test. The failure must be observed for the missing behavior before the minimum implementation is added. After each focused GREEN run, execute the full suite before refactoring.
