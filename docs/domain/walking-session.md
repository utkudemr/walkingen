# Walking Session Domain Contract

## Purpose

A walking session is a deliberate user-started activity. This contract defines the smallest production slice needed to create, pause, recover, and finish one session while preserving raw GPS evidence.

This is a domain contract, not a Drift table specification. Table names, indexes, and migrations are derived from failing persistence tests.

## Session identity and states

Each session has a stable identifier, creation/start timestamps, lifecycle state, inclusion state, a monotonically increasing revision, and ordered track points. Lifecycle history is represented by explicit events and segment records; a single mutable timestamp is not used to represent repeated pauses or interruptions.

Allowed lifecycle states:

- `active`: the user has started the walk; accepted location points may advance movement metrics.
- `paused`: the walk remains open, but location observations must not advance movement metrics. The foreground service and session notification remain alive.
- `completed`: the user explicitly confirmed finish and the final checkpoint was persisted. Terminal.
- `interrupted`: continuity was lost because the service/process was unavailable or the platform stopped ownership. The interrupted segment is closed, but the session aggregate may be explicitly resumed as a new segment or completed without resuming.

Allowed transitions:

```text
create -> active
active -> paused
paused -> active
active -> completed
paused -> completed
active -> interrupted
paused -> interrupted
interrupted -> active  (explicit user confirmation; new continuity segment)
interrupted -> completed (explicit user confirmation; no new points required)
```

There is never more than one `active` or `paused` session. `completed` sessions are terminal. An `interrupted` session is closed for its current segment but remains resumable or completable only through an explicit user action; it never becomes active automatically.

## Explicit user actions

- `start`: creates a new session and enters `active`; it is rejected when another session is `active` or `paused`.
- `pause`: enters `paused`; it is idempotent only when already paused and rejected for terminal states.
- `resume`: enters `active`; it is allowed from `paused`, or from `interrupted` only after explicit user confirmation and with a new continuity segment.
- `finish`: requires explicit user confirmation, persists a final checkpoint/close marker in the same transaction, and enters `completed`.
- `markInterrupted`: records loss of service ownership and enters `interrupted`; it does not fabricate a point or route segment.

UI disposal, navigation, app backgrounding, screen lock, and recent-apps removal are not domain actions and must not pause, finish, or cancel a session.

## Track points and continuity

An accepted track point contains at minimum:

- session identifier
- continuity segment identifier
- observation timestamp from the location provider
- latitude and longitude
- horizontal accuracy
- optional altitude, speed, and heading when supplied
- insertion timestamp for persistence diagnostics

A point is accepted only for an `active` session and only when it passes the location acceptance policy selected by the production slice. Paused-state observations may be received by the service but are not movement-contributing points.

### v1 location acceptance policy

The first production slice uses an injectable deterministic policy:

- latitude must be in `[-90, 90]` and longitude in `[-180, 180]`;
- accuracy must be finite and non-negative;
- observation time must be finite and must not be earlier than the last accepted point in the same segment;
- an observation with the same provider event/id, when supplied, is a duplicate and is ignored;
- without a provider event/id, an exact match of timestamp, latitude, longitude, and accuracy against the last accepted point is a duplicate and is ignored;
- out-of-order observations are `rejected` without changing the checkpoint; duplicate observations are `duplicate` no-ops without changing the checkpoint;
- v1 does not reject solely on an accuracy threshold and does not infer movement from speed/distance;
- paused observations are transient and are not persisted as track points.

The policy returns one of `accepted`, `duplicate`, or `rejected` with a reason. Rejected and duplicate observations are observable in diagnostics but never mutate the aggregate. GPS-gap heuristics are out of scope for v1; service interruption and explicit interrupted resume are the only segment boundaries required here.

A new continuity segment metadata record is created:

- when a session starts;
- when an interrupted session is explicitly resumed;
- `markInterrupted` closes the current segment but does not create a new segment; a new segment is created only by an explicit interrupted-session resume.

Missing GPS intervals and interruption gaps are represented by the boundary between the closed current segment and the later segment created on explicit resume. No straight line, interpolated point, or estimated route is persisted across such a gap. A segment metadata record may be provisional and contain zero points before the first accepted observation; it is not a route segment until it contains an accepted point and is never rendered as a route. A session interrupted or completed before its first point keeps this empty provisional record as recovery metadata.

## Checkpoints and transactions

A checkpoint is durable recovery state, not merely the latest UI value. During `active` tracking, accepted points and the corresponding latest checkpoint are persisted before the service acknowledges the write as durable.

The v1 checkpoint contains: session id, current lifecycle state, current segment id, last accepted point id (nullable before the first point), last accepted observation time (nullable), last accepted coordinates/accuracy (nullable), the latest recovery boundary (nullable), aggregate revision, and updated-at. A recovery boundary identifies the last durable point/segment before ownership was lost; it is not a synthetic point and has no coordinates unless it references an existing accepted point.

Required atomic operations:

1. `start`: create session, initial provisional segment metadata, and initial checkpoint atomically.
2. `acceptPoint`: append the point and update the session checkpoint atomically.
3. `pause`/`resume`: update lifecycle and checkpoint atomically.
4. `finish`: persist the final checkpoint and terminal state atomically.
5. `markInterrupted`: close the current segment, persist interruption state and a recovery boundary atomically; do not create an empty segment.
6. `resumeInterrupted`: update the original session with a new segment and active state only after confirmation.

Every mutating command carries the aggregate revision it read. Revision validation happens before idempotency evaluation: a stale revision is always `rejected` and leaves durable state unchanged, even if the provider key was seen before. Point acceptance also carries an idempotency key when the provider supplies one; the key is scoped to the session and a repeated key with the current revision is a `duplicate` no-op. If no provider key exists, the v1 duplicate tuple rule above applies. Concurrent starts are serialized by the database transaction and the unique open-session invariant; exactly one succeeds. Out-of-order observations are `rejected` with an explicit reason; they are not silently classified as duplicates.

A failed transaction must leave the previous durable state intact and must not report success to the UI/service.

## Startup recovery

At app/service startup:

- If no open session exists, remain idle.
- If persisted state is `active` or `paused` and the service is present, the persisted state is authoritative for the domain aggregate; the service is instructed to adopt that state or report an interruption. A service-reported `active`/`paused` state cannot create a second session or overwrite a newer aggregate revision.
- If persisted state is `active` or `paused` and the service is absent, mark the session `interrupted`; never silently convert it to completed or paused.
- An interrupted session is never auto-resumed after reboot, process death, or Force Stop.
- The user may explicitly resume it, which starts a new continuity segment, or explicitly complete it without resuming.

Force Stop is a platform boundary. No background work is expected until the user opens Walkingen again.

## Inclusion state

Every newly created session starts with `needsReview` inclusion. The first production slice does not expose inclusion-changing operations; a completed or interrupted session retains raw points even when excluded from progress calculations. Inclusion changes do not delete points. Permanent deletion is outside this production slice.

## Acceptance criteria for the first production slice

- Starting a session persists exactly one `active` session.
- A second start is rejected while an open session exists.
- Pause prevents movement-contributing points while preserving the open session.
- Resume from pause continues the same segment.
- Finish requires confirmation and persists a terminal session.
- Point/checkpoint writes survive process restart in tests.
- Missing service ownership transitions an open session to `interrupted`.
- Optional step sensor updates provide an approximate session-relative step count and never interrupt GPS tracking when unavailable.
- Explicit interrupted resume creates a new segment.
- No test or implementation connects points across a missing interval.
- Navigation and widget disposal do not change lifecycle state.

- History detail route rendering uses the persisted ordered points grouped by segment. Each continuity segment is rendered independently; points from interrupted segments are never joined by a synthetic line.

## Out of scope

- Distance/calorie algorithms beyond the minimum point persistence and approximate step-distance fallback defined for this slice
- Notifications copy and full permission UX beyond the service boundary
- Automatic reboot continuation
- Cloud sync, Health Connect, and export/import
