# ADR 0002: Android foreground location and recovery boundary

- Status: Accepted from spike; production implementation pending
- Date: 2026-08-25

## Context

Walkingen must record a deliberate walk while the user presses Home, listens to music, locks the screen, or removes the app card from recent apps. It must persist observations during the walk, not only at completion. It must not silently fabricate missing route intervals or automatically continue an interrupted walk after reboot.

Spike 001 evaluated Android 16 location foreground-service behavior with synthetic coordinates. The complete evidence is recorded in `spikes/001-android-foreground-location/README.md`; its executable code was discarded.

## Decision

- Start tracking only from an explicit user action while the application is visible.
- Run active tracking as an Android location foreground service with a localized ongoing notification.
- Keep position-stream and walk-session ownership outside UI widgets. Navigation and widget disposal must not stop tracking.
- Keep the foreground service and session notification alive while a walk is `paused`, but suspend movement-contributing location observations. If the service is absent while persisted state is `active` or `paused`, treat that as lost session ownership and transition to `interrupted` rather than as an intentional pause.
- Persist lifecycle state, accepted track points, continuity segment, and recovery checkpoints during tracking through the production Drift boundary.
- Initially request foreground location only. Do not request `ACCESS_BACKGROUND_LOCATION` merely to continue a user-started foreground service after Home or screen-off.
- Declare the permissions required by the chosen production implementation, including Android 14+ `FOREGROUND_SERVICE_LOCATION`; request notification permission where the Android version requires it.
- On Android 13+, notification-permission denial does not prevent the foreground service from running, but its notice may be visible only in the system's active-apps Task Manager rather than the notification drawer. The permission rationale and real-device acceptance must not promise a drawer notification when permission is denied.
- Treat Force Stop as a platform boundary. Walkingen cannot continue or notify until the user opens it again.
- Do not automatically restart a walk after reboot. If persisted state says `active` or `paused` but the service is absent, transition the walk to `interrupted` and notify when Android allows.
- Resume an interrupted walk only after explicit user confirmation and begin a new continuity segment. Never draw a straight route through the missing interval.

## Evidence

On the Android 16/API 36 emulator:

- The service was reported as foreground type `location`; the captured notification carried `ONGOING_EVENT`, `NO_CLEAR`, and `FOREGROUND_SERVICE` flags. These observed flags are not treated as proof that every supported Android UI prevents user dismissal.
- Checkpoints advanced `0 → 3` while visible, `3 → 5` after Home, and `5 → 7` while the screen was asleep.
- Recent-apps removal continued checkpoints only when subscription ownership outlived widget disposal.
- Force Stop removed the PID, service, and notification; an injected fix was not recorded.
- Reboot preserved the last checkpoint but did not restart the service; the app reopened idle.

## Consequences

- The first production tracking slice needs an explicit session/service boundary even if no broad state-management framework is selected.
- Drift persistence and service lifecycle must be designed together and tested through failure/recovery cases.
- Background location permission is not part of the initial permission request unless later evidence proves a background-originated start requirement.
- Emulator evidence reduces framework risk but does not satisfy Samsung-specific acceptance. Real Galaxy S23 tests remain mandatory for screen-off tracking, recent-apps removal, battery policy, notification behavior, and real GNSS quality.
- Wake-lock use must be measured against battery impact in the real-device slice rather than copied blindly from the spike.

## Follow-up production slice

Implement a minimal persisted walking-session vertical slice with RED/GREEN tests:

1. Start one session and persist `active`.
2. Own the foreground location stream outside the UI.
3. Persist accepted points/checkpoints with continuity segments.
4. Detect missing service versus persisted active/paused state and mark `interrupted`.
5. Require explicit confirmation to resume in a new segment.
6. Verify the documented Samsung S23 lifecycle matrix before merge.
