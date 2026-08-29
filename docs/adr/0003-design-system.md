# ADR 0003: Versioned visual design contract

- Status: Accepted
- Date: 2026-08-25

## Context

Walkingen already has approved visual principles—Material 3, a fixed calm green seed, light/dark/system modes, Action-First Calm hierarchy, scalable text, 48dp touch targets, and non-color status cues—but those decisions were distributed across Flutter code, product notes, tests, and Obsidian.

As profile, settings, walking, history, and recovery screens are added by multiple agent roles, visual values and component rules need one versioned, machine-readable source. The source must not duplicate product behavior, domain lifecycle, or screen-flow decisions.

## Decision

- Keep a root-level [`DESIGN.md`](../../DESIGN.md) as the source of truth for visual tokens and visual rationale.
- Use Google's alpha DESIGN.md format: YAML front matter for normative tokens and canonical Markdown sections for human/agent guidance.
- Derive the initial light/dark palette from the actual Flutter `ColorScheme.fromSeed` output for the fixed `#4F6F52` seed.
- Mirror the pinned Flutter Material 3 type scale rather than introducing a custom font or arbitrary typography.
- Keep product behavior in `docs/product/`, lifecycle in `docs/domain/`, technical decisions in `docs/adr/`, test/device strategy in `docs/testing/`, and executable truth in Flutter code/tests.
- Do not copy token values into Obsidian. Obsidian records the decision and project status; the repository file owns current values.
- UI changes must either conform to `DESIGN.md` or update it deliberately in the same PR with accessibility evidence and independent review.
- Validate the file with the exact CLI version:

  ```bash
  npx -y -p @google/design.md@0.4.0 designmd lint DESIGN.md
  ```

- Keep lint local and review-gated initially. Do not make the alpha CLI a mandatory CI network dependency until the format and workflow have survived real UI slices.
- Do not generate Flutter theme code from `DESIGN.md` yet. Flutter theme/components remain handwritten and test-backed until automation has a demonstrated benefit.

## Consequences

- Coding agents have one explicit visual contract before implementing UI slices.
- Visual drift becomes reviewable in Git rather than living only in screenshots or conversation history.
- The initial file stays deliberately small: current palette, typography, spacing, shape, touch target, component hierarchy, and accessibility rules.
- New semantic status colors are deferred until the slice that introduces each state; they must include light/dark contrast and non-color cues.
- The alpha schema may change. A CLI upgrade requires an intentional diff, lint run, and review rather than an implicit latest-version update.
