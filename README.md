# Walkingen

A personal, local-first walking tracker for Android, built with Flutter.

> **Project status:** Product discovery and technical planning. The Flutter application has not been scaffolded yet.

Walkingen is designed around a simple question: **am I walking consistently, and how is my activity changing over time?** It records deliberate walking sessions, draws the route on a map, keeps the history on the device, and compares recent activity with the user's own previous periods instead of enforcing an arbitrary fixed daily distance.

## Product principles

- **Personal-first:** the initial product is built for a single user's real daily needs.
- **Local-first:** profile, settings, walks, and route points are stored in the on-device database and are not uploaded to a Walkingen backend in the MVP. Third-party map services may still process the requests required to render maps.
- **Simple by default:** the primary action must be obvious enough for a non-technical user.
- **No arbitrary success target:** a valid walk marks the day as active; progress is measured against personal history.
- **Reliable tracking:** background execution, checkpointing, and interrupted-session recovery are core requirements.
- **Accessible UI:** calm visuals, large touch targets, scalable text, and status indicators that do not rely on color alone.
- **Honest metrics:** uncertain or excluded activities are represented explicitly rather than silently distorting reports.

## Planned MVP

### Profile and preferences

- First-run profile with display name, height, weight, and birth year
- Editable daily reminder time
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
7. Once the initial CI workflow is added, CI and secret scanning must pass before merge. CI setup is required before the first production-code PR.
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

## Planned repository structure

```text
walkingen/
├─ app/                      # Flutter application
├─ docs/
│  ├─ product/              # Vision, scope, glossary
│  ├─ domain/               # Walking and progress rules
│  ├─ architecture/         # Data, background tracking, localization
│  ├─ adr/                  # Architecture decision records
│  └─ testing/              # Test strategy and device matrix
├─ .github/                 # Pull request and CI configuration
├─ AGENTS.md                # Binding instructions for coding agents
└─ README.md
```

## Near-term roadmap

1. Create the versioned product/domain documentation.
2. Scaffold the Flutter application and test harness.
3. Prove background GPS persistence and recovery on the Samsung Galaxy S23.
4. Implement profile and local settings as the first end-to-end slice.
5. Implement walking session lifecycle and route persistence.
6. Add history, weekly activity, and personal trend comparison.
7. Validate the MVP through real walks.
8. Add local export/import as the first post-MVP capability.

## Contributing

The project is public but currently personal and in an early design phase. Pull requests should remain narrow, include test evidence, update affected domain documentation, and follow the repository rules in [`AGENTS.md`](AGENTS.md).

## License

No open-source license has been selected yet. Public visibility does not grant permission to reuse or redistribute the code.
