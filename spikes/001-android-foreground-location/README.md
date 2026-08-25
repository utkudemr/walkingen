# Spike 001: Android foreground location continuity

- Date: 2026-08-25
- Environment: `Walkingen_S23_API_36`, Android 16 / API 36, 1080×2400
- Disposable package: `com.utkudemir.location_spike`
- Evaluated library: `geolocator 14.0.3`

## Question

Given a user-started walk, when Walkingen is backgrounded, the screen is turned off, or its recent-apps card is removed, can Android continue location observations under a visible location foreground-service notification and persist checkpoints during the session?

## Scope

The experiment used only synthetic emulator coordinates. No real route, credential, API key, or personal data was used. The runnable Flutter spike was discarded after the experiment; it must not be copied into production.

## Approach

- Start tracking only from an explicit visible button action.
- Request foreground fine/coarse location and notification permission.
- Configure an Android location foreground service with an ongoing notification and wake lock.
- Subscribe to the position stream with tracking ownership independent of page/widget disposal.
- Flush each observed coordinate immediately to an app-local checkpoint file.
- Inject deterministic GPS test-provider coordinates through Android's `cmd location` interface.

`forceLocationManager: true` was used only to bind the experiment to the emulator GPS test provider. It is not a production recommendation.

## Evidence

### Build and static checks

- `dart format lib test`: 0 changed.
- `flutter analyze`: no issues.
- Disposable widget test: 1/1 passed.
- Debug APK build: passed.

A Windows cross-drive Kotlin incremental-cache failure occurred because the Pub cache is on `D:` and the spike project was on `C:`. Disabling Kotlin incremental compilation for the disposable spike made the clean build deterministic. Production configuration was not changed.

### Foreground service and notification

Android reported:

- `GeolocatorLocationService`
- `isForeground=true`
- foreground service type `0x00000008` (`location`)
- notification flags `ONGOING_EVENT|NO_CLEAR|FOREGROUND_SERVICE`
- title `Walkingen location spike`

### Location/checkpoint scenarios

| Scenario | Before | After | Result |
|---|---:|---:|---|
| Visible activity, three fixes | 0 | 3 | PASS |
| Home/background, two fixes | 3 | 5 | PASS |
| Screen off (`mWakefulness=Asleep`), two fixes | 5 | 7 | PASS |
| Recent-apps swipe with widget-owned cancellation | 7 | 7 | FAIL by design; UI disposal stopped the subscription |
| Recent-apps swipe with ownership outliving the widget | 1 | 2 | PASS |
| Force Stop, one attempted fix | 2 | 2 | PASS; PID/service/notification were absent |
| Reopen after Force Stop, explicitly start tracking, persist one fix | 2 | 3 | PASS; tracking resumed only after visible user action |
| Reboot after the explicit restart checkpoint | 3 | 3 | PASS; checkpoint survived, service did not restart, UI opened idle |

### Important lifecycle finding

A foreground-service notification alone does not make a UI-owned stream safe. In the first variant, cancelling the subscription from widget `dispose()` left a foreground-service record but stopped checkpoints. Tracking ownership must live in a dedicated session/service layer and stop only on an explicit domain transition.

## Verdict: PARTIAL

### What worked

- A location foreground service started from a visible user action continued through Home/background and screen-off on Android 16.
- An ongoing notification made tracking visible to the user.
- Synthetic location observations were flushed during the session rather than only at completion.
- Recent-apps removal did not stop checkpoints when tracking ownership outlived the UI widget.
- App-local checkpoint data survived both Force Stop and reboot.

### What did not work automatically

- Force Stop terminated the process, service, notification, and new observations.
- Reboot did not restart tracking.
- The experiment did not persist an explicit walk lifecycle record, so it could not itself transition `active/paused` to `interrupted`.
- Emulator evidence cannot validate Samsung battery optimization or real GNSS behavior.
- Android 13+ may show a running foreground service only in the active-apps Task Manager when notification permission is denied; this spike granted notification permission and verified the drawer notification path.

### Surprises

- Leaving the foreground-service record alive was insufficient when widget disposal cancelled the stream.
- Android treats a running location foreground service as foreground location access. Because Walkingen starts tracking from a visible user action and must not auto-resume after reboot, the MVP can avoid requesting `ACCESS_BACKGROUND_LOCATION` unless a future requirement genuinely needs background-originated startup.

### Recommendation for the real build

1. Keep tracking ownership outside widgets in a dedicated walking-session/service boundary.
2. Start the location foreground service only after an explicit visible user action and granted permission.
3. Use localized ongoing notification text and declare Android 14+ location foreground-service permissions.
4. Request only foreground precise/coarse location for the first production slice; do not request background location pre-emptively.
5. Persist session state and accepted points/checkpoints transactionally in Drift during tracking.
6. Stop tracking only on explicit pause/finish/interruption domain transitions, never on navigation or widget disposal.
7. On app startup, compare persisted `active/paused` state with actual service presence. If continuity was lost, persist `interrupted` and begin a new route segment only after user confirmation.
8. Never connect the pre-interruption and resumed segments with a fabricated straight line.
9. Treat Force Stop as an Android boundary: no work can continue until the user reopens the app.
10. Repeat Home, screen-off, recent-apps swipe, music/multitasking, low-battery, and reboot scenarios on the real Samsung Galaxy S23 before production completion.

## Sources

- Android foreground service types: https://developer.android.com/develop/background-work/services/fgs/service-types
- Android location permissions: https://developer.android.com/develop/sensors-and-location/location/permissions
- Geolocator documentation: https://pub.dev/packages/geolocator
