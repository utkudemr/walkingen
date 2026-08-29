# Spike 002: Samsung S23 foreground location continuity

- Date: 2026-08-29
- Environment: Samsung Galaxy S23 (`SM-S911B`), Android API 36
- Disposable package: `com.utkudemir.location.walkingen_s23_location_spike`
- Evaluated library: `geolocator 14.0.3`

## Question

Given an explicit user-started tracking session, when Walkingen is sent to Home/background, can Android keep a location foreground service alive on the real Samsung Galaxy S23 without the Flutter page owning the tracking lifecycle?

## Scope

This experiment is disposable and is not production Walkingen code. It uses a minimal Flutter app with a visible Start/Stop control and Geolocator's Android foreground notification configuration. No map, route database, API key, or personal route data is used.

## Approach

- Start tracking only from an explicit visible button action.
- Request foreground precise/coarse location permission.
- Configure `GeolocatorLocationService` with a location foreground-service type, wake lock, and Wi-Fi lock.
- Subscribe to the position stream from the spike app.
- Send the app to Home while the stream remains active.
- Inspect Android service/process state and the on-screen event log.

The disposable spike's Kotlin incremental compilation was disabled because the repository's Pub cache is on `D:` while the temporary spike project was on `C:`. This is an environment workaround only and must not be copied into production configuration.

## Evidence

### Build and static checks

- `dart format --output=none --set-exit-if-changed lib test`: passed after formatting.
- `flutter analyze`: `No issues found!`
- `flutter test`: `1/1` passed.
- `flutter build apk --debug`: passed.
- APK installed on the S23: `Success`.

### Real-device startup

- MainActivity launched successfully.
- The spike UI rendered with `IDLE`, `Start tracking`, and `Stop tracking` controls.
- Android location permission dialog was shown in Turkish.
- The user granted location access.
- After starting, the UI showed `RUNNING` and the Android status bar showed the location indicator.

### Android service inspection

After the app was sent to Home, Android reported:

- `GeolocatorLocationService` present.
- `isForeground=true`.
- Foreground service type `0x00000008` (`location`).
- Foreground notification channel `geolocator_channel_01` present.
- `ACCESS_FINE_LOCATION`: granted.
- `FOREGROUND_SERVICE`: granted.
- `FOREGROUND_SERVICE_LOCATION`: granted.
- The spike process remained alive in background.

### Notification permission limitation

`POST_NOTIFICATIONS` was `granted=false` on this device during the run. Therefore the service-level foreground state was verified, but the user-visible notification drawer path was not counted as fully verified for this S23 run. The app should request notification permission as part of the production start flow and repeat this scenario after the user grants it.

### GPS fix limitation

No real coordinate event arrived during the indoor test window. The test proved service startup and background process continuity, but not outdoor GNSS fix delivery. A real walk or outdoor stationary test is required for coordinate/checkpoint evidence.

## Verdict: PARTIAL

### What worked

- A real Samsung S23 running Android API 36 accepted the foreground precise/coarse location permission.
- An explicit Start action created a real Android location foreground service.
- The service remained foreground after the app was sent to Home.
- The process remained alive while the app was backgrounded.
- Android exposed the expected location foreground-service type.

### What did not work or remain unverified

- No outdoor GNSS coordinate was captured during the indoor test.
- Notification drawer visibility was not fully verified because notification permission was denied/not granted for the spike.
- Recent-apps removal, screen-off, low-battery, reboot, and Samsung battery-optimization scenarios were not run in this session.
- This spike does not prove durable checkpoint persistence; it has no production database.

### Recommendation for the real build

1. Keep the location/session ownership outside Flutter widgets in a dedicated walking-session service boundary.
2. Start the service only after explicit user action and successful foreground location plus notification permission handling.
3. Persist session state and accepted points/checkpoints transactionally in Drift during tracking.
4. Keep the service alive across navigation and widget disposal; stop only on explicit pause/finish or an explicit interruption transition.
5. Repeat an outdoor S23 test with notification permission granted, then run Home, screen-off, recent-apps swipe, music/multitasking, low-battery, and reboot scenarios.
6. Do not request background-originated location access until a product requirement needs it.
7. Do not connect route segments across missing GPS intervals with a fabricated straight line.
