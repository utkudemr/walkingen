# Walkingen

A personal, local-first walking tracker for Android, built with Flutter.

> **Project status:** The first usable local Profile slice is implemented and merged. It includes file-backed Drift persistence, draft recovery, and a Turkish/English profile form. Walking, maps, and background tracking are the next product slices.

Walkingen is designed around a simple question: **am I walking consistently, and how is my activity changing over time?** It records deliberate walking sessions, draws the route on a map, keeps the history on the device, and compares recent activity with the user's own previous periods instead of enforcing an arbitrary fixed daily distance.

## Quick start

### Prerequisites

- Flutter stable with the Dart SDK bundled by Flutter
- Android SDK and an Android API level supported by the installed Flutter version
- A connected Android device or emulator for device verification

The primary test device is a Samsung Galaxy S23 running Android API 36. The project is Android-first; iOS and web are not current targets.

### Run the app

```bash
cd app
flutter pub get
flutter run
```

### Build and verify

```bash
cd app
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
flutter build apk --debug
```

The generated debug APK is written to `app/build/app/outputs/flutter-apk/app-debug.apk`.

## Current status

### Implemented

- Local profile with display name, height, weight, and birth year
- Drift/SQLite file-backed persistence
- Recoverable partial profile drafts
- Turkish and English profile labels and messages
- System/light/dark theme foundations
- CI verification and Gitleaks secret scanning

### Next

- Background GPS persistence and recovery on the Samsung Galaxy S23
- User-editable settings screen for locale, theme, and weekly active-day target
- Walking session lifecycle and route persistence

### Planned later

- History, weekly activity, and personal trend comparison
- Real-walk validation
- Local export/import after the MVP

## Product principles

- **Personal-first:** the initial product is built for a single user's real daily needs.
- **Local-first:** profile, settings, walks, and route points are stored in the on-device database and are not uploaded to a Walkingen backend in the MVP. Third-party map services may still process the requests required to render maps.
- **Simple by default:** the primary action must be obvious enough for a non-technical user.
- **No arbitrary success target:** a valid walk marks the day as active; progress is measured against personal history.
- **Reliable tracking:** background execution, checkpointing, and interrupted-session recovery are core requirements.
- **Accessible UI:** calm visuals, large touch targets, scalable text, and status indicators that do not rely on color alone.
- **Honest metrics:** uncertain or excluded activities are represented explicitly rather than silently distorting reports.

## MVP scope

### Profile and preferences

- First-run profile with display name, height, weight, and birth year (implemented)
- Local profile persistence with recoverable drafts (implemented)
- Persisted locale/theme foundations (implemented; settings editing UI is next)
- Light, dark, and system theme modes
- Turkish and English localization

### Walking session

- Start, pause, resume, and finish manually
- Confirmation before finishing
- Live Google Maps route
- Large duration and distance metrics
- Secondary step count and pace metrics
- Phone step sensor during an active Walkingen session
- GPS/personal stride estimate when step sensor data is unavailable

### Background reliability

- Android foreground location service during an active walk
- Tracking while the screen is off or another app is in use
- Persistent Android notification for the active session
- Route points and session checkpoints persisted during the walk
- Recovery after UI/process interruption
- Interrupted-session notification after a phone restart
- No fabricated straight route segment across a period with missing GPS data

### Activity and progress

- Monday-to-Sunday activity view
- Valid walking day: green check
- Past day without a valid walk: red cross
- Current and future days represented separately
- Activity states: valid, uncertain, and excluded
- Confirmation for uncertain activity: “Should this activity count as a walk?”
- Weekly trends compared with the same elapsed period of previous weeks
- Future monthly and multi-month reports based on the same personal baseline

### History

- Local walk history
- Walk detail with route, distance, duration, steps, and pace
- Ability to include or exclude an activity from progress calculations without deleting its raw record

## Technology direction

| Area | Choice |
|---|---|
| Application | Flutter, Android-first |
| Test device | Samsung Galaxy S23 |
| Map | Google Maps |
| Local persistence | Drift + SQLite |
| Notifications | Local Android notifications |
| Active-walk steps | Phone step sensor during active Walkingen sessions |
| Cloud/backend | Out of scope for the MVP |
| Health Connect | Out of scope for the MVP |
| Calories | Out of scope for the MVP |
| Offline maps | Out of scope for the MVP |
| Reminder time and notifications | Deferred to a separate vertical slice |

## Visual design system

The root [`DESIGN.md`](DESIGN.md) is the versioned source of truth for Walkingen's visual tokens and visual rationale. It records the Action-First Calm direction, measured light/dark Material 3 palette, typography, spacing, touch targets, component hierarchy, and accessibility rules. Product behavior and screen flows remain in their dedicated product, domain, ADR, and testing documents.

Validate the design contract with the pinned alpha CLI:

```bash
npx -y -p @google/design.md@0.4.0 designmd lint DESIGN.md
```

Flutter theme and component code remain handwritten and test-backed; the project does not generate Dart code from `DESIGN.md` at this stage.

## Privacy and secrets

Walkingen must never commit credentials or personal route data to the repository. The MVP has no Walkingen cloud backend, but Google Maps is a third-party SDK and is subject to Google's own data-processing and privacy terms.

- `.env` and local secret files are ignored.
- Android signing keys and local properties are ignored.
- Google Maps API keys must be supplied from ignored local configuration or GitHub Actions Secrets.
- A Google Maps Android key must be restricted by package name and signing certificate.
- Recorded walking data belongs in the local application database, never in source control or test fixtures copied from real use.

See [`.gitignore`](.gitignore) for enforced local exclusions.

## Development model

Development uses small vertical slices and an agentic review pipeline:

1. Hermes defines and orchestrates a verifiable slice.
2. A domain guardian checks the requirement and acceptance criteria.
3. Codex implements the slice with strict RED–GREEN–REFACTOR TDD.
4. Flutter quality gates run locally.
5. An independent reviewer examines the diff and evidence.
6. The branch is pushed and opened as a pull request.
7. CI verification and secret scanning must pass before merge.
8. Verified progress is synchronized to the project dashboard in Obsidian.

The implementer cannot be the only reviewer of its own change. See [`AGENTS.md`](AGENTS.md) for repository-level agent rules.

## Quality gates

Once the Flutter app exists under `app/`, every production change is expected to pass from that directory:

```bash
cd app
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
flutter build apk --debug
```

Relevant changes also require widget, integration, and Samsung S23 device evidence. Background location behavior cannot be considered verified using unit tests alone.

## Branch and pull request workflow

- `feat/*` — product features
- `fix/*` — bug fixes
- `test/*` — test-only changes
- `docs/*` — documentation
- `ci/*` — CI and automation
- `refactor/*` — behavior-preserving cleanup

Commits follow [Conventional Commits](https://www.conventionalcommits.org/). Feature branches are intended to be squash-merged and deleted after verification.

## Repository structure

```text
walkingen/
├─ app/
│  ├─ android/               # Android application configuration
│  ├─ lib/                   # Flutter source and TR/EN localization
│  └─ test/                  # Widget tests
├─ docs/
│  ├─ product/mvp-scope.md
│  ├─ domain/core-model.md
│  ├─ adr/0001-flutter-foundation.md
│  ├─ adr/0002-android-foreground-location.md
│  ├─ adr/0003-design-system.md
│  ├─ adr/0004-profile-local-settings.md
│  └─ testing/strategy.md
├─ spikes/
│  └─ 001-android-foreground-location/README.md  # Evidence; executable discarded
├─ .github/
│  ├─ workflows/             # Flutter verification and Gitleaks
│  └─ pull_request_template.md
├─ DESIGN.md                 # Visual tokens and agent-readable design contract
├─ AGENTS.md                 # Binding instructions for coding agents
└─ README.md
```

## Near-term roadmap

1. Prove background GPS persistence and recovery on the Samsung Galaxy S23.
2. Add user-editable locale, theme, and weekly-target settings.
3. Implement walking session lifecycle and route persistence.
4. Add history, weekly activity, and personal trend comparison.
5. Validate the MVP through real walks.
6. Add local export/import as the first post-MVP capability.

## Contributing

The project is public but currently personal and in an early design phase. Pull requests should remain narrow, include test evidence, update affected domain documentation, and follow the repository rules in [`AGENTS.md`](AGENTS.md).

## License

No open-source license has been selected yet. Public visibility does not grant permission to reuse or redistribute the code.
