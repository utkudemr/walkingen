# Walkingen Agent Rules

These rules apply to every human or coding agent working in this repository.

## Sources of truth

- The planned versioned sources are `docs/product/`, `docs/domain/`, and `docs/adr/`; create and maintain them as the relevant slices begin.
- Product intent and scope live under `docs/product/` once created.
- Domain behavior lives under `docs/domain/` once created.
- Architecture decisions live under `docs/adr/` once created.
- Executable behavior is proven by tests.
- Obsidian is the project dashboard, not the source of detailed technical behavior.

If code, tests, and documentation disagree, stop and surface the conflict. Do not silently choose one.

## Development discipline

- Work in small vertical slices that produce one testable behavior.
- No production behavior without a failing test first.
- Verify RED for the expected reason before writing production code.
- Implement only enough to reach GREEN, then refactor with all tests passing.
- Do not add unrelated refactors or speculative abstractions.
- Bug fixes require a failing regression test.
- Generated code and throwaway spikes are exceptions; spike code must be discarded before the tested implementation begins.

## Required quality gates

Before declaring a production change complete, run and report real output from the Flutter application directory:

```bash
cd app
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
flutter build apk --debug
```

Run the smallest relevant test during RED/GREEN, then the complete suite. Android lifecycle, location, notification, or sensor changes also require the documented Samsung S23 scenario.

Documentation-only, repository bootstrap, and pre-scaffold configuration changes do not require unavailable Flutter commands or a RED test. They still require applicable syntax/diff checks, secret scanning, link/consistency validation, and independent review. Explain every skipped gate in the PR evidence.

## Review and Git

- The implementer cannot be the only reviewer of its own change.
- Use `feat/*`, `fix/*`, `test/*`, `docs/*`, `ci/*`, or `refactor/*` branches.
- Use Conventional Commits.
- Do not push directly to `main` after repository bootstrap.
- PRs must include summary, domain/ADR impact, test evidence, device evidence when applicable, and documentation impact.
- After the initial workflow is installed, CI and secret scanning must pass before merge. CI is required before the first production-code PR.
- Use separate worktrees for parallel agents; do not let agents edit the same files concurrently.

## Secrets and privacy

- Never commit API keys, tokens, passwords, signing material, `.env`, local properties, secret properties, or real route data.
- Never paste secrets into prompts, logs, tests, documentation, commits, or PR bodies.
- Use ignored local configuration for development and GitHub Actions Secrets for CI.
- Keep `.env.example` value-free; include names and safe placeholders only.
- Restrict Google Maps Android keys by package name and signing certificate.
- If a secret is committed, stop, rotate it immediately, and clean history before continuing.

## Flutter product rules

- Android-first; Samsung Galaxy S23 is the primary real-device target.
- All user-visible strings must use Turkish/English localization resources.
- Support light, dark, and system theme modes.
- Do not use wallpaper-derived dynamic colors in the initial product.
- Use calm visuals, scalable text, clear semantics, and touch targets of at least 48dp.
- Never communicate a status using color alone.
- User preferences and product thresholds must not be scattered as hard-coded UI constants.

## Domain invariants

- At most one walking session may be active at a time.
- Session states and transitions must be explicit and persisted.
- GPS points and recovery checkpoints are written during a walk, not only at completion.
- Missing GPS intervals must not be represented as a fabricated straight route.
- Raw activity records remain available when excluded from progress calculations.
- Daily activity and personal progress trend are separate concepts.
- Personal trend comparisons must use equivalent elapsed periods.

## Completion

A production-code task is complete only when acceptance criteria, tests, analysis, build, independent review, and affected documentation all agree. Documentation-only, repository bootstrap, and pre-scaffold configuration tasks must pass every applicable check and explicitly record why Flutter-only gates do not apply. Update the Obsidian dashboard only after verification succeeds.
