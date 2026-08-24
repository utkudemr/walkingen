# ADR 0001: Flutter application foundation

- Status: Accepted
- Date: 2026-08-24

## Context

Walkingen is Android-first, local-first, and expected to grow through small independently reviewed vertical slices. The first production change must establish a testable application and CI baseline without prematurely selecting broad state-management abstractions.

## Decision

- Place the Flutter application under `app/`.
- Use the stable Flutter SDK and Material 3.
- Use Flutter's generated localization support with Turkish and English ARB resources.
- Support light, dark, and system theme modes from the start.
- Use a simple stateful navigation shell for the initial Home, History, and Profile/Settings destinations.
- Do not add a state-management package until a concrete vertical slice demonstrates the need.
- Use Android package/application ID `com.utkudemir.walkingen`. This spelling is
  intentionally based on the developer's full name rather than the abbreviated
  GitHub username.
- Target Android only in the initial scaffold; web and desktop folders are not production targets.

## Consequences

- The initial code remains small and understandable.
- User-visible strings and theme behavior have an enforceable foundation.
- Profile persistence, Drift, maps, permissions, and background tracking remain separate reviewed slices.
- A future state-management ADR may supersede the simple shell when lifecycle or persistence behavior requires it.

## Verification

- Pull requests and pushes to `main` run format, analyze, test, and debug APK
  build jobs from `app/`.
- CI uses a fixed Flutter version matching the repository's development baseline.
- The workflow grants read-only repository contents permission and receives no
  application credentials.
