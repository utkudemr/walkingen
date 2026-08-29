# Core Domain Model

## Terms

### Profile

The single local user's personal inputs used by Walkingen.

- Display name
- Height in centimetres
- Weight in kilograms
- Birth year

A profile must exist before normal application use. Validation limits belong to the profile vertical slice and must not be guessed in the foundation layer.

### Profile draft

A recoverable local copy of partially entered profile fields. It is updated as the user edits the form and removed only after a valid profile is persisted successfully.

### Walk

A deliberate walking session recorded by Walkingen. A walk owns lifecycle state, timestamps, accumulated metrics, quality/inclusion state, and ordered track points.

### Track point

One observed location sample associated with a walk. At minimum it records observation time, latitude, longitude, accuracy, and its continuity segment. Missing observation intervals create a segment boundary; they must not be represented as an invented straight route.

### Settings

- Local preferences including locale override, theme mode, and weekly active-day target. Reminder time belongs to the future local-notification slice and is not part of the current settings aggregate.

## Walk lifecycle

Allowed states:

- `active`: tracking and movement metrics may advance.
- `paused`: the session exists but new movement must not contribute to tracked metrics.
- `completed`: the user confirmed finishing and the final checkpoint was persisted.
- `interrupted`: tracking continuity was lost, for example after reboot or an unrecoverable service interruption.

Allowed transitions:

```text
start -> active
active -> paused
paused -> active
active -> completed
paused -> completed
active -> interrupted
paused -> interrupted
interrupted -> active      only after explicit user confirmation
interrupted -> completed   only after explicit user confirmation
```

`completed` is terminal. At most one walk may be `active` or `paused` at a time. An interrupted walk is never resumed automatically.

## Activity inclusion

A persisted walk has one inclusion state:

- `valid`: contributes to the active day, weekly target, and personal trend.
- `excluded`: remains in history but does not contribute to progress calculations.
- `needsReview`: remains visible and contributes to neither valid nor excluded progress until the user decides.

Changing inclusion state does not delete the walk or its track points. Permanent deletion is a separate strongly confirmed transaction that removes the walk and associated track points together.

## Invariants

1. At most one session is active or paused.
2. Lifecycle and inclusion states are persisted explicitly.
3. Route points and recovery checkpoints are persisted during tracking, not only at completion.
4. Missing GPS intervals create continuity boundaries.
5. Exclusion never destroys raw activity data.
6. A calendar day is active when it contains at least one valid walk; no distance or duration threshold is used.
7. Weekly target progress and personal performance trend are separate concepts.
8. Trend comparison uses equivalent elapsed periods.

## Persistence boundary

This document defines domain behavior, not table names or a frozen SQL schema.
The Drift schema, constraints, indexes, and migration policy will be derived from
failing persistence tests in the profile and walking-session vertical slices.
