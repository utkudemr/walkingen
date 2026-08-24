# Walkingen MVP Scope

## Product intent

Walkingen is a personal, local-first Android walking tracker. It helps one user record deliberate walks, retain reliable route history on the device, and compare recent activity with equivalent periods in their own history.

## MVP outcomes

The MVP must let the user:

1. Create and edit a local profile.
2. Start, pause, resume, and finish one walking session at a time.
3. Keep tracking through an Android foreground service while the UI is backgrounded.
4. Persist route points and recovery checkpoints during the walk.
5. Review local walking history and route details.
6. Include, exclude, or review uncertain activities without deleting raw records.
7. Set a weekly active-day target and see personal trend information separately.
8. Use Turkish or English with light, dark, or system theme mode.

## Non-goals

The initial MVP does not include:

- A Walkingen backend, account, or cloud synchronization.
- Health Connect or Samsung Health integration.
- Calorie estimates.
- Offline maps.
- Automatic pause.
- Badges, streaks, or personal records.

## Privacy boundary

Profile, settings, walks, route points, and drafts remain in the on-device database. Google Maps may process requests needed to render maps. Credentials, real route data, signing material, and local databases must never enter source control.

## Foundation slice

The first production slice proves that the application:

- Starts on Android.
- Exposes Home, History, and Profile/Settings destinations.
- Sources every visible string from Turkish and English localization resources.
- Supports light, dark, and system theme configuration.
- Uses accessible, calm Material 3 foundations without dynamic wallpaper colors.
- Runs format, analysis, test, and debug APK build checks in GitHub Actions for
  pull requests and pushes to `main`.

Persistence, profile forms, permissions, maps, and tracking are intentionally outside this slice.
