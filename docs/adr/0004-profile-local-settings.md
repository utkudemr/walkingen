# ADR 0004: Profile and local settings first production slice

- Status: Accepted
- Date: 2026-08-29

## Context

The Flutter foundation provides navigation, localization, themes, and accessibility foundations but no persisted user data. The fastest useful product step is allowing the owner to create and edit the local profile and observe that data survive closing and reopening the app.

Profile validation and draft behavior were intentionally left open in the foundation. Reminder settings also conflicted with the decision to keep notification behavior out of this slice.

## Decision

- Implement the first production vertical slice as profile create/edit plus minimal local application settings.
- Store one local profile containing display name, height in centimetres, weight in kilograms, and Gregorian birth year. Use the `characters` package for user-perceived display-name length.
- Use the inclusive ranges and parsing rules in [`docs/domain/profile.md`](../domain/profile.md): name 1–80 grapheme clusters, height 80–250 cm, weight 20.0–300.0 kg at 0.1 precision without rounding, birth year 1900–injected current device year. Only the documented ASCII numeric syntax is accepted.
- Preserve user-entered profile drafts locally after meaningful edits. Do not persist an all-empty draft.
- Use create/edit abandon semantics from the domain document: create abandon leaves no profile and removes the draft; edit abandon preserves the saved profile and removes the draft.
- Save the valid profile and clear its draft in one Drift transaction. A failed save must not partially replace the saved profile or delete the draft.
- Enforce the singleton profile at persistence level.
- Keep locale override, theme mode, and weekly active-day target as separate singleton local settings. Locale supports Turkish/English/system fallback; theme supports system/light/dark with system default; weekly target is 1–7 with default 3.
- Defer reminder time and notification controls until a separate local-notification vertical slice can provide real behavior. Do not show a non-functional reminder setting in this slice.
- Keep walking, permissions, maps, foreground service, sensors, and route persistence out of this slice.

## Consequences

- The app becomes personally usable before walking tracking is implemented.
- The schema remains small and migration risk is limited to profile, draft, and settings.
- Profile data remains local and must never appear in logs, source control, fixtures copied from real use, or error payloads.
- The current-year birth-year boundary changes over time by design and must have deterministic tests using an injected/current-year boundary.
- Reminder behavior will be decided and implemented separately rather than creating a misleading UI now.
